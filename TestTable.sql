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