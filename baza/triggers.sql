CREATE OR REPLACE FUNCTION check_insert_update_results()
RETURNS TRIGGER AS $$
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM results
        WHERE id_sqt = NEW.id_sqt
          AND id_bp = NEW.id_bp
          AND id_dl = NEW.id_dl
          AND id_result != NEW.id_result
    ) THEN
        RAISE EXCEPTION 'Duplicate combination of id_sqt %, id_bp %, and id_dl % on %.', 
        NEW.id_sqt, NEW.id_bp, NEW.id_dl, NEW.id_result;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_results_before_insert_update
BEFORE insert OR UPDATE ON results
FOR EACH ROW
EXECUTE FUNCTION check_insert_update_results();
-------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_insert_update_ccs()
RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (
        SELECT 1
        FROM competition_competitors_starts
        WHERE id_str = NEW.id_str
          AND id_cmpt = NEW.id_cmpt
          AND id_cmptr = NEW.id_cmptr
          AND id_comp_compt_start != NEW.id_comp_compt_start 
    ) THEN
        RAISE EXCEPTION 'Duplicate entry for id_str %, id_cmpt %, and id_cmptr % on %.',
        NEW.id_str, NEW.id_cmpt, NEW.id_cmptr, NEW.id_comp_compt_start;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_ccs_before_insert_update
BEFORE INSERT OR UPDATE ON competition_competitors_starts
FOR EACH ROW
EXECUTE FUNCTION check_insert_update_ccs();
------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_insert_update_ar()
RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (
        SELECT 1
        FROM admin_request
        WHERE id_adm = NEW.id_adm
          AND id_req = NEW.id_req
          AND id_adm_req != NEW.id_adm_req 
    ) THEN
        RAISE EXCEPTION 'Duplicate entry for id_adm % and id_req % on %',
        NEW.id_adm, NEW.id_req, NEW.id_adm_req;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_ar_before_insert_update
BEFORE INSERT OR UPDATE ON admin_request
FOR EACH ROW
EXECUTE FUNCTION check_insert_update_ar();
---------------------------------------------------




CREATE OR REPLACE FUNCTION check_unique_federation_name()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM federations
        WHERE fed_name = NEW.fed_name
          AND id_federation != NEW.id_federation 
    ) THEN
        RAISE EXCEPTION 'Federation name "%" already exists in the database on %.', NEW.fed_name, NEW.id_federation;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_unique_federation_name
BEFORE INSERT OR UPDATE ON federations
FOR EACH ROW
EXECUTE FUNCTION check_unique_federation_name();
----------------------------------------------------


CREATE OR REPLACE FUNCTION check_unique_admin_login()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM admins
        WHERE admin_login = NEW.admin_login
          AND id_admin != NEW.id_admin 
    ) THEN
        RAISE EXCEPTION 'Admin login "%" already exists in the database on %.', NEW.admin_login, NEW.id_admin;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_unique_admin_login
BEFORE INSERT OR UPDATE ON admins
FOR EACH ROW
EXECUTE FUNCTION check_unique_admin_login();
----------------------------------------------------


CREATE OR REPLACE FUNCTION handle_admin_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM admin_request
    WHERE id_adm = OLD.id_admin;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_admin_delete
BEFORE DELETE ON admins
FOR EACH ROW
EXECUTE FUNCTION handle_admin_delete();
--------------------------------------


CREATE OR REPLACE FUNCTION handle_request_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM admin_request
    WHERE id_req = OLD.id_request;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_request_delete
BEFORE DELETE ON requests
FOR EACH ROW
EXECUTE FUNCTION handle_request_delete();
-------------------------------------------

CREATE OR REPLACE FUNCTION handle_results_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM bench_press WHERE id_bench_press = OLD.id_bp;
    DELETE FROM deadlifts WHERE id_deadlift = OLD.id_dl;
    DELETE FROM squats WHERE id_squat = OLD.id_sqt;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_results_delete
AFTER DELETE ON results
FOR EACH ROW
EXECUTE FUNCTION handle_results_delete();
--------------------------------------

CREATE OR REPLACE FUNCTION handle_ccs_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM starts WHERE id_start = OLD.id_str;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_ccs_delete
AFTER DELETE ON competition_competitors_starts
FOR EACH ROW
EXECUTE FUNCTION handle_ccs_delete();
--------------------------------------


CREATE OR REPLACE FUNCTION check_insert_update_cf()
RETURNS TRIGGER AS $$
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM competition_federation
        WHERE id_fed = NEW.id_fed
          AND id_comp = NEW.id_comp
          AND id_comp_fed != NEW.id_comp_fed
    ) THEN
        RAISE EXCEPTION 'Duplicate combination of id_fed %, id_comp  % on %.', 
		NEW.id_fed, NEW.id_comp, NEW.id_comp_fed;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_cf_before_insert_update
BEFORE insert OR UPDATE ON competition_federation
FOR EACH ROW
EXECUTE FUNCTION check_insert_update_cf();

----------------------------------------------------
CREATE OR REPLACE FUNCTION handle_competitions_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM competition_federation WHERE id_comp = OLD.id_competition;
    DELETE FROM competition_competitors_starts WHERE id_cmpt = OLD.id_competition;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_competitions_delete
BEFORE DELETE ON competitions
FOR EACH ROW
EXECUTE FUNCTION handle_competitions_delete();
----------------------------------------------------

CREATE OR REPLACE FUNCTION handle_competitors_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM competition_competitors_starts WHERE id_cmptr = OLD.id_competitor;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_competitors_delete
BEFORE DELETE ON competitors
FOR EACH ROW
EXECUTE FUNCTION handle_competitors_delete();
------------------------------------------------------

CREATE OR REPLACE FUNCTION handle_federations_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM competition_federation WHERE id_fed = OLD.id_federation;
	DELETE FROM admins WHERE id_fed_adm = OLD.id_federation;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_federations_delete
BEFORE DELETE ON federations
FOR EACH ROW
EXECUTE FUNCTION handle_federations_delete();
------------------------------------------------------


CREATE OR REPLACE FUNCTION handle_starts_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM results WHERE id_result= OLD.id_res;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_starts_delete
AFTER DELETE ON starts
FOR EACH ROW
EXECUTE FUNCTION handle_starts_delete();
----------------------------------------------------

CREATE OR REPLACE FUNCTION check_insert_update_starts()
RETURNS TRIGGER AS $$
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM starts
        WHERE id_res = NEW.id_res
          AND id_start != NEW.id_start
    ) THEN
        RAISE EXCEPTION 'Duplicate of id_res % on %.', 
		NEW.id_res, NEW.id_start;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_starts_before_insert_update
BEFORE insert OR UPDATE ON starts
FOR EACH ROW
EXECUTE FUNCTION check_insert_update_starts();


-- Trigger function for validating weight and weight category
CREATE OR REPLACE FUNCTION validate_and_insert_weight_class()
RETURNS TRIGGER AS $$
BEGIN
    -- Validate and standardize the weight category using the provided function
    NEW.weight_category := validate_weight_class(NEW.weight_category, NEW.competitor_weight);

    -- Return the modified record for insertion
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add the trigger to the starts table
CREATE TRIGGER validate_weight_category_trigger
BEFORE INSERT OR UPDATE ON starts
FOR EACH ROW
EXECUTE FUNCTION validate_and_insert_weight_class();
