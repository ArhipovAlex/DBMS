USE PD_321

SELECT
	direction_name		AS 'Направление',
	COUNT(*)		AS 'Кол-во студентов'
FROM	Students, Directions, Groups 
WHERE	Students.[group] = Groups.group_id
		AND Groups.direction = Directions.direction_id
GROUP BY direction_name