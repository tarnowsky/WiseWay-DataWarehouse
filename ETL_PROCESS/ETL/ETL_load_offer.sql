use Warehouse
go

if (object_id('vETLDimOffer') is not null) drop view vETLDimOffer;
go

create view vETLDimOffer
as
SELECT DISTINCT
    [name] as [Subject],
    CASE
        WHEN [level] = 1 THEN 'podstawowy / a'
        WHEN [level] = 2 THEN 'sredni / b'
        ELSE 'zaawansowany / c'
    END as [LevelCategory],
    CASE
        WHEN [duration] >= 30 AND [duration] <= 60 THEN 'od 30 minut do 1 godziny'
        WHEN [duration] > 60 AND [duration] <= 90 THEN 'od 1 godziny do 1,5 godziny'
        ELSE 'od 1,5 godziny'
    END as [DurationCategory]
FROM [WiseDB].dbo.[offer]
JOIN [WiseDB].dbo.[subject] ON [WiseDB].dbo.[offer].[subject_id] = [WiseDB].dbo.[subject].[subject_id];
go

MERGE INTO OFFER AS TT
    USING vETLDimOffer AS ST
        ON TT.Subject = ST.Subject
        AND TT.LevelCategory = ST.LevelCategory
        AND TT.DurationCategory = ST.DurationCategory
            WHEN NOT Matched
                THEN
                    INSERT
                    VALUES (
                        ST.Subject,
                        ST.LevelCategory,
                        ST.DurationCategory
                    )
            WHEN NOT Matched BY Source
                THEN
                    DELETE
            ;

drop view vETLDimOffer;


    
    