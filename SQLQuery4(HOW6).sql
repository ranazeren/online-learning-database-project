USE OnlineLearningPlatformDB

-- 1.retrieve the students who are enrolled in courses created by verified instructors.
SELECT UserID, Name, Email
 FROM USERS
 WHERE UserID IN(
SELECT StudentUserID
FROM ENROLLMENT
WHERE CourseID IN(
  SELECT CourseID
  FROM COURSE
  WHERE InstructorUserID IN(
   SELECT UserID
   FROM INSTRUCTOR
   WHERE VerificationStatus = 'Verified')))

-- 2.Retrieve the courses that belong to active categories.
SELECT CourseID, Title, Level, Price
 FROM COURSE
 WHERE CourseID IN(
  SELECT CourseID
  FROM CLASSIFIES
  WHERE CategoryID IN(
   SELECT CategoryID
   FROM CATEGORY
   WHERE Active = 1))

-- 3.Retrieve the enrollment records that have the highest progress in each course.
SELECT EnrollmentNo, StudentUserID, CourseID, Progress, Status
FROM ENROLLMENT E
WHERE Progress =(SELECT MAX(Progress)
 FROM ENROLLMENT
 WHERE CourseID = E.CourseID)


-- 4.Retrieve the quiz attempts that have the lowest score in each quiz.
SELECT AttemptID, StudentUserID, QuizID, Score, Passed
FROM QUIZATTEMPT Q
WHERE Score =(SELECT MIN(Score)
 FROM QUIZATTEMPT
 WHERE QuizID = Q.QuizID)


-- 5.Retrieve all course and quiz titles that are not NULL.
SELECT Title AS LearningTitle
FROM COURSE
WHERE Title IS NOT NULL
UNION
SELECT Title AS LearningTitle
FROM QUIZ
WHERE Title IS NOT NULL

-- 6.Retrieve the student IDs who either submitted an assignment or passed a quiz.
SELECT StudentUserID
FROM SUBMISSION
WHERE StudentUserID IS NOT NULL
UNION
SELECT StudentUserID
FROM QUIZATTEMPT
WHERE Passed = 1


-- 7.Retrieve all assignment and lesson titles duplicate values are kept.
SELECT Title AS ContentTitle
FROM ASSIGNMENT
WHERE Title IS NOT NULL
UNION ALL
SELECT Title AS ContentTitle
FROM LESSON
WHERE Title IS NOT NULL

-- 8.Retrieve all course IDs from lessons and quizzes duplicate values are kept.
SELECT CourseID
FROM LESSON
WHERE CourseID IS NOT NULL
UNION ALL
SELECT CourseID
FROM QUIZ
WHERE CourseID IS NOT NULL

-- 9.Retrieve the student IDs of learners who both submitted an assignment and attempted a quiz.
SELECT StudentUserID
FROM SUBMISSION
WHERE StudentUserID IS NOT NULL
INTERSECT
SELECT StudentUserID
FROM QUIZATTEMPT
WHERE StudentUserID IS NOT NULL

-- 10.Retrieve the course IDs that exist in both LESSON and QUIZ.
SELECT CourseID
FROM LESSON
WHERE CourseID IS NOT NULL
INTERSECT
SELECT CourseID
FROM QUIZ
WHERE CourseID IS NOT NULL

-- 11.Retrieve the student IDs of learners who submitted an assignment but did not pass any quiz.
SELECT StudentUserID
FROM SUBMISSION
WHERE StudentUserID IS NOT NULL
EXCEPT
SELECT StudentUserID
FROM QUIZATTEMPT
WHERE Passed = 1

-- 12.Retrieve the course IDs that exist in LESSON but do not exist in QUIZ.
SELECT CourseID
FROM LESSON
WHERE CourseID IS NOT NULL
EXCEPT
SELECT CourseID
FROM QUIZ
WHERE CourseID IS NOT NULL

-- 13.Display enrollment end dates and replace NULL values using ISNULL.
SELECT EnrollmentNo, Status,ISNULL(CAST(Ended AS NVARCHAR(20)), 'Not Completed Yet') AS EndDateInfo
FROM ENROLLMENT

-- 14.Display course completion date information using ISNULL.
SELECT EnrollmentNo, StudentUserID, CourseID,ISNULL(CAST(Ended AS NVARCHAR(20)), 'No End Date') AS CompletionDate
FROM ENROLLMENT

-- 15.Display enrollment end date information using COALESCE.
SELECT EnrollmentNo, Progress,COALESCE(CAST(Ended AS NVARCHAR(20)), 'Course Still In Progress') AS EndDateStatus
FROM ENROLLMENT

-- 16.Display completed course information using COALESCE.
SELECT EnrollmentNo, Completed,COALESCE(CAST(Ended AS NVARCHAR(20)), 'Not Finished') AS CourseEndInformation
FROM ENROLLMENT



-- 17.Display enrollment completion status using CASE.
SELECT EnrollmentNo, Status,
 CASE
  WHEN Ended IS NULL THEN 'Course is not completed yet'
  ELSE 'Course completed'
END AS CompletionStatus
FROM ENROLLMENT

-- 18.Display detailed enrollment progress information using CASE.
SELECT EnrollmentNo, Progress, Completed,
 CASE
  WHEN Ended IS NULL THEN 'In progress - no completion date'
  ELSE 'Completed'
END AS ProgressExplanation
FROM ENROLLMENT