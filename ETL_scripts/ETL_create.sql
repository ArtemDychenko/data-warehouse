-- Table: [user]
CREATE TABLE [user] (
    user_id INT PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL
);

-- Table: [date]
CREATE TABLE [date] (
    date_id INT IDENTITY(0,1) PRIMARY KEY,
    [date] DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- Table: [time]
CREATE TABLE [time] (
    time_id INT IDENTITY(0,1) PRIMARY KEY,
    hours INT NOT NULL,
    minutes INT NOT NULL
);

-- Table: [car_type]
CREATE TABLE car_type (
    car_type_id INT IDENTITY(0,1) PRIMARY KEY,
    model NVARCHAR(100) NOT NULL,
    manufacturer NVARCHAR(100) NOT NULL,
    production_year INT NOT NULL
);

-- Table: [car]
CREATE TABLE car (
    car_id INT IDENTITY(0,1) PRIMARY KEY,
    car_type_id INT NOT NULL,
    plate_number NVARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (car_type_id) REFERENCES car_type(car_type_id)
);

-- Table: [parking_station]
CREATE TABLE parking_station (
    station_id INT IDENTITY(0,1) PRIMARY KEY,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    city NVARCHAR(100) NOT NULL,
    location_description NVARCHAR(255) NOT NULL,
    max_capacity INT NOT NULL,
    creation_date DATE NOT NULL,
    expiration_date DATE
);

-- Table: [Cars_on_stations]
CREATE TABLE Cars_on_stations (
    car_id INT NOT NULL,
    date_id INT NOT NULL,
    start_time_id INT NOT NULL,
    time_stayed INT NOT NULL,
    parking_station_id INT NOT NULL,
    PRIMARY KEY (car_id, date_id, start_time_id, parking_station_id),
    FOREIGN KEY (car_id) REFERENCES car(car_id),
    FOREIGN KEY (date_id) REFERENCES [date](date_id),
    FOREIGN KEY (start_time_id) REFERENCES [time](time_id),
    FOREIGN KEY (parking_station_id) REFERENCES [parking_station](station_id)
);

-- Table: [Rent]
CREATE TABLE Rent (
    total_payment DECIMAL(10, 2) NOT NULL,
    car_price DECIMAL(10, 2) NOT NULL,
    price_per_minute DECIMAL(10, 2) NOT NULL,
	profitability DECIMAL(10, 8) NOT NULL,
    total_time INT NOT NULL,
    start_station_id INT NOT NULL,
    end_station_id INT NOT NULL,
    date_id INT NOT NULL,
    time_id INT NOT NULL,
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    FOREIGN KEY (start_station_id) REFERENCES parking_station(station_id),
    FOREIGN KEY (end_station_id) REFERENCES parking_station(station_id),
    FOREIGN KEY (date_id) REFERENCES [date](date_id),
    FOREIGN KEY (time_id) REFERENCES [time](time_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (car_id) REFERENCES car(car_id)
);