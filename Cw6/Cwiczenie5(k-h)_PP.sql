-- k)
SELECT p.stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pensje p 
GROUP BY p.stanowisko;

-- l)
SELECT 
       AVG(p.kwota) AS srednia_placa,
       MIN(p.kwota) AS minimalna_placa,
       MAX(p.kwota) AS maksymalna_placa
FROM ksiegowosc.pensje p
WHERE p.stanowisko = 'Data Scientist';

-- m)
SELECT SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensje

-- f)
SELECT pe.stanowisko, SUM(pe.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensje pe
JOIN ksiegowosc.wynagrodzenie w ON pe.id_pensji = w.id_pensji
GROUP BY pe.stanowisko

--g)
SELECT pe.stanowisko, COUNT(pre.id_premii) AS licz_premii
FROM ksiegowosc.pensje pe
JOIN ksiegowosc.wynagrodzenie w ON pe.id_pensji = w.id_pensji
JOIN ksiegowosc.premie pre ON w.id_premii = pre.id_premii
GROUP BY pe.stanowisko;

-- h)
DELETE FROM ksiegowosc.pensje
WHERE kwota < 3500


SELECT * FROM ksiegowosc.pensje