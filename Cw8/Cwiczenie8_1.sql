WITH Pracownicy AS (
  SELECT e.BusinessEntityID, p.FirstName, p.LastName, h.Rate
  FROM HumanResources.EmployeePayHistory AS h
  INNER JOIN HumanResources.Employee AS e ON h.BusinessEntityID = e.BusinessEntityID
  INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT *

INTO Tymczasowa

FROM Pracownicy;

SELECT * FROM Tymczasowa;