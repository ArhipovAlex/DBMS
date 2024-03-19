USE PD_321
/*
SELECT 
	last_name+' '+first_name+' '+middle_name AS 'ФИО студента',
	DATEDIFF(hour,birth_date,GETDATE())/8766 AS 'Возраст',
	group_name								 AS 'Группа'
	--direction_name								 AS 'Направление'
FROM Students, Groups --Directions
WHERE	Students.[group] = Groups.group_id 
--		AND Groups.direction = Directions.direction_id
--ORDER BY last_name*/

SELECT
	[Ф.И.О. студента] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[Возраст] = DATEDIFF(hour, birth_date, GETDATE())/8766,
	[Группа] = group_name
FROM Students
JOIN Groups ON (Students.[group]=Groups.group_id)