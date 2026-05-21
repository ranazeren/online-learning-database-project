USE OnlineLearningPlatformDB


-- Query 1:Display all Users with UserID, Email, Password, RegDate, Name and Status
SELECT * FROM USERS

-- Query 2:Display All Courses with CourseID, Price, Level, Language, Title, CreatedAt, and InstructorUserID
SELECT * FROM COURSE

-- Query 3:Display  names and emails of users
SELECT Name, Email FROM USERS

--Query 4:Display course title and price
SELECT Title, Price FROM COURSE

--Query 5:Display students from Turkey
SELECT * FROM STUDENT
WHERE Country = 'Turkey'

--Query 6:Display courses with price greater than 150
SELECT * FROM COURSE
WHERE Price > 150

--Query 7:Find users whose name starts with 'A'
SELECT * FROM USERS
WHERE Name LIKE 'A%'

-- Query 8:Find courses containing 'Data' in title
SELECT * FROM COURSE
WHERE Title LIKE '%Data%'

-- Query 9:Display paid courses sorted by price ascending
SELECT *
FROM COURSE
WHERE Price > 0
ORDER BY Price ASC

-- Query 10:Display Active Users Sorted by Name in Alphabetical Order
SELECT Name, Status
FROM USERS
WHERE Status = 'Active'
ORDER BY Name

-- Query 11:Display students from known countries sorted by country and level
SELECT *
FROM STUDENT
WHERE Country IS NOT NULL
ORDER BY Country, Level

-- Query 12:Display courses with price greater than 100 sorted by level and price
SELECT *
FROM COURSE
WHERE Price > 100
ORDER BY Level, Price

-- Query 13:Display the first 5 users with UserID, Email, Password, RegDate, Name and Status
SELECT TOP 5 *
FROM USERS
ORDER BY UserID

-- Query 14:Display the first 5 courses with CourseID, Price, Level, Language, Title, CreatedAt and InstructorUserID
SELECT TOP 5 *
FROM COURSE
ORDER BY CourseID

-- Query 15:Display the first 5 enrollments with EnrollmentNo, Started, Ended, Status, Progress, Completed, StudentUserID, and CourseID
SELECT TOP 5 *
FROM ENROLLMENT
ORDER BY EnrollmentNo

-- Query 16:Display the top 20 percent of users
SELECT TOP 20 PERCENT *
FROM USERS
ORDER BY UserID

-- Query 17:Display the top 20 percent of courses
SELECT TOP 20 PERCENT *
FROM COURSE
ORDER BY CourseID

-- Query 18:Display the top 20 percent of payments 
SELECT TOP 20 PERCENT *
FROM PAYMENT
ORDER BY PaymentID

-- Query 19:Course statistics by level
SELECT Level,
       COUNT(*) AS TotalCourses,
       SUM(Price) AS TotalPrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
FROM COURSE
GROUP BY Level

-- Query 20:Payment statistics by currency
SELECT Currency,
       COUNT(*) AS TotalPayments,
       SUM(Amount) AS TotalAmount,
       MIN(Amount) AS MinPayment,
       MAX(Amount) AS MaxPayment
FROM PAYMENT
GROUP BY Currency

-- Query 21:Enrollment progress statistics by status
SELECT Status,
       COUNT(*) AS TotalEnrollments,
       SUM(Progress) AS TotalProgress,
       MIN(Progress) AS MinProgress,
       MAX(Progress) AS MaxProgress
FROM ENROLLMENT
GROUP BY Status

-- Query 22:List tables using INFORMATION_SCHEMA
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

-- Query 23:List tables using sys.tables
SELECT name
FROM sys.tables

-- Query 24:List all user tables using sys.objects
SELECT name
FROM sys.objects
WHERE type = 'U'