USE PD_321

SELECT
	group_name		AS '������',
	COUNT(*)		AS '���-�� ���������'
FROM	Students, Groups 
WHERE	Students.[group] = Groups.group_id
GROUP BY group_name