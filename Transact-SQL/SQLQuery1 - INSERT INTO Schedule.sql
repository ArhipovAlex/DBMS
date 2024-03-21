USE PD_321

IF NOT EXISTS
(
SELECT 
		[group],discipline, teacher, [date], [time], spent
FROM	Schedule
JOIN	Groups		ON	([group]=group_id)
JOIN	Disciplines	ON	(discipline=discipline_id)
JOIN	Teachers	ON	(teacher=teacher_id)
)
BEGIN
	INSERT INTO Schedule
			([group], discipline, teacher, [date], [time], spent)
	VALUES
	(
			(SELECT group_id		FROM Groups			WHERE group_name = 'PD_321'),
			(SELECT discipline_id	FROM Disciplines	WHERE discipline_name LIKE('%MS SQL Server%')),
			(SELECT teacher_id		FROM Teachers		WHERE first_name = 'Олег'),
			GETDATE(),
			'13:30',
			1
	)
END

SELECT 
		lesson_id,
		[Группа]		= group_name,
		[Дисциплина]	= discipline_name,
		[Преподаватель] = FORMATMESSAGE('%s %s %s', last_name,first_name,middle_name),
		[Дата]			= Schedule.[date],
		[День недели]	= DATENAME(WEEKDAY,Schedule.[date]),
		[Время]			= Schedule.[time],
		[Статус]		= IIF([Schedule].[spent]=1,'проведено','запланировано')
FROM Schedule
JOIN	Groups		ON	([group]=group_id)
JOIN	Disciplines	ON	(discipline=discipline_id)
JOIN	Teachers	ON	(teacher=teacher_id)