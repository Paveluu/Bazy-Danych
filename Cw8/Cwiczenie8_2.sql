WITH Revenue AS (SELECT c.CompanyName AS CompanyContact, h.TotalDue AS Revenue
  FROM SalesLT.Customer AS c
  INNER JOIN SalesLT.SalesOrderHeader AS h ON c.CustomerID = h.CustomerID
)
SELECT * FROM Revenue
ORDER BY CompanyContact;