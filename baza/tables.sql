create table zawodnicy (id_zawodnik BIGSERIAL not null primary key, nazwisko text not null, imie text not null, data_urodzenia date not null  check (data_urodzenia >= '1864-01-01') , kraj_pochodzenia varchar(47) default 'świat', plec char(1) not null check (plec in ('M', 'F')));

create table federacje (id_federacja BIGSERIAL not null primary key, nazwa text not null,  data_zalozenia date not null check (data_zalozenia >= '1958-01-01'));

create table zawody (id_zawody BIGSERIAL not null primary key, id_federacja_zawody int not null, rodzaj varchar(14) not null check (rodzaj in ('Raw', 'Bandaże', 'Raw + Bandaże', 'Jednowarstwowy', 'Wielowarstwowy', 'Nielimitowany')), data_rozpoczecia date not null check (data_rozpoczecia >= '1964-01-01'), data_zakonczenia date not null check (data_zakonczenia <= CURRENT_DATE), lokalizacja_kraj varchar(47) not null, lokalizacja_miasto varchar(58) not null, prize_pool int default 0 check (prize_pool >= 0));

create table federacje (id_federacja BIGSERIAL not null primary key, nazwa text not null,  data_zalozenia date not null check (data_zalozenia >= '1958-01-01'));

create table wystapienia (id_wystapienie BIGSERIAL not null primary key, id_zawodnik_wystapienie int not null, id_zawody_wystapienie int not null, waga real not null check(waga > 0.0), kategoria_wagowa varchar(4) not null, klasyfikacja_wiekowa varchar(10) check(klasyfikacja_wiekowa in ('Youth', 'Teen', 'Juniors', 'Seniors', 'Submasters', 'Masters')), id_rezultat_wystapienie int not null);

create table rezultaty (id_rezultat BIGSERIAL not null primary key, id_przysiady_rezultat int not null, id_wyciskanie_rezultat int not null, id_martwy_ciag_rezultat int not null);

create table przysiady (id_przysiady BIGSERIAL not null primary key, przysiad_podejscie_pierwsze real not null check(przysiad_podejscie_pierwsze > 0.0), zaliczenie_podejscie_pierwsze varchar(3) not null check(zaliczenie_podejscie_pierwsze in ('Nie', 'Tak'), przysiad_podejscie_drugie real not null check(przysiad_podejscie_drugie > 0.0), zaliczenie_podejscie_drugie varchar(3) not null check(zaliczenie_podejscie_drugie in ('Nie', 'Tak'), przysiad_podejscie_trzecie real not null check(przysiad_podejscie_trzecie > 0.0), zaliczenie_podejscie_trzecie varchar(3) not null check(zaliczenie_podejscie_trzecie in ('Nie', 'Tak'));

create table martwe_ciagi (id_martwy_ciag BIGSERIAL not null primary key, martwy_ciag_podejscie_pierwsze real not null check(martwy_ciag_podejscie_pierwsze > 0.0), zaliczenie_podejscie_pierwsze varchar(3) not null check(zaliczenie_podejscie_pierwsze in ('Nie', 'Tak'), martwy_ciag_podejscie_drugie real not null check(martwy_ciag_podejscie_drugie > 0.0), zaliczenie_podejscie_drugie varchar(3) not null check(zaliczenie_podejscie_drugie in ('Nie', 'Tak'), martwy_ciag_podejscie_trzecie real not null check(martwy_ciag_podejscie_trzecie > 0.0), zaliczenie_podejscie_trzecie varchar(3) not null check(zaliczenie_podejscie_trzecie in ('Nie', 'Tak'));

create table wyciskanie (id_wyciskanie BIGSERIAL not null primary key, wyciskanie_podejscie_pierwsze real not null check(wyciskanie_podejscie_pierwsze > 0.0), zaliczenie_podejscie_pierwsze varchar(3) not null check(zaliczenie_podejscie_pierwsze in ('Nie', 'Tak'), wyciskanie_podejscie_drugie real not null check(wyciskanie_podejscie_drugie > 0.0), zaliczenie_podejscie_drugie varchar(3) not null check(zaliczenie_podejscie_drugie in ('Nie', 'Tak'), wyciskanie_podejscie_trzecie real not null check(wyciskanie_podejscie_trzecie > 0.0), zaliczenie_podejscie_trzecie varchar(3) not null check(zaliczenie_podejscie_trzecie in ('Nie', 'Tak'));
--
alter table zawodnicy add constraint kraj_pochodzenia_check check (kraj_pochodzenia in ('Afganistan', 'Albania', 'Algieria', 'Andora', 'Angola', 'Antigua i Barbuda', 'Arabia Saudyjska', 
'Argentyna', 'Armenia', 'Australia', 'Austria', 'Azerbejdżan', 'Bahamy', 'Bahrajn', 'Bangladesz', 
'Barbados', 'Belgia', 'Belize', 'Benin', 'Bhutan', 'Białoruś', 'Boliwia', 'Bośnia i Hercegowina', 
'Botswana', 'Brazylia', 'Brunei', 'Bułgaria', 'Burkina Faso', 'Burundi', 'Chile', 'Chiny', 
'Chorwacja', 'Cypr', 'Czarnogóra', 'Czechy', 'Dania', 'Dominika', 'Dominikana', 'Dżibuti', 
'Ekwador', 'Egipt', 'Erytrea', 'Estonia', 'Eswatini', 'Etiopia', 'Fidżi', 'Filipiny', 'Finlandia', 
'Francja', 'Gabon', 'Gambia', 'Ghana', 'Grecja', 'Grenada', 'Gruzja', 'Gujana', 'Gwatemala', 
'Gwinea', 'Gwinea Bissau', 'Gwinea Równikowa', 'Haiti', 'Hiszpania', 'Holandia', 'Honduras', 
'Indie', 'Indonezja', 'Irak', 'Iran', 'Irlandia', 'Islandia', 'Izrael', 'Jamajka', 'Japonia', 
'Jemen', 'Jordania', 'Kambodża', 'Kamerun', 'Kanada', 'Katar', 'Kazachstan', 'Kenia', 
'Kirgistan', 'Kiribati', 'Kolumbia', 'Komory', 'Kongo', 'Korea Południowa', 'Korea Północna', 
'Kostaryka', 'Kuba', 'Kuwejt', 'Laos', 'Lesotho', 'Liban', 'Liberia', 'Libia', 'Liechtenstein', 
'Litwa', 'Luksemburg', 'Łotwa', 'Macedonia Północna', 'Madagaskar', 'Malawi', 'Malediwy', 
'Malezja', 'Mali', 'Malta', 'Maroko', 'Mauretania', 'Mauritius', 'Meksyk', 'Mikronezja', 
'Mjanma', 'Mołdawia', 'Monako', 'Mongolia', 'Mozambik', 'Namibia', 'Nauru', 'Nepal', 
'Niemcy', 'Niger', 'Nigeria', 'Nikaragua', 'Norwegia', 'Nowa Zelandia', 'Oman', 'Pakistan', 
'Palau', 'Panama', 'Papua-Nowa Gwinea', 'Paragwaj', 'Peru', 'Polska', 'Portugalia', 
'Republika Południowej Afryki', 'Republika Środkowoafrykańska', 'Republika Zielonego Przylądka', 
'Rosja', 'Rumunia', 'Rwanda', 'Saint Kitts i Nevis', 'Saint Lucia', 'Saint Vincent i Grenadyny', 
'Salwador', 'Samoa', 'San Marino', 'Senegal', 'Serbia', 'Seszele', 'Sierra Leone', 'Singapur', 
'Słowacja', 'Słowenia', 'Somalia', 'Sri Lanka', 'Stany Zjednoczone', 'Sudan', 'Sudan Południowy', 
'Surinam', 'Syria', 'Szwajcaria', 'Szwecja', 'Tadżykistan', 'Tajlandia', 'Tanzania', 
'Togo', 'Tonga', 'Trynidad i Tobago', 'Tunezja', 'Turcja', 'Turkmenistan', 'Tuvalu', 
'Uganda', 'Ukraina', 'Urugwaj', 'Uzbekistan', 'Vanuatu', 'Watykan', 'Wenezuela', 'Węgry', 
'Wielka Brytania', 'Wietnam', 'Włochy', 'Wybrzeże Kości Słoniowej', 'Wyspy Marshalla', 
'Wyspy Salomona', 'Zambia', 'Zimbabwe', 'Zjednoczone Emiraty Arabskie', 'Świat')
);

alter table zawody add foreign key (id_federacja_zawody) references federacje ( id_federacja) ;
alter table zawody add constraint lokalizacja_kraj_check check (lokalizacja_kraj in ('Afganistan', 'Albania', 'Algieria', 'Andora', 'Angola', 'Antigua i Barbuda', 'Arabia Saudyjska', 
'Argentyna', 'Armenia', 'Australia', 'Austria', 'Azerbejdżan', 'Bahamy', 'Bahrajn', 'Bangladesz', 
'Barbados', 'Belgia', 'Belize', 'Benin', 'Bhutan', 'Białoruś', 'Boliwia', 'Bośnia i Hercegowina', 
'Botswana', 'Brazylia', 'Brunei', 'Bułgaria', 'Burkina Faso', 'Burundi', 'Chile', 'Chiny', 
'Chorwacja', 'Cypr', 'Czarnogóra', 'Czechy', 'Dania', 'Dominika', 'Dominikana', 'Dżibuti', 
'Ekwador', 'Egipt', 'Erytrea', 'Estonia', 'Eswatini', 'Etiopia', 'Fidżi', 'Filipiny', 'Finlandia', 
'Francja', 'Gabon', 'Gambia', 'Ghana', 'Grecja', 'Grenada', 'Gruzja', 'Gujana', 'Gwatemala', 
'Gwinea', 'Gwinea Bissau', 'Gwinea Równikowa', 'Haiti', 'Hiszpania', 'Holandia', 'Honduras', 
'Indie', 'Indonezja', 'Irak', 'Iran', 'Irlandia', 'Islandia', 'Izrael', 'Jamajka', 'Japonia', 
'Jemen', 'Jordania', 'Kambodża', 'Kamerun', 'Kanada', 'Katar', 'Kazachstan', 'Kenia', 
'Kirgistan', 'Kiribati', 'Kolumbia', 'Komory', 'Kongo', 'Korea Południowa', 'Korea Północna', 
'Kostaryka', 'Kuba', 'Kuwejt', 'Laos', 'Lesotho', 'Liban', 'Liberia', 'Libia', 'Liechtenstein', 
'Litwa', 'Luksemburg', 'Łotwa', 'Macedonia Północna', 'Madagaskar', 'Malawi', 'Malediwy', 
'Malezja', 'Mali', 'Malta', 'Maroko', 'Mauretania', 'Mauritius', 'Meksyk', 'Mikronezja', 
'Mjanma', 'Mołdawia', 'Monako', 'Mongolia', 'Mozambik', 'Namibia', 'Nauru', 'Nepal', 
'Niemcy', 'Niger', 'Nigeria', 'Nikaragua', 'Norwegia', 'Nowa Zelandia', 'Oman', 'Pakistan', 
'Palau', 'Panama', 'Papua-Nowa Gwinea', 'Paragwaj', 'Peru', 'Polska', 'Portugalia', 
'Republika Południowej Afryki', 'Republika Środkowoafrykańska', 'Republika Zielonego Przylądka', 
'Rosja', 'Rumunia', 'Rwanda', 'Saint Kitts i Nevis', 'Saint Lucia', 'Saint Vincent i Grenadyny', 
'Salwador', 'Samoa', 'San Marino', 'Senegal', 'Serbia', 'Seszele', 'Sierra Leone', 'Singapur', 
'Słowacja', 'Słowenia', 'Somalia', 'Sri Lanka', 'Stany Zjednoczone', 'Sudan', 'Sudan Południowy', 
'Surinam', 'Syria', 'Szwajcaria', 'Szwecja', 'Tadżykistan', 'Tajlandia', 'Tanzania', 
'Togo', 'Tonga', 'Trynidad i Tobago', 'Tunezja', 'Turcja', 'Turkmenistan', 'Tuvalu', 
'Uganda', 'Ukraina', 'Urugwaj', 'Uzbekistan', 'Vanuatu', 'Watykan', 'Wenezuela', 'Węgry', 
'Wielka Brytania', 'Wietnam', 'Włochy', 'Wybrzeże Kości Słoniowej', 'Wyspy Marshalla', 
'Wyspy Salomona', 'Zambia', 'Zimbabwe', 'Zjednoczone Emiraty Arabskie')
);

alter table wystapienia add foreign key (id_zawodnik_wystapienie) references zawodnicy ( id_zawodnik);
alter table wystapienia add foreign key (id_zawody_wystapienie) references zawody ( id_zawody);
alter table wystapienia add foreign key (id_rezultat_wystapienie) references rezultaty ( id_rezultat);

alter table rezultaty add foreign key (id_przysiady_rezultat) references przysiady ( id_przysiady);
alter table rezultaty add foreign key (id_wyciskanie_rezultat) references wyciskanie ( id_wyciskanie);
alter table rezultaty add foreign key (id_martwy_ciag_rezultat) references martwe_ciagi ( id_martwy_ciag);