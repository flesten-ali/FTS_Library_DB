CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS INT
AS
BEGIN
	DECLARE @fees INT = 0;
	DECLARE @overdueDays INT = 0;
	
	SELECT @overdueDays =
	    CASE
			WHEN DateReturned = NULL AND DueDate < GETDATE() THEN  DATEDIFF(DAY,DueDate,GETDATE())
			WHEN DateReturned > DueDate THEN DATEDIFF(DAY,DueDate,DateReturned)
		    ELSE 0
		END
	FROM 
	   Loans
	WHERE 
	   LoanID = @LoanID 

	IF @overdueDays != 0
		BEGIN
			IF @overdueDays <= 30
				SET @fees = @overdueDays
			ELSE
				SET @fees = 30 + (@overdueDays - 30) * 2
		END

	RETURN @fees
END

BEGIN TRY

   SELECT dbo.fn_CalculateOverdueFees(2) AS [Fees in $]

END TRY
BEGIN CATCH

   declare @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
   declare @ErrorSeverity INT = ERROR_SEVERITY();
   declare @ErrorState INT = ERROR_STATE();

   RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);

END CATCH