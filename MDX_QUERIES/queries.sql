-- 1. Analiza sezonowej frekwencji na zajęciach podzielona na przedmioty w roku 2017:
SELECT 
    NON EMPTY { [Measures].[Attendance on classes pos] } ON COLUMNS, 
    NON EMPTY { ([DATE].[Vacation].[Vacation].ALLMEMBERS * [OFFER].[Subject].[Subject].ALLMEMBERS ) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM [Warehouse] 
WHERE ([DATE].[Year].[2017])
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS


-- 2. Pokaż liczbę obecności na zajęciach oraz procentową frekwencję dla poszczególnych miesięcy w roku 2017.
WITH 
MEMBER [Measures].[Attendance Percentage] AS 
    ([Measures].[Attendance on classes pos] / [Measures].[Number of classes done]) * 100, 
    FORMAT_STRING = "Percent"
SELECT 
    NON EMPTY { [Measures].[Attendance on classes pos], [Measures].[Attendance Percentage] } ON COLUMNS, 
    NON EMPTY { ([DATE].[Date hierarchy].[Month].ALLMEMBERS ) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    ( 
        SELECT 
            ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS 
        FROM [Warehouse]
    ) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS


-- 3. Jakie jest 5 najczęściej wybieranch przedmiotów przez uczniów w bieżącym roku?
SELECT 
    NON EMPTY { [Measures].[Number of classes done] } ON COLUMNS, 
    NON EMPTY { 
        TopCount(
            ([DATE].[Date hierarchy].[Month].ALLMEMBERS * [OFFER].[Subject].[Subject].ALLMEMBERS), 
            5, 
            [Measures].[Number of classes done]
        ) 
    } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    ( 
        SELECT 
            ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS 
        FROM [Warehouse]
    ) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

-- 4. Porównaj frekwencję na zajęciach prowadzonych przez różnych nauczycieli w bieżącym i poprzednim miesiącu.
WITH 
MEMBER [Measures].[Average Attendance] AS 
    [Measures].[Attendance on classes pos] / 30, 
    FORMAT_STRING = "Standard"
SELECT 
    NON EMPTY { [Measures].[Attendance on classes pos], [Measures].[Average Attendance] } ON COLUMNS, 
    NON EMPTY { ([TEACHER].[Name And Surname].[Name And Surname].ALLMEMBERS * [DATE].[Date hierarchy].[Month].ALLMEMBERS ) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    ( 
        SELECT 
            ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS 
        FROM [Warehouse]
    ) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS


-- 5. Przeanalizuj miesięczną frekwencję nauczycieli w 2017 roku, obliczając również średnią dzienną obecność zaokrągloną do dwóch miejsc po przecinku?
WITH 
MEMBER [Measures].[Average Attendance per day] AS 
    ROUND([Measures].[Attendance on classes pos] / 30, 2), 
    FORMAT_STRING = "Standard"
SELECT 
    NON EMPTY { [Measures].[Attendance on classes pos], [Measures].[Average Attendance per day] } ON COLUMNS, 
    NON EMPTY { ([TEACHER].[Name And Surname].[Name And Surname].ALLMEMBERS * [DATE].[Date hierarchy].[Month].ALLMEMBERS ) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    ( 
        SELECT 
            ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS 
        FROM [Warehouse]
    ) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS


-- 6. Zwróć 5 miesięcy z najniższym średnim poziomem satysfakcji uczniów roku 2017.
SELECT 
    NON EMPTY { [Measures].[Average satisfaction level] } ON COLUMNS, 
    NON EMPTY { 
        BottomCount(
            [DATE].[Date hierarchy].[Month].ALLMEMBERS, 
            5, 
            [Measures].[Average satisfaction level]
        ) 
    } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    ( 
        SELECT 
            ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS 
        FROM [Warehouse]
    ) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS


-- 7. Jak zmieniła się liczba godzin przeprowadzonych lekcji w bieżącym miesiącu w porównaniu do poprzedniego miesiąca? 
SELECT NON EMPTY { [Measures].[Sum of minutes of classes done] } ON COLUMNS, NON EMPTY { ([DATE].[Date hierarchy].[Month].ALLMEMBERS ) } DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS FROM ( SELECT ( { [DATE].[Date hierarchy].[Year].&[2017] } ) ON COLUMNS FROM [Warehouse]) CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

-- 8. Którzy nauczyciele mają największy wpływ na wzrost / spadek poziomu satysfakcji uczniów w bieżącym miesiącu?
SELECT NON EMPTY { [Measures].[Average satisfaction level] } ON COLUMNS, NON EMPTY { ([DATE].[Date hierarchy].[Month].ALLMEMBERS * [TEACHER].[Name And Surname].[Name And Surname].ALLMEMBERS ) } DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS FROM ( SELECT ( { [DATE].[Date hierarchy].[Year].&[2017].&[January] } ) ON COLUMNS FROM [Warehouse]) CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

-- 9. Jakie przedmioty mają największy wpływ na wzrost /spadek liczby godzin lekcji w bieżącym miesiącu?
SELECT NON EMPTY { [Measures].[Sum of minutes of classes done] } ON COLUMNS, NON EMPTY { ([DATE].[Date hierarchy].[Month].ALLMEMBERS * [OFFER].[Subject].[Subject].ALLMEMBERS ) } DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS FROM ( SELECT ( { [DATE].[Date hierarchy].[Year].&[2017].&[January] } ) ON COLUMNS FROM [Warehouse]) CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

-- 10. Jak zmienia się poziom satysfakcji uczniów w zależności od liczby godzin lekcji, które zostały zrealizowane na przestrzeni ostatnich sześciu miesięcy?
SELECT NON EMPTY { [Measures].[Sum of minutes of classes done], [Measures].[Average satisfaction level] } ON COLUMNS, NON EMPTY { ([DATE].[Date hierarchy].[Month].ALLMEMBERS ) } DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS FROM ( SELECT ( { [DATE].[Date hierarchy].[Year].&[2017].&[January], [DATE].[Date hierarchy].[Year].&[2017].&[February], [DATE].[Date hierarchy].[Year].&[2017].&[March], [DATE].[Date hierarchy].[Year].&[2017].&[April], [DATE].[Date hierarchy].[Year].&[2017].&[May], [DATE].[Date hierarchy].[Year].&[2017].&[June] } ) ON COLUMNS FROM [Warehouse]) CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS