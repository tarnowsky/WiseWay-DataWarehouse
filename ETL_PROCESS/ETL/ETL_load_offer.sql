USE Warehouse;
GO

-- Drop view if exists
IF (OBJECT_ID('vETLDimOffer') IS NOT NULL)
    DROP VIEW vETLDimOffer;
GO

-- Create a view to transform data
CREATE VIEW vETLDimOffer AS
SELECT
    s.[name] AS [Subject],
    CASE
        WHEN o.[level] = 1 THEN 'podstawowy / a'
        WHEN o.[level] = 2 THEN 'sredni / b'
        ELSE 'zaawansowany / c'
    END AS [LevelCategory],
    CASE
        WHEN o.duration >= 30 AND o.duration <= 60 THEN 'od 30 minut do 1 godziny'
        WHEN o.duration > 60 AND o.duration <= 90 THEN 'od 1 godziny do 1,5 godziny'
        ELSE 'od 1,5 godziny'
    END AS [DurationCategory]
FROM [WiseDB].dbo.[offer] AS o
JOIN [WiseDB].dbo.[subject] AS s
    ON o.subject_id = s.subject_id;
GO

-- Merge data into Warehouse.OFFER table
MERGE INTO OFFER AS TT
USING vETLDimOffer AS ST
ON TT.[Subject] = ST.[Subject]
   AND TT.[LevelCategory] = ST.[LevelCategory]
   AND TT.[DurationCategory] = ST.[DurationCategory]
WHEN NOT MATCHED THEN
    INSERT ([Subject], [LevelCategory], [DurationCategory])
    VALUES (ST.[Subject], ST.[LevelCategory], ST.[DurationCategory]);

-- Clean up by dropping the view
DROP VIEW vETLDimOffer;
GO
