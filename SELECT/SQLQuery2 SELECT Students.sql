USE PD_321
/*
SELECT 
	last_name+' '+first_name+' '+middle_name AS '��� ��������',
	DATEDIFF(hour,birth_date,GETDATE())/8766 AS '�������',
	group_name								 AS '������'
	--direction_name								 AS '�����������'
FROM Students, Groups --Directions
WHERE	Students.[group] = Groups.group_id 
--		AND Groups.direction = Directions.direction_id
--ORDER BY last_name*/

SELECT
	[�.�.�. ��������] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[�������] = DATEDIFF(hour, birth_date, GETDATE())/8766,
	[������] = group_name
FROM Students
JOIN Groups ON (Students.[group]=Groups.group_id)