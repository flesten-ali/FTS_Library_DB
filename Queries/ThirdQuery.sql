WITH FindBorrowingfrequency
AS (
	SELECT 
	   BorrowerID,
	   count(BorrowerID) AS Borrowingfrequency
	FROM 
	   Loans
	GROUP BY
	   BorrowerID
)

select 
   BorrowerID ,
   Borrowingfrequency
into 
  #TmpTableForCTE
from
   FindBorrowingfrequency

 -- to avoid re-execute the cte every time, I stored the cte result into tmp table

SELECT 
   br.BorrowerID, 
   Borrowingfrequency,
   CONCAT (br.FirstName, ' ', br.LastName) AS [Borrower Name],
   Dense_Rank() OVER (ORDER BY Borrowingfrequency DESC) AS [Rank]
FROM 
   #TmpTableForCTE AS f
JOIN
   Borrowers AS br ON br.BorrowerID = f.BorrowerID

drop table #TmpTableForCTE;