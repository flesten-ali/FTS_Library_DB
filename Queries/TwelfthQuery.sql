CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1, 1) PRIMARY KEY,
    BookID INT,
    StatusChange NVARCHAR(50), 
    ChangeDate DATE
);

CREATE TRIGGER LogAfterStatusChangeTrigger 
ON Books
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
    SELECT 
        i.BookID, 
        CASE 
            WHEN i.CurrentStatus = 'Borrowed' AND d.CurrentStatus = 'Available' 
                THEN 'Available to Borrowed'
            WHEN i.CurrentStatus = 'Available' AND d.CurrentStatus = 'Borrowed'
                THEN 'Borrowed to Available'
        END AS StatusChange, 
        GETDATE() AS ChangeDate
    FROM 
        inserted AS i
    JOIN 
        deleted AS d ON i.BookID = d.BookID
    WHERE 
        i.CurrentStatus != d.CurrentStatus;
END;

BEGIN TRY

	BEGIN TRANSACTION;

		UPDATE Books
		SET CurrentStatus = 'Borrowed'
		WHERE BookID = 1;

	COMMIT TRANSACTION;

    PRINT 'Transaction completed successfully.';
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

	PRINT 'Transaction failed.'+ERROR_MESSAGE();
END CATCH


