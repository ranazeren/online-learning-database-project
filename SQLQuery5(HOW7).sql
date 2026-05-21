USE OnlineLearningPlatformDB

-- Query 1 :changes the user name and email format.
--It finds the first letter of the name, shows its ASCII value, reverses the name, 
--calculates the name length, changes email to lowercase, and changes status to uppercase.
SELECT UserID,Name,Email,
    ASCII(LEFT(Name, 1)) AS FirstLetterASCII,
    CHAR(ASCII(LEFT(Name, 1))) AS FirstLetter,
    LTRIM(RTRIM(Name)) AS TrimmedName,
    LOWER(Email) AS LowerEmail,
    UPPER(Status) AS UpperStatus,
    REVERSE(Name) AS ReversedName,
    LEN(Name) AS NameLength
FROM USERS
WHERE Name IS NOT NULL AND Email IS NOT NULL


-- Query 2 :changes the course title format.
-- It takes characters from the left and right side of the title,
-- finds the position of words in the title,
-- replaces a word, adds spaces, and changes part of the title.
SELECT CourseID,Title,
    LEFT(Title, 5) AS FirstFiveCharacters,
    RIGHT(Title, 5) AS LastFiveCharacters,
    CHARINDEX('Data', Title) AS DataPosition,
    SUBSTRING(Title, 1, 4) AS ShortTitle,
    REPLICATE('*', 5) AS Stars,
    Title + SPACE(3) + Level AS TitleWithLevel,
    PATINDEX('%SQL%', Title) AS SQLPatternPosition,
    REPLACE(Title, 'Course', 'Class') AS ReplacedTitle,
    STUFF(Title, 1, 2, 'OL') AS StuffedTitle
FROM COURSE
WHERE Title IS NOT NULL AND Level IS NOT NULL

-- Query 3 :shows assignment due date information.
-- It separates the due date into day, month, and year,and shows the month name.
SELECT AssignmentID,Title,DueDate,
    ISDATE(CAST(DueDate AS VARCHAR(20))) AS IsValidDate,
    DAY(DueDate) AS DueDay,
    MONTH(DueDate) AS DueMonth,
    YEAR(DueDate) AS DueYear,
    DATENAME(MONTH, DueDate) AS DueMonthName
FROM ASSIGNMENT
WHERE DueDate IS NOT NULL

-- Query 4:shows enrollment date information.
-- It adds 7 days to the start date,calculates the number of days between start and end dates,and shows the weekday name.
SELECT EnrollmentNo,Started,Ended,
    DATEADD(DAY, 7, Started) AS OneWeekAfterStart,
    DATEDIFF(DAY, Started, Ended) AS EnrollmentDurationDays,
    DATENAME(WEEKDAY, Started) AS StartDayName
FROM ENROLLMENT
WHERE Started IS NOT NULL AND Ended IS NOT NULL

-- Query 5:calculates quiz score values.
-- It rounds the score, finds the square of the score,finds the square root of the score and shows ceiling and floor values.
SELECT AttemptID,StudentUserID,QuizID,Score,
    ABS(Score) AS AbsoluteScore,
    CEILING(Score) AS CeilingScore,
    FLOOR(Score) AS FloorScore,
    ROUND(Score, 0) AS RoundedScore,
    SQUARE(Score) AS ScoreSquare,
    SQRT(Score) AS ScoreSquareRoot
FROM QUIZATTEMPT
WHERE Score IS NOT NULL

-- Query 6:calculates payment amount values.
-- It rounds the payment amount,shows ceiling and floor values,calculates the power of the amount,and creates a random value.
SELECT PaymentID,EnrollmentNo,Amount,Currency,
    POWER(Amount, 2) AS AmountPowerTwo,
    ROUND(Amount, 1) AS RoundedAmount,
    CEILING(Amount) AS CeilingAmount,
    FLOOR(Amount) AS FloorAmount,
    RAND() AS RandomValue
FROM PAYMENT
WHERE Amount IS NOT NULL