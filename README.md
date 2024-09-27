# Library Management System: Database Project

## Project Overview

Database management system for a local library transitioning from traditional book-keeping to a digital platform. The system efficiently tracks books, borrowers, loans.The database is designed using Microsoft SQL Server and includes complex queries,functions, stored procedures, and triggers.

## Entity Relationship Model (ERM) Diagram

• Books: Stores information about each book in the library.

• Borrowers: Stores borrower information.

• Loans: Tracks loans of books to borrowers.

#### Tools Used:

ERD Tool: Lucidchart

#### ‣ ERM diagram provided in the ERD folder.

## Relational Schema

### 1. Books

    BookID (Primary Key)

    Title

    Author

    ISBN

    PublishedDate

    Genre

    ShelfLocation

    CurrentStatus (Available or Borrowed)

### 2. Borrowers

    BorrowerID (Primary Key)

    FirstName

    LastName

    Email

    DateOfBirth

    MembershipDate

### 3. Loans

    LoanID (Primary Key)

    BookID (Foreign Key)

    BorrowerID (Foreign Key)

    DateBorrowed

    DueDate

    DateReturned (NULL if not returned)

#### ‣ Schema Digrams are included in the SchemaDigram folder

## Database Schema Creation

#### ‣ The SQL script to create these tables is provided in the Schema folder.

## Data Seeding

Fictional data was generated for:

• 1000 books

• 1000 borrowers

• 1000 loan records

#### Tools:

<a href="https://www.mockaroo.com/"> mockaroo.com </a>

#### ‣ Data seeding scripts are included in the Data folder

## Complex Queries and Procedures

#### 1. List of Borrowed Books:

Retrieves books borrowed by a specific borrower, including those that haven't been returned.

#### 2. Active Borrowers (CTE):

Identifies borrowers who borrowed 2 or more books but have not returned any.

#### 3. Borrowing Frequency (Window Functions):

Ranks borrowers based on the number of books borrowed.

#### 4. Popular Genre by Month:

Analyzes the most popular genre of books for a given month.

#### 5. Stored Procedure: sp_AddNewBorrower

Adds a new borrower, checking for duplicate email addresses before insertion.

#### 6. Function: fn_CalculateOverdueFees

Calculates overdue fees based on the number of overdue days.

#### 7. Function: fn_BookBorrowingFrequency

Calculates how many times a book has been borrowed.

#### 8. Overdue Books:

Lists books overdue by more than 30 days along with borrower details.

#### 9. Author Popularity:

Ranks authors by the borrowing frequency of their books.

#### 10. Genre Preference by Age:

Analyzes the preferred genre of different age groups of borrowers.

#### 11. Stored Procedure: sp_BorrowedBooksReport

Generates a report of books borrowed within a given date range.

#### 12. Trigger: LogAfterStatusChangeTrigger

Logs changes in the status of a book (Available ↔ Borrowed) to an AuditLog table.

#### 13. Stored Procedure with Temp Table:

Retrieves borrowers with overdue books, listing specific overdue books for each borrower.

#### Bonus Query: Weekly Peak Days

Determines the top 3 busiest days of the week based on loan data, displaying the result as a percentage of total weekly loans.

#### ‣ Queries scripts are included in the Queries folder
