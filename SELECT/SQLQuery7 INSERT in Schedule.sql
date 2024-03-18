USE PD_321;
GO
--ПАРАМЕТРЫ от пользователя
--дата начала занятий для группы
DECLARE @DateStart DATE; 
SET @DateStart = '2023-02-14';
--номер группы
DECLARE @Group INT;
SET @Group = 7;
--номер дисциплины
DECLARE @Discipline SMALLINT;
SET @Discipline = 1;
--номер учителя 
DECLARE @Teacher SMALLINT;
SET @Teacher = 1;
--количество занятий по выбранной дисциплине
DECLARE @CountLesson TINYINT;
SET @CountLesson = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @Discipline);
--PRINT @CountLesson;

--проводим проверку на возможную комбинацию параметров
--?Может ли выбранный преподаватель вести такую дисциплину?
IF (SELECT teacher FROM Disciplines_Teachers WHERE discipline = @Discipline AND teacher=@Teacher) = @Teacher
PRINT 'Teacher can teach this Discipline'
ELSE 
BEGIN
	PRINT 'ERROR: Teacher cannot teach this Discipline';
	GOTO ErrorExit; --метка в конце всего кода
END
--?Прошла ли группа необходимые дисциплины для данной?
IF (SELECT COUNT(*) FROM RequiredDisciplines WHERE discipline = @Discipline) = 0 --вставляемая дисциплина базовая?
	BEGIN
		IF ((SELECT direction FROM Groups WHERE group_id = @Group) IN (SELECT direction FROM Directions_Disciplines WHERE discipline = @Discipline))--вставляемая дисциплина соответствует направлению группы
			PRINT 'Group can learn this Discipline';
		ELSE BEGIN
			PRINT 'Group can learn Disciplines in other Direction';
			GOTO ErrorExit; --метка в конце всего кода
		END;
	END
ELSE
IF	((SELECT required_discipline FROM RequiredDisciplines WHERE discipline = @Discipline) IN (SELECT discipline FROM Schedule WHERE [group] = @Group AND date < @DateStart))--группа изучила требуемые дисциплины
AND 
	((SELECT direction FROM Groups WHERE group_id = @Group) IN (SELECT direction FROM Directions_Disciplines WHERE discipline = @Discipline))--вставляемая дисциплина соответствует направлению группы
PRINT 'Group can learn this Discipline'
ELSE 
BEGIN
	PRINT 'ERROR: Group cannot learn this Discipline';
	GOTO ErrorExit; --метка в конце всего кода
END
--заполнение расписания по параметрам
--номер урока
DECLARE @LessonId BIGINT; 
SET @LessonId = 1;
WHILE @LessonId<=@CountLesson
BEGIN
	PRINT @DateStart;
	SET @DateStart = DATEADD(DAY,1,@DateStart);

	IF DATENAME(weekday, @DateStart) IN (N'Saturday', N'Sunday')
       PRINT DATENAME(weekday, @DateStart) + ' Weekend';
	ELSE
       PRINT DATENAME(weekday, @DateStart) + ' Weekday';

	SET @LessonId +=1;
END
ErrorExit: