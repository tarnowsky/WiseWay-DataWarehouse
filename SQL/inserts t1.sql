USE WiseDB;
GO

BULK INSERT dbo.attendance FROM 'C:\Users\User\source\repos\hurtownie-danych\data\attendance.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.class FROM 'C:\Users\User\source\repos\hurtownie-danych\data\class.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.feedback FROM 'C:\Users\User\source\repos\hurtownie-danych\data\feedback.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.offer FROM 'C:\Users\User\source\repos\hurtownie-danych\data\offer.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.student FROM 'C:\Users\User\source\repos\hurtownie-danych\data\student.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.subject FROM 'C:\Users\User\source\repos\hurtownie-danych\data\subject.csv' WITH (FIELDTERMINATOR=',')