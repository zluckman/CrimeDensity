#CREATE table testTable (id VARCHAR(4), name VARCHAR(20));
#drop table testtable;

create table if not exists population(
	fips_code INT(5),
    geography VARCHAR(40),
    year INT(4),
    program_type VARCHAR(80),
    population INT(8)
    );
    
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Annual_Population_Estimates_for_New_York_State_and_Counties__Beginning_1970.csv' 
INTO TABLE population 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

create table if not exists crimedata(
	county VARCHAR(40),
    agency VARCHAR(40),
    year INT(4),
    months_reported INT(4),
    index_total INT(10),
    violent_total INT(10),
    murder INT(10),
    rape INT(10),
    robbery INT(10),
    aggravated_assault INT(10),
    property_total INT(10),
    burglary INT(10),
    larceny INT(10),
    motor_vehicle_theft INT(10),
    region VARCHAR(40)
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Index_Crimes_by_County_and_Agency__Beginning_1990.csv' 
INTO TABLE crimedata 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM crimedata;

-- drop table population;
-- drop table crimedata;