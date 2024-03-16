USE PD_321

SELECT
	last_name+' '+first_name+' '+middle_name	AS 'Ф.И.О. студента',
	DATEDIFF(HOUR, birth_date, GETDATE())/8766	AS 'Возраст',
	DATEDIFF(hour, work_since, GETDATE())/8766	AS 'Опыт преподавания',
	discipline_name								AS 'Читаемая дисциплина'
FROM Teachers, Disciplines, Disciplines_Teachers
WHERE	Disciplines.discipline_id = Disciplines_Teachers.discipline
		AND Teachers.teacher_id = Disciplines_Teachers.teacher
		AND Disciplines.discipline_id = 1
ORDER BY last_name