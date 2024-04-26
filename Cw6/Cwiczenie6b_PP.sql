-- a)
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48)', ' ', telefon)


--SELECT * FROM ksiegowosc.pracownicy

-- b)

UPDATE rozliczenia.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 4, 3), '-', SUBSTRING(telefon, 7, 3))


-- c) Upper pomijamy róznice duzych i malych liter

SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
WHERE UPPER(nazwisko) = (SELECT MAX(UPPER(nazwisko)) FROM ksiegowosc.pracownicy)



-- d) CAST -> typ danych na varchhar

SELECT HASHBYTES('MD5', p.imie), HASHBYTES('MD5', p.nazwisko), HASHBYTES('MD5', CAST(pe.kwota AS VARCHAR(20)))
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji


-- f)zachowanie wszystkich danych z lewej tabeli niezależnie od tego, 
-- czy majš one odpowiedniki w prawej tabeli. 

SELECT p.id_pracownika, p.imie, p.nazwisko, pe.kwota AS pensja, pr.rodzaj AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.pensje pe ON p.id_pracownika = pe.id_pensji
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii


-- g)

SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', w.data_, ' otrzymał pensję całkowitš na kwotę ', 
pn.kwota, ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pn.kwota, ' zł, premia: ', pr.kwota, ' zł, nadgodziny: ', 
CASE
        WHEN godz.liczba_godzin > 160 THEN CAST(godz.liczba_godzin - 160 AS VARCHAR(10))
        ELSE '0'
    END) 
AS raport

FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.godziny godz ON w.id_godziny = godz.id_godziny
JOIN ksiegowosc.pracownicy p ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensje pn ON w.id_pensji = pn.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
ORDER BY p.id_pracownika
