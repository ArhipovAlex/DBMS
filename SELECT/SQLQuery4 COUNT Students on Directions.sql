USE PD_321
/*
SELECT
	direction_name		AS 'Направление',
	COUNT(*)		AS 'Кол-во студентов'
FROM	Students, Directions, Groups 
WHERE	Students.[group] = Groups.group_id
		AND Groups.direction = Directions.direction_id
GROUP BY direction_name
*/
SELECT
	[Ф.И.О. студента] = FORMATMESSAGE('%s %s %s',last_name,first_name,middle_name),
	[Группа] = group_name,
	[Направление обучения] = direction_name
FROM Students
JOIN Groups ON (Students.[group]=Groups.group_id)
RIGHT OUTER JOIN Directions ON (Groups.direction = Directions.direction_id)