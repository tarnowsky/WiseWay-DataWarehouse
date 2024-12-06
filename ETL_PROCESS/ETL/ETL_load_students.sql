Use Warehouse
go

If (object_id('vETLStudentsData') is not null) Drop View vETLStudentsData;
go
CREATE VIEW vETLStudentsData
AS
SELECT DISTINCT
    [login] AS [Login],
    [name] + ' ' + [surname] AS [NameAndSurname],
    CASE
        WHEN [age] >= 18 AND [age] <= 21 THEN 'od 18 do 21'
        WHEN [age] >= 22 AND [age] <= 29 THEN 'od 22 do 29'
        WHEN [age] >= 30 AND [age] <= 49 THEN 'od 30 do 49'
        WHEN [age] >= 50 AND [age] <= 64 THEN 'od 50 do 64'
        ELSE 'od 64'
    END AS [AgeCategory]
FROM WiseDB.dbo.student
go

MERGE INTO Student AS TT
    USING vETLStudentsData AS ST
        ON TT.Login = ST.login
        AND TT.NameAndSurname = ST.NameAndSurname
        AND TT.AgeCategory = ST.AgeCategory
            WHEN NOT Matched
                THEN
                    INSERT
                    VALUES (
                        ST.Login,
                        ST.NameAndSurname,
                        ST.AgeCategory,
                        1
                    )
            WHEN NOT Matched BY Source
                THEN
                    DELETE
            ;

Drop View vETLStudentsData;