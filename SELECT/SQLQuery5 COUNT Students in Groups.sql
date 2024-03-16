USE PD_321

SELECT
	group_name		AS 'Группа',
	COUNT(*)		AS 'Кол-во студентов'
FROM	Students, Groups 
WHERE	Students.[group] = Groups.group_id
GROUP BY group_name