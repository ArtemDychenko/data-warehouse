USE carSharingDW

GO

IF (OBJECT_ID('vETLCars', 'V') IS NOT NULL) DROP VIEW vETLCars;
GO
CREATE VIEW vETLCars
AS
SELECT
	plate_number,
	car_type_id
FROM carSharingDB.dbo.cars;

GO

MERGE INTO car as TT
	USING vETLCars as ST
	ON TT.plate_number = ST.plate_number
		WHEN NOT MATCHED
			THEN
				INSERT VALUES (ST.car_type_id, ST.plate_number);
DROP VIEW vETLCars;