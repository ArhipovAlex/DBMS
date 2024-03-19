USE PD_321
/*
SELECT
	discipline_name		AS 'Дисциплина',
	COUNT(*)			AS 'Кол-во преподавателей'
FROM	Disciplines, Disciplines_Teachers, Teachers
WHERE	Disciplines.discipline_id = Disciplines_Teachers.discipline
		AND Teachers.teacher_id = Disciplines_Teachers.teacher
GROUP BY discipline_name
*/
SELECT
	[Дисциплина] = discipline_name,
	[Количество преподавателей] = COUNT(teacher_id)
FROM Teachers
JOIN Disciplines_Teachers ON (teacher = teacher_id)
RIGHT JOIN Disciplines ON (discipline = discipline_id)
GROUP BY discipline_name
HAVING COUNT(teacher_id)<2
ORDER BY [Количество преподавателей]