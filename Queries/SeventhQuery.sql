CREATE FUNCTION fn_BookBorrowingFrequency (@BookID INT)
RETURNS INT
AS
BEGIN
	DECLARE @count INT;

	SELECT @count = count(l.BookID)
	FROM Loans AS l
	WHERE l.BookID = @BookID

	RETURN @count;
END;

SELECT dbo.fn_BookBorrowingFrequency(1) AS [Borrowing count]

 