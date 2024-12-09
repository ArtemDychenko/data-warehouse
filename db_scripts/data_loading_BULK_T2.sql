-- Ładowanie danych z T2

DECLARE @path NVARCHAR(MAX) = 'C:\Users\Danylo\politechnika\semester_5\hd\data-warehouse\generated_data';
DECLARE @sql NVARCHAR(MAX);

-- BULK INSERT for car_types
SET @sql = N'BULK INSERT car_types
FROM ''' + @path + '\car_types_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;

-- BULK INSERT for cars
SET @sql = N'BULK INSERT cars
FROM ''' + @path + '\cars_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;

-- BULK INSERT for parking_stations
SET @sql = N'BULK INSERT parking_stations
FROM ''' + @path + '\parking_station_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;

-- BULK INSERT for cars_on_station
SET @sql = N'BULK INSERT cars_on_station
FROM ''' + @path + '\car_on_station_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;

-- BULK INSERT for users
SET @sql = N'BULK INSERT users
FROM ''' + @path + '\users_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;
-- BULK INSERT for invoices
SET @sql = N'BULK INSERT invoices
FROM ''' + @path + '\invoice_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;

-- BULK INSERT for rents
SET @sql = N'BULK INSERT rents
FROM ''' + @path + '\rents_T2.csv''
WITH (
    FIELDTERMINATOR = '','',  
    ROWTERMINATOR = ''\n'',  
    FIRSTROW = 2
);';
EXEC sp_executesql @sql;
