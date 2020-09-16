-- -----------------------------------------------------
-- driver legends
-- -----------------------------------------------------

CREATE VIEW legends AS
SELECT t.*, RANK() OVER(ORDER BY total_wins DESC) AS legend_rank
FROM (
	SELECT 
		d.driverId, 
		d.forename, 
		d.surname, 
		d.nationality, 
		sum(r.position) AS total_wins, 
		min(races.year) AS first_year, 
		max(races.year) AS last_year
	FROM drivers AS d
	INNER JOIN results AS r	ON d.driverId = r.driverId AND r.position = 1
    INNER JOIN races ON r.raceId = races.raceId    
    GROUP BY d.driverId
	ORDER BY total_wins DESC) AS t;

SELECT *
FROM legends;

DROP VIEW legends;

