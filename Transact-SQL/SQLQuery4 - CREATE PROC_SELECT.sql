--CREATE PROCEDURE my_sp_select_from_schedule 
--AS 
--SELECT 
--		lesson_id,
--		[Группа]		= group_name,
--		[Дисциплина]	= discipline_name,
--		[Преподаватель] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
--		[День недели]	= DATENAME(WEEKDAY,[Schedule].[date]),		
--		[Дата]			= [Schedule].[date],
--		[Время]			= [Schedule].[time],
--		[Статус]		= IIF([Schedule].spent = 1, 'Проведено', 'Запланировано'),
--		[номер занятия]	= number_of_lesson,
--		[тема занятия]	= subject_of_lesson

--FROM	Schedule
--JOIN	Groups		ON ([group] = group_id)
--JOIN	Disciplines ON (discipline = discipline_id)
--JOIN	Teachers	ON (teacher = teacher_id);

CREATE PROCEDURE my_sp_select_group_from_schedule
@group_name NVARCHAR(10)
AS 
SELECT 
		lesson_id,
		[Группа]		= group_name,
		[Дисциплина]	= discipline_name,
		[Преподаватель] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[День недели]	= DATENAME(WEEKDAY,[Schedule].[date]),		
		[Дата]			= [Schedule].[date],
		[Время]			= [Schedule].[time],
		[Статус]		= IIF([Schedule].spent = 1, 'Проведено', 'Запланировано'),
		[номер занятия]	= number_of_lesson,
		[тема занятия]	= subject_of_lesson

FROM	Schedule
JOIN	Groups		ON ([group] = group_id)
JOIN	Disciplines ON (discipline = discipline_id)
JOIN	Teachers	ON (teacher = teacher_id)
WHERE group_name=@group_name