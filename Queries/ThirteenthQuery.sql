CREATE PROCEDURE sp_BorrowersWithOverdue
AS
BEGIN
	CREATE TABLE #OverdueBorrowers(
	BorrowerID INT,
	BookID INT,
	DateBorrowed DATE, 
	DateReturned DATE
	);

	INSERT INTO #OverdueBorrowers (BorrowerID,BookID,DateBorrowed,DateReturned)
	SELECT DISTINCT (BorrowerID),BookID,DateBorrowed,DateReturned
	FROM Loans
	WHERE (DateReturned > DueDate) OR (DateReturned = NULL AND GETDATE()>DueDate)

	SELECT 
	    overdue.BorrowerID,
		overdue.BookID,
		b.Title,
		overdue.DateBorrowed,
		overdue.DateReturned
	FROM
	    #OverdueBorrowers AS overdue
	JOIN 
	    Books AS b ON b.BookID = overdue.BookID
END

EXEC sp_BorrowersWithOverdue;