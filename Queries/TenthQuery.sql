CREATE FUNCTION fn_GetAgeGroup (@DateOfBirth DATE)
RETURNS NVARCHAR(8)
AS
BEGIN
	DECLARE @AgeGroup NVARCHAR(8);
	DECLARE @DateDiff INT = DateDiff(Year, @DateOfBirth, GETDATE());

	IF MONTH(GETDATE()) < MONTH(@DateOfBirth)
	   SET @DateDiff = @DateDiff - 1;
	   
	SET @AgeGroup = CASE 
			WHEN @DateDiff BETWEEN 0  AND 10  THEN '(0,10)'
			WHEN @DateDiff BETWEEN 11 AND 20 THEN '(11,20)'
			WHEN @DateDiff BETWEEN 21 AND 30 THEN '(21,30)'
			WHEN @DateDiff BETWEEN 31 AND 40 THEN '(31,40)'
			ELSE '+41'
	END

	RETURN @AgeGroup
END

WITH GenreWithAgeGroups AS (
		SELECT 
		   dbo.fn_GetAgeGroup(br.DateOfBirth) AS Age, 
		   b.Genre
		FROM 
		   Borrowers AS br
		JOIN
		   Loans AS l ON br.BorrowerID = l.BorrowerID
		JOIN 
		   Books AS b ON b.BookID = l.BookID
		)

SELECT
   Age, 
   Genre,
   count(*) AS [CountOfBorrower]
FROM 
   GenreWithAgeGroups as cte
GROUP BY 
   Genre,
   Age
HAVING
   count(*) = (
		SELECT max(CountOfBorrower.mx)
		FROM (
			SELECT Genre, count(*) AS mx
			FROM GenreWithAgeGroups AS mainCTE
			WHERE mainCTE.Age = cte.Age
			GROUP BY Genre
			) AS CountOfBorrower
		)
ORDER BY
   Age

 
 