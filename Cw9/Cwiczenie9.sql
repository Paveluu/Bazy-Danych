--9.1

BEGIN TRANSACTION
  UPDATE Production.Product SET ListPrice = ListPrice*1.1
  WHERE ProductID = 680;
  COMMIT;

  SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductID = 680;



  -- 9.2

  BEGIN TRANSACTION;
BEGIN TRY
    DELETE Production.Product WHERE ProductID = 707;
    COMMIT TRANSACTION;
	PRINT 'Produkt zostal usuniety.'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja zsota³a wycofana.';
END CATCH;

SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductID = 707;

-- 9.3

BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, 
	StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES ('Sports Shorts, S', 'GF-E12N-87', 'BLACK', 90, 55, 12.00, 21.00, 1, '2021-07-01 00:00:00.000');
COMMIT TRANSACTION;

SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductNumber = 'GF-E12N-87';



-- 9.4

BEGIN TRANSACTION;
	UPDATE Production.Product SET StandardCost = StandardCost*1.1;
	DECLARE @SUMCOST DECIMAL(10, 2);
	SELECT @SUMCOST = SUM(StandardCost) FROM Production.Product;
	IF @SUMCOST <= 50000 
		BEGIN
			COMMIT;
		END
	ELSE 
		BEGIN
			  ROLLBACK TRANSACTION;
			  PRINT 'Transakcja zosta³a odrzucona';
		  END



-- 9.5

BEGIN TRANSACTION;
	DECLARE @nowy INT;
	DECLARE @numer VARCHAR(20) = 'GF-E12N-87' 
	SELECT @nowy = COUNT(*) FROM Production.Product WHERE ProductNumber = @numer; 
	IF @nowy = 0
	BEGIN
		INSERT INTO Production.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
		VALUES ('Sports Shorts, S', 'GF-E12N-87', 'BLACK', 90, 55, 12.00, 21.00, 1, '2021-07-01 00:00:00.000');
		COMMIT;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
		PRINT 'Produkt nie zostal dodany, poniewaz taki ProductNumber jest juz w bazie.'
	END



-- 9.6

BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty - 1;

DECLARE @zero INT;
SELECT @zero = COUNT(*) FROM Sales.SalesOrderDetail WHERE OrderQty = 0;

IF @zero > 0
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transakcje zosta³a anulowano, OrderQty wynosi 0.';
END
ELSE
BEGIN
    COMMIT;
    PRINT 'Transakcja zosta³a wykonana.';
END

SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0;



-- 9.7

BEGIN TRANSACTION;
	DECLARE @koszt DECIMAL (8, 2)
	DECLARE @usun INT;
	SELECT @koszt = AVG(StandardCost) FROM Production.Product;
	SELECT @usun = COUNT(*) FROM Production.Product WHERE StandardCost > @koszt; 
	IF @usun <= 10
	BEGIN
		DELETE Production.Product WHERE StandardCost > @koszt;
		COMMIT;
		PRINT 'Tarnsakcja zosta³a wykonana. Produkty zostaly usuniete.';
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
		PRINT 'Transakcja zosta³a anulowana. Liczba produktow do usuniecia wynosi: '+ CAST(@usun AS VARCHAR(8));
	END