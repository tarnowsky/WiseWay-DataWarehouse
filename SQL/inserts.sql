USE WiseDB;
GO

BULK INSERT dbo.attendance FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\attendance.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.class FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\class.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.feedback FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\feedback.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.offer FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\offer.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.student FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\student.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.subject FROM 'C:\Users\dawid\Codes\Generator\Hurtownie-Danych\data\subject.csv' WITH (FIELDTERMINATOR=',')