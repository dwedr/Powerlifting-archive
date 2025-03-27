CREATE OR REPLACE FUNCTION validate_weight_class(weight_class TEXT, weight REAL)
RETURNS TEXT AS $$
DECLARE
    numeric_value REAL;        -- Numeric part of weightclass
    direction CHAR;            -- Direction indicator (+/-)
    standardized_class TEXT;   -- Standardized weight class to return
BEGIN
    -- Validation format
    IF NOT weight_class ~ '^[-+]?\d+[-+]?$' THEN
        RAISE EXCEPTION 'Invalid weight class format: %', weight_class;
    END IF;

    -- Extracting numeric value
    numeric_value := regexp_replace(weight_class, '[^\d]', '', 'g')::REAL;

    -- Determining direction
    IF weight_class ~ '[-+]$' THEN
        direction := substring(weight_class FROM '.$'); 
    ELSE
        direction := substring(weight_class FROM '^.'); 
        IF direction NOT IN ('+', '-') THEN
            direction := '-'; 
        END IF;
    END IF;

    -- Standardizing fromat
    IF direction = '+' THEN
        standardized_class := numeric_value::TEXT || '+';
    ELSE
        standardized_class := '-' || numeric_value::TEXT;
    END IF;

    -- Validating value
    IF direction = '+' AND weight < numeric_value THEN
        RAISE EXCEPTION 'Weight % does not meet the criteria of weight class %', weight, weight_class;
    ELSIF direction = '-' AND weight > numeric_value THEN
        RAISE EXCEPTION 'Weight % does not meet the criteria of weight class %', weight, weight_class;
    END IF;
    RETURN standardized_class;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION text_to_boolean(input_text TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    CASE LOWER(input_text)
        WHEN 'p' THEN RETURN TRUE;
        WHEN 'prawda' THEN RETURN TRUE;
        WHEN 'tak' THEN RETURN TRUE;
        WHEN 't' THEN RETURN TRUE;
        WHEN 'f' THEN RETURN FALSE;
        WHEN 'fałsz' THEN RETURN FALSE;
        WHEN 'nie' THEN RETURN FALSE;
        WHEN 'n' THEN RETURN FALSE;
        WHEN 'true' THEN RETURN TRUE;
        WHEN 't' THEN RETURN TRUE;
        WHEN 'yes' THEN RETURN TRUE;
        WHEN 'y' THEN RETURN TRUE;
        WHEN '1' THEN RETURN TRUE;
        WHEN 'false' THEN RETURN FALSE;
        WHEN 'f' THEN RETURN FALSE;
        WHEN 'no' THEN RETURN FALSE;
        WHEN 'n' THEN RETURN FALSE;
        WHEN '0' THEN RETURN FALSE;
        ELSE
            RAISE EXCEPTION 'Invalid input: %', input_text;
    END CASE;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION bolean_valid_values(input_text TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    CASE LOWER(input_text)
        WHEN 'true' THEN RETURN TRUE;
        WHEN 't' THEN RETURN TRUE;
        WHEN 'yes' THEN RETURN TRUE;
        WHEN 'y' THEN RETURN TRUE;
        WHEN '1' THEN RETURN TRUE;
        WHEN 'false' THEN RETURN FALSE;
        WHEN 'f' THEN RETURN FALSE;
        WHEN 'no' THEN RETURN FALSE;
        WHEN 'n' THEN RETURN FALSE;
        WHEN '0' THEN RETURN FALSE;
        ELSE
            RETURN NULL;
    END CASE;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_competitor_age_category(date_of_birth DATE, date_of_start DATE)
RETURNS TEXT AS $$
DECLARE
    age INTEGER; 
BEGIN
	IF date_of_start < date_of_birth THEN
	    RAISE EXCEPTION 'Invalid dates: date_of_start (%), cannot be earlier than date_of_birth (%)', date_of_start, date_of_birth;
	END IF;
    -- Calculating the age of the competitor
   age := EXTRACT(YEAR FROM date_of_start) - EXTRACT(YEAR FROM date_of_birth);

    IF (EXTRACT(MONTH FROM date_of_start) < EXTRACT(MONTH FROM date_of_birth)) OR
       (EXTRACT(MONTH FROM date_of_start) = EXTRACT(MONTH FROM date_of_birth) AND
        EXTRACT(DAY FROM date_of_start) < EXTRACT(DAY FROM date_of_birth)) THEN
        age := age - 1;
    END IF;

    -- Determining the category
    IF age <= 13 THEN
        RETURN 'Youth';
    ELSIF age BETWEEN 14 AND 18 THEN
        RETURN 'Teen';
    ELSIF age BETWEEN 19 AND 23 THEN
        RETURN 'Juniors';
    ELSIF age BETWEEN 24 AND 49 THEN
        RETURN 'Seniors';
    ELSIF age BETWEEN 50 AND 59 THEN
        RETURN 'Submasters';
    ELSE
        RETURN 'Masters';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Calculating total
CREATE OR REPLACE FUNCTION total_calc(squat REAL, bp REAL, dl REAL)
RETURNS REAL AS $$
BEGIN
    RETURN squat + bp + dl;
END;
$$ LANGUAGE plpgsql;

--Calculating ipf score
CREATE OR REPLACE FUNCTION ipf_calc(
    total_lifted REAL,
    bodyweight REAL,
    sex CHAR(1)
)
RETURNS REAL AS $$
DECLARE
    -- Coefficients for the IPF formula
    a REAL;
    b REAL;
    c REAL;
    d REAL;
    e REAL;
    f REAL;
    coefficient REAL;
BEGIN
    -- Assigning coefficients based on sex
    IF sex = 'M' THEN
        a := -216.0475144;
        b := 16.2606339;
        c := -0.002388645;
        d := -0.00113732;
        e := 7.01863E-6;
        f := -1.291E-8;
    ELSIF sex = 'F' THEN
        a := 594.31747775582;
        b := -27.23842536447;
        c := 0.82112226871;
        d := -0.00930733913;
        e := 4.731582E-5;
        f := -9.054E-8;
    ELSE
        RAISE EXCEPTION 'Invalid sex: %; must be M or F', sex;
    END IF;

    -- Calculating the coefficient
    coefficient := a 
                 + b * bodyweight 
                 + c * POWER(bodyweight, 2) 
                 + d * POWER(bodyweight, 3) 
                 + e * POWER(bodyweight, 4) 
                 + f * POWER(bodyweight, 5);


    RETURN 50 * total_lifted / coefficient;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION standardize_sex(input_sex TEXT)
RETURNS CHAR(1) AS $$
BEGIN
    CASE LOWER(input_sex)
        WHEN 'male' THEN
            RETURN 'M';
        WHEN 'm' THEN
            RETURN 'M';
        WHEN 'mężczyzna' THEN
            RETURN 'M';
        WHEN 'female' THEN
            RETURN 'F';
        WHEN 'f' THEN
            RETURN 'F';
        WHEN 'kobieta' THEN
            RETURN 'F';
        WHEN 'k' THEN
            RETURN 'F';
        ELSE
            RAISE EXCEPTION 'Invalid input for sex: %', input_sex;
    END CASE;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION calculate_total(result_id BIGINT)
RETURNS REAL AS $$
DECLARE
    squat_value REAL := 0;
    bench_value REAL := 0;
    deadlift_value REAL := 0;
BEGIN
    -- Fetch the highest successful squat value
    SELECT COALESCE(
        (SELECT sqt_third_attempt FROM squats WHERE id_squat = (SELECT id_sqt FROM results r WHERE r.id_result = result_id) AND sqt_third_attempt_success),
        (SELECT sqt_second_attempt FROM squats WHERE id_squat = (SELECT id_sqt FROM results r WHERE r.id_result = result_id) AND sqt_second_attempt_success),
        (SELECT sqt_first_attempt FROM squats WHERE id_squat = (SELECT id_sqt FROM results r WHERE r.id_result = result_id) AND sqt_first_attempt_success),
        0
    )
    INTO squat_value;

    -- Fetch the highest successful bench press value
    SELECT COALESCE(
        (SELECT bp_third_attempt FROM bench_press WHERE id_bench_press = (SELECT id_bp FROM results r WHERE r.id_result = result_id) AND bp_third_attempt_success),
        (SELECT bp_second_attempt FROM bench_press WHERE id_bench_press = (SELECT id_bp FROM results r WHERE r.id_result = result_id) AND bp_second_attempt_success),
        (SELECT bp_first_attempt FROM bench_press WHERE id_bench_press = (SELECT id_bp FROM results r WHERE r.id_result = result_id) AND bp_first_attempt_success),
        0
    )
    INTO bench_value;

    -- Fetch the highest successful deadlift value
    SELECT COALESCE(
        (SELECT dl_third_attempt FROM deadlifts WHERE id_deadlift = (SELECT id_dl FROM results r WHERE r.id_result = result_id) AND dl_third_attempt_success),
        (SELECT dl_second_attempt FROM deadlifts WHERE id_deadlift = (SELECT id_dl FROM results r WHERE r.id_result = result_id) AND dl_second_attempt_success),
        (SELECT dl_first_attempt FROM deadlifts WHERE id_deadlift = (SELECT id_dl FROM results r WHERE r.id_result = result_id) AND dl_first_attempt_success),
        0
    )
    INTO deadlift_value;

    RETURN total_calc(squat_value, bench_value, deadlift_value);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fetch_athlete_details(
    comp_type VARCHAR,
    age VARCHAR,
    weight_class VARCHAR,
    sex_input TEXT,
    limit_amount INT
)
RETURNS TABLE (
    first_name TEXT,
    surname TEXT,
    r_sex CHAR(1),
    r_sqt_first_attempt REAL,
    r_sqt_first_attempt_success BOOLEAN,
    r_sqt_second_attempt REAL,
    r_sqt_second_attempt_success BOOLEAN,
    r_sqt_third_attempt REAL,
    r_sqt_third_attempt_success BOOLEAN,
    r_bp_first_attempt REAL,
    r_bp_first_attempt_success BOOLEAN,
    r_bp_second_attempt REAL,
    r_bp_second_attempt_success BOOLEAN,
    r_bp_third_attempt REAL,
    r_bp_third_attempt_success BOOLEAN,
    r_dl_first_attempt REAL,
    r_dl_first_attempt_success BOOLEAN,
    r_dl_second_attempt REAL,
    r_dl_second_attempt_success BOOLEAN,
    r_dl_third_attempt REAL,
    r_dl_third_attempt_success BOOLEAN,
    r_total REAL,
    r_ipf_score REAL
) AS $$
DECLARE
sex_input_valid text := standardize_sex(sex_input);
BEGIN
    RETURN QUERY
    WITH athlete_data AS (
        SELECT
            c.fname,
            c.surname as lname,
            c.sex,
            sq.sqt_first_attempt,
            sq.sqt_first_attempt_success,
            sq.sqt_second_attempt,
            sq.sqt_second_attempt_success,
            sq.sqt_third_attempt,
            sq.sqt_third_attempt_success,
            bp.bp_first_attempt,
            bp.bp_first_attempt_success,
            bp.bp_second_attempt,
            bp.bp_second_attempt_success,
            bp.bp_third_attempt,
            bp.bp_third_attempt_success,
            dl.dl_first_attempt,
            dl.dl_first_attempt_success,
            dl.dl_second_attempt,
            dl.dl_second_attempt_success,
            dl.dl_third_attempt,
            dl.dl_third_attempt_success,
            calculate_total(
                r.id_result
            ) AS total,
            ipf_calc(
                calculate_total(
                r.id_result
            ),
                s.competitor_weight,
                c.sex
            ) AS ipf_score
        FROM
            results r
        JOIN starts s ON r.id_result = s.id_res
        JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
        JOIN competitors c ON ccs.id_cmptr = c.id_competitor
        JOIN competitions comp ON ccs.id_cmpt = comp.id_competition
        JOIN squats sq ON r.id_sqt = sq.id_squat
        JOIN bench_press bp ON r.id_bp = bp.id_bench_press
        JOIN deadlifts dl ON r.id_dl = dl.id_deadlift
        WHERE
            comp.competition_type = comp_type
            AND s.age_class = age_class
            AND s.weight_category = weight_class
            AND c.sex = sex_input_valid
    )
    SELECT
        fname,
        lname,
        sex,
        sqt_first_attempt,
        sqt_first_attempt_success,
        sqt_second_attempt,
        sqt_second_attempt_success,
        sqt_third_attempt,
        sqt_third_attempt_success,
        bp_first_attempt,
        bp_first_attempt_success,
        bp_second_attempt,
        bp_second_attempt_success,
        bp_third_attempt,
        bp_third_attempt_success,
        dl_first_attempt,
        dl_first_attempt_success,
        dl_second_attempt,
        dl_second_attempt_success,
        dl_third_attempt,
        dl_third_attempt_success,
        total,
        ipf_score
    FROM
        athlete_data
    ORDER BY
        ipf_score DESC
    LIMIT limit_amount;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------
----------------------------------------------------------------


-- Function to count athletes by sex and country with HAVING clause
-- Repaired Function to Count Athletes by Sex and Country
CREATE OR REPLACE FUNCTION count_athletes_by_sex_and_country(
    input_sex TEXT
)
RETURNS TABLE (
    country Varchar(47),
    athlete_count BigINT
) AS $$
DECLARE
    standardized_sex CHAR(1);
BEGIN
    IF input_sex IS NOT NULL THEN
        -- Standardize the input sex using the provided function
        standardized_sex := standardize_sex(input_sex);
        RETURN QUERY
        SELECT 
            c.country, 
            COUNT(*) AS athlete_count
        FROM 
            competitors c
        WHERE 
            c.sex = standardized_sex
        GROUP BY 
            c.country
        HAVING COUNT(*) > 0;
    ELSE
        RETURN QUERY
        SELECT 
            c.country, 
            COUNT(*) AS athlete_count
        FROM 
            competitors c
        GROUP BY 
            c.country
        HAVING COUNT(*) > 0;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Function to count federation competitions with HAVING clause
CREATE OR REPLACE FUNCTION count_federation_competitions(
    competition_type_input VARCHAR
)
RETURNS TABLE (
    federation_name TEXT,
    competition_count BIGINT
) AS $$
BEGIN
IF competition_type_input IS NOT NULL THEN
    RETURN QUERY
    SELECT
        f.fed_name AS federation_name,
        COUNT(c.id_competition) AS competition_count
    FROM
        federations f
    JOIN competition_federation cf ON f.id_federation = cf.id_fed
    JOIN competitions c ON cf.id_comp = c.id_competition
    WHERE
        c.competition_type = competition_type_input
    GROUP BY
        f.fed_name
    HAVING
        COUNT(c.id_competition) > 0
    ORDER BY
        competition_count DESC;
 ELSE
	RETURN QUERY
    SELECT
        f.fed_name AS federation_name,
        COUNT(c.id_competition) AS competition_count
    FROM
        federations f
    JOIN competition_federation cf ON f.id_federation = cf.id_fed
    JOIN competitions c ON cf.id_comp = c.id_competition
    GROUP BY
        f.fed_name
    HAVING
        COUNT(c.id_competition) > 0
    ORDER BY
        competition_count DESC;
end if;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fetch_athlete_details_by_name(
    athlete_name TEXT,
    athlete_surname TEXT
)
RETURNS TABLE (
    r_first_name TEXT,
    r_surname TEXT,
    r_sex CHAR(1),
    r_country varchar(47),
    r_competition_name TEXT,
    r_sqt_first_attempt REAL,
    r_sqt_first_attempt_success BOOLEAN,
    r_sqt_second_attempt REAL,
    r_sqt_second_attempt_success BOOLEAN,
    r_sqt_third_attempt REAL,
    r_sqt_third_attempt_success BOOLEAN,
    r_bp_first_attempt REAL,
    r_bp_first_attempt_success BOOLEAN,
    r_bp_second_attempt REAL,
    r_bp_second_attempt_success BOOLEAN,
    r_bp_third_attempt REAL,
    r_bp_third_attempt_success BOOLEAN,
    r_dl_first_attempt REAL,
    r_dl_first_attempt_success BOOLEAN,
    r_dl_second_attempt REAL,
    r_dl_second_attempt_success BOOLEAN,
    r_dl_third_attempt REAL,
    r_dl_third_attempt_success BOOLEAN,
    r_total_lift REAL,
    r_ipf_score REAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.fname AS first_name,
        c.surname,
        c.sex,
        c.country,
        comp.competition_name,
        sq.sqt_first_attempt,
        sq.sqt_first_attempt_success,
        sq.sqt_second_attempt,
        sq.sqt_second_attempt_success,
        sq.sqt_third_attempt,
        sq.sqt_third_attempt_success,
        bp.bp_first_attempt,
        bp.bp_first_attempt_success,
        bp.bp_second_attempt,
        bp.bp_second_attempt_success,
        bp.bp_third_attempt,
        bp.bp_third_attempt_success,
        dl.dl_first_attempt,
        dl.dl_first_attempt_success,
        dl.dl_second_attempt,
        dl.dl_second_attempt_success,
        dl.dl_third_attempt,
        dl.dl_third_attempt_success,
        calculate_total(r.id_result) AS total_lift,
        ipf_calc(
            calculate_total(r.id_result),
            s.competitor_weight,
            c.sex
        ) AS ipf_score
    FROM
        competitors c
    JOIN competition_competitors_starts ccs ON c.id_competitor = ccs.id_cmptr
    JOIN starts s ON ccs.id_str = s.id_start
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition
    JOIN results r ON s.id_res = r.id_result
    JOIN squats sq ON r.id_sqt = sq.id_squat
    JOIN bench_press bp ON r.id_bp = bp.id_bench_press
    JOIN deadlifts dl ON r.id_dl = dl.id_deadlift
    WHERE
        c.fname = athlete_name
        AND c.surname = athlete_surname;
END;
$$ LANGUAGE plpgsql;


-- Function to fetch competitions organized by a federation
CREATE OR REPLACE FUNCTION fetch_competitions_by_federation(
    federation_name TEXT
)
RETURNS TABLE (
    id_competition BIGINT,
    competition_name TEXT,
    competition_type VARCHAR(14),
    begin_date DATE,
    end_date DATE,
    loc_country VARCHAR(47),
    loc_city VARCHAR(58),
    prize_pool REAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.id_competition,
        c.competition_name,
        c.competition_type,
        c.begin_date,
        c.end_date,
        c.loc_country,
        c.loc_city,
        c.prize_pool
    FROM
        competitions c
    JOIN competition_federation cf ON c.id_competition = cf.id_comp
    JOIN federations f ON cf.id_fed = f.id_federation
    WHERE
        f.fed_name = federation_name;
END;
$$ LANGUAGE plpgsql;



-- Function to insert competition
CREATE OR REPLACE FUNCTION insert_competition(
    federation_id INT,
    competition_details JSONB
)
RETURNS BIGINT AS $$
DECLARE
    competition_id BIGINT;
BEGIN
    -- Insert competition
    INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool)
    VALUES (
        competition_details->>'competition_name',
        competition_details->>'competition_type',
        (competition_details->>'begin_date')::DATE,
        (competition_details->>'end_date')::DATE,
        competition_details->>'loc_country',
        competition_details->>'loc_city',
        (competition_details->>'prize_pool')::REAL
    ) RETURNING id_competition INTO competition_id;

    -- Associate competition with federation
    INSERT INTO competition_federation (id_fed, id_comp)
    VALUES (federation_id, competition_id);

    RETURN competition_id;
END;
$$ LANGUAGE plpgsql;

-- Function to insert related data for a competition
CREATE OR REPLACE FUNCTION insert_competition_related(
    competition_id BIGINT,
    competitor_details JSONB,
    competitor_weight REAL,
    weight_class TEXT,
    squat_details JSONB,
    bench_details JSONB,
    deadlift_details JSONB
)
RETURNS VOID AS $$
DECLARE
    competitor_id BIGINT;
    start_id BIGINT;
    result_id BIGINT;
    squat_id BIGINT;
    bench_id BIGINT;
    deadlift_id BIGINT;
BEGIN
    IF competitor_details->>'id_competitor' IS NOT NULL THEN
        competitor_id := (competitor_details->>'id_competitor')::BIGINT;
    ELSE
        INSERT INTO competitors (fname, surname, date_of_birth, country, sex)
        VALUES (
            competitor_details->>'fname',
            competitor_details->>'surname',
            (competitor_details->>'date_of_birth')::DATE,
            competitor_details->>'country',
            standardize_sex(competitor_details->>'sex')
        ) RETURNING id_competitor INTO competitor_id;
    END IF;

    weight_class := validate_weight_class(weight_class, competitor_weight);
    INSERT INTO squats (sqt_first_attempt, sqt_second_attempt, sqt_third_attempt, sqt_first_attempt_success, sqt_second_attempt_success, sqt_third_attempt_success)
    VALUES (
        (squat_details->>'sqt_first_attempt')::REAL,
        (squat_details->>'sqt_second_attempt')::REAL,
        (squat_details->>'sqt_third_attempt')::REAL,
        text_to_boolean(squat_details->>'sqt_first_attempt_success'),
        text_to_boolean(squat_details->>'sqt_second_attempt_success'),
        text_to_boolean(squat_details->>'sqt_third_attempt_success')
    ) RETURNING id_squat INTO squat_id;


    INSERT INTO bench_press (bp_first_attempt, bp_second_attempt, bp_third_attempt, bp_first_attempt_success, bp_second_attempt_success, bp_third_attempt_success)
    VALUES (
        (bench_details->>'bp_first_attempt')::REAL,
        (bench_details->>'bp_second_attempt')::REAL,
        (bench_details->>'bp_third_attempt')::REAL,
        text_to_boolean(bench_details->>'bp_first_attempt_success'),
        text_to_boolean(bench_details->>'bp_second_attempt_success'),
        text_to_boolean(bench_details->>'bp_third_attempt_success')
    ) RETURNING id_bench_press INTO bench_id;

    -- Insert deadlift
    INSERT INTO deadlifts (dl_first_attempt, dl_second_attempt, dl_third_attempt, dl_first_attempt_success, dl_second_attempt_success, dl_third_attempt_success)
    VALUES (
        (deadlift_details->>'dl_first_attempt')::REAL,
        (deadlift_details->>'dl_second_attempt')::REAL,
        (deadlift_details->>'dl_third_attempt')::REAL,
        text_to_boolean(deadlift_details->>'dl_first_attempt_success'),
        text_to_boolean(deadlift_details->>'dl_second_attempt_success'),
        text_to_boolean(deadlift_details->>'dl_third_attempt_success')
    ) RETURNING id_deadlift INTO deadlift_id;

    -- Insert result
    INSERT INTO results (id_sqt, id_bp, id_dl)
    VALUES (squat_id, bench_id, deadlift_id) RETURNING id_result INTO result_id;

    -- Insert start
    INSERT INTO starts (competitor_weight, weight_category, age_class, id_res)
    VALUES (
        competitor_weight,
        weight_class,
        get_competitor_age_category((competitor_details->>'date_of_birth')::DATE, (SELECT begin_date FROM competitions WHERE id_competition = competition_id)),
        result_id
    ) RETURNING id_start INTO start_id;

    -- Link start to competitor and competition
    INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr)
    VALUES (start_id, competition_id, competitor_id);
END;
$$ LANGUAGE plpgsql;



-- Function to delete a competitor's start
CREATE OR REPLACE FUNCTION delete_competitor_start(start_id BIGINT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM competition_competitors_starts WHERE id_str = start_id;
END;
$$ LANGUAGE plpgsql;

-- Function to update a competitor's personal data
CREATE OR REPLACE FUNCTION update_competitor_data(
    competitor_id BIGINT,
    in_fname TEXT,
    in_surname TEXT,
    in_country varchar(47),
    in_date_of_birth DATE,
    in_sex text
)
RETURNS VOID AS $$
BEGIN
    UPDATE competitors
    SET fname = in_fname,
        surname = in_surname,
        date_of_birth = in_date_of_birth,
		country = in_country,
        sex = standardize_sex(in_sex)
    WHERE id_competitor = competitor_id;
END;
$$ LANGUAGE plpgsql;



drop function list_requests_by_admin
-- Function to list requests where fulfilled is NULL and admin_id matches
CREATE OR REPLACE FUNCTION list_requests_by_admin(admin_id BIGINT)
RETURNS TABLE (out_id_request BIGINT, out_type_code SMALLINT, out_req_description text, out_fulfilled BOoLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT id_request, type_code, req_description, fulfilled
    FROM requests
    WHERE fulfilled IS NULL AND id_request IN (
        SELECT id_req
        FROM admin_request
        WHERE id_adm = admin_id
    );
END;
$$ LANGUAGE plpgsql;


-- Function to list all requests where fulfilled is NULL
CREATE OR REPLACE FUNCTION list_requests_unfulfilled()
RETURNS TABLE (out_id_request BIGINT, out_type_code SMALLINT, out_req_description text, out_fulfilled BoOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT id_request, type_code, req_description, fulfilled
    FROM requests
    WHERE fulfilled IS NULL;
END;
$$ LANGUAGE plpgsql;


-- Function to list all requests regardless of fulfillment status
-- Function to list all requests regardless of fulfillment status
CREATE OR REPLACE FUNCTION list_all_requests()
RETURNS TABLE (out_id_request BIGINT, out_type_code SMALLINT, out_req_description text, out_fulfilled BoOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT id_request, type_code, req_description, fulfilled
    FROM requests
	where fulfilled is not null;
END;
$$ LANGUAGE plpgsql;

-- Function to update request fulfillment
CREATE OR REPLACE FUNCTION update_request_fulfillment(
    request_id BIGINT,
    in_fulfilled BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    UPDATE requests
    SET fulfilled = in_fulfilled
    WHERE id_request = request_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION list_competitors_by_competition(competition_name_input TEXT)
RETURNS TABLE (
    r_first_name TEXT,
    r_surname TEXT,
    r_sex CHAR(1),
    r_sqt_first_attempt REAL,
    r_sqt_first_attempt_success BOOLEAN,
    r_sqt_second_attempt REAL,
    r_sqt_second_attempt_success BOOLEAN,
    r_sqt_third_attempt REAL,
    r_sqt_third_attempt_success BOOLEAN,
    r_bp_first_attempt REAL,
    r_bp_first_attempt_success BOOLEAN,
    r_bp_second_attempt REAL,
    r_bp_second_attempt_success BOOLEAN,
    r_bp_third_attempt REAL,
    r_bp_third_attempt_success BOOLEAN,
    r_dl_first_attempt REAL,
    r_dl_first_attempt_success BOOLEAN,
    r_dl_second_attempt REAL,
    r_dl_second_attempt_success BOOLEAN,
    r_dl_third_attempt REAL,
    r_dl_third_attempt_success BOOLEAN,
    r_total REAL,
    r_ipf_score REAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.fname AS first_name,
        c.surname,
        c.sex,
        sq.sqt_first_attempt,
        sq.sqt_first_attempt_success,
        sq.sqt_second_attempt,
        sq.sqt_second_attempt_success,
        sq.sqt_third_attempt,
        sq.sqt_third_attempt_success,
        bp.bp_first_attempt,
        bp.bp_first_attempt_success,
        bp.bp_second_attempt,
        bp.bp_second_attempt_success,
        bp.bp_third_attempt,
        bp.bp_third_attempt_success,
        dl.dl_first_attempt,
        dl.dl_first_attempt_success,
        dl.dl_second_attempt,
        dl.dl_second_attempt_success,
        dl.dl_third_attempt,
        dl.dl_third_attempt_success,
        calculate_total(
                r.id_result
            ) AS total,
        ipf_calc(
            calculate_total(
                r.id_result
            ),
            s.competitor_weight,
            c.sex
        ) AS ipf_score
    FROM competitions comp
    JOIN competition_competitors_starts ccs ON comp.id_competition = ccs.id_cmpt
    JOIN starts s ON ccs.id_str = s.id_start
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN results r ON s.id_res = r.id_result
    JOIN squats sq ON r.id_sqt = sq.id_squat
    JOIN bench_press bp ON r.id_bp = bp.id_bench_press
    JOIN deadlifts dl ON r.id_dl = dl.id_deadlift
    WHERE comp.competition_name = competition_name_input;
END;
$$ LANGUAGE plpgsql;



-- Function to return all distinct weight categories
CREATE OR REPLACE FUNCTION get_distinct_weight_categories()
RETURNS TABLE (
    weight_category VARCHAR(4)
) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT s.weight_category
    FROM starts s;
END;
$$ LANGUAGE plpgsql;


GRANT MAINTAIN ON MATERIALIZED VIEW top_100_male_results to superuser;

CREATE OR REPLACE FUNCTION get_requests_by_federation(federation_id INT)
RETURNS TABLE (
    out_id_request BIGINT,
    out_type_code SMALLINT,
    out_req_description TEXT,
    out_fulfilled BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.id_request,
        r.type_code,
        r.req_description,
        r.fulfilled
    FROM requests r
    JOIN admin_request ar ON r.id_request = ar.id_req
    JOIN admins a ON ar.id_adm = a.id_admin
    WHERE a.id_fed_adm = federation_id;
END;
$$ LANGUAGE plpgsql;
