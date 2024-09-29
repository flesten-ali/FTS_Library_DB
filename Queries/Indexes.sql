CREATE NONCLUSTERED INDEX IX_Loans_BorrowerID_BookID
ON Loans (BorrowerID,BookID)

CREATE NONCLUSTERED INDEX IX_Loans_BookID_BorrowerID
ON Loans (BookID,BorrowerID)

CREATE NONCLUSTERED INDEX IX_Loans_DateReturned_DueDate 
ON Loans (DateReturned,DueDate)

CREATE NONCLUSTERED INDEX IX_Books_BookID_Genre 
ON Books (BookID,Genre) 

CREATE NONCLUSTERED INDEX IX_Books_BookID_Author 
ON Books (BookID,Author)

CREATE NONCLUSTERED INDEX IX_Books_BookID_Title
ON Books (BookID,Title)

CREATE NONCLUSTERED INDEX IX_Borrowers_FirstName_LastName
ON Borrowers (FirstName,LastName)

CREATE NONCLUSTERED INDEX IX_Borrowers_Email
ON Borrowers (Email)