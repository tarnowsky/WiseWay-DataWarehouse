USE Warehouse;
GO

-- Usunięcie istniejącego widoku, jeśli istnieje
IF (OBJECT_ID('dbo.vETLClassRun') IS NOT NULL) DROP VIEW dbo.vETLClassRun;
GO

-- Tworzenie widoku z eliminacją duplikatów
CREATE VIEW dbo.vETLClassRun AS
WITH CTE_ClassRun AS (
    SELECT DISTINCT
        CD.ID_Date,                               -- Data klasy
        T.ID_Time,                                -- Czas (godzina)
        CO.teacher_id AS ID_Teacher,              -- Nauczyciel
        WC.student_id AS ID_Student,              -- Student
        CO.offer_id AS ID_Offer,                  -- Oferta
        WC.class_id AS ID_Class,                  -- Klasa
        ISNULL(FB.feedback, 0) AS Feedback,       -- Domyślny feedback 0
        CASE 
            WHEN ATD.present = 1 THEN 1 
            ELSE 0 
        END AS Attendance,                        -- Obecność jako BIT
        CO.[level] AS [Level],                    -- Poziom klasy
        CO.duration AS Duration,                  -- Czas trwania klasy
        ROW_NUMBER() OVER (                       -- Generowanie unikalnego wiersza
            PARTITION BY WC.student_id, CD.ID_Date, T.ID_Time 
            ORDER BY CO.offer_id
        ) AS RowNum
    FROM dbo.[DATE] AS CD
    JOIN WiseDB.dbo.[class] AS WC
        ON CAST(CD.Date AS DATE) = CAST(WC.[date] AS DATE)  
    JOIN WiseDB.dbo.[offer] AS CO
        ON WC.offer_id = CO.offer_id
    LEFT JOIN (
        SELECT 
            class_id, 
            MAX(CAST(present AS INT)) AS present  -- Konwersja BIT na INT
        FROM WiseDB.dbo.[attendance]
        GROUP BY class_id
    ) AS ATD
        ON WC.class_id = ATD.class_id
    LEFT JOIN (
        SELECT 
            class_id, 
            MAX(feedback) AS feedback             -- Feedback jest już w odpowiednim typie
        FROM WiseDB.dbo.[feedback]
        GROUP BY class_id
    ) AS FB
        ON WC.class_id = FB.class_id
    JOIN dbo.[TIME] AS T
        ON T.Hour = DATEPART(HOUR, WC.[date])
)
SELECT 
    ID_Date,
    ID_Time,
    ID_Teacher,
    ID_Student,
    ID_Offer,
    ID_Class,
    Feedback,
    Attendance,
    [Level],
    Duration
FROM CTE_ClassRun
WHERE RowNum = 1; -- Wyeliminowanie duplikatów
GO

-- MERGE do tabeli CLASSRUN
MERGE INTO CLASSRUN AS TT
USING dbo.vETLClassRun AS ST
    ON TT.ID_Date = ST.ID_Date                                       -- Łączenie po dacie
    AND TT.ID_Time = ST.ID_Time                                      -- Łączenie po czasie
    AND TT.ID_Teacher = ST.ID_Teacher                                -- Łączenie po nauczycielu
    AND TT.ID_Student = ST.ID_Student                                -- Łączenie po uczniu
    AND TT.ID_Offer = ST.ID_Offer                                    -- Łączenie po ofercie
    AND TT.ID_Class = ST.ID_Class                                    -- Łączenie po klasie
    AND TT.Feedback = ST.Feedback                                    -- Łączenie po feedbacku
    AND TT.Attendance = ST.Attendance                                -- Łączenie po obecności
WHEN NOT MATCHED THEN
    INSERT (
        ID_Date,
        ID_Time,
        ID_Teacher,
        ID_Student,
        ID_Offer,
        ID_Class,
        Feedback,
        Attendance,
        [Level],
        Duration
    )
    VALUES (
        ST.ID_Date,
        ST.ID_Time,
        ST.ID_Teacher,
        ST.ID_Student,
        ST.ID_Offer,
        ST.ID_Class,
        ST.Feedback,
        ST.Attendance,
        ST.[Level],
        ST.Duration
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO
