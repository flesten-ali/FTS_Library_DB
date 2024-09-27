CREATE PROCEDURE sp_AddNewBorrower (
	@res NVARCHAR(50) OUTPUT,
	@FirstName NVARCHAR(10),
	@LastName NVARCHAR(10),
	@Email NVARCHAR(50), 
	@DateOfBirth DATE, @MembershipDate DATE
	)
AS
BEGIN
	IF NOT EXISTS 
	(   SELECT 1
		FROM Borrowers
		WHERE Email = @Email
	)

		BEGIN
			INSERT INTO Borrowers
			VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate)

			DECLARE @NewBorrowerID INT;

			SELECT @NewBorrowerID = SCOPE_IDENTITY()
			FROM Borrowers;

			SELECT @res = CONCAT ('BorrowerID is ', @NewBorrowerID)
		END
	ELSE
		SET @res = 'Borrower with the same Email exists!'
END

DECLARE @msg NVARCHAR(50);

EXEC sp_AddNewBorrower @msg OUTPUT, 'Nour', 'Jor', 'nour123@gmail.com', '2003-12-12', '2024-09-25'

PRINT @msg
