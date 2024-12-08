USE carSharingDW

GO

IF (OBJECT_ID('vETLCarTypes', 'V') IS NOT NULL) DROP VIEW vETLCarTypes;
GO
CREATE VIEW vETLCarTypes
AS
SELECT
	id,
	model,
	manufacturer,
	production_year
FROM carSharingDB.dbo.car_types;

GO

SET IDENTITY_INSERT car_type ON;

MERGE INTO car_type as TT
	USING vETLCarTypes as ST
	ON TT.car_type_id = ST.id
		WHEN NOT MATCHED
			THEN
				INSERT (car_type_id, model, manufacturer, production_year) 
				VALUES (ST.id, ST.model, ST.manufacturer, ST.production_year);

SET IDENTITY_INSERT car_type OFF;

DROP VIEW vETLCarTypes;