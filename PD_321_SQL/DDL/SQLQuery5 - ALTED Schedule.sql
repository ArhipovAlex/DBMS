USE PD_321

ALTER TABLE Schedule
	ADD number_of_lesson	TINYINT NULL,
		subject_of_lesson	NVARCHAR(200) NULL