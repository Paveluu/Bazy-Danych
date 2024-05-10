-- 1
CREATE SCHEMA oblicz;
GO


CREATE FUNCTION oblicz.Fib(@n INT)
RETURNS INT

AS

BEGIN

    DECLARE @wynik BIGINT;

    IF @n <= 0
        SET @wynik = 0;
    ELSE IF @n = 1
        SET @wynik = 1;
    ELSE
    BEGIN

        DECLARE @f1 BIGINT = 0;
        DECLARE @f2 BIGINT = 1;
        DECLARE @i INT = 2;

        WHILE @i <= @n
        BEGIN
            SET @wynik = @f1 + @f2;
            SET @f1 = @f2;
            SET @f2 = @wynik;
            SET @i = @i + 1;
        END
    END
    RETURN @wynik;
END;
GO

CREATE PROCEDURE oblicz.PoliczonyFib(@n INT)

AS

BEGIN

    DECLARE @i INT = 0;
    DECLARE @liczbaFib INT;

    WHILE @i <= @n
    BEGIN
        SET @liczbaFib = oblicz.Fib(@i);
        PRINT 'Liczba ciagu Fibonacciego na pozycji ' + CAST(@i AS VARCHAR(30)) + ' to ' + CAST(@liczbaFib AS VARCHAR(30));
        SET @i = @i + 1;
    END
END;
GO

EXEC oblicz.PoliczonyFib @n = 10;


-- 2

CREATE TRIGGER Nazwisko

  ON Person.Person
  AFTER INSERT
  AS
  BEGIN
      UPDATE Person.Person SET LastName = UPPER(LastName)
  END;



  -- 3

  CREATE TRIGGER taxRateMonitoring

  ON Sales.SalesTaxRate

  AFTER INSERT, UPDATE, DELETE

  AS

  BEGIN

	DECLARE @nowyTAX SMALLMONEY, @staryTAX SMALLMONEY;
	SELECT @nowyTAX = TaxRate FROM inserted;
	SELECT @staryTAX = TaxRate FROM deleted;

	IF @nowyTAX > @staryTAX*1.3 OR @nowyTAX < @staryTAX*0.7
	BEGIN
		PRINT 'B£AD';	
		ROLLBACK;
	End
  END;
    
  SELECT * FROM Sales.SalesTaxRate;

  UPDATE Sales.SalesTaxRate SET TaxRate = TaxRate*1.4