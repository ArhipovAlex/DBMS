USE PD_321

SELECT
	discipline_name		AS '����������',
	COUNT(*)			AS '���-�� ��������������'
FROM	Disciplines, Disciplines_Teachers, Teachers
WHERE	Disciplines.discipline_id = Disciplines_Teachers.discipline
		AND Teachers.teacher_id = Disciplines_Teachers.teacher
GROUP BY discipline_name