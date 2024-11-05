DECLARE @Month INT = 11;

WITH BorrowingFrequencyPerMonth
AS (
	SELECT 
	   b.Genre, 
	   count(*) AS BorrowingFrequency
	FROM
	   Loans AS l
	JOIN 
	   Books AS b ON b.BookID = l.BookID
	WHERE 
	   Month(DateBorrowed) = @Month
	GROUP BY
	   b.Genre
	)

SELECT TOP (1) WITH TIES *
FROM 
   BorrowingFrequencyPerMonth
ORDER BY 
   BorrowingFrequency DESC
