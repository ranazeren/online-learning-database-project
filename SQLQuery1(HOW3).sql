CREATE DATABASE OnlineLearningPlatformDB
USE OnlineLearningPlatformDB

CREATE TABLE USERS(
    UserID INT NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    RegDate DATE NOT NULL DEFAULT GETDATE(),
    Name NVARCHAR(100) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    PRIMARY KEY (UserID),
    UNIQUE (Email)
)

CREATE TABLE STUDENT(
    UserID INT NOT NULL,
    StudentID INT NOT NULL,
    Level NVARCHAR(30),
    Description NVARCHAR(255),
    Country NVARCHAR(50),
    LearningGoal NVARCHAR(255),
    PRIMARY KEY (UserID),
    UNIQUE (StudentID)
)

CREATE TABLE INSTRUCTOR(
    UserID INT NOT NULL,
    InstructorID INT NOT NULL,
    RatingAvg DECIMAL(3,2),
    JoinedAt DATE,
    Expertise NVARCHAR(100),
    VerificationStatus NVARCHAR(20),
    Bio NVARCHAR(500),
    PRIMARY KEY (UserID),
    UNIQUE (InstructorID)
)

CREATE TABLE CATEGORY(
    CategoryID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATE NOT NULL DEFAULT GETDATE(),
    Active BIT NOT NULL DEFAULT 1,
    PRIMARY KEY (CategoryID)
)

CREATE TABLE COURSE(
    CourseID INT NOT NULL,
    Price DECIMAL(10,2),
    Level NVARCHAR(30),
    Language NVARCHAR(30),
    Title NVARCHAR(150),
    CreatedAt DATE DEFAULT GETDATE(),
    InstructorUserID INT NOT NULL,
    PRIMARY KEY (CourseID),
    CHECK (Price >= 0)
)

CREATE TABLE LESSON(
    LessonID INT NOT NULL,
    Description NVARCHAR(500),
    CreatedAt DATE DEFAULT GETDATE(),
    VideoUrl NVARCHAR(255),
    Title NVARCHAR(150),
    Duration INT,
    CourseID INT NOT NULL,
    PRIMARY KEY (LessonID),
    CHECK (Duration > 0)
)

CREATE TABLE SUBTOPIC(
    SubtopicID INT NOT NULL,
    LessonID INT NOT NULL,
    OrderNo INT,
    Content NVARCHAR(1000),
    Duration INT,
    Title NVARCHAR(150),
    MaterialLink NVARCHAR(255),
    PRIMARY KEY (SubtopicID),
    CHECK (Duration > 0),
    CHECK (OrderNo > 0)
)

CREATE TABLE ENROLLMENT(
    EnrollmentNo INT NOT NULL,
    Started DATE,
    Ended DATE,
    Status NVARCHAR(20),
    Progress DECIMAL(5,2) DEFAULT 0,
    Completed BIT DEFAULT 0,
    StudentUserID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (EnrollmentNo),
    CHECK (Progress BETWEEN 0 AND 100)
)

CREATE TABLE CERTIFICATE(
    CertificateCode NVARCHAR(50) NOT NULL,
    IssuedAt DATE,
    DownloadUrl NVARCHAR(255),
    Status NVARCHAR(20),
    CompletedScore DECIMAL(5,2),
    EnrollmentNo INT NOT NULL,
    PRIMARY KEY (CertificateCode),
    UNIQUE (EnrollmentNo),
    CHECK (CompletedScore BETWEEN 0 AND 100)
)

CREATE TABLE PAYMENT(
    PaymentID INT NOT NULL,
    Date DATE,
    RefCode NVARCHAR(50),
    Amount DECIMAL(10,2),
    Currency NVARCHAR(10),
    Method NVARCHAR(30),
    EnrollmentNo INT NOT NULL,
    PRIMARY KEY (PaymentID),
    UNIQUE (RefCode),
    CHECK (Amount >= 0)
)


CREATE TABLE REFUND(
    RefundID INT NOT NULL,
    Reason NVARCHAR(255),
    RefundAmount DECIMAL(10,2),
    RequestDate DATE,
    ProcessedDate DATE,
    Status NVARCHAR(20),
    PaymentID INT NOT NULL,
    PRIMARY KEY (RefundID),
    CHECK (RefundAmount >= 0)
)

CREATE TABLE QUIZ(
    QuizID INT NOT NULL,
    Password NVARCHAR(50),
    TimeLimit INT,
    Status NVARCHAR(20),
    Title NVARCHAR(150),
    CourseID INT NOT NULL,
    PRIMARY KEY (QuizID),
    CHECK (TimeLimit > 0)
)

CREATE TABLE QUIZATTEMPT(
    AttemptID INT NOT NULL,
    Started DATETIME,
    Ended DATETIME,
    Passed BIT,
    Score DECIMAL(5,2),
    QuizID INT NOT NULL,
    StudentUserID INT NOT NULL,
    PRIMARY KEY (AttemptID),
    CHECK (Score BETWEEN 0 AND 100)
)

CREATE TABLE ASSIGNMENT(
    AssignmentID INT NOT NULL,
    Description NVARCHAR(500),
    DueDate DATE,
    MaxScore DECIMAL(5,2),
    Title NVARCHAR(150),
    CourseID INT NOT NULL,
    PRIMARY KEY (AssignmentID),
    CHECK (MaxScore > 0)
)

CREATE TABLE SUBMISSION(
    SubmissionID INT NOT NULL,
    SubmissionAt DATETIME,
    Feedback NVARCHAR(500),
    Grade DECIMAL(5,2),
    FileUrl NVARCHAR(255),
    Status NVARCHAR(20),
    AssignmentID INT NOT NULL,
    StudentUserID INT NOT NULL,
    PRIMARY KEY (SubmissionID),
    CHECK (Grade BETWEEN 0 AND 100)
)

CREATE TABLE CLASSIFIES(
    CategoryID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (CategoryID, CourseID)
)


INSERT INTO USERS VALUES (1,'ali.yilmaz@student.com','s1234','2024-01-10','Ali Yilmaz','Active')
INSERT INTO USERS VALUES (2,'ayse.demir@student.com','s2345','2024-01-12','Ayse Demir','Active')
INSERT INTO USERS VALUES (3,'mehmet.kaya@student.com','s3456','2024-01-15','Mehmet Kaya','Active')
INSERT INTO USERS VALUES (4,'zeynep.arslan@student.com','s4567','2024-01-18','Zeynep Arslan','Active')
INSERT INTO USERS VALUES (5,'can.kurt@student.com','s5678','2024-01-20','Can Kurt','Inactive')
INSERT INTO USERS VALUES (6,'elif.aydin@student.com','s6789','2024-01-22','Elif Aydin','Active')
INSERT INTO USERS VALUES (7,'burak.sen@student.com','s7890','2024-01-25','Burak Sen','Active')
INSERT INTO USERS VALUES (8,'ece.cetin@student.com','s8901','2024-01-28','Ece Cetin','Active')
INSERT INTO USERS VALUES (9,'mert.sahin@student.com','s9012','2024-02-01','Mert Sahin','Active')
INSERT INTO USERS VALUES (10,'selin.koc@student.com','s0123','2024-02-05','Selin Koc','Active')

INSERT INTO USERS VALUES (11,'hakan.yildiz@instructor.com','i1234','2024-02-10','Hakan Yildiz','Active')
INSERT INTO USERS VALUES (12,'derya.bulut@instructor.com','i2345','2024-02-12','Derya Bulut','Active')
INSERT INTO USERS VALUES (13,'ahmet.can@instructor.com','i3456','2024-02-15','Ahmet Can','Active')
INSERT INTO USERS VALUES (14,'fatma.aksoy@instructor.com','i4567','2024-02-18','Fatma Aksoy','Active')
INSERT INTO USERS VALUES (15,'kemal.eren@instructor.com','i5678','2024-02-20','Kemal Eren','Active')
INSERT INTO USERS VALUES (16,'deniz.tunc@instructor.com','i6789','2024-02-22','Deniz Tunc','Active')
INSERT INTO USERS VALUES (17,'seda.kalkan@instructor.com','i7890','2024-02-25','Seda Kalkan','Active')
INSERT INTO USERS VALUES (18,'okan.dogan@instructor.com','i8901','2024-02-28','Okan Dogan','Active')
INSERT INTO USERS VALUES (19,'buse.acar@instructor.com','i9012','2024-03-02','Buse Acar','Active')
INSERT INTO USERS VALUES (20,'emre.tas@instructor.com','i0123','2024-03-05','Emre Tas','Active')
INSERT INTO USERS VALUES (21,'cem.uysal@instructor.com','i1122','2024-03-08','Cem Uysal','Active')
INSERT INTO USERS VALUES (22,'eren.guler@instructor.com','i2233','2024-03-10','Eren Guler','Active')
SELECT* FROM USERS

INSERT INTO STUDENT VALUES (1,1001,'Beginner','Interested in basic programming concepts and simple database systems','Turkey','Learn SQL and relational databases')
INSERT INTO STUDENT VALUES (2,1002,'Beginner','Enjoys coding and solving beginner-level Java problems','Austria','Improve Java programming skills')
INSERT INTO STUDENT VALUES (3,1003,'Intermediate','Interested in Python for data analysis and automation','Denmark','Learn Python for data projects')
INSERT INTO STUDENT VALUES (4,1004,'Beginner','Wants to build modern and responsive websites','Germany','Learn web development fundamentals')
INSERT INTO STUDENT VALUES (5,1005,'Intermediate','Curious about data modeling and information systems','Sweden','Understand database design better')
INSERT INTO STUDENT VALUES (6,1006,'Beginner','Interested in creating Android mobile applications','Turkey','Learn mobile app development')
INSERT INTO STUDENT VALUES (7,1007,'Intermediate','Follows developments in artificial intelligence','Turkey','Learn AI and machine learning basics')
INSERT INTO STUDENT VALUES (8,1008,'Beginner','Wants to understand cloud services and platforms','Turkey','Learn cloud computing concepts')
INSERT INTO STUDENT VALUES (9,1009,'Intermediate','Interested in secure systems and network protection','Turkey','Learn cyber security principles')
INSERT INTO STUDENT VALUES (10,1010,'Beginner','Likes interface design and visual communication','Turkey','Learn UI and UX design')
SELECT* FROM STUDENT

INSERT INTO INSTRUCTOR VALUES (11,2001,4.5,'2024-03-15','SQL','Verified','Experienced instructor in SQL and database systems')
INSERT INTO INSTRUCTOR VALUES (12,2002,4.7,'2024-03-17','Java','Verified','Passionate about teaching software development')
INSERT INTO INSTRUCTOR VALUES (13,2003,4.2,'2024-03-20','Python','Verified','Focuses on Python programming and practical coding')
INSERT INTO INSTRUCTOR VALUES (14,2004,4.8,'2024-03-22','Web','Verified','Teaches frontend and backend web development')
INSERT INTO INSTRUCTOR VALUES (15,2005,4.1,'2024-03-25','Mobile','Verified','Specializes in mobile application development')
INSERT INTO INSTRUCTOR VALUES (16,2006,4.3,'2024-03-27','AI','Verified','Expert in modern technologies and AI concepts')
INSERT INTO INSTRUCTOR VALUES (17,2007,4.6,'2024-03-30','Cloud','Verified','Teaches cloud services and distributed systems')
INSERT INTO INSTRUCTOR VALUES (18,2008,4.4,'2024-04-02','Security','Verified','Experienced instructor in cyber security topics')
INSERT INTO INSTRUCTOR VALUES (19,2009,4.9,'2024-04-04','Game Dev','Verified','Focuses on game development and interactive design')
INSERT INTO INSTRUCTOR VALUES (20,2010,4.0,'2024-04-07','Data Science','Verified','Teaches data science and visualization techniques')
INSERT INTO INSTRUCTOR VALUES (21,2011,4.3,'2024-04-10','DevOps','Verified','Focuses on DevOps tools and deployment processes')
INSERT INTO INSTRUCTOR VALUES (22,2012,4.6,'2024-04-12','UI Design','Verified','Teaches user interface and visual design principles')
SELECT* FROM INSTRUCTOR

INSERT INTO CATEGORY VALUES (1,'Programming','Courses about software development, coding and programming languages','2024-04-15',1)
INSERT INTO CATEGORY VALUES (2,'Database','Courses focused on database design, SQL queries and data management systems','2024-04-16',1)
INSERT INTO CATEGORY VALUES (3,'Web Development','Courses covering frontend and backend web technologies including HTML, CSS and JavaScript','2024-04-17',1)
INSERT INTO CATEGORY VALUES (4,'Mobile Development','Courses about building mobile applications for Android and iOS platforms','2024-04-18',1)
INSERT INTO CATEGORY VALUES (5,'Artificial Intelligence','Courses related to machine learning, deep learning and AI technologies','2024-04-19',1)
INSERT INTO CATEGORY VALUES (6,'Cloud Computing','Courses about cloud services, distributed systems and cloud platforms such as AWS and Azure','2024-04-20',1)
INSERT INTO CATEGORY VALUES (7,'Cyber Security','Courses focusing on system security, network protection and ethical hacking concepts','2024-04-21',1)
INSERT INTO CATEGORY VALUES (8,'Game Development','Courses about game design, game engines and interactive application development','2024-04-22',1)
INSERT INTO CATEGORY VALUES (9,'Data Science','Courses related to data analysis, statistics and data visualization techniques','2024-04-23',1)
INSERT INTO CATEGORY VALUES (10,'UI and UX Design','Courses about user interface design, user experience and visual communication principles','2024-04-24',1)
SELECT* FROM CATEGORY

INSERT INTO COURSE VALUES (1,100,'Beginner','English','Introduction to SQL','2024-05-01',11)
INSERT INTO COURSE VALUES (2,120,'Beginner','English','Java Programming Basics','2024-05-03',12)
INSERT INTO COURSE VALUES (3,130,'Intermediate','English','Python for Data Analysis','2024-05-05',13)
INSERT INTO COURSE VALUES (4,140,'Beginner','English','Web Development Fundamentals','2024-05-07',14)
INSERT INTO COURSE VALUES (5,150,'Intermediate','English','Mobile App Development with Android','2024-05-09',15)
INSERT INTO COURSE VALUES (6,160,'Intermediate','English','Introduction to Artificial Intelligence','2024-05-11',16)
INSERT INTO COURSE VALUES (7,170,'Beginner','English','Cloud Computing Essentials','2024-05-13',17)
INSERT INTO COURSE VALUES (8,180,'Intermediate','English','Cyber Security Basics','2024-05-15',18)
INSERT INTO COURSE VALUES (9,190,'Advanced','English','Game Development with Unity','2024-05-17',19)
INSERT INTO COURSE VALUES (10,200,'Intermediate','English','Data Science and Visualization','2024-05-19',20)
SELECT* FROM COURSE

INSERT INTO LESSON VALUES (1,'Covers the basic structure of SQL queries and database tables','2024-05-21','video_sql_1','SQL Fundamentals',35,1)
INSERT INTO LESSON VALUES (2,'Introduces Java syntax, variables and control structures','2024-05-22','video_java_1','Java Syntax Basics',40,2)
INSERT INTO LESSON VALUES (3,'Explains how Python is used in data analysis workflows','2024-05-23','video_python_1','Python and Data',45,3)
INSERT INTO LESSON VALUES (4,'Introduces HTML, CSS and basic page layout design','2024-05-24','video_web_1','Building Web Pages',30,4)
INSERT INTO LESSON VALUES (5,'Explains Android Studio setup and basic mobile UI components','2024-05-25','video_mobile_1','Android Introduction',42,5)
INSERT INTO LESSON VALUES (6,'Introduces artificial intelligence concepts and common applications','2024-05-26','video_ai_1','AI Fundamentals',38,6)
INSERT INTO LESSON VALUES (7,'Explains cloud service models and deployment concepts','2024-05-27','video_cloud_1','Cloud Basics',36,7)
INSERT INTO LESSON VALUES (8,'Introduces threats, vulnerabilities and security best practices','2024-05-28','video_security_1','Security Principles',41,8)
INSERT INTO LESSON VALUES (9,'Explains game engines, design logic and interactive elements','2024-05-29','video_game_1','Game Development Concepts',44,9)
INSERT INTO LESSON VALUES (10,'Introduces data science tools and basic data visualization','2024-05-30','video_data_1','Data Visualization Basics',39,10)
SELECT* FROM LESSON


INSERT INTO SUBTOPIC VALUES (1,1,1,'Introduction to databases, tables and simple SQL syntax',12,'Database Concepts','material_sql_1')
INSERT INTO SUBTOPIC VALUES (2,2,1,'Variables, data types and output statements in Java',10,'Java Variables','material_java_1')
INSERT INTO SUBTOPIC VALUES (3,3,1,'Using Python libraries to read and process tabular data',14,'Python Libraries','material_python_1')
INSERT INTO SUBTOPIC VALUES (4,4,1,'Creating page structure with HTML and styling with CSS',11,'HTML and CSS Basics','material_web_1')
INSERT INTO SUBTOPIC VALUES (5,5,1,'Understanding layouts, activities and Android Studio tools',13,'Android UI Basics','material_mobile_1')
INSERT INTO SUBTOPIC VALUES (6,6,1,'Definition of AI, machine learning and real-world examples',12,'AI Concepts','material_ai_1')
INSERT INTO SUBTOPIC VALUES (7,7,1,'Cloud models such as IaaS, PaaS and SaaS',10,'Service Models','material_cloud_1')
INSERT INTO SUBTOPIC VALUES (8,8,1,'Basic protection methods against common cyber attacks',12,'Security Threats','material_security_1')
INSERT INTO SUBTOPIC VALUES (9,9,1,'Game loops, scenes and interaction design principles',15,'Game Engine Basics','material_game_1')
INSERT INTO SUBTOPIC VALUES (10,10,1,'Charts, graphs and simple analysis using data tools',11,'Visualization Tools','material_data_1')
SELECT* FROM SUBTOPIC

INSERT INTO ENROLLMENT VALUES (1,'2024-06-01',NULL,'In Progress',25,0,1,1)
INSERT INTO ENROLLMENT VALUES (2,'2024-06-02',NULL,'In Progress',40,0,2,2)
INSERT INTO ENROLLMENT VALUES (3,'2024-06-03',NULL,'In Progress',55,0,3,3)
INSERT INTO ENROLLMENT VALUES (4,'2024-06-04','2024-07-10','Completed',100,1,4,4)
INSERT INTO ENROLLMENT VALUES (5,'2024-06-05',NULL,'In Progress',35,0,5,5)
INSERT INTO ENROLLMENT VALUES (6,'2024-06-06',NULL,'In Progress',60,0,6,6)
INSERT INTO ENROLLMENT VALUES (7,'2024-06-07',NULL,'In Progress',20,0,7,7)
INSERT INTO ENROLLMENT VALUES (8,'2024-06-08','2024-07-15','Completed',100,1,8,8)
INSERT INTO ENROLLMENT VALUES (9,'2024-06-09',NULL,'In Progress',70,0,9,9)
INSERT INTO ENROLLMENT VALUES (10,'2024-06-10',NULL,'In Progress',15,0,10,10)
SELECT*FROM ENROLLMENT


INSERT INTO PAYMENT VALUES (1,'2024-06-01','PAY001',100,'USD','Credit Card',1)
INSERT INTO PAYMENT VALUES (2,'2024-06-02','PAY002',120,'USD','Debit Card',2)
INSERT INTO PAYMENT VALUES (3,'2024-06-03','PAY003',130,'EUR','Credit Card',3)
INSERT INTO PAYMENT VALUES (4,'2024-06-04','PAY004',140,'USD','Bank Transfer',4)
INSERT INTO PAYMENT VALUES (5,'2024-06-05','PAY005',150,'EUR','Credit Card',5)
INSERT INTO PAYMENT VALUES (6,'2024-06-06','PAY006',160,'USD','Debit Card',6)
INSERT INTO PAYMENT VALUES (7,'2024-06-07','PAY007',170,'GBP','Credit Card',7)
INSERT INTO PAYMENT VALUES (8,'2024-06-08','PAY008',180,'USD','Bank Transfer',8)
INSERT INTO PAYMENT VALUES (9,'2024-06-09','PAY009',190,'EUR','Credit Card',9)
INSERT INTO PAYMENT VALUES (10,'2024-06-10','PAY010',200,'USD','Debit Card',10)
SELECT*FROM PAYMENT

INSERT INTO REFUND VALUES (1,'Duplicate payment detected',50,'2024-06-12','2024-06-14','Approved',1)
INSERT INTO REFUND VALUES (2,'Course access problem after payment',60,'2024-06-13','2024-06-15','Approved',2)
INSERT INTO REFUND VALUES (3,'Incorrect billing amount',40,'2024-06-14','2024-06-16','Approved',3)
INSERT INTO REFUND VALUES (4,'Requested by student due to schedule conflict',70,'2024-06-15','2024-06-17','Pending',4)
INSERT INTO REFUND VALUES (5,'Payment made twice by mistake',55,'2024-06-16','2024-06-18','Approved',5)
INSERT INTO REFUND VALUES (6,'Technical issue during course enrollment',65,'2024-06-17','2024-06-19','Pending',6)
INSERT INTO REFUND VALUES (7,'Student changed learning plan',45,'2024-06-18','2024-06-20','Rejected',7)
INSERT INTO REFUND VALUES (8,'Unauthorized card usage reported',80,'2024-06-19','2024-06-21','Approved',8)
INSERT INTO REFUND VALUES (9,'System error in payment process',75,'2024-06-20','2024-06-22','Approved',9)
INSERT INTO REFUND VALUES (10,'Late cancellation request',30,'2024-06-21','2024-06-23','Rejected',10)
SELECT*FROM REFUND

INSERT INTO QUIZ VALUES (1,'sqlpass',20,'Active','SQL Quiz 1',1)
INSERT INTO QUIZ VALUES (2,'javapass',25,'Active','Java Quiz 1',2)
INSERT INTO QUIZ VALUES (3,'pythonpass',30,'Active','Python Quiz 1',3)
INSERT INTO QUIZ VALUES (4,'webpass',20,'Active','Web Quiz 1',4)
INSERT INTO QUIZ VALUES (5,'mobilepass',25,'Active','Mobile Quiz 1',5)
INSERT INTO QUIZ VALUES (6,'aipass',30,'Active','AI Quiz 1',6)
INSERT INTO QUIZ VALUES (7,'cloudpass',20,'Active','Cloud Quiz 1',7)
INSERT INTO QUIZ VALUES (8,'securitypass',25,'Active','Security Quiz 1',8)
INSERT INTO QUIZ VALUES (9,'gamepass',30,'Active','Game Quiz 1',9)
INSERT INTO QUIZ VALUES (10,'datapass',20,'Active','Data Science Quiz 1',10)
SELECT*FROM QUIZ

INSERT INTO QUIZATTEMPT VALUES (1,'2024-06-25 10:00:00','2024-06-25 10:18:00',1,82,1,1)
INSERT INTO QUIZATTEMPT VALUES (2,'2024-06-25 11:00:00','2024-06-25 11:22:00',1,76,2,2)
INSERT INTO QUIZATTEMPT VALUES (3,'2024-06-26 09:30:00','2024-06-26 09:58:00',1,88,3,3)
INSERT INTO QUIZATTEMPT VALUES (4,'2024-06-26 10:30:00','2024-06-26 10:47:00',0,49,4,4)
INSERT INTO QUIZATTEMPT VALUES (5,'2024-06-27 12:00:00','2024-06-27 12:23:00',1,91,5,5)
INSERT INTO QUIZATTEMPT VALUES (6,'2024-06-27 13:00:00','2024-06-27 13:27:00',1,84,6,6)
INSERT INTO QUIZATTEMPT VALUES (7,'2024-06-28 14:00:00','2024-06-28 14:18:00',0,45,7,7)
INSERT INTO QUIZATTEMPT VALUES (8,'2024-06-28 15:00:00','2024-06-28 15:21:00',1,79,8,8)
INSERT INTO QUIZATTEMPT VALUES (9,'2024-06-29 16:00:00','2024-06-29 16:29:00',1,93,9,9)
INSERT INTO QUIZATTEMPT VALUES (10,'2024-06-29 17:00:00','2024-06-29 17:17:00',1,86,10,10)
SELECT* FROM QUIZATTEMPT


INSERT INTO ASSIGNMENT VALUES (1,'Prepare SQL queries for simple database operations','2024-07-01',100,'SQL Assignment',1)
INSERT INTO ASSIGNMENT VALUES (2,'Write a Java program using loops and conditions','2024-07-02',100,'Java Assignment',2)
INSERT INTO ASSIGNMENT VALUES (3,'Analyze a small dataset using Python libraries','2024-07-03',100,'Python Assignment',3)
INSERT INTO ASSIGNMENT VALUES (4,'Create a simple responsive web page','2024-07-04',100,'Web Assignment',4)
INSERT INTO ASSIGNMENT VALUES (5,'Design a basic Android mobile screen','2024-07-05',100,'Mobile Assignment',5)
INSERT INTO ASSIGNMENT VALUES (6,'Explain a real-world application of artificial intelligence','2024-07-06',100,'AI Assignment',6)
INSERT INTO ASSIGNMENT VALUES (7,'Compare cloud service models with examples','2024-07-07',100,'Cloud Assignment',7)
INSERT INTO ASSIGNMENT VALUES (8,'Write a report about common cyber security threats','2024-07-08',100,'Security Assignment',8)
INSERT INTO ASSIGNMENT VALUES (9,'Describe a game concept and its interaction design','2024-07-09',100,'Game Assignment',9)
INSERT INTO ASSIGNMENT VALUES (10,'Create a data visualization report with explanation','2024-07-10',100,'Data Science Assignment',10)
SELECT* FROM ASSIGNMENT


INSERT INTO SUBMISSION VALUES (1,'2024-06-30 10:15:00','Clear and well-structured work',88,'file_sql_1','Reviewed',1,1)
INSERT INTO SUBMISSION VALUES (2,'2024-07-01 11:20:00','Good use of Java syntax',84,'file_java_1','Reviewed',2,2)
INSERT INTO SUBMISSION VALUES (3,'2024-07-02 09:40:00','Strong analysis and correct output',91,'file_python_1','Reviewed',3,3)
INSERT INTO SUBMISSION VALUES (4,'2024-07-03 13:05:00','Layout is simple but functional',79,'file_web_1','Reviewed',4,4)
INSERT INTO SUBMISSION VALUES (5,'2024-07-04 15:30:00','Good interface elements and structure',87,'file_mobile_1','Reviewed',5,5)
INSERT INTO SUBMISSION VALUES (6,'2024-07-05 12:10:00','Interesting ideas and examples',85,'file_ai_1','Reviewed',6,6)
INSERT INTO SUBMISSION VALUES (7,'2024-07-06 14:45:00','Comparison is useful and understandable',82,'file_cloud_1','Reviewed',7,7)
INSERT INTO SUBMISSION VALUES (8,'2024-07-07 16:20:00','Report includes relevant security points',90,'file_security_1','Reviewed',8,8)
INSERT INTO SUBMISSION VALUES (9,'2024-07-08 17:10:00','Creative game idea and design flow',93,'file_game_1','Reviewed',9,9)
INSERT INTO SUBMISSION VALUES (10,'2024-07-09 18:00:00','Visualization is clear and meaningful',89,'file_data_1','Reviewed',10,10)
SELECT* FROM SUBMISSION

INSERT INTO CERTIFICATE VALUES ('CERT001','2024-07-20','cert_link_1','Issued',88,1)
INSERT INTO CERTIFICATE VALUES ('CERT002','2024-07-21','cert_link_2','Issued',84,2)
INSERT INTO CERTIFICATE VALUES ('CERT003','2024-07-22','cert_link_3','Issued',91,3)
INSERT INTO CERTIFICATE VALUES ('CERT004','2024-07-23','cert_link_4','Issued',79,4)
INSERT INTO CERTIFICATE VALUES ('CERT005','2024-07-24','cert_link_5','Issued',87,5)
INSERT INTO CERTIFICATE VALUES ('CERT006','2024-07-25','cert_link_6','Issued',85,6)
INSERT INTO CERTIFICATE VALUES ('CERT007','2024-07-26','cert_link_7','Issued',82,7)
INSERT INTO CERTIFICATE VALUES ('CERT008','2024-07-27','cert_link_8','Issued',90,8)
INSERT INTO CERTIFICATE VALUES ('CERT009','2024-07-28','cert_link_9','Issued',93,9)
INSERT INTO CERTIFICATE VALUES ('CERT010','2024-07-29','cert_link_10','Issued',89,10)
SELECT* FROM CERTIFICATE

INSERT INTO CLASSIFIES VALUES (2,1)
INSERT INTO CLASSIFIES VALUES (1,2)
INSERT INTO CLASSIFIES VALUES (9,3)
INSERT INTO CLASSIFIES VALUES (3,4)
INSERT INTO CLASSIFIES VALUES (4,5)
INSERT INTO CLASSIFIES VALUES (5,6)
INSERT INTO CLASSIFIES VALUES (6,7)
INSERT INTO CLASSIFIES VALUES (7,8)
INSERT INTO CLASSIFIES VALUES (8,9)
INSERT INTO CLASSIFIES VALUES (9,10)
INSERT INTO CLASSIFIES VALUES (1,3)
INSERT INTO CLASSIFIES VALUES (10,10)
SELECT* FROM CLASSIFIES

ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_USERS
FOREIGN KEY (UserID) REFERENCES USERS(UserID)

ALTER TABLE INSTRUCTOR
ADD CONSTRAINT FK_INSTRUCTOR_USERS
FOREIGN KEY (UserID) REFERENCES USERS(UserID)

ALTER TABLE COURSE
ADD CONSTRAINT FK_COURSE_INSTRUCTOR
FOREIGN KEY (InstructorUserID) REFERENCES INSTRUCTOR(UserID)

ALTER TABLE LESSON
ADD CONSTRAINT FK_LESSON_COURSE
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

ALTER TABLE SUBTOPIC
ADD CONSTRAINT FK_SUBTOPIC_LESSON
FOREIGN KEY (LessonID) REFERENCES LESSON(LessonID)

ALTER TABLE ENROLLMENT
ADD CONSTRAINT FK_ENROLLMENT_STUDENT
FOREIGN KEY (StudentUserID) REFERENCES STUDENT(UserID)

ALTER TABLE ENROLLMENT
ADD CONSTRAINT FK_ENROLLMENT_COURSE
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

ALTER TABLE CERTIFICATE
ADD CONSTRAINT FK_CERTIFICATE_ENROLLMENT
FOREIGN KEY (EnrollmentNo) REFERENCES ENROLLMENT(EnrollmentNo)

ALTER TABLE PAYMENT
ADD CONSTRAINT FK_PAYMENT_ENROLLMENT
FOREIGN KEY (EnrollmentNo) REFERENCES ENROLLMENT(EnrollmentNo)

ALTER TABLE REFUND
ADD CONSTRAINT FK_REFUND_PAYMENT
FOREIGN KEY (PaymentID) REFERENCES PAYMENT(PaymentID)

ALTER TABLE QUIZ
ADD CONSTRAINT FK_QUIZ_COURSE
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

ALTER TABLE QUIZATTEMPT
ADD CONSTRAINT FK_QUIZATTEMPT_QUIZ
FOREIGN KEY (QuizID) REFERENCES QUIZ(QuizID)

ALTER TABLE QUIZATTEMPT
ADD CONSTRAINT FK_QUIZATTEMPT_STUDENT
FOREIGN KEY (StudentUserID) REFERENCES STUDENT(UserID)

ALTER TABLE ASSIGNMENT
ADD CONSTRAINT FK_ASSIGNMENT_COURSE
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

ALTER TABLE SUBMISSION
ADD CONSTRAINT FK_SUBMISSION_ASSIGNMENT
FOREIGN KEY (AssignmentID) REFERENCES ASSIGNMENT(AssignmentID)

ALTER TABLE SUBMISSION
ADD CONSTRAINT FK_SUBMISSION_STUDENT
FOREIGN KEY (StudentUserID) REFERENCES STUDENT(UserID)

ALTER TABLE CLASSIFIES
ADD CONSTRAINT FK_CLASSIFIES_CATEGORY
FOREIGN KEY (CategoryID) REFERENCES CATEGORY(CategoryID)

ALTER TABLE CLASSIFIES
ADD CONSTRAINT FK_CLASSIFIES_COURSE
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

