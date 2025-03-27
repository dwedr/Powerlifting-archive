ALTER TABLE competitors
ADD CONSTRAINT dob_constraint CHECK (date_of_birth >= '1864-01-01'),
ADD CONSTRAINT country_constraint CHECK (country IN (
    'Afganistan', 'Albania', 'Algieria', 'Andora', 'Angola', 'Antigua i Barbuda', 
    'Arabia Saudyjska', 'Argentyna', 'Armenia', 'Australia', 'Austria', 'Azerbejdżan', 
    'Bahamy', 'Bahrajn', 'Bangladesz', 'Barbados', 'Belgia', 'Belize', 'Benin', 'Bhutan', 
    'Białoruś', 'Boliwia', 'Bośnia i Hercegowina', 'Botswana', 'Brazylia', 'Brunei', 
    'Bułgaria', 'Burkina Faso', 'Burundi', 'Chile', 'Chiny', 'Chorwacja', 'Cypr', 'Czarnogóra', 
    'Czechy', 'Dania', 'Dominika', 'Dominikana', 'Dżibuti', 'Ekwador', 'Egipt', 'Erytrea', 
    'Estonia', 'Eswatini', 'Etiopia', 'Fidżi', 'Filipiny', 'Finlandia', 'Francja', 'Gabon', 
    'Gambia', 'Ghana', 'Grecja', 'Grenada', 'Gruzja', 'Gujana', 'Gwatemala', 'Gwinea', 
    'Gwinea Bissau', 'Gwinea Równikowa', 'Haiti', 'Hiszpania', 'Holandia', 'Honduras', 'Indie', 
    'Indonezja', 'Irak', 'Iran', 'Irlandia', 'Islandia', 'Izrael', 'Jamajka', 'Japonia', 
    'Jemen', 'Jordania', 'Kambodża', 'Kamerun', 'Kanada', 'Katar', 'Kazachstan', 'Kenia', 
    'Kirgistan', 'Kiribati', 'Kolumbia', 'Komory', 'Kongo', 'Korea Południowa', 'Korea Północna', 
    'Kostaryka', 'Kosowo', 'Kuba', 'Kuwejt', 'Laos', 'Lesotho', 'Liban', 'Liberia', 'Libia', 
    'Liechtenstein', 'Litwa', 'Luksemburg', 'Łotwa', 'Macedonia Północna', 'Madagaskar', 
    'Malawi', 'Malediwy', 'Malezja', 'Mali', 'Malta', 'Maroko', 'Mauretania', 'Mauritius', 
    'Meksyk', 'Mikronezja', 'Mjanma', 'Mołdawia', 'Monako', 'Mongolia', 'Mozambik', 'Namibia', 
    'Nauru', 'Nepal', 'Niemcy', 'Niger', 'Nigeria', 'Nikaragua', 'Norwegia', 'Nowa Zelandia', 
    'Oman', 'Pakistan', 'Palau', 'Panama', 'Papua-Nowa Gwinea', 'Paragwaj', 'Peru', 'Polska', 
    'Portugalia', 'Republika Południowej Afryki', 'Republika Środkowoafrykańska', 
    'Republika Zielonego Przylądka', 'Rosja', 'Rumunia', 'Rwanda', 'Saint Kitts i Nevis', 
    'Saint Lucia', 'Saint Vincent i Grenadyny', 'Salwador', 'Samoa', 'San Marino', 'Senegal', 
    'Serbia', 'Seszele', 'Sierra Leone', 'Singapur', 'Słowacja', 'Słowenia', 'Somalia', 
    'Sri Lanka', 'Stany Zjednoczone', 'Sudan', 'Sudan Południowy', 'Surinam', 'Syria', 
    'Szwajcaria', 'Szwecja', 'Tadżykistan', 'Tajlandia', 'Tanzania', 'Togo', 'Tonga', 
    'Trynidad i Tobago', 'Tunezja', 'Turcja', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraina', 
    'Urugwaj', 'Uzbekistan', 'Vanuatu', 'Watykan', 'Wenezuela', 'Węgry', 'Wielka Brytania', 
    'Wietnam', 'Włochy', 'Wybrzeże Kości Słoniowej', 'Wyspy Marshalla', 'Wyspy Salomona', 
    'Zambia', 'Zimbabwe', 'Zjednoczone Emiraty Arabskie', 'Świat'
)),
ADD CONSTRAINT sex_constraint CHECK (sex IN ('M', 'F'));

ALTER TABLE federations
ADD CONSTRAINT doc_constraint CHECK (date_of_creation >= '1958-01-01'),
ADD CONSTRAINT unique_federation_name UNIQUE (fed_name);

