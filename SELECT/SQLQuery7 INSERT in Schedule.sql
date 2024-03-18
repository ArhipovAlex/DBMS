USE PD_321;
GO
--��������� �� ������������
--���� ������ ������� ��� ������
DECLARE @DateStart DATE; 
SET @DateStart = '2023-02-14';
--����� ������
DECLARE @Group INT;
SET @Group = 7;
--����� ����������
DECLARE @Discipline SMALLINT;
SET @Discipline = 1;
--����� ������� 
DECLARE @Teacher SMALLINT;
SET @Teacher = 1;
--���������� ������� �� ��������� ����������
DECLARE @CountLesson TINYINT;
SET @CountLesson = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @Discipline);
--PRINT @CountLesson;

--�������� �������� �� ��������� ���������� ����������
--?����� �� ��������� ������������� ����� ����� ����������?
IF (SELECT teacher FROM Disciplines_Teachers WHERE discipline = @Discipline AND teacher=@Teacher) = @Teacher
PRINT 'Teacher can teach this Discipline'
ELSE 
BEGIN
	PRINT 'ERROR: Teacher cannot teach this Discipline';
	GOTO ErrorExit; --����� � ����� ����� ����
END
--?������ �� ������ ����������� ���������� ��� ������?
IF (SELECT COUNT(*) FROM RequiredDisciplines WHERE discipline = @Discipline) = 0 --����������� ���������� �������?
	BEGIN
		IF ((SELECT direction FROM Groups WHERE group_id = @Group) IN (SELECT direction FROM Directions_Disciplines WHERE discipline = @Discipline))--����������� ���������� ������������� ����������� ������
			PRINT 'Group can learn this Discipline';
		ELSE BEGIN
			PRINT 'Group can learn Disciplines in other Direction';
			GOTO ErrorExit; --����� � ����� ����� ����
		END;
	END
ELSE
IF	((SELECT required_discipline FROM RequiredDisciplines WHERE discipline = @Discipline) IN (SELECT discipline FROM Schedule WHERE [group] = @Group AND date < @DateStart))--������ ������� ��������� ����������
AND 
	((SELECT direction FROM Groups WHERE group_id = @Group) IN (SELECT direction FROM Directions_Disciplines WHERE discipline = @Discipline))--����������� ���������� ������������� ����������� ������
PRINT 'Group can learn this Discipline'
ELSE 
BEGIN
	PRINT 'ERROR: Group cannot learn this Discipline';
	GOTO ErrorExit; --����� � ����� ����� ����
END
--���������� ���������� �� ����������
--����� �����
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