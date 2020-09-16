-- -----------------------------------------------------
-- rookie career
-- -----------------------------------------------------

CREATE VIEW rookies AS 
	SELECT 
		r.raceId, 
        r.driverId, 
        l.forename, 
        l.surname, 
        races.year, 
        races.date, 
        races.name, 
        r.position, 
        r.points,
        total_points.max_points_in_race,
        r.points/total_points.max_points_in_race AS points_vs_max_points,
        races.year-l.first_year+1 AS rookie_year,
        row_number() over ( partition by r.driverId order by races.date) AS race_nr
	FROM results AS r
    INNER JOIN (
		SELECT
        	r.raceId, 
            max(r.points) AS max_points_in_race
			FROM results AS r
			GROUP BY r.raceId
            ) AS total_points
		ON total_points.raceId = r.raceId
	INNER JOIN legends AS l	ON l.driverId = r.driverId
	INNER JOIN races ON r.raceId = races.raceId
	WHERE races.year BETWEEN l.first_year AND l.first_year+1 
    AND l.legend_rank BETWEEN 1 AND 3
	ORDER BY r.driverId, races.date;
    
    SELECT *
    from rookies;