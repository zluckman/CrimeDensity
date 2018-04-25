#CREATE table testTable (id VARCHAR(4), name VARCHAR(20));
#drop table testtable;

create table if not exists population(
	fips_code INT(10),
    geography VARCHAR(40),
    year INT(10),
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
    year INT(10),
    months_reported INT(10),
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


create table if not exists policedata(
	county VARCHAR(40),
    pd VARCHAR(40),
    year INT(10),
    sworn_full_time INT(10),
    sworn_part_time INT(10),
    sworn_total INT(10),
    civilian_full_time INT(10),
    civilian_part_time INT(10),
    civilian_total INT(10),
    full_time_total INT(10),
    part_time_total INT(10),
    grand_total INT(10)
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Law_Enforcement_Personnel_by_Agency___Beginning_2007.csv' 
INTO TABLE policedata 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM population;
SELECT * FROM crimedata;
SELECT * FROM policedata;

drop table population, crimedata, policedata;


