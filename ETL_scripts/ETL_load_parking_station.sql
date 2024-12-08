USE carSharingDW
GO

DECLARE @GeneratedRows INT = 0;

IF OBJECT_ID('tempdb..#TempParkingStations') IS NOT NULL DROP TABLE #TempParkingStations;
IF OBJECT_ID('tempdb..#ExcelParkingStation') IS NOT NULL DROP TABLE #ExcelParkingStation;
GO


CREATE TABLE #ExcelParkingStation (
	station_id INT,
	max_capacity INT,
	city NVARCHAR(100),
    location_description NVARCHAR(255)
);




CREATE TABLE #TempParkingStations (
    station_id INT,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    city NVARCHAR(100),
    location_description NVARCHAR(255),
    max_capacity INT,
    creation_date DATE,
    expiration_date DATE
);


INSERT INTO #TempParkingStations (station_id, latitude, longitude, max_capacity)
SELECT 
	ROW_NUMBER() OVER (ORDER BY id) - 1 AS station_id,
	latitude,
	longitude,
	max_capacity
FROM carSharingDB.dbo.parking_stations 
ORDER BY id
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY; 

BULK INSERT #ExcelParkingStation
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\parking_stations_excel_T1.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2          
);


UPDATE T
SET 
    T.city = E.city,
    T.location_description = E.location_description
FROM #TempParkingStations T
INNER JOIN #ExcelParkingStation E
    ON T.station_id = E.station_id;

UPDATE #TempParkingStations
SET 
    creation_date = GETDATE(),
    expiration_date = NULL;

MERGE INTO parking_station as TT
	USING #TempParkingStations as ST
		ON  TT.latitude = ST.latitude
		AND TT.longitude = ST.longitude
		AND TT.expiration_date IS NULL
			WHEN MATCHED AND (TT.max_capacity <> ST.max_capacity)
			THEN
				UPDATE
				SET TT.expiration_date = GETDATE();


INSERT INTO carSharingDW.dbo.parking_station (
    latitude, 
    longitude, 
    city, 
    location_description, 
    max_capacity, 
    creation_date, 
    expiration_date
)
SELECT  
    latitude, 
    longitude, 
    city, 
    location_description, 
    max_capacity, 
    creation_date, 
    expiration_date
FROM #TempParkingStations as ST
WHERE NOT EXISTS (
    SELECT 1
    FROM parking_station TT
    WHERE TT.latitude = ST.latitude
    AND TT.longitude = ST.longitude
    AND TT.city = ST.city
    AND TT.expiration_date IS NULL
);


DROP TABLE #TempParkingStations;
DROP TABLE #ExcelParkingStation;
