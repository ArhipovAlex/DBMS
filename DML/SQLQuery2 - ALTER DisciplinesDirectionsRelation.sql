USE PD_321

ALTER TABLE DisciplinesDirectionsRelation
ADD CONSTRAINT FK_DisciplinesDirectionsRelation_Directions	FOREIGN KEY(direction) REFERENCES Directions(direction_id)
--ADD CONSTRAINT FK_DisciplinesDirectionsRelation_Disciplines	FOREIGN KEY (discipline) REFERENCES Disciplines (discipline_id)