USE WiseDB;
GO

BULK INSERT dbo.attendance FROM 'C:\Users\User\source\repos\hurtownie-danych\data\attendance_2.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.class FROM 'C:\Users\User\source\repos\hurtownie-danych\data\class_2.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.feedback FROM 'C:\Users\User\source\repos\hurtownie-danych\data\feedback_2.csv' WITH (FIELDTERMINATOR=',')