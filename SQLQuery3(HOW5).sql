USE OnlineLearningPlatformDB

-- Query 1:Display each course with the expertise of its instructor
SELECT Title, Expertise
FROM COURSE
JOIN INSTRUCTOR ON COURSE.InstructorUserID = INSTRUCTOR.UserID

-- Query 2:Display each lesson with its related course title
SELECT LESSON.Title AS LessonTitle, COURSE.Title AS CourseTitle
FROM LESSON
JOIN COURSE ON LESSON.CourseID = COURSE.CourseID

-- Query 3:Display each quiz with its course title
SELECT QUIZ.Title, COURSE.Title AS CourseTitle
FROM QUIZ
JOIN COURSE ON QUIZ.CourseID = COURSE.CourseID

-- Query 4:Display student names, course titles, and enrollment status
SELECT Name, Title, ENROLLMENT.Status
FROM ENROLLMENT
JOIN STUDENT ON ENROLLMENT.StudentUserID = STUDENT.UserID
JOIN USERS ON STUDENT.UserID = USERS.UserID
JOIN COURSE ON ENROLLMENT.CourseID = COURSE.CourseID

-- Query 5:Display student names, quiz titles, and scores
SELECT Name, Title, Score
FROM QUIZATTEMPT
JOIN STUDENT ON QUIZATTEMPT.StudentUserID = STUDENT.UserID
JOIN USERS ON STUDENT.UserID = USERS.UserID
JOIN QUIZ ON QUIZATTEMPT.QuizID = QUIZ.QuizID

-- Query 6:Display lesson titles, subtopic titles, and course titles
SELECT LESSON.Title AS LessonTitle, SUBTOPIC.Title AS SubtopicTitle, COURSE.Title AS CourseTitle
FROM SUBTOPIC
JOIN LESSON ON SUBTOPIC.LessonID = LESSON.LessonID
JOIN COURSE ON LESSON.CourseID = COURSE.CourseID

-- Query 7:Display instructors and their courses, including instructors without any course
SELECT InstructorID,Title
FROM INSTRUCTOR
LEFT OUTER JOIN COURSE 
ON INSTRUCTOR.UserID = COURSE.InstructorUserID

-- Query 8:Display all students and their enrollments 
SELECT StudentID, EnrollmentNo
FROM STUDENT
LEFT OUTER JOIN ENROLLMENT ON STUDENT.UserID = ENROLLMENT.StudentUserID

-- Query 9:Display all assignments and their submissions 
SELECT Title,SubmissionID
FROM ASSIGNMENT
LEFT OUTER JOIN SUBMISSION ON ASSIGNMENT.AssignmentID = SUBMISSION.AssignmentID

-- Query 10:Display all refunds and their related payments
SELECT PAYMENT.PaymentID, RefundID, Status
FROM PAYMENT
RIGHT OUTER JOIN REFUND
ON PAYMENT.PaymentID = REFUND.PaymentID

-- Query 11:Display all submissions and their related assignments
SELECT Title, SubmissionID, Grade
FROM ASSIGNMENT
RIGHT OUTER JOIN SUBMISSION
ON ASSIGNMENT.AssignmentID = SUBMISSION.AssignmentID

-- Query 12:Display all enrollments and certificates, including unmatched records
SELECT ENROLLMENT.EnrollmentNo, CertificateCode
FROM ENROLLMENT
FULL OUTER JOIN CERTIFICATE
ON ENROLLMENT.EnrollmentNo = CERTIFICATE.EnrollmentNo

-- Query 13:Display all courses and quizzes, including unmatched records
SELECT COURSE.Title, QUIZ.Title AS QuizTitle
FROM COURSE
FULL OUTER JOIN QUIZ
ON COURSE.CourseID = QUIZ.CourseID



-- Query 14:Display all combinations of courses and categories
SELECT COURSE.Title, CATEGORY.Name
FROM COURSE
CROSS JOIN CATEGORY

-- Query 15:Display all combinations of students and quizzes
SELECT STUDENT.StudentID, QUIZ.Title
FROM STUDENT
CROSS JOIN QUIZ


-- Query 16:Display courses with other courses that have the same level
SELECT 
    C1.Title AS CourseName,
    C1.Level AS CourseLevel,
    C2.Title AS SimilarCourse,
    C2.Level AS SimilarCourseLevel
FROM COURSE C1
JOIN COURSE C2
ON C1.Level = C2.Level
AND C1.CourseID < C2.CourseID


-- Query 17:Display students with other students from the same country
SELECT
    S1.StudentID,
    S1.Country,
    S2.StudentID AS OtherStudent,
    S2.Country AS SameCountry
FROM STUDENT S1
JOIN STUDENT S2
ON S1.Country = S2.Country
AND S1.UserID < S2.UserID
