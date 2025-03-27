-- Fixed Materialized View for Top 100 Male Results
CREATE MATERIALIZED VIEW top_100_male_results AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        s.weight_category,
        comp.competition_type,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, 'M') AS ipf_score, -- Use the IPF calculation function
        comp.competition_name
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
    WHERE
        c.sex = 'M' -- Filter only male competitors
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;


-- Function to refresh the materialized view
CREATE OR REPLACE FUNCTION refresh_top_100_male_results()
RETURNS TRIGGER AS $$
BEGIN
    DROP MATERIALIZED VIEW top_100_male_results;
    CREATE MATERIALIZED VIEW top_100_male_results AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        s.weight_category,
        comp.competition_type,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, 'M') AS ipf_score, -- Use the IPF calculation function
        comp.competition_name
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
    WHERE
        c.sex = 'M' -- Filter only male competitors
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Triggers for Top 100 Male Results
CREATE TRIGGER after_results_change
AFTER INSERT OR UPDATE OR DELETE ON results
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_male_results();

CREATE TRIGGER after_competitors_change
AFTER INSERT OR UPDATE OR DELETE ON competitors
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_male_results();

CREATE TRIGGER after_starts_change
AFTER INSERT OR UPDATE OR DELETE ON starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_male_results();

CREATE TRIGGER after_competition_competitors_starts_change
AFTER INSERT OR UPDATE OR DELETE ON competition_competitors_starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_male_results();

CREATE TRIGGER after_competitions_change
AFTER INSERT OR UPDATE OR DELETE ON competitions
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_male_results();

-- Materialized View for Top 100 Female Results
CREATE MATERIALIZED VIEW top_100_female_results AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        comp.competition_type,
        s.weight_category,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, 'F') AS ipf_score, -- Use the IPF calculation function
        comp.competition_name
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
    WHERE
        c.sex = 'F' -- Filter only male competitors
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;


-- Function to refresh the materialized view
CREATE OR REPLACE FUNCTION refresh_top_100_female_results()
RETURNS TRIGGER AS $$
BEGIN
    Drop materialized VIEW top_100_female_results;
    CREATE MATERIALIZED VIEW top_100_female_results AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        comp.competition_type,
        s.weight_category,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, 'F') AS ipf_score, -- Use the IPF calculation function
        comp.competition_name
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
    WHERE
        c.sex = 'F' -- Filter only male competitors
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Triggers for Top 100 Female Results
CREATE TRIGGER after_results_change_f
AFTER INSERT OR UPDATE OR DELETE ON results
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_female_results();

CREATE TRIGGER after_competitors_change_f
AFTER INSERT OR UPDATE OR DELETE ON competitors
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_female_results();

CREATE TRIGGER after_starts_change_f
AFTER INSERT OR UPDATE OR DELETE ON starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_female_results();

CREATE TRIGGER after_competition_competitors_starts_change_f
AFTER INSERT OR UPDATE OR DELETE ON competition_competitors_starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_female_results();

CREATE TRIGGER after_competitions_change_f
AFTER INSERT OR UPDATE OR DELETE ON competitions
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_female_results();

-- Materialized View for Top 100 Overall Athletes
CREATE MATERIALIZED VIEW top_100_athletes AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        s.weight_category,
        comp.competition_type,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, c.sex) AS ipf_score, -- Use the IPF calculation function
        comp.competition_name,
        c.sex AS sex
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score,
    sex
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;

-- Function to refresh the materialized view
CREATE OR REPLACE FUNCTION refresh_top_100_athletes()
RETURNS TRIGGER AS $$
BEGIN
    drop MATERIALIZED VIEW  top_100_athletes;
    CREATE MATERIALIZED VIEW top_100_athletes AS
WITH competitor_data AS (
    SELECT
        c.fname AS first_name,
        c.surname,
        s.age_class AS age_category,
        s.competitor_weight AS weight,
        s.weight_category,
        comp.competition_type,
        calculate_total(r.id_result) AS total, -- Use the previously created function
        ipf_calc(calculate_total(r.id_result), s.competitor_weight, c.sex) AS ipf_score, -- Use the IPF calculation function
        comp.competition_name,
        c.sex AS sex
    FROM
        results r
    JOIN starts s ON r.id_result = s.id_res
    JOIN competition_competitors_starts ccs ON s.id_start = ccs.id_str
    JOIN competitors c ON ccs.id_cmptr = c.id_competitor
    JOIN competitions comp ON ccs.id_cmpt = comp.id_competition -- Correct join using competition_competitors_starts
)
SELECT
    first_name,
    surname,
    age_category,
    weight,
    weight_category,
    competition_type,
    competition_name,
    total,
    ipf_score,
    sex
FROM
    competitor_data
ORDER BY
    ipf_score DESC -- Rank by IPF score, highest first
LIMIT 100;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Triggers for Top 100 Overall Athletes
CREATE TRIGGER after_results_change_all
AFTER INSERT OR UPDATE OR DELETE ON results
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_athletes();

CREATE TRIGGER after_competitors_change_all
AFTER INSERT OR UPDATE OR DELETE ON competitors
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_athletes();

CREATE TRIGGER after_starts_change_all
AFTER INSERT OR UPDATE OR DELETE ON starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_athletes();

CREATE TRIGGER after_competition_competitors_starts_change_all
AFTER INSERT OR UPDATE OR DELETE ON competition_competitors_starts
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_athletes();

CREATE TRIGGER after_competitions_change_all
AFTER INSERT OR UPDATE OR DELETE ON competitions
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_top_100_athletes();


CREATE UNIQUE INDEX idx_top_100_male_results_unique
ON top_100_male_results (first_name, surname, competition_name);

CREATE UNIQUE INDEX idx_top_100_female_results_unique
ON top_100_female_results (first_name, surname, competition_name);

CREATE UNIQUE INDEX idx_top_100_athletes_unique
ON top_100_athletes (first_name, surname, competition_name);





