
LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/circuits.csv'
INTO TABLE dbm_project_f1.circuits
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
(circuitId,circuitRef,name,location,country,lat,lng,@alt,url)
SET alt = nullif(@alt,'')
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructors.csv'
INTO TABLE dbm_project_f1.constructors
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/drivers.csv'
INTO TABLE dbm_project_f1.drivers
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
(driverId,driverRef,@number,code,@forename,@surname,@dob,nationality,url)
SET dob = if(@dob='',NULL,if(substring(@dob,5,1)='-',str_to_date(@dob,'%Y-%m-%d'),str_to_date(@dob,'%d/%m/%Y'))),
number = nullif(@number,''),
forename = if(char_length(@forename) > 15, substring(@forename,1,15), @forename),
surname = if(char_length(@surname) > 15, substring(@surname,1,15), @surname)
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/races.csv'
INTO TABLE dbm_project_f1.races
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
(raceId,year,round,circuitId,name,date,@time,url)
set time = if(CHAR_LENGTH(@time) < 5,SEC_TO_TIME(0),@time)
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructorResults.csv'
INTO TABLE dbm_project_f1.constructorresults
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructorStandings.csv'
INTO TABLE dbm_project_f1.constructorStandings
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/driverStandings.csv'
INTO TABLE dbm_project_f1.driverStandings
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lapTimes.csv'
INTO TABLE dbm_project_f1.lapTimes
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pitStops.csv'
INTO TABLE dbm_project_f1.pitStops
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/qualifying.csv'
INTO TABLE dbm_project_f1.qualifying
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 LINES
(qualifyId,raceId,driverId,constructorId,number,position,@q1,@q2,@q3)
set q1 = if(CHAR_LENGTH(@q1)<5,NULL,if(substr(@q1,5,1)=':',insert(@q1,5,1,'.'),@q1)),
q2 = if(CHAR_LENGTH(@q2)<5,NULL,if(substr(@q2,5,1)=':',insert(@q2,5,1,'.'),@q2)),
q3 = if(CHAR_LENGTH(@q3)<5,NULL,if(substr(@q3,5,1)=':',insert(@q3,5,1,'.'),@q3))
;

LOAD DATA infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/results.csv'
INTO TABLE dbm_project_f1.results
CHARACTER SET latin1
fields terminated BY ","
OPTIONALLY ENCLOSED BY '"'
lines terminated BY "\r\n" 
IGNORE 1 ROWS
(resultId,raceId,driverId,constructorId,@number,grid,@position,positionText,positionOrder,points,laps,@time,@milliseconds,@fastestLap,@rank_race,fastestLapTime,@fastestLapSpeed,statusId)
SET milliseconds = nullif(@milliseconds,''),
position = nullif(@position,''),
fastestLap = nullif(@fastestLap,''),
fastestLapSpeed = if(@fastestLapSpeed like '%:%',NULL,nullif(@fastestLapSpeed,'')),
time = if(@time like "%:%",replace(@time,'+','0'), if(@time > 60,sec_to_time(replace(@time,' sec','')), replace(replace(replace(@time,' sec',''),'+',''),'s',''))),
rank_race = nullif(@rank_race,''),
number = nullif(@number,'')
;