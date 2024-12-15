use Warehouse
GO

-- Create the teachersTemp table
If (object_id('dbo.teachersTemp') is not null) drop table dbo.teachersTemp;
CREATE TABLE dbo.teachersTemp (
    ID_Teacher INT,
    Name VARCHAR(25),
    Surname VARCHAR(25),
    Age INT,
    Email VARCHAR(50),
    Phone INT,
    HireDate DATE,
    Salary INT,
    BankAccount VARCHAR(50),
    Education VARCHAR(50),
    WorkExperience INT,
    PESEL VARCHAR(11)
);
go

-- bulk insert data from the csv file
BULK INSERT dbo.teachersTemp
    FROM 'C:\Users\User\source\repos\hurtownie-danych\ETL_PROCESS\sources\teacher.csv'
    WITH (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
go


CREATE VIEW vDimTeachersData
AS
SELECT DISTINCT
    [Name] + ' ' + [Surname] AS [NameAndSurname],
    [PESEL],
    CASE
        WHEN [Age] >= 18 AND [Age] <= 29 THEN 'od 18 do 29'
        WHEN [Age] >= 30 AND [Age] <= 39 THEN 'od 30 do 39'
        WHEN [Age] >= 40 AND [Age] <= 49 THEN 'od 40 do 49'
        WHEN [Age] >= 50 AND [Age] <= 59 THEN 'od 50 do 59'
        ELSE 'od 60'
    END AS [AgeCategory],
    [Education],
    CASE
        WHEN [WorkExperience] <= 1 THEN 'rok i mniej'
        WHEN [WorkExperience] > 1 AND [WorkExperience] <= 5 THEN 'miedzy dwa, a piec lat'
        ELSE 'wiecej niz piec lat'
    END AS [WorkExperience]
FROM dbo.teachersTemp
go

MERGE INTO TEACHER AS TT
    USING vDimTeachersData AS ST
        ON TT.NameAndSurname = ST.NameAndSurname
        AND TT.PESEL = ST.PESEL
        AND TT.AgeCategory = ST.AgeCategory
        AND TT.Education = ST.Education
        AND TT.WorkExperience = ST.WorkExperience
            WHEN NOT Matched
                THEN
                    INSERT
                    VALUES (
                        ST.AgeCategory,
                        ST.PESEL,
                        ST.NameAndSurname,
                        ST.Education,
                        ST.WorkExperience,
                        1
                    )
            WHEN NOT Matched BY Source
                THEN
                    DELETE
            ;

Drop table dbo.teachersTemp;
DROP VIEW vDimTeachersData;
