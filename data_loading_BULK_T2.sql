-- Ładowanie danych z T2

BULK INSERT car_types
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\car_types_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);

BULK INSERT cars
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\cars_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);

BULK INSERT parking_stations
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\parking_station_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);

BULK INSERT cars_on_station
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\car_on_station_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);


BULK INSERT users
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\users_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);

BULK INSERT invoices
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\invoice_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);

BULK INSERT rents
FROM 'C:\Users\artem\OneDrive\Documentos\HD_ETL_scripts\generated_data\rents_T2.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2            
);


