USE carSharingDW
GO

IF (OBJECT_ID('vETLCars_on_stations', 'V') IS NOT NULL) DROP VIEW vETLCars_on_stations;
GO

CREATE VIEW vETLCars_on_stations
AS
SELECT
	[car].car_id as car_id,
	[date].date_id as date_id,
	[time].time_id  as time_id, 
	DATEDIFF(MINUTE, [start_datetime], [end_timetime]) as time_stayed,
	[parking_station].station_id as parking_station_id

FROM carSharingDB.dbo.cars_on_station as COS
	LEFT JOIN [date]
		ON date.year = DATEPART(YEAR, COS.[start_datetime])
		AND date.month = DATEPART(MONTH, COS.[start_datetime])
		AND date.day = DATEPART(DAY, COS.[start_datetime])
	LEFT JOIN [time]
		ON time.hours = DATEPART(HOUR, COS.[start_datetime])
		AND time.minutes = DATEPART(MINUTE, COS.[start_datetime])
	LEFT JOIN [car]
		On carSharingDW.dbo.car.plate_number = COS.car_plate_number
	LEFT JOIN [parking_station]
		ON carSharingDW.dbo.parking_station.station_id = COS.parking_station_id;
Go

MERGE INTO Cars_on_stations as TT
	USING vETLCars_on_stations as ST
	ON TT.car_id = ST.car_id
		WHEN NOT MATCHED
			THEN
				INSERT 
				VALUES (ST.car_id, ST.date_id, ST.time_id, ST.time_stayed, parking_station_id);
DROP VIEW vETLCars_on_stations;
