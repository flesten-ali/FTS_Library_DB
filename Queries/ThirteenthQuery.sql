CREATE PROCEDURE sp_BorrowersWithOverdue
AS
BEGIN
	CREATE TABLE #OverdueBorrowers (BorrowerID INT);

	INSERT INTO #OverdueBorrowers (BorrowerID)
	SELECT DISTINCT (BorrowerID)
	FROM Loans
	WHERE DateReturned > DueDate

	SELECT 
	    l.BorrowerID,
		l.BookID,
		b.Title,
		l.DateBorrowed,
		l.DateReturned
	FROM
	    #OverdueBorrowers AS overdue
	JOIN 
	    Loans AS l ON overdue.BorrowerID = l.BorrowerID
	JOIN 
	    Books AS b ON b.BookID = l.BookID
	WHERE 
	    l.DateReturned > l.DueDate
END

EXEC sp_BorrowersWithOverdue;
