USE carSharingDW
GO


DECLARE @StartDate DATE; 
DECLARE @EndDate DATE;
DECLARE @DateInProcess DATETIME;
  

SELECT @StartDate = '2004-05-18', @EndDate = '2024-11-24';


SET @DateInProcess = @StartDate;

WHILE @DateInProcess <= @EndDate
BEGIN
	MERGE INTO [dbo].[date] AS Target
    USING (VALUES (@DateInProcess, YEAR(@DateInProcess), MONTH(@DateInProcess), DAY(@DateInProcess))) 
          AS Source ([Date], [Year], [Month], [Day])
    ON Target.[Date] = Source.[Date]
    WHEN NOT MATCHED THEN
        INSERT ([Date], [Year], [Month], [Day])
        VALUES (Source.[Date], Source.[Year], Source.[Month], Source.[Day]);


  
    -- Add a day and loop again
    SET @DateInProcess = DATEADD(DAY, 1, @DateInProcess);
END
GO
