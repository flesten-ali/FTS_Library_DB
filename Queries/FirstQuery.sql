DECLARE @BorrowerID INT = 2;

SELECT 
   b.Title,
   b.Author, 
   CONCAT (br.FirstName, ' ', br.LastName) AS [Borrower Name],
   l.DateBorrowed
FROM
   Books AS b
JOIN 
   Loans AS l ON b.BookID = l.BookID
JOIN 
   Borrowers AS br ON l.BorrowerID = br.BorrowerID
WHERE
   br.BorrowerID = @BorrowerID;
