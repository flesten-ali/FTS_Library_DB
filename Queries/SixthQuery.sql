CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS INT
AS
BEGIN
	DECLARE @fees INT = 0;
	DECLARE @overdueDays INT = 0;

	SELECT @overdueDays = DATEDIFF(DAY, DueDate, DateReturned)
	FROM 
	   Loans
	WHERE 
	   LoanID = @LoanID AND DateReturned > DueDate

	IF @overdueDays != 0
	BEGIN
		IF @overdueDays <= 30
			SET @fees = @overdueDays
		ELSE
			SET @fees = 30 + (@overdueDays - 30) * 2
	END

	RETURN @fees
END

SELECT dbo.fn_CalculateOverdueFees(2) AS [Fees in $]

 