USE Warehouse;
GO

IF (OBJECT_ID('dbo.vETLClassRun') IS NOT NULL) DROP VIEW dbo.vETLClassRun;
GO

CREATE VIEW dbo.vETLClassRun
AS
SELECT
    CD.ID_Date AS ID_Date,
    T.ID_Time AS ID_Time,
    CO.teacher_id AS ID_Teacher,
    WC.student_id AS ID_Student,
    CO.offer_id AS ID_Offer,
    WC.class_id AS ID_Class,
    ISNULL(FB.feedback, 0) AS Feedback, -- Domyślnie 0, jeśli brak opinii
    CASE 
        WHEN ATD.present = 1 THEN 1 
        ELSE 0 
    END AS Attendance, -- Konwersja na BIT
    CO.[level] AS [Level],
    CO.duration AS Duration
FROM dbo.[DATE] AS CD
JOIN WiseDB.dbo.[class] AS WC
    ON CONVERT(DATE, CAST(CD.ID_Date AS CHAR(8)), 112) = CAST(WC.[date] AS DATE)
JOIN WiseDB.dbo.[offer] AS CO
    ON WC.offer_id = CO.offer_id
LEFT JOIN WiseDB.dbo.[attendance] AS ATD
    ON WC.class_id = ATD.class_id
LEFT JOIN WiseDB.dbo.[feedback] AS FB
    ON WC.class_id = FB.class_id
JOIN dbo.[TIME] AS T
    ON CD.ID_Time = T.ID_Time;
GO

MERGE INTO CLASSRUN AS TT
    USING dbo.vETLClassRun AS ST
        ON TT.ID_Date = ST.ClassDate
        AND TT.ID_Time = ST.ClassTime
        AND TT.ID_Teacher = ST.ClassTutor
        AND TT.ID_Student = ST.ClassStudent
        AND TT.ID_Offer = ST.ClassOffer
        AND TT.ID_Class = ST.Class
        AND TT.Feedback = ST.Feedback
            WHEN NOT MATCHED
                THEN
                    INSERT
                    VALUES (
                        ST.ClassDate,
                        ST.ClassTime,
                        ST.ClassTutor,
                        ST.ClassStudent,
                        ST.ClassOffer,
                        ST.Class,
                        ST.Feedback
                    )
            WHEN NOT MATCHED BY SOURCE
                THEN
                    DELETE
            ;

DROP VIEW dbo.vETLClassRun;
