WITH BorrowingTimesInEachDay
AS (
	SELECT
	   YEAR(DateBorrowed) AS yearNum,
	   DATEPART(WEEK, DateBorrowed) AS weekNum,
	   DATENAME(WEEKDAY, DateBorrowed) AS dayName,
	   count(*) AS BorrowingTimesInTheWeek,
	   sum(count(*)) OVER (PARTITION BY YEAR(DateBorrowed),DATEPART(WEEK, DateBorrowed))
	   AS TotalLoansInTheWeek
	FROM 
	   Loans
	GROUP BY
	   YEAR(DateBorrowed),DATEPART(WEEK, DateBorrowed),DATENAME(WEEKDAY, DateBorrowed)
	),
PercentageOfLoansForEachDay
AS (
	SELECT
	   yearNum,
	   weekNum,
	   dayName,
	   BorrowingTimesInTheWeek,
	   cast(BorrowingTimesInTheWeek AS DECIMAL(10, 2)) / cast(TotalLoansInTheWeek AS DECIMAL(10, 2)) * 100 
	   AS PercentageOfLoans
	FROM
	   BorrowingTimesInEachDay
	),
RankOfPercentage
AS (
	SELECT
	   *,
	   Dense_Rank() OVER (PARTITION BY yearNum,weekNum ORDER BY PercentageOfLoans DESC) AS ranks
	FROM 
	   PercentageOfLoansForEachDay
	)

SELECT 
   yearNum,
   weekNum,
   dayName,
   ranks,
   CAST(PercentageOfLoans AS DECIMAL(10, 2)) AS PercentageOfLoans
FROM
   RankOfPercentage
WHERE
   ranks <= 3