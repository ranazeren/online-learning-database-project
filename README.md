# Online Learning Database Project

## Project Overview

This project is a database design and implementation project for an Online Learning Platform. The system is designed to manage the main operations of an online education environment such as users, students, instructors, courses, lessons, enrollments, payments, refunds, quizzes, assignments, submissions, certificates, and course categories.

The project follows the main stages of database development:

- Requirement analysis
- ER diagram design
- Relational schema transformation
- Database and table creation
- Constraint implementation
- Sample data insertion
- SQL queries
- Join operations
- Subqueries and set operations
- Built-in functions
- Stored procedures
- User-defined functions
- Temporary relations
- Indexes
- Views

The database was implemented using Microsoft SQL Server and T-SQL.

## Project Topic

The selected topic of this project is an Online Learning Platform.

In this system, users can register as students or instructors. Students can enroll in courses, make payments, follow lessons, complete subtopics, attempt quizzes, submit assignments, and receive certificates. Instructors can create courses and manage course-related content. Courses can be classified into categories and may include lessons, quizzes, assignments, and subtopics.

## Database Name

The database used in this project is:

OnlineLearningPlatformDB

## Main Entities

The main entities included in the ER diagram and relational schema are:

- USERS
- STUDENT
- INSTRUCTOR
- COURSE
- CATEGORY
- LESSON
- SUBTOPIC
- ENROLLMENT
- PAYMENT
- REFUND
- QUIZ
- QUIZATTEMPT
- ASSIGNMENT
- SUBMISSION
- CERTIFICATE
- CLASSIFIES

## ER Diagram

The ER diagram represents the conceptual design of the Online Learning Platform database.

It includes:

- Entities
- Attributes
- Primary key attributes
- Relationships between entities
- Cardinalities
- Specialization between USERS, STUDENT, and INSTRUCTOR
- Many-to-many relationship between COURSE and CATEGORY through CLASSIFIES

The ER diagram file is located in the diagrams folder.

## Relational Schema

The relational schema was created by transforming the ER diagram into relational tables.

Main relations used in the project:

USERS(UserID, Email, Password, RegDate, Name, Status)

STUDENT(UserID, StudentID, Level, Description, Country, LearningGoal)

INSTRUCTOR(UserID, InstructorID, RatingAvg, JoinedAt, Expertise, VerificationStatus, Bio)

COURSE(CourseID, Price, Level, Language, Title, CreatedAt, InstructorUserID)

CATEGORY(CategoryID, Description, CreatedAt, Name, Active)

LESSON(LessonID, Description, CreatedAt, VideoUrl, Title, Duration, CourseID)

SUBTOPIC(SubtopicID, LessonID, OrderNo, Content, Duration, Title, MaterialLink)

ENROLLMENT(EnrollmentNO, Started, Ended, Status, Progress, Completed, StudentUserID, CourseID)

CERTIFICATE(CertificateCode, IssuedAt, DownloadUrl, Status, CompletedScore, EnrollmentNO)

PAYMENT(PaymentID, Date, RefCode, Amount, Currency, Method, EnrollmentNO)

REFUND(RefundID, Reason, RefundAmount, RequestDate, ProcessedDate, Status, PaymentID)

QUIZ(QuizID, Password, TimeLimit, Status, Title, CourseID)

QUIZATTEMPT(AttemptID, Started, Ended, Passed, Score, QuizID, StudentUserID)

ASSIGNMENT(AssignmentID, Description, DueDate, MaxScore, Title, CourseID)

SUBMISSION(SubmissionID, SubmissionAt, Feedback, Grade, FileUrl, Status, AssignmentID, StudentUserID)

CLASSIFIES(CategoryID, CourseID)

## Main Relationships

The database includes the following main relationships:

- A user can be a student.
- A user can be an instructor.
- An instructor can create many courses.
- A course is created by one instructor.
- A course can include many lessons.
- A lesson can include many subtopics.
- A student can enroll in many courses.
- A course can have many enrollments.
- An enrollment can have a payment.
- A payment can have a refund.
- A course can have quizzes.
- A quiz can have many quiz attempts.
- A student can attempt many quizzes.
- A course can have assignments.
- An assignment can have many submissions.
- A student can make many submissions.
- An enrollment can generate a certificate.
- A course can belong to many categories.
- A category can include many courses.

## Important Foreign Key Relationships

Some important foreign key relationships are:

STUDENT.UserID references USERS.UserID

