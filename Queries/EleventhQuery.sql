CREATE PROCEDURE sp_BorrowedBooksReport (@StartDate DATE, @EndDate DATE)
AS
BEGIN
	IF @StartDate > @EndDate
	BEGIN
		THROW 60001, 'End Date Must be more than or equal Start Date',1;
	END

	SELECT 
	   b.BookID, 
	   b.Title, 
	   br.BorrowerID,
	   CONCAT (br.FirstName, ' ', br.LastName) AS [Borrower Name],
	   l.DateBorrowed
	FROM
	   Loans AS l
	JOIN
	   Borrowers AS br ON l.BorrowerID = br.BorrowerID
	JOIN
	   Books AS b ON b.BookID = l.BookID
	WHERE
	   DateBorrowed BETWEEN @StartDate AND @EndDate
END


EXEC sp_BorrowedBooksReport '2026-12-12', '2024-01-12'