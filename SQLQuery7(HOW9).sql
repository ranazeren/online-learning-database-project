USE OnlineLearningPlatformDB
GO
-- UDF 1
-- This scalar-valued function calculates the success percentage
-- of a submitted assignment.
-- It compares the student's grade with the maximum score of the assignment.

-- The function returns the calculated percentage value.

CREATE FUNCTION fn_SubmissionSuccessPercentage
(@SubmissionID INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @SuccessPercentage DECIMAL(5,2)
    -- Calculate the submitted assignment success percentage.
    SELECT @SuccessPercentage = ROUND((S.Grade * 100.0) / A.MaxScore, 2)
    FROM SUBMISSION S, ASSIGNMENT A
    WHERE S.AssignmentID = A.AssignmentID
    AND S.SubmissionID = @SubmissionID
    AND S.Grade IS NOT NULL
    AND A.MaxScore IS NOT NULL

RETURN @SuccessPercentage
END
GO


-- OUTPUT18 - Definition of scalar-valued function 

EXEC sp_helptext 'fn_SubmissionSuccessPercentage'
GO


-- OUTPUT19 and OUTPUT20 - Calling scalar-valued function 

-- This query calls the scalar-valued function.
-- It shows submitted assignment information and calculates
-- the success percentage of the submission.

SELECT SubmissionID,AssignmentID,StudentUserID,Grade,dbo.fn_SubmissionSuccessPercentage(SubmissionID) AS SuccessPercentage
FROM SUBMISSION
WHERE Grade IS NOT NULL
GO



--UDF 2
-- This inline table-valued function returns certificate and
-- course completion information.
-- It shows enrollment progress, completion status,
-- certificate score, and certificate status.
CREATE FUNCTION fn_StudentCertificateStatus
(@StudentUserID INT)
RETURNS TABLE
AS
RETURN(
  SELECT E.EnrollmentNo,E.StudentUserID,E.CourseID,E.Progress,E.Completed,C.CertificateCode,C.IssuedAt,C.CompletedScore,C.Status AS CertificateStatus
  FROM ENROLLMENT E, CERTIFICATE C
  WHERE E.EnrollmentNo = C.EnrollmentNo
  AND E.StudentUserID = @StudentUserID)
GO


--OUTPUT18)Definition of inline table-valued function 

EXEC sp_helptext 'fn_StudentCertificateStatus'


--OUTPUT19 and OUTPUT20 - Calling inline table-valued function 

-- This query calls the inline table-valued function.
-- It lists certificate and course completion information
-- for the selected student.

SELECT *
FROM dbo.fn_StudentCertificateStatus(1)
GO



--PART 2)LOCAL TEMPORARY RELATION FOR JOIN

-- This query creates a local temporary relation by combining
-- student, enrollment, course, and user information.
-- It stores active students with their course progress
-- and completion information.

SELECT 
 U.UserID,
 U.Name AS StudentName,
 U.Email,
 S.Level AS StudentLevel,
 S.Country,
 E.EnrollmentNo,
 E.Started,
 E.Ended,
 E.Status AS EnrollmentStatus,
 E.Progress,
 E.Completed,
 C.CourseID,
 C.Title AS CourseTitle,
 C.Level AS CourseLevel,
 C.Price
INTO #StudentCourseProgress
FROM USERS U, STUDENT S, ENROLLMENT E, COURSE C
WHERE U.UserID = S.UserID
AND S.UserID = E.StudentUserID
AND E.CourseID = C.CourseID
AND U.Status = 'Active'
GO


--OUTPUT21 and OUTPUT22) Display local temporary relation 

SELECT *
FROM #StudentCourseProgress
GO



-- PART 3) QUERIES ON LOCAL TEMPORARY RELATION

-- Query 1
-- This query uses the local temporary relation.
-- It calculates student count, average progress,
-- lowest progress, and highest progress for each course.

SELECT CourseID,CourseTitle,
  COUNT(UserID) AS StudentCount,
  MIN(Progress) AS LowestProgress,
  MAX(Progress) AS HighestProgress,
  ROUND(AVG(Progress), 2) AS AverageProgress
FROM #StudentCourseProgress
WHERE Progress IS NOT NULL
GROUP BY CourseID, CourseTitle
GO


-- Query 2
-- This query uses the local temporary relation.
-- It lists students who completed their courses
-- and shows their course information.

SELECT StudentName,Email,Country,CourseTitle,Completed
FROM #StudentCourseProgress
WHERE Completed = 1
GO