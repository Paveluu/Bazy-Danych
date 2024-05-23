WITH Sales AS (
  SELECT pc.Name AS Category, od.UnitPrice AS SalesValue
  FROM SalesLT.ProductCategory AS pc
  INNER JOIN SalesLT.Product AS p ON p.ProductCategoryID = pc.ProductCategoryID
  INNER JOIN SalesLT.SalesOrderDetail AS od ON p.ProductID = od.ProductID
)
SELECT Category, SUM(SalesValue) AS TotalSalesValue
FROM Sales
GROUP BY Category
ORDER BY Category;