SELECT
   b.BookID, 
   b.Title,
   CONCAT (br.FirstName, ' ', br.LastName) AS [Borrower Full Name]
FROM 
   Loans AS l
JOIN 
   Borrowers AS br ON l.BorrowerID = br.BorrowerID
JOIN
   Books AS b ON b.BookID = l.BookID
WHERE 
   DateReturned > DueDate AND DATEDIFF(DAY, DueDate, DateReturned) > 30
