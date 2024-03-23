CREATE PROCEDURE my_sp_select_discipline_for_group_from_schedule
@discipline_name NVARCHAR(50),
@group_name NVARCHAR(10)
AS 
SELECT 
		lesson_id,
		[������]		= group_name,
		[����������]	= discipline_name,
		[�������������] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[���� ������]	= DATENAME(WEEKDAY,[Schedule].[date]),		
		[����]			= [Schedule].[date],
		[�����]			= [Schedule].[time],
		[������]		= IIF([Schedule].spent = 1, '���������', '�������������'),
		[����� �������]	= number_of_lesson,
		[���� �������]	= subject_of_lesson

FROM	Schedule
JOIN	Groups		ON ([group] = group_id)
JOIN	Disciplines ON (discipline = discipline_id)
JOIN	Teachers	ON (teacher = teacher_id)
WHERE discipline_name LIKE(@discipline_name)
	AND group_name=@group_name