ALTER TABLE competitions
ADD CONSTRAINT comp_type_constraint CHECK (competition_type IN (
    'Raw', 'Bandaże', 'Raw + Bandaże', 'Jednowarstwowy', 'Wielowarstwowy', 'Nielimitowany'
)),
ADD CONSTRAINT begin_constraint CHECK (begin_date >= '1964-01-01'),
ADD CONSTRAINT end_constraint CHECK (end_date >= begin_date),
ADD CONSTRAINT loc_country_constraint CHECK (loc_country IN (
    'Afganistan', 'Albania', 'Algieria', 'Andora', 'Angola', 'Antigua i Barbuda', 
    'Arabia Saudyjska', 'Argentyna', 'Armenia', 'Australia', 'Austria', 'Azerbejdżan', 
    'Bahamy', 'Bahrajn', 'Bangladesz', 'Barbados', 'Belgia', 'Belize', 'Benin', 'Bhutan', 
    'Białoruś', 'Boliwia', 'Bośnia i Hercegowina', 'Botswana', 'Brazylia', 'Brunei', 
    'Bułgaria', 'Burkina Faso', 'Burundi', 'Chile', 'Chiny', 'Chorwacja', 'Cypr', 'Czarnogóra', 
    'Czechy', 'Dania', 'Dominika', 'Dominikana', 'Dżibuti', 'Ekwador', 'Egipt', 'Erytrea', 
    'Estonia', 'Eswatini', 'Etiopia', 'Fidżi', 'Filipiny', 'Finlandia', 'Francja', 'Gabon', 
    'Gambia', 'Ghana', 'Grecja', 'Grenada', 'Gruzja', 'Gujana', 'Gwatemala', 'Gwinea', 
    'Gwinea Bissau', 'Gwinea Równikowa', 'Haiti', 'Hiszpania', 'Holandia', 'Honduras', 'Indie', 
    'Indonezja', 'Irak', 'Iran', 'Irlandia', 'Islandia', 'Izrael', 'Jamajka', 'Japonia', 
    'Jemen', 'Jordania', 'Kambodża', 'Kamerun', 'Kanada', 'Katar', 'Kazachstan', 'Kenia', 
    'Kirgistan', 'Kiribati', 'Kolumbia', 'Komory', 'Kongo', 'Korea Południowa', 'Korea Północna', 
    'Kostaryka', 'Kosowo', 'Kuba', 'Kuwejt', 'Laos', 'Lesotho', 'Liban', 'Liberia', 'Libia', 
    'Liechtenstein', 'Litwa', 'Luksemburg', 'Łotwa', 'Macedonia Północna', 'Madagaskar', 
    'Malawi', 'Malediwy', 'Malezja', 'Mali', 'Malta', 'Maroko', 'Mauretania', 'Mauritius', 
    'Meksyk', 'Mikronezja', 'Mjanma', 'Mołdawia', 'Monako', 'Mongolia', 'Mozambik', 'Namibia', 
    'Nauru', 'Nepal', 'Niemcy', 'Niger', 'Nigeria', 'Nikaragua', 'Norwegia', 'Nowa Zelandia', 
    'Oman', 'Pakistan', 'Palau', 'Panama', 'Papua-Nowa Gwinea', 'Paragwaj', 'Peru', 'Polska', 
    'Portugalia', 'Republika Południowej Afryki', 'Republika Środkowoafrykańska', 
    'Republika Zielonego Przylądka', 'Rosja', 'Rumunia', 'Rwanda', 'Saint Kitts i Nevis', 
    'Saint Lucia', 'Saint Vincent i Grenadyny', 'Salwador', 'Samoa', 'San Marino', 'Senegal', 
    'Serbia', 'Seszele', 'Sierra Leone', 'Singapur', 'Słowacja', 'Słowenia', 'Somalia', 
    'Sri Lanka', 'Stany Zjednoczone', 'Sudan', 'Sudan Południowy', 'Surinam', 'Syria', 
    'Szwajcaria', 'Szwecja', 'Tadżykistan', 'Tajlandia', 'Tanzania', 'Togo', 'Tonga', 
    'Trynidad i Tobago', 'Tunezja', 'Turcja', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraina', 
    'Urugwaj', 'Uzbekistan', 'Vanuatu', 'Watykan', 'Wenezuela', 'Węgry', 'Wielka Brytania', 
    'Wietnam', 'Włochy', 'Wybrzeże Kości Słoniowej', 'Wyspy Marshalla', 'Wyspy Salomona', 
    'Zambia', 'Zimbabwe', 'Zjednoczone Emiraty Arabskie', 'Świat'
)),
ADD CONSTRAINT prize_constraint CHECK (prize_pool >= 0.0);

ALTER TABLE starts
ADD CONSTRAINT weight_constraint CHECK (competitor_weight >= 0.0),
ADD CONSTRAINT class_constraint CHECK (age_class IN ('Youth', 'Teen', 'Juniors', 'Seniors', 'Submasters', 'Masters'));


ALTER TABLE squats
ADD CONSTRAINT chk_sqt_first_attempt_positive CHECK (sqt_first_attempt > 0.0),
ADD CONSTRAINT chk_sqt_second_attempt_positive CHECK (sqt_second_attempt > 0.0),
ADD CONSTRAINT chk_sqt_third_attempt_positive CHECK (sqt_third_attempt > 0.0);

ALTER TABLE deadlifts
ADD CONSTRAINT chk_dl_first_attempt_positive CHECK (dl_first_attempt > 0.0),
ADD CONSTRAINT chk_dl_second_attempt_positive CHECK (dl_second_attempt > 0.0),
ADD CONSTRAINT chk_dl_third_attempt_positive CHECK (dl_third_attempt > 0.0);

ALTER TABLE bench_press
ADD CONSTRAINT chk_bp_first_attempt_positive CHECK (bp_first_attempt > 0.0),
ADD CONSTRAINT chk_bp_second_attempt_positive CHECK (bp_second_attempt > 0.0),
ADD CONSTRAINT chk_bp_third_attempt_positive CHECK (bp_third_attempt > 0.0);

