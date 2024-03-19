USE PD_321

DECLARE @group		INT			=(SELECT group_id FROM Groups WHERE group_name='PD_321')
DECLARE @discipline	SMALLINT	=(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE('%MS SQL Server%'))
DECLARE @teacher	SMALLINT	=(SELECT teacher_id FROM Teachers WHERE first_name='Олег')
DECLARE @start_date DATE		='2024-02-27'
DECLARE	@date		DATE		=@start_date
DECLARE @time		TIME		='15:00'

IF NOT EXISTS 
(
	SELECT 
		[group], discipline, teacher, [date], [time], spent
	FROM Schedule
	JOIN Groups			ON ([group]=group_id)
	JOIN Disciplines	ON (discipline=discipline_id)
	JOIN Teachers		ON (teacher=teacher_id)
	WHERE	[group]=@group
	AND		discipline=@discipline
	AND		teacher=@teacher
	AND		[date]=@date
	AND		[time]=@time
)
BEGIN
	INSERT INTO Schedule
					([group],discipline,teacher,[date],[time],spent)
	VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date<GETDATE(),1,0))
END

SELECT 
		lesson_id,
		[Группа]		= group_name,
		[Дисциплина]	= discipline_name,
		[Преподаватель] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Дата]			= [Schedule].[date],
		[Время]			= [Schedule].[time],
		[Статус]		= IIF([Schedule].spent = 1, 'Проведено', 'Запланировано')

FROM	Schedule
JOIN	Groups		ON ([group] = group_id)
JOIN	Disciplines ON (discipline = discipline_id)
JOIN	Teachers	ON (teacher = teacher_id)