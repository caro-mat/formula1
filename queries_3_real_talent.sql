-- -----------------------------------------------------
-- real talent
-- -----------------------------------------------------

CREATE VIEW teammembers_of_legends AS
WITH constructors_of_legends_CTE (driverId, constructorId, constructor_name, year, raceId)
AS
	(SELECT 
		r.driverId, 
		r.constructorId, 
		c.name as constructor_name, 
		races.year, 
		races.raceId
	FROM results as r
	INNER JOIN legends as l ON  r.driverId = CASE WHEN l.legend_rank <= 3 THEN l.driverId END
	INNER JOIN constructors as c ON c. constructorId = r.constructorId 
	INNER JOIN races ON r.raceId = races.raceId)
SELECT 
	cl.driverId as legend_driverId, 
	d2.surname as legend_name, 
	cl.constructorId, 
	cl.constructor_name, 
	cl.year, 
	r.driverId as teammember_driverId, 
	d1.surname as teammember_name, 
	sum(r.points) as teammember_points
FROM constructors_of_legends_CTE as cl
INNER JOIN results as r ON r.constructorId = cl.constructorId AND r.raceId = cl.raceId
INNER JOIN drivers as d1 ON r.driverId = d1.driverId
INNER JOIN drivers as d2 ON cl.driverId = d2.driverId
GROUP BY year, teammember_driverId;

SELECT *
FROM teammembers_of_legends;

DROP VIEW teammembers_of_legends;