INSTRUCTOR.UserID references USERS.UserID

COURSE.InstructorUserID references INSTRUCTOR.UserID

LESSON.CourseID references COURSE.CourseID

SUBTOPIC.LessonID references LESSON.LessonID

ENROLLMENT.StudentUserID references STUDENT.UserID

ENROLLMENT.CourseID references COURSE.CourseID

CERTIFICATE.EnrollmentNO references ENROLLMENT.EnrollmentNO

PAYMENT.EnrollmentNO references ENROLLMENT.EnrollmentNO

REFUND.PaymentID references PAYMENT.PaymentID

QUIZ.CourseID references COURSE.CourseID

QUIZATTEMPT.QuizID references QUIZ.QuizID

QUIZATTEMPT.StudentUserID references STUDENT.UserID

ASSIGNMENT.CourseID references COURSE.CourseID

SUBMISSION.AssignmentID references ASSIGNMENT.AssignmentID

SUBMISSION.StudentUserID references STUDENT.UserID

CLASSIFIES.CategoryID references CATEGORY.CategoryID

CLASSIFIES.CourseID references COURSE.CourseID

## Repository Structure

OnlineLearningProject/
│
├── README.md
│
├── docs/
│   ├── OnlineLearningRequirements.docx
│   ├── SCHEMA.docx
│   └── OUTPUTS.docx
│
├── diagrams/
│   └── ER_Diagram.jpeg
│
└── sql/
    ├── SQLQuery1_HOW3.sql
    ├── SQLQuery2_HOW4.sql
    ├── SQLQuery3_HOW5.sql
    ├── SQLQuery4_HOW6.sql
    ├── SQLQuery5_HOW7.sql
    ├── SQLQuery6_HOW8.sql
    ├── SQLQuery7_HOW9.sql
    └── SQLQuery8_HOW10.sql

## Document Descriptions

### OnlineLearningRequirements.docx

This document contains the requirements of the Online Learning Platform. It explains what the system should manage and store. The requirements describe the main parts of the platform such as users, students, instructors, courses, enrollments, payments, refunds, quizzes, assignments, submissions, certificates, lessons, subtopics, and categories.

### ER_Diagram.jpeg

This file contains the ER diagram of the project. It shows the conceptual structure of the database, including entities, attributes, relationships, and cardinalities.

### SCHEMA.docx

This document contains the relational schema of the database. It shows the tables, attributes, primary keys, foreign keys, and relationships after converting the ER diagram into relational form.

### OUTPUTS.docx

This document contains the outputs and screenshots of the SQL operations. It shows the execution results of the SQL scripts, table outputs, query results, joins, subqueries, functions, stored procedures, indexes, views, and other database operations.

## SQL File Descriptions

### SQLQuery1_HOW3.sql

This file contains the database creation and table creation operations.

It includes:

- Creating the OnlineLearningPlatformDB database
- Creating all main tables
- Defining primary keys
- Defining unique constraints
- Defining check constraints
- Defining default values
- Inserting sample records
- Displaying inserted records
- Adding foreign key constraints

The main purpose of this file is to create the database structure and prepare the sample data used in the other SQL files.

### SQLQuery2_HOW4.sql

This file contains basic SELECT query operations.

It includes:

- SELECT *
- Selecting specific columns
- WHERE conditions
- LIKE operator
- ORDER BY
- TOP
- TOP PERCENT
- GROUP BY
- Aggregate functions
- Listing tables using INFORMATION_SCHEMA
- Listing tables using sys.tables

Example operations include displaying users, listing courses, filtering students by country, finding courses by price, grouping courses by level, and showing payment statistics.

### SQLQuery3_HOW5.sql

This file contains join operations.

It includes:

- INNER JOIN
- LEFT OUTER JOIN
- RIGHT OUTER JOIN
- FULL OUTER JOIN
- CROSS JOIN
- SELF JOIN

Example operations include joining courses with instructors, lessons with courses, students with enrollments, quiz attempts with students, assignments with submissions, and courses with categories.

### SQLQuery4_HOW6.sql

This file contains advanced query operations.

It includes:

- Subqueries
- Correlated subqueries
- UNION
- UNION ALL
- INTERSECT
- EXCEPT
- ISNULL
- COALESCE
- CASE expressions

Example operations include finding students enrolled in courses of verified instructors, finding active category courses, retrieving highest progress values, combining query results, handling NULL values, and displaying conditional results using CASE.

### SQLQuery5_HOW7.sql

This file contains SQL Server built-in function examples.

It includes string functions, date functions, and mathematical functions.

String functions used in this file include:

- ASCII
- CHAR
- LTRIM
- TRIM
- LOWER
- UPPER
- REVERSE
- LEN
- LEFT
- RIGHT
- CHARINDEX
- SUBSTRING
- REPLICATE
- SPACE
- PATINDEX
- REPLACE
- STUFF

Date and time functions used in this file include:

- ISDATE
- DAY
- MONTH
- YEAR
- DATENAME
- DATEADD
- DATEDIFF

Mathematical functions used in this file include:

- ABS
- CEILING
- FLOOR
- POWER
- SQUARE
- SQRT
- RAND
- ROUND

The purpose of this file is to demonstrate how built-in SQL Server functions can be used on project data.

### SQLQuery6_HOW8.sql

This file contains stored procedure examples.

It includes stored procedures with parameters and output parameters.

The stored procedures are used to:

- Calculate course progress statistics
- Display payment and refund information
- Return calculated values using output parameters

This file demonstrates how stored procedures can be used to make database operations more reusable and organized.

### SQLQuery7_HOW9.sql

This file contains user-defined functions and a local temporary relation.

It includes:

- Scalar-valued function
- Inline table-valued function
- Local temporary table
- Queries on the temporary table

One function calculates the success percentage of a submission by comparing the submission grade with the assignment maximum score.

Another function returns certificate and course completion information for a selected student.

The temporary table is used to store and analyze student course progress information.

### SQLQuery8_HOW10.sql

This file contains index and view operations.

It includes:

- Creating indexes
- Creating a clustered index
- Creating a nonclustered index
- Creating a unique index
- Displaying index information
- Creating a view
- Querying a view
- Inserting data into a base table
- Checking how the view reflects inserted data
- Deleting data from a base table
- Checking the final view result

The view created in this file combines enrollment and course information to make query results easier to read and reuse.

## SQL Concepts Used

This project demonstrates the following database and SQL concepts:

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Unique constraints
- Check constraints
- Default values
- Data insertion
- Basic SELECT queries
- WHERE conditions
- LIKE operator
- ORDER BY
- TOP and TOP PERCENT
- Aggregate functions
- GROUP BY
- INFORMATION_SCHEMA
- sys.tables
- INNER JOIN
- LEFT OUTER JOIN
- RIGHT OUTER JOIN
- FULL OUTER JOIN
- CROSS JOIN
- SELF JOIN
- Subqueries
- Correlated subqueries
- UNION
- UNION ALL
- INTERSECT
- EXCEPT
- ISNULL
- COALESCE
- CASE
- String functions
- Date and time functions
- Mathematical functions
- Stored procedures
- Output parameters
- User-defined functions
- Scalar-valued functions
- Inline table-valued functions
- Temporary tables
- Indexes
- Views

## How to Run the Project

To run this project:

1. Open Microsoft SQL Server Management Studio.
2. Open the SQL files from the sql folder.
3. Execute SQLQuery1_HOW3.sql first.
4. After the database, tables, constraints, and sample records are created, execute the remaining SQL files in order.
5. Make sure the selected database is OnlineLearningPlatformDB.
6. Review the query results and outputs in SQL Server Management Studio.

Recommended execution order:

1. SQLQuery1_HOW3.sql
2. SQLQuery2_HOW4.sql
3. SQLQuery3_HOW5.sql
4. SQLQuery4_HOW6.sql
5. SQLQuery5_HOW7.sql
6. SQLQuery6_HOW8.sql
7. SQLQuery7_HOW9.sql
8. SQLQuery8_HOW10.sql

SQLQuery1_HOW3.sql must be executed first because it creates the database, tables, constraints, and sample data required by the other SQL scripts.

## Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio
- T-SQL
- Microsoft Word
- ER Modeling
- Relational Database Design

## Purpose of the Project

The purpose of this project is to practice the full database design and implementation process. It starts from requirement analysis and ER modeling, then continues with relational schema design and SQL implementation. The project also demonstrates how SQL can be used to query, manage, analyze, and organize data in a real-world database scenario.

## Notes

- This project was created for educational purposes.
- The data used in the project is sample data.
- The database represents a simplified version of an online learning platform.
- The output document includes screenshots of the executed SQL statements and results.
- The project files should be executed in the correct order to avoid dependency errors.

## Course

Database Management Systems and Applications
