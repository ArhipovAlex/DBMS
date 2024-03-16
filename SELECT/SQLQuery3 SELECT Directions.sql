USE PD_321

SELECT
	direction_name		AS 'Направление',
	discipline_name		AS 'Дисциплина'
	
FROM Disciplines, Directions, Directions_Disciplines
WHERE	Directions.direction_id = Directions_Disciplines.direction
		AND Disciplines.discipline_id = Directions_Disciplines.discipline
		AND Directions.direction_id = 1
ORDER BY direction_name