CREATE PROCEDURE my_sp_add_stacionar_to_schedule
@discipline_name NVARCHAR(50),
@group_name NVARCHAR(10),
@name_of_teacher NVARCHAR(50),
@start_date	DATE,
@time TIME

AS
DECLARE @group				INT		=(SELECT group_id FROM Groups WHERE @group_name='PD_321')
DECLARE @discipline			SMALLINT=(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE(@discipline_name))
DECLARE @number_of_lessons	TINYINT	=(SELECT number_of_lessons FROM Disciplines WHERE discipline_name LIKE(@discipline_name))
DECLARE @number_of_lesson	TINYINT	=0
DECLARE @teacher			SMALLINT=(SELECT teacher_id FROM Teachers WHERE first_name=@name_of_teacher)
DECLARE	@date				DATE	=@start_date

WHILE @number_of_lesson<@number_of_lessons
BEGIN
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
				([group],discipline,teacher,[date],[time],spent,number_of_lesson)
			VALUES 
				(@group, @discipline, @teacher, @date, @time, IIF(@date<GETDATE(),1,0),@number_of_lesson+1),
				(@group, @discipline, @teacher, @date, DATEADD(MINUTE,95,@time), IIF(@date<GETDATE(),1,0),@number_of_lesson+2)
	END
	SET @number_of_lesson=@number_of_lesson+2
	IF DATENAME(WEEKDAY,@start_date) IN ('Tuesday','Thursday','Saturday')
	BEGIN
		IF DATENAME(WEEKDAY,@date) IN ('Tuesday','Thursday')
			SET @date = DATEADD(DAY,2,@date)
		ELSE
			SET @date = DATEADD(DAY,3,@date)
	END
	ELSE
	BEGIN
		IF DATENAME(WEEKDAY,@date) IN ('Monday','Wednesday')
			SET @date = DATEADD(DAY,2,@date)
		ELSE
			SET @date = DATEADD(DAY,3,@date)
	END
END