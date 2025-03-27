-- Polish competitors
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Nowak', 'Anna', '1987-05-10', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Kowalski', 'Jan', '1990-03-15', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Wiśniewska', 'Maria', '1995-08-22', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Zielinski', 'Piotr', '1980-02-14', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Szymanska', 'Katarzyna', '1988-09-07', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Majewski', 'Tomasz', '1979-11-30', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Lewandowski', 'Zofia', '1993-06-19', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Kaczmarek', 'Marek', '1991-12-25', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Lis', 'Magdalena', '1985-04-08', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Wojcik', 'Andrzej', '1982-01-20', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Grabowski', 'Ewa', '1990-07-15', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Wieczorek', 'Krzysztof', '1992-09-10', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Kamińska', 'Agnieszka', '1986-03-30', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Baran', 'Grzegorz', '1989-11-11', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Ostrowska', 'Anna', '1994-02-18', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Duda', 'Paweł', '1983-10-27', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Jankowski', 'Joanna', '1997-04-05', 'Polska', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Sikorski', 'Łukasz', '1981-06-22', 'Polska', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Rutkowska', 'Magda', '1996-08-13', 'Polska', 'F');

-- Competitors from other countries
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Smith', 'John', '1990-05-12', 'Stany Zjednoczone', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Garcia', 'Maria', '1989-06-25', 'Hiszpania', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Fernandez', 'Carlos', '1985-09-30', 'Meksyk', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Schmidt', 'Laura', '1991-12-11', 'Niemcy', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Ivanov', 'Ivan', '1980-07-07', 'Rosja', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Yamada', 'Haruto', '1993-04-21', 'Japonia', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('OConnor', 'Siobhan', '1992-10-14', 'Irlandia', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Nakamura', 'Riku', '1996-03-03', 'Japonia', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Doe', 'Jane', '1998-07-27', 'Wielka Brytania', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Ali', 'Ahmed', '1984-11-18', 'Egipt', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Petrov', 'Sergey', '1986-01-09', 'Rosja', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Liu', 'Wei', '1995-02-14', 'Chiny', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Tanaka', 'Akiko', '1994-11-03', 'Japonia', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Nguyen', 'Minh', '1993-07-19', 'Wietnam', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Singh', 'Aisha', '1988-09-25', 'Indie', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Kim', 'Ji-Ho', '1989-05-17', 'Korea Południowa', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Müller', 'Hans', '1987-03-11', 'Niemcy', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Johnson', 'Emily', '1992-06-08', 'Wielka Brytania', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Dupont', 'Claire', '1995-12-20', 'Francja', 'F');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Ahmed', 'Youssef', '1983-04-15', 'Egipt', 'M');
INSERT INTO competitors (surname, fname, date_of_birth, country, sex) VALUES ('Chen', 'Li', '1990-08-02', 'Chiny', 'F');



INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) 
VALUES ('super', 'super', NULL, TRUE);


-- Insert federations into the federations table
INSERT INTO federations (fed_name, date_of_creation, federation_password) VALUES ('XPC', CURRENT_DATE, 'XPC123');
INSERT INTO federations (fed_name, date_of_creation, federation_password) VALUES ('WPC', CURRENT_DATE, 'WPC123');
INSERT INTO federations (fed_name, date_of_creation, federation_password) VALUES ('WPA', CURRENT_DATE, 'WPA123');
INSERT INTO federations (fed_name, date_of_creation, federation_password) VALUES ('PLT', CURRENT_DATE, 'PLT123');
INSERT INTO federations (fed_name, date_of_creation, federation_password) VALUES ('RAW', CURRENT_DATE, 'RAW123');




-- Insert admins for federations
INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) VALUES ('admin_xpc', 'XPC123', (SELECT id_federation FROM federations WHERE fed_name = 'XPC'), FALSE);
INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) VALUES ('admin_wpc', 'WPC123', (SELECT id_federation FROM federations WHERE fed_name = 'WPC'), FALSE);
INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) VALUES ('admin_wpa', 'WPA123', (SELECT id_federation FROM federations WHERE fed_name = 'WPA'), FALSE);
INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) VALUES ('admin_plt', 'PLT123', (SELECT id_federation FROM federations WHERE fed_name = 'PLT'), FALSE);
INSERT INTO admins (admin_login, admin_password, id_fed_adm, superadmin) VALUES ('admin_raw', 'RAW123', (SELECT id_federation FROM federations WHERE fed_name = 'RAW'), FALSE);


-- Insert competitions into the competitions table
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Raw Powerlifting Championship', 'Raw', '2025-03-01', '2025-03-03', 'Polska', 'Warszawa', 5000.0);
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Bandaże Open', 'Bandaże', '2025-04-15', '2025-04-17', 'Niemcy', 'Berlin', 3000.0);
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Raw + Bandaże Cup', 'Raw + Bandaże', '2025-05-10', '2025-05-12', 'Stany Zjednoczone', 'Chicago', 7000.0);
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Jednowarstwowy Clash', 'Jednowarstwowy', '2025-06-20', '2025-06-22', 'Wielka Brytania', 'Londyn', 4500.0);
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Wielowarstwowy Battle', 'Wielowarstwowy', '2025-07-15', '2025-07-18', 'Francja', 'Paryż', 6000.0);
INSERT INTO competitions (competition_name, competition_type, begin_date, end_date, loc_country, loc_city, prize_pool) VALUES ('Nielimitowany Showdown', 'Nielimitowany', '2025-08-05', '2025-08-08', 'Kanada', 'Toronto', 8000.0);


insert into competition_federation (id_fed, id_comp) values(1, 1);
insert into competition_federation (id_fed, id_comp) values(2, 2);
insert into competition_federation (id_fed, id_comp) values(3, 3);
insert into competition_federation (id_fed, id_comp) values(4, 4);
insert into competition_federation (id_fed, id_comp) values(5, 5);
insert into competition_federation (id_fed, id_comp) values(1, 4);
insert into competition_federation (id_fed, id_comp) values(2, 3);

-- Insert results into the squats table
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (140.0, TRUE, 150.0, FALSE, 160.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (145.0, FALSE, 155.0, TRUE, 165.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (150.0, TRUE, 160.0, TRUE, 170.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (155.0, FALSE, 165.0, TRUE, 175.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (160.0, TRUE, 170.0, TRUE, 180.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (165.0, FALSE, 175.0, TRUE, 185.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (170.0, TRUE, 180.0, TRUE, 190.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (175.0, TRUE, 185.0, FALSE, 195.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (180.0, TRUE, 190.0, TRUE, 200.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (185.0, FALSE, 195.0, TRUE, 205.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (190.0, TRUE, 200.0, TRUE, 210.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (195.0, TRUE, 205.0, FALSE, 215.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (200.0, TRUE, 210.0, TRUE, 220.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (205.0, FALSE, 215.0, TRUE, 225.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (210.0, TRUE, 220.0, TRUE, 230.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (215.0, TRUE, 225.0, FALSE, 235.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (220.0, TRUE, 230.0, TRUE, 240.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (225.0, FALSE, 235.0, TRUE, 245.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (230.0, TRUE, 240.0, TRUE, 250.0, true);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (300.0, TRUE, 310.0, FALSE, 320.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (305.0, TRUE, 315.0, TRUE, 325.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (310.0, TRUE, 320.0, TRUE, 330.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (315.0, FALSE, 325.0, TRUE, 335.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (320.0, TRUE, 330.0, TRUE, 340.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (325.0, TRUE, 335.0, FALSE, 345.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (330.0, TRUE, 340.0, TRUE, 350.0, FALSE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (335.0, TRUE, 345.0, TRUE, 355.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (340.0, TRUE, 350.0, FALSE, 360.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (345.0, TRUE, 355.0, TRUE, 365.0, TRUE);
INSERT INTO squats (sqt_first_attempt, sqt_first_attempt_success, sqt_second_attempt, sqt_second_attempt_success, sqt_third_attempt, sqt_third_attempt_success) VALUES (350.0, TRUE, 360.0, FALSE, 370.0, TRUE);




INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (100.0, TRUE, 102.5, TRUE, 105.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (105.0, TRUE, 107.5, TRUE, 110.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (110.0, FALSE, 112.5, TRUE, 115.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (115.0, TRUE, 117.5, FALSE, 120.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (120.0, TRUE, 122.5, TRUE, 125.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (125.0, FALSE, 127.5, TRUE, 130.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (130.0, TRUE, 132.5, TRUE, 135.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (135.0, TRUE, 137.5, FALSE, 140.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (140.0, TRUE, 142.5, TRUE, 145.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (145.0, TRUE, 147.5, FALSE, 150.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (150.0, TRUE, 152.5, TRUE, 155.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (155.0, FALSE, 157.5, TRUE, 160.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (160.0, TRUE, 162.5, TRUE, 165.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (165.0, TRUE, 167.5, FALSE, 170.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (170.0, TRUE, 172.5, TRUE, 175.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (175.0, FALSE, 177.5, TRUE, 180.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (180.0, TRUE, 182.5, TRUE, 185.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (185.0, TRUE, 187.5, FALSE, 190.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (190.0, TRUE, 192.5, TRUE, 195.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (195.0, FALSE, 197.5, TRUE, 200.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (200.0, TRUE, 202.5, FALSE, 205.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (205.0, TRUE, 207.5, TRUE, 210.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (210.0, TRUE, 212.5, FALSE, 215.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (215.0, TRUE, 217.5, TRUE, 220.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (220.0, TRUE, 222.5, TRUE, 225.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (225.0, FALSE, 227.5, TRUE, 230.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (230.0, TRUE, 232.5, FALSE, 235.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (235.0, TRUE, 237.5, TRUE, 240.0, TRUE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (240.0, TRUE, 242.5, TRUE, 245.0, FALSE);
INSERT INTO bench_press (bp_first_attempt, bp_first_attempt_success, bp_second_attempt, bp_second_attempt_success, bp_third_attempt, bp_third_attempt_success) VALUES (245.0, TRUE, 247.5, FALSE, 250.0, TRUE);



INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (250.0, TRUE, 260.0, TRUE, 270.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (255.0, TRUE, 265.0, FALSE, 275.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (260.0, FALSE, 270.0, TRUE, 280.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (265.0, TRUE, 275.0, TRUE, 285.0, FALSE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (270.0, TRUE, 280.0, TRUE, 290.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (275.0, TRUE, 285.0, FALSE, 295.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (280.0, TRUE, 290.0, TRUE, 300.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (285.0, FALSE, 295.0, TRUE, 305.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (290.0, TRUE, 300.0, TRUE, 310.0, FALSE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (295.0, TRUE, 305.0, FALSE, 315.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (300.0, TRUE, 310.0, TRUE, 320.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (305.0, TRUE, 315.0, TRUE, 325.0, FALSE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (310.0, TRUE, 320.0, FALSE, 330.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (315.0, TRUE, 325.0, TRUE, 335.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (320.0, FALSE, 330.0, TRUE, 340.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (325.0, TRUE, 335.0, TRUE, 345.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (330.0, TRUE, 340.0, TRUE, 350.0, FALSE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (335.0, TRUE, 345.0, FALSE, 355.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (340.0, TRUE, 350.0, TRUE, 360.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (345.0, FALSE, 355.0, TRUE, 365.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (350.0, TRUE, 360.0, TRUE, 370.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (355.0, TRUE, 365.0, FALSE, 375.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (360.0, TRUE, 370.0, TRUE, 380.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (365.0, FALSE, 375.0, TRUE, 385.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (370.0, TRUE, 380.0, TRUE, 390.0, FALSE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (375.0, TRUE, 385.0, TRUE, 395.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (380.0, TRUE, 390.0, TRUE, 400.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (385.0, TRUE, 395.0, FALSE, 405.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (390.0, TRUE, 400.0, TRUE, 410.0, TRUE);
INSERT INTO deadlifts (dl_first_attempt, dl_first_attempt_success, dl_second_attempt, dl_second_attempt_success, dl_third_attempt, dl_third_attempt_success) VALUES (420.0, TRUE, 430.0, TRUE, 460.0, TRUE);



-- Insert results into the results table
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (1, 2, 3);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (4, 5, 6);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (7, 8, 9);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (10, 11, 12);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (13, 14, 15);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (16, 17, 18);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (19, 20, 21);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (22, 23, 24);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (25, 26, 27);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (28, 29, 30);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (30, 1, 2);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (3, 4, 5);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (6, 7, 8);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (9, 10, 11);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (12, 13, 14);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (15, 16, 17);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (18, 19, 20);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (21, 22, 23);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (24, 25, 26);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (27, 28, 29);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (2, 3, 1);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (5, 6, 4);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (8, 9, 7);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (11, 12, 10);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (14, 15, 13);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (17, 18, 16);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (20, 21, 19);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (23, 24, 22);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (26, 27, 25);
INSERT INTO results (id_sqt, id_bp, id_dl) VALUES (29, 30, 28);


select *  from competitors c ;

-- Insert results into the starts table
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (57.0, '-59', 'Seniors', 1);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (64.0, '-66', 'Seniors', 2);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (72.0, '-74', 'Seniors', 3);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (81.0, '-83', 'Seniors', 4);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (91.0, '-93', 'Seniors', 5);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (103.0, '-105', 'Seniors', 6);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (118.0, '-120', 'Seniors', 7);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (139.0, '120+', 'Seniors', 8);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (56.5, '-59', 'Seniors', 9);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (65.5, '-66', 'Seniors', 10);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (73.0, '-74', 'Seniors', 11);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (82.5, '-83', 'Seniors', 12);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (92.0, '-93', 'Seniors', 13);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (104.5, '-105', 'Seniors', 14);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (119.5, '-120', 'Seniors', 15);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (137.5, '120+', 'Seniors', 16);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (58.5, '-59', 'Seniors', 17);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (63.5, '-66', 'Seniors', 18);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (71.0, '-74', 'Seniors', 19);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (80.0, '-83', 'Seniors', 20);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (90.0, '-93', 'Seniors', 21);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (102.5, '-105', 'Seniors', 22);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (117.0, '-120', 'Seniors', 23);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (138.0, '120+', 'Seniors', 24);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (57.5, '-59', 'Seniors', 25);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (66.0, '-66', 'Seniors', 26);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (73.5, '-74', 'Seniors', 27);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (82.0, '-83', 'Seniors', 28);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (92.5, '-93', 'Seniors', 29);
INSERT INTO starts (competitor_weight, weight_category, age_class, id_res) VALUES (103.5, '-105', 'Seniors', 30);


-- Insert into competition_competitors_starts table
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (28, 1, 2);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (29, 1, 3);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (30, 1, 4);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (31, 1, 5);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (32, 1, 6);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (33, 2, 7);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (34, 2, 8);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (35, 2, 9);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (36, 2, 10);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (37, 2, 11);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (38, 3, 12);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (39, 3, 13);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (40, 3, 14);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (41, 3, 15);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (42, 3, 16);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (43, 4, 17);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (44, 4, 18);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (45, 4, 19);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (46, 4, 20);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (47, 4, 21);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (48, 5, 22);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (49, 5, 23);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (50, 5, 24);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (51, 5, 25);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (52, 5, 26);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (53, 6, 27);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (54, 6, 28);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (55, 6, 29);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (56, 6, 30);
INSERT INTO competition_competitors_starts (id_str, id_cmpt, id_cmptr) VALUES (57, 6, 31);



