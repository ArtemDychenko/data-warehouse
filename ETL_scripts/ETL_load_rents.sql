USE carSharingDW;

GO

IF (OBJECT_ID('vETLRents', 'V') IS NOT NULL) DROP VIEW vETLRents;
GO

CREATE TABLE tempCarTypes (
	id INT NOT NULL,
	model VARCHAR(50) NOT NULL,
	manufacturer VARCHAR(50) NOT NULL,
	production_year INT NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
	[count] INT NOT NULL
);

GO

BULK INSERT tempCarTypes
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\cars_excel_T1.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2           
);

GO



CREATE VIEW vETLRents
AS
SELECT
	DATEDIFF(MINUTE, [start_date], [end_date]) as total_time,
	price_per_minute * DATEDIFF(MINUTE, [start_date], [end_date]) as total_payment,
	price_per_minute * DATEDIFF(MINUTE, [start_date], [end_date]) / tempCarTypes.price as profitability,
	renter as [user_id],
	price_per_minute,
	price as car_price,
	[time].time_id as time_id,
	[date].date_id as date_id,
	START_PARKING_STATION.station_id as start_station_id,
	END_PARKING_STATION.station_id as end_station_id,
	car.car_id as car_id,
FROM carSharingDB.dbo.rents AS RENTS
	JOIN carSharingDB.dbo.parking_stations as START_PARKING_STATION_DB
		ON RENTS.start_station_id = START_PARKING_STATION_DB.id
	JOIN car
		ON car.plate_number = RENTS.car_plate_number
	JOIN carSharingDB.dbo.parking_stations as END_PARKING_STATION_DB
		ON RENTS.end_station_id = END_PARKING_STATION_DB.id
	JOIN carSharingDB.dbo.car_types AS CAR_TYPES
		ON car.car_type_id = CAR_TYPES.id
	JOIN tempCarTypes
		ON tempCarTypes.id = CAR_TYPES.id
	JOIN [time] 
		ON [time].hours = DATEPART(HOUR, RENTS.[start_date])
		AND [time].minutes = DATEPART(MINUTE, RENTS.[start_date])
	JOIN [date]
		ON [date].year = DATEPART(YEAR, RENTS.[start_date])
		AND [date].month = DATEPART(MONTH, RENTS.[start_date])
		AND [date].day = DATEPART(DAY, RENTS.[start_date])
	JOIN parking_station AS START_PARKING_STATION
		ON START_PARKING_STATION.latitude = START_PARKING_STATION_DB.latitude
		AND START_PARKING_STATION.longitude = START_PARKING_STATION_DB.longitude
		AND START_PARKING_STATION.expiration_date IS NULL
	JOIN parking_station AS END_PARKING_STATION
		ON END_PARKING_STATION.latitude = END_PARKING_STATION_DB.latitude
		AND END_PARKING_STATION.longitude = END_PARKING_STATION_DB.longitude
		AND END_PARKING_STATION.expiration_date IS NULL;
GO

MERGE INTO Rent AS TT
	USING vETLRents AS ST
		ON TT.[user_id] = ST.[user_id]
		AND TT.car_id = ST.car_id
		AND TT.time_id = ST.time_id
		AND TT.date_id = ST.date_id
		AND TT.start_station_id = ST.start_station_id
		AND TT.end_station_id = ST.end_station_id

			WHEN NOT MATCHED
				THEN
				INSERT (
					total_payment,
					car_price,
					profitability,
					price_per_minute,
					total_time,
					start_station_id,
					end_station_id,
					date_id,
					time_id,
					car_id,
					[user_id]
				)
				VALUES (
					ST.total_payment,
					ST.car_price,
					ST.profitability,
					ST.price_per_minute,
					ST.total_time,
					ST.start_station_id,
					ST.end_station_id,
					ST.date_id,
					ST.time_id,
					ST.car_id,
					ST.[user_id]
				);

DROP VIEW vETLRents;
DROP TABLE tempCarTypes