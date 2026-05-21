USE OnlineLearningPlatformDB
GO

--It provides information such as the number of students enrolled, the average progress, 
--the lowest/highest progress, and the number of students who have completed the program.
--It also returns AverageProgress as output.
CREATE PROCEDURE sp_CourseProgressStatistics
    @CourseID INT,
    @AverageProgress DECIMAL(5,2) OUTPUT
AS
BEGIN
    -- Calculate average progress for the selected course.
    SELECT @AverageProgress = ROUND(AVG(Progress), 2)
    FROM ENROLLMENT
    WHERE CourseID = @CourseID
    AND Progress IS NOT NULL

    -- Display calculated enrollment statistics for the selected course.
    SELECT
        CourseID,
        COUNT(StudentUserID) AS TotalStudents,
        MIN(Progress) AS LowestProgress,
        MAX(Progress) AS HighestProgress,
        ROUND(AVG(Progress), 2) AS AverageProgress,
        SUM(CASE WHEN Completed = 1 THEN 1 ELSE 0 END) AS CompletedStudents
    FROM ENROLLMENT
    WHERE CourseID = @CourseID
    GROUP BY CourseID
END
GO


DECLARE @AvgProgress DECIMAL(5,2)
EXEC sp_CourseProgressStatistics
    @CourseID = 2,
    @AverageProgress = @AvgProgress OUTPUT
SELECT @AvgProgress AS AverageCourseProgress

EXEC sp_helptext 'sp_CourseProgressStatistics'


--It displays payment information. 
--If there is a refund associated with that payment, it also displays the refund information.
--The output returns the total refund amount.
CREATE PROCEDURE sp_ShowPaymentRefundInfo
    @PaymentID INT,
    @TotalRefundAmount DECIMAL(10,2) OUTPUT
AS
BEGIN
    -- Calculate total refund amount for the selected payment.
    SELECT @TotalRefundAmount = ISNULL(SUM(RefundAmount), 0)
    FROM REFUND
    WHERE PaymentID = @PaymentID

    -- Display payment information.
    SELECT PaymentID, EnrollmentNo, Amount, Currency, Method, Date
    FROM PAYMENT
    WHERE PaymentID = @PaymentID

    -- Display refund information if refund exists.
    SELECT RefundID, PaymentID, RefundAmount, Reason, RequestDate, ProcessedDate, Status
    FROM REFUND
    WHERE PaymentID = @PaymentID
END
GO

DECLARE @RefundTotal DECIMAL(10,2)
EXEC sp_ShowPaymentRefundInfo
    @PaymentID = 1,
    @TotalRefundAmount = @RefundTotal OUTPUT

SELECT @RefundTotal AS TotalRefundAmount

EXEC sp_helptext 'sp_ShowPaymentRefundInfo'

