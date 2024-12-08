-- Use the database
USE carSharingDB;
GO
 
IF OBJECT_ID('parking_stations', 'U') IS NULL
BEGIN
    CREATE TABLE parking_stations (
        id INT PRIMARY KEY,
        latitude DECIMAL(9,6) NOT NULL, 
        longitude DECIMAL(9,6) NOT NULL, 
        max_capacity INT NOT NULL
    );
END;
GO

IF OBJECT_ID('car_types', 'U') IS NULL
BEGIN
    CREATE TABLE car_types (
        id INT PRIMARY KEY,
        model VARCHAR(30) NOT NULL,
        manufacturer VARCHAR(30) NOT NULL,
        production_year INT NOT NULL,
        price_per_minute DECIMAL(10,2) NOT NULL
    );
END;
GO

IF OBJECT_ID('users', 'U') IS NULL
BEGIN
    CREATE TABLE users (
        id INT PRIMARY KEY,
        email VARCHAR(50) NOT NULL UNIQUE,
        first_name VARCHAR(30) NOT NULL,
        last_name VARCHAR(30) NOT NULL
    );
END;
GO


IF OBJECT_ID('cars', 'U') IS NULL
BEGIN
    CREATE TABLE cars (
        plate_number VARCHAR(10) PRIMARY KEY,
   
        car_type_id INT NOT NULL,

        FOREIGN KEY (car_type_id) REFERENCES car_types(id) ON DELETE CASCADE
    );
END;
GO

IF OBJECT_ID('rents', 'U') IS NULL
BEGIN
    CREATE TABLE rents (
        id INT PRIMARY KEY,
        renter INT NOT NULL,
        start_station_id INT NOT NULL,
        start_date DATETIME NOT NULL,
        end_station_id INT NOT NULL,
        end_date DATETIME NOT NULL,
        car_plate_number VARCHAR(10) NOT NULL,
        FOREIGN KEY (renter) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (start_station_id) REFERENCES parking_stations(id) ON DELETE NO ACTION,
        FOREIGN KEY (end_station_id) REFERENCES parking_stations(id) ON DELETE NO ACTION,
        FOREIGN KEY (car_plate_number) REFERENCES cars(plate_number) ON DELETE CASCADE,
    );
END;
GO


IF OBJECT_ID('invoices', 'U') IS NULL
BEGIN
    CREATE TABLE invoices (
        number INT PRIMARY KEY,
        rent_id INT NOT NULL,
        date DATE NOT NULL,
        currency VARCHAR(3) NOT NULL,
        total_price DECIMAL(10,2) NOT NULL,
        description VARCHAR(100),
        FOREIGN KEY (rent_id) REFERENCES rents(id) ON DELETE CASCADE
    );
END;
GO

IF OBJECT_ID('cars_on_station', 'U') IS NULL
BEGIN
    CREATE TABLE cars_on_station (
		id INT PRIMARY KEY,
		start_datetime DATETIME NOT NULL,
		end_timetime DATETIME NOT NULL,
        car_plate_number VARCHAR(10) NOT NULL,
        parking_station_id INT NOT NULL,
		FOREIGN KEY (parking_station_id) REFERENCES parking_stations(id) ON DELETE CASCADE,
		FOREIGN KEY (car_plate_number) REFERENCES cars(plate_number) ON DELETE CASCADE
    );
END;
GO