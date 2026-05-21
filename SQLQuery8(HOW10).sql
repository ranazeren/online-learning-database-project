use OnlineLearningPlatformDB
GO
 -- PART 1 ) INDEXES

--Query 1: drops the existing clustered primary key constraint on the REFUND table.
--Then it creates a new clustered index on RequestDate.
--This is done because the homework asks us to delete the existing clustered index and create a new clustered index.
ALTER TABLE REFUND
DROP CONSTRAINT [PK__REFUND__725AB9004FE323EE]
GO

CREATE CLUSTERED INDEX IX_REFUND_RequestDate
ON REFUND(RequestDate)
GO

--2
CREATE NONCLUSTERED INDEX IX_ENROLLMENT_Student_Course
ON ENROLLMENT(StudentUserID, CourseID)
GO


--3
CREATE UNIQUE INDEX IX_REFUND_RefundID_Unique
ON REFUND(RefundID)
GO

EXEC sp_helpindex 'REFUND'
EXEC sp_helpindex 'ENROLLMENT'
GO


--Query 5:creates a simple view by joining ENROLLMENT and COURSE tables.
--The view shows enrollment information together with the course title.

CREATE VIEW VW_EnrollmentCourse AS
SELECT
 E.EnrollmentNo,
 E.StudentUserID,
 E.CourseID,
 C.Title AS CourseTitle,
 E.Started,
 E.Ended,
 E.Status,
 E.Progress,
 E.Completed
FROM ENROLLMENT E
INNER JOIN COURSE C ON E.CourseID = C.CourseID;
GO


--Query 6: displays all records from the view.
SELECT *
FROM VW_EnrollmentCourse
GO

--Query 7:displays enrollments with progress greater than 50.
SELECT EnrollmentNo,StudentUserID,CourseID,CourseTitle,Status,Progress,Completed
FROM VW_EnrollmentCourse
WHERE Progress > 50
GO

--Query 8:displays the definition of the created view.
EXEC sp_helptext 'VW_EnrollmentCourse'
GO

--Query 9:inserts a new enrollment record into the ENROLLMENT table.
INSERT INTO ENROLLMENT
( EnrollmentNo,StudentUserID,CourseID,Started, Ended,Status,Progress,Completed )
VALUES(99,1,1,'2024-08-01',NULL,'In Progress',45,0)
GO

--Query 10:displays the inserted record from the view.
SELECT *
FROM VW_EnrollmentCourse
WHERE EnrollmentNo = 99
GO

--Query 11:deletes the inserted record.
DELETE FROM ENROLLMENT
WHERE EnrollmentNo = 99
GO

--Query 12:checks the view after delete operation.
SELECT *
FROM VW_EnrollmentCourse
WHERE EnrollmentNo = 99
GO

