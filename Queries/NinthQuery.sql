WITH BooksBorrowingFrequency
AS (
	SELECT
	   b.Author, 
	   count(b.BookID) OVER (PARTITION BY b.Author) AS BorrowingFrequency
	FROM
	   Loans AS l
	JOIN 
	   Books AS b ON l.BookID = b.BookID
	)

SELECT
   bf.Author,
   bf.BorrowingFrequency,
   Dense_Rank() OVER (ORDER BY BorrowingFrequency DESC) AS [RankOfAuthor]
FROM
   BooksBorrowingFrequency bf
GROUP BY
   bf.Author, bf.BorrowingFrequency
ORDER BY 
   BorrowingFrequency DESC