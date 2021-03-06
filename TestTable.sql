-- CREATE TRIGGER CreationTrigger
-- ON Database
-- FOR CREATE_TABLE
-- AS
-- BEGIN
-- 	Print 'New table created'
-- END

-- set foreign_key_checks=0;
-- drop table population;
create table if not exists population(
	fips_code INT(10),
    geography VARCHAR(40),
    year INT(10),
    program_type VARCHAR(80),
    population INT(8)
--     PRIMARY KEY(geography, year, program_type)
--     FOREIGN KEY(geography, year)
--     REFERENCES crimedata(county, year)
    );
    
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Annual_Population_Estimates_for_New_York_State_and_Counties__Beginning_1970.csv' 
INTO TABLE population 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- drop table crimedata;
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
--     PRIMARY KEY(county, agency, year)
--     FOREIGN KEY(county, year)
-- 		REFERENCES population(geography, year)
--         ON UPDATE CASCADE,
-- 	FOREIGN KEY(county, agency, year)
-- 		REFERENCES policedata(county, pd, year)
--         ON UPDATE CASCADE
        
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Index_Crimes_by_County_and_Agency__Beginning_1990.csv' 
INTO TABLE crimedata 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



-- drop table policedata;
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
--     PRIMARY KEY(county, pd, year)
-- --     FOREIGN KEY(county, pd, year)
-- --     REFERENCES crimedata(county, agency, year)
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Law_Enforcement_Personnel_by_Agency___Beginning_2007.csv' 
INTO TABLE policedata 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
    
-- Indexes don't seem to make the queries any faster
-- because the primary key data is already sorted
-- CREATE INDEX PopulationIndex ON
-- 	population(geography, year);
--     
-- CREATE INDEX CrimeIndex ON
-- 	crimedata(county, agency, year);
-- 
-- CREATE INDEX PoliceIndex ON
-- 	policedata(county, pd, year);

SELECT * FROM population LIMIT 0,4000;
SELECT * FROM crimedata LIMIT 0,20000;
SELECT * FROM policedata LIMIT 0,10000;

drop view policeandcrime;

create view policeandcrime as
	select c.county, count(c.agency) as agencies, c.year, sum(c.index_total)/sum(p.grand_total) as crimespercop, sum(c.index_total) as crimetotal, sum(c.violent_total) as violenttotal, sum(c.murder) as murder, sum(c.rape) as rape, sum(c.robbery) as robbery, sum(c.aggravated_assault) as aggravatedassault, sum(c.property_total) as propertytotal, sum(c.burglary) as burglary, sum(c.larceny) as larceny, sum(c.motor_vehicle_theft) as vehicletheft, count(p.pd) as pdcount, sum(p.sworn_full_time) as swornfulltime, sum(p.grand_total) as policegrandtotal
    from crimedata c, policedata p
    where c.county = p.county and c.year = p.year and c.agency = p.pd
    group by c.county, c.year
    order by c.year, c.county;

select * from policeandcrime;



drop view crimepercapita;

create view crimepercapita as
	select c.county, count(c.agency) as agencies, c.year, pop.population, sum(c.index_total)/pop.population as crimesperperson, c.index_total, sum(c.violent_total)/pop.population as violentperperson, c.violent_total, sum(c.murder)/pop.population as murderperperson, c.murder, sum(c.rape)/pop.population as rapeperperson, c.rape, sum(c.robbery)/pop.population as robberyperperson, c.robbery, sum(c.aggravated_assault)/pop.population as aggravated_assaultperperson, c.aggravated_assault, sum(c.property_total)/pop.population as propertyperperson, c.property_total, sum(c.burglary)/pop.population as burglaryperperson, c.burglary, sum(c.larceny)/pop.population as larcenyperperson, c.larceny, sum(c.motor_vehicle_theft)/pop.population as vehicletheftperperson, c.motor_vehicle_theft
    from crimedata c, population pop
    where c.county = pop.geography and c.year = pop.year
    group by c.county, c.year
    order by c.year, c.county;

select * from crimepercapita limit 0,2000;

create view crimeperthousand as
	select county, agencies, year, population, crimesperperson * 1000 as crimesperthousand, index_total, violentperperson * 1000 as violentperthousand, violent_total, murderperperson*1000 as murderperthousand, murder, rapeperperson * 1000, rape, robberyperperson * 1000 as robberyperthousand, robbery, aggravated_assaultperperson * 1000 as aggravated_assaultperthousand, aggravated_assault, propertyperperson * 1000 as propertyperthousand, property_total, burglaryperperson * 1000 as burglaryperthousand, burglary, larcenyperperson * 1000 as larcenyperthousand, larceny, vehicletheftperperson * 1000 as vehicletheftperthousand, motor_vehicle_theft
    from crimepercapita;
    
select * from crimeperthousand limit 0,2000;