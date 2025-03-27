-- Table for Competitors
CREATE TABLE competitors (
    id_competitor BIGSERIAL PRIMARY KEY,
    surname TEXT NOT NULL,
    fname TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    country VARCHAR(47) DEFAULT 'Świat',
    sex CHAR(1) NOT NULL
);

-- Table for Federations
CREATE TABLE federations (
    id_federation BIGSERIAL PRIMARY KEY,
    fed_name TEXT NOT NULL,
    date_of_creation DATE NOT NULL,
    federation_password VARCHAR(20) NOT NULL
);

-- Table for Competitions
CREATE TABLE competitions (
    id_competition BIGSERIAL PRIMARY KEY,
    competition_name text not null,
    competition_type VARCHAR(14) NOT NULL,
    begin_date DATE NOT NULL,
    end_date DATE NOT NULL,
    loc_country VARCHAR(47) NOT NULL,
    loc_city VARCHAR(58) NOT NULL,
    prize_pool REAL DEFAULT 0.0
);

-- Table for Starts
CREATE TABLE starts (
    id_start BIGSERIAL PRIMARY KEY,
    competitor_weight REAL NOT NULL,
    weight_category VARCHAR(4) NOT NULL,
    age_class VARCHAR(10) NOT NULL,
    id_res INT NOT NULL
);

-- Table for Results
CREATE TABLE results (
    id_result BIGSERIAL PRIMARY KEY,
    id_sqt INT NOT NULL,
    id_bp INT NOT NULL,
    id_dl INT NOT NULL
);

-- Table for Squats
CREATE TABLE squats (
    id_squat BIGSERIAL PRIMARY KEY,
    sqt_first_attempt REAL NOT NULL,
    sqt_first_attempt_success BOOLEAN NOT NULL,
    sqt_second_attempt REAL NOT NULL,
    sqt_second_attempt_success BOOLEAN NOT NULL,
    sqt_third_attempt REAL NOT NULL,
    sqt_third_attempt_success BOOLEAN NOT NULL
);

-- Table for Deadlifts
CREATE TABLE deadlifts (
    id_deadlift BIGSERIAL PRIMARY KEY,
    dl_first_attempt REAL NOT NULL,
    dl_first_attempt_success BOOLEAN NOT NULL,
    dl_second_attempt REAL NOT NULL,
    dl_second_attempt_success BOOLEAN NOT NULL,
    dl_third_attempt REAL NOT NULL,
    dl_third_attempt_success BOOLEAN NOT NULL
);

-- Table for Bench Press
CREATE TABLE bench_press (
    id_bench_press BIGSERIAL PRIMARY KEY,
    bp_first_attempt REAL NOT NULL,
    bp_first_attempt_success BOOLEAN NOT NULL,
    bp_second_attempt REAL NOT NULL,
    bp_second_attempt_success BOOLEAN NOT NULL,
    bp_third_attempt REAL NOT NULL,
    bp_third_attempt_success BOOLEAN NOT NULL
);

-- Table for Admins
CREATE TABLE admins (
    id_admin BIGSERIAL PRIMARY KEY,
    admin_login VARCHAR(20) NOT NULL,
    admin_password VARCHAR(20) NOT NULL,
    id_fed_adm INT,
    superadmin BOOLEAN NOT NULL
);

-- Table for Requests
CREATE TABLE requests (
    id_request BIGSERIAL PRIMARY KEY,
    id_federation_req INT,
    type_code SMALLINT NOT NULL,
    req_description TEXT,
    fulfilled BOOLEAN DEFAULT NULL
);

-- Table for Competition-Federation Relationship
CREATE TABLE competition_federation (
    id_comp_fed BIGSERIAL PRIMARY KEY,
    id_fed INT NOT NULL,
    id_comp INT NOT NULL
);

-- Table for Competition-Competitor-Starts Relationship
CREATE TABLE competition_competitors_starts (
    id_comp_compt_start BIGSERIAL PRIMARY KEY,
    id_str INT NOT NULL,
    id_cmpt INT NOT NULL,
    id_cmptr INT NOT NULL
);

-- Table for Admin-Requests Relationship
CREATE TABLE admin_request (
    id_adm_req BIGSERIAL PRIMARY KEY,
    id_adm INT NOT NULL,
    id_req INT NOT NULL
);
