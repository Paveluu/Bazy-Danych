CREATE DATABASE firma;

CREATE SCHEMA rozliczenie;

CREATE TABLE rozliczenie.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(20) NOT NULL
);

CREATE TABLE rozliczenie.premie (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
);

CREATE TABLE rozliczenie.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin DECIMAL(5,2) NOT NULL,
    id_pracownika INT,
);

CREATE TABLE rozliczenie.pensje (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL,
    id_premii INT,
);

ALTER TABLE rozliczenie.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenie.pracownicy(id_pracownika);
ALTER TABLE rozliczenie.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenie.premie(id_premii);

INSERT INTO rozliczenie.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Anna', 'Kowalska', 'Morska 22, Gdañsk', '58 123 45 67'),
(2, 'Piotr', 'Nowak', 'S³oneczna 5, Kraków', '12 345 67 89'),
(3, 'Magdalena', 'Wiœniewska', 'Kwiatowa 10, Warszawa', '22 333 44 55'),
(4, 'Adam', 'D¹browski', 'S³owackiego 3, £ódŸ', '42 555 66 77'),
(5, 'Karolina', 'Lewandowska', 'Podgórna 15, Wroc³aw', '71 777 88 99'),
(6, 'Tomasz', 'Wójcik', 'Mickiewicza 7, Poznañ', '61 999 00 11'),
(7, 'Joanna', 'Kamiñska', 'Paderewskiego 12, Szczecin', '91 111 22 33'),
(8, 'Marcin', 'Kowalczyk', 'Kopernika 8, Lublin', '81 222 33 44'),
(9, 'Monika', 'Zieliñska', 'Piastowska 20, Katowice', '32 444 55 66'),
(10, '£ukasz', 'Szymañski', 'Królewska 25, Gdynia', '54 666 77 88');

INSERT INTO rozliczenie.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2024-06-15', 145, 3),
(2, '2024-08-10', 92, 5),
(3, '2024-09-28', 178, 2),
(4, '2024-10-05', 162, 10),
(5, '2024-11-20', 155, 8),
(6, '2024-05-22', 168, 4),
(7, '2024-04-01', 170, 9),
(8, '2024-08-18', 155, 6),
(9, '2024-08-23', 95, 1),
(10, '2024-10-31', 110, 7);

INSERT INTO rozliczenie.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
(1, 'Content Marketing Specialist', 4400, 9),
(2, 'Social Media Manager', 5100, 3),
(3, 'Digital Marketing Analyst', 3800, 2),
(4, 'Public Relations Manager', 4300, 8),
(5, 'Brand Strategist', 5300, 4),
(6, 'UX/UI Designer', 4000, 7),
(7, 'Graphic Designer', 3400, 6),
(8, 'Data Scientist', 4600, 5),
(9, 'Software Developer', 5600, 1),
(10, 'Project Manager', 5900, 10);

INSERT INTO rozliczenie.premie (id_premii, rodzaj, kwota)
VALUES
(1, 'uznaniowa', 280),
(2, 'regulaminowa', 510),
(3, 'frekwencja', 420),
(4, 'frekwencja', 90),
(5, 'regulaminowa', 190),
(6, 'uznaniowa', 330),
(7, 'uznaniowa', 60),
(8, 'frekwencja', 480),
(9, 'regulaminowa', 470),
(10, 'uznaniowa', 310);

SELECT nazwisko, adres FROM rozliczenie.pracownicy;


SELECT 
    DATEPART(day, data) AS dzien,
    DATEPART(month, data) AS miesiac
FROM 
    rozliczenie.godziny;

EXEC sp_rename 'rozliczenie.pensje.kwota', 'kwota_brutto', 'COLUMN';


ALTER TABLE rozliczenie.pensje ADD kwota_netto DECIMAL(10, 2);

Update rozliczenie.pensje SET kwota_netto = kwota_brutto*0.73;

SELECT * FROM rozliczenie.pensje;
SELECT * FROM rozliczenie.godziny;
SELECT * FROM rozliczenie.pracownicy;
SELECT * FROM rozliczenie.premie;