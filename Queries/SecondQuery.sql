WITH MoreThanOneUnReturnedBooks AS (
    SELECT 
        COUNT(*) AS numOfUnReturned,
        b.BorrowerID,
        CONCAT (b.FirstName, ' ', b.LastName) AS [Borrower Name]
    FROM 
        Borrowers AS b
    JOIN 
        Loans AS l ON b.BorrowerID = l.BorrowerID
    WHERE 
        l.DateReturned IS NULL
    GROUP BY 
        b.BorrowerID, b.FirstName, b.LastName
    HAVING
        COUNT(*) >= 2
)

SELECT
   b.BorrowerID,
   CONCAT (b.FirstName,' ',b.LastName) AS [Borrower Name],
   numOfUnReturned AS [Number of un returned books]
FROM 
   MoreThanOneUnReturnedBooks AS unreturned
JOIN
   Borrowers AS b ON b.BorrowerID = unreturned.BorrowerID