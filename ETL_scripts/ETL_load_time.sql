USE carSharingDW
GO

-- Fill DimTimes Lookup Table
-- Step a: Declare variables used in processing
DECLARE @Hour INT = 0;         -- Zmienna do iteracji po godzinach
DECLARE @Minute INT = 0;       -- Zmienna do iteracji po minutach
DECLARE @TimeId INT = 1;       -- Zmienna do generowania unikalnych ID

-- Step b: Iterate through all possible hours and minutes
WHILE @Hour < 24
BEGIN
    WHILE @Minute < 60
    BEGIN
         MERGE INTO [dbo].[time] AS Target
        USING (VALUES (@Hour, @Minute)) AS Source ([hours], [minutes])
        ON Target.[hours] = Source.[hours] AND Target.[minutes] = Source.[minutes]
        WHEN NOT MATCHED THEN
            INSERT ([hours], [minutes])
            VALUES (Source.[hours], Source.[minutes]);

        SET @Minute = @Minute + 1;
    END

    SET @Minute = 0;
    SET @Hour = @Hour + 1;
END
GO
