CREATE TABLE [Borrowers] (
	BorrowerID INT identity,
	FirstName NVARCHAR(10) NOT NULL,
	LastName NVARCHAR(10) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	DateOfBirth DATE NOT NULL,
	MembershipDate DATE NOT NULL,
	PRIMARY KEY (BorrowerID)
	);

CREATE TABLE [Books] (
	BookID INT identity,
	Title NVARCHAR(50) NOT NULL,
	Author NVARCHAR(50) NOT NULL,
	ISBN NVARCHAR(50) NOT NULL,
	PublishedDate DATE NOT NULL,
	Genre NVARCHAR(50) NOT NULL,
	ShelfLocation NVARCHAR(50) NOT NULL,
	CurrentStatus NVARCHAR(20) NOT NULL,
	PRIMARY KEY (BookID),
	CONSTRAINT [Status] CHECK (
		CurrentStatus = 'Available'
		OR CurrentStatus = 'Borrowed'
		)
	);

CREATE TABLE [Loans] (
	LoanID INT identity,
	BookID INT NOT NULL,
	BorrowerID INT NOT NULL,
	DateBorrowed DATE NOT NULL,
	DueDate DATE NOT NULL,
	DateReturned DATE,
	PRIMARY KEY (LoanID),
	CONSTRAINT [FK_Loans.BookID ] FOREIGN KEY (BookID) REFERENCES [Books](BookID),
	CONSTRAINT [FK_Loans.BorrowerID ] FOREIGN KEY (BorrowerID) REFERENCES [Borrowers](BorrowerID)
	);
