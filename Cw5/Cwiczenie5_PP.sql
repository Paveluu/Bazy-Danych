CREATE DATABASE firma;
USE firma;
GO

CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy ( 
    id_pracownika INT PRIMARY KEY, -- Unikalny identyfikator pracownika
    imie VARCHAR(50) NOT NULL, -- Imiê pracownika
    nazwisko VARCHAR(50) NOT NULL, -- Nazwisko pracownika
    adres VARCHAR(100) NOT NULL, -- Adres zamieszkania pracownika
    telefon VARCHAR(20) NOT NULL -- Numer telefonu pracownika
);

CREATE TABLE ksiegowosc.premie (
    id_premii INT PRIMARY KEY, -- Unikalny identyfikator premii
    rodzaj VARCHAR(50) NOT NULL, -- Rodzaj premii
    kwota DECIMAL(10,2) NOT NULL -- Kwota premii
);

CREATE TABLE ksiegowosc.godziny (
    id_godziny INT PRIMARY KEY, -- Unikalny identyfikator godzin pracy
    data DATE NOT NULL, -- Data pracy
    liczba_godzin DECIMAL(5,2) NOT NULL, -- Liczba przepracowanych godzin
    id_pracownika INT, -- ID pracownika, do którego przypisane s¹ godziny
);

CREATE TABLE ksiegowosc.pensje (
    id_pensji INT PRIMARY KEY, -- Unikalny identyfikator pensji
    stanowisko VARCHAR(50) NOT NULL, -- Stanowisko pracownika
    kwota DECIMAL(10,2) NOT NULL, -- Kwota pensji
    
);

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY, -- Unikalny identyfikator wynagrodzenia
    data_ DATE NOT NULL, -- Data wynagrodzenia
    id_pracownika INT NOT NULL, -- ID pracownika
    id_godziny INT NOT NULL, -- ID godzin
    id_pensji INT NOT NULL, -- ID pensji
    id_premii INT NOT NULL, -- ID premii
) ;

ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);


ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
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

INSERT INTO ksiegowosc.pensje (id_pensji, stanowisko, kwota)
VALUES
(1, 'Content Marketing Specialist', 4400 ),
(2, 'Social Media Manager', 5100),
(3, 'Digital Marketing Analyst', 3800),
(4, 'Public Relations Manager', 4300),
(5, 'Brand Strategist', 5300),
(6, 'UX/UI Designer', 4000),
(7, 'Graphic Designer', 3400),
(8, 'Data Scientist', 4600),
(9, 'Software Developer', 5600),
(10, 'Project Manager', 5900);

INSERT INTO ksiegowosc.premie (id_premii, rodzaj, kwota)
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

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data_, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2024-04-01', 1, 1, 3, 3),
(2, '2024-04-18', 2, 2, 1, 1),
(3, '2024-04-21', 3, 3, 4, 4),
(4, '2024-04-17', 4, 4, 7, 7),
(5, '2024-05-01', 5, 5, 8, 8),
(6, '2024-05-02', 6, 6, 2, 2),
(7, '2024-06-03', 7, 7, 9, 9),
(8, '2024-06-05', 8, 8, 10, 10),
(9, '2024-06-11', 9, 9, 5, 5),
(10, '2024-06-15', 10, 10, 6, 6);


-- a)
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b)

SELECT id_pracownika FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensje ON id_pracownika = id_pensji
WHERE kwota > 1000;

-- c)
SELECT p.id_pracownika FROM ksiegowosc.pracownicy p 
JOIN ksiegowosc.pensje s ON p.id_pracownika = s.id_pensji 
LEFT JOIN ksiegowosc.premie pr ON p.id_pracownika = pr.id_premii 
WHERE pr.id_premii IS NULL AND s.kwota > 2000;

-- d)
SELECT imie
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

-- e)
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f)
SELECT p.imie, p.nazwisko, g.liczba_godzin 
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_godziny
WHERE liczba_godzin > 160;

-- g)
SELECT p.imie, p.nazwisko, kwota
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensje pe ON p.id_pracownika = p.id_pensji
WHERE kwota BETWEEN 1500 AND 3000;

-- h)
SELECT p.imie, p.nazwisko FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.premie pe ON p.id_pracownika = pe.id_premii
LEFT JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_godziny
WHERE pe.id_premii IS NULL AND g.liczba_godzin > 160 
-- i)
SELECT p.imie, p.nazwisko, kwota AS pensja
FROM ksiegowosc.pracownicy p 
JOIN ksiegowosc.pensje pe ON p.id_pracownika = pe.id_pensji
ORDER BY kwota;

-- j)
SELECT p.imie, p.nazwisko, s.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensje s ON p.id_pracownika = s.id_pensji
LEFT JOIN ksiegowosc.premie pr ON p.id_pracownika = pr.id_premii 
ORDER BY s.kwota, pr.kwota;