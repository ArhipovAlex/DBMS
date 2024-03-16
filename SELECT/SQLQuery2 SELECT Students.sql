USE PD_321

SELECT 
	last_name+' '+first_name+' '+middle_name AS '��� ��������',
	DATEDIFF(hour,birth_date,GETDATE())/8766 AS '�������',
	group_name								 AS '������',
	direction_name								 AS '�����������'
FROM Students, Groups, Directions
WHERE	Students.[group] = Groups.group_id 
		AND Groups.direction = Directions.direction_id
--ORDER BY last_name