USE Warehouse
GO

INSERT INTO DATE (Date, Year, Month, MonthNo, DayOfWeek, DayOfWeekNo, WorkingDay, Vacation, Holiday, BeforeHolidayDay)
VALUES 
('2024-01-01', 2024, 'styczen', 1, 'poniedzialek', 1, 'dzien wolny', 'ferie zimowe', 'nowy rok', NULL),
('2024-01-02', 2024, 'styczen', 1, 'wtorek', 2, 'dzien roboczy', 'ferie zimowe', NULL, NULL),
('2024-01-03', 2024, 'styczen', 1, 'sroda', 3, 'dzien roboczy', 'ferie zimowe', NULL, NULL),
('2024-02-14', 2024, 'luty', 2, 'sroda', 3, 'dzien roboczy', 'dni robocze', 'walentynki', NULL),
('2024-03-20', 2024, 'marzec', 3, 'sroda', 3, 'dzien roboczy', 'dni robocze', NULL, NULL),
('2024-04-01', 2024, 'kwiecien', 4, 'poniedzialek', 1, 'dzien wolny', 'dni robocze', NULL, 'jutro jest dzien wolny'),
('2024-05-01', 2024, 'maj', 5, 'sroda', 3, 'dzien wolny', 'dni robocze', NULL, 'jutro jest swieto flagi'),
('2024-06-01', 2024, 'czerwiec', 6, 'sobota', 6, 'dzien wolny', 'dni robocze', 'dzien dziecka', NULL),
('2024-07-15', 2024, 'lipiec', 7, 'poniedzialek', 1, 'dzien roboczy', 'wakacje', NULL, NULL),
('2024-12-24', 2024, 'grudzien', 12, 'wtorek', 2, 'dzien wolny', 'ferie zimowe', 'wigilia', 'jutro jest boze narodzenie');


INSERT INTO TIME (Hour, TimeOfDay)
VALUES
(0, 'od 0 do 8'),
(1, 'od 0 do 8'),
(2, 'od 0 do 8'),
(3, 'od 0 do 8'),
(4, 'od 0 do 8'),
(5, 'od 0 do 8'),
(6, 'od 0 do 8'),
(7, 'od 0 do 8'),
(8, 'od 0 do 8'),
(9, 'od 9 do 12');


INSERT INTO TEACHER (AgeCategory, PESEL, NameAndSurname, Education, WorkExperience, IsCurrent)
VALUES
('od 30 do 49', '12345678901', 'Jan Kowalski', 'wyzsze licencjackie / inzynierskie', 'miedzy dwa, a piec lat', 1),
('od 50 do 64', '23456789012', 'Anna Nowak', 'wyzsze magisterskie', 'wiecej niz piec lat', 1),
('od 22 do 29', '34567890123', 'Piotr Szymański', 'pomaturalne', 'rok i mniej', 1),
('od 18 do 21', '45678901234', 'Maria Wiśniewska', 'srednie ogolne', 'rok i mniej', 1),
('od 64', '56789012345', 'Krzysztof Kowalczyk', 'wyzsze magisterskie', 'wiecej niz piec lat', 0),
('od 30 do 49', '67890123456', 'Ewa Adamczyk', 'doktoranckie', 'miedzy dwa, a piec lat', 1),
('od 22 do 29', '78901234567', 'Andrzej Kaczmarek', 'wyzsze licencjackie / inzynierskie', 'miedzy dwa, a piec lat', 1),
('od 50 do 64', '89012345678', 'Tomasz Zawisza', 'srednie zawodowe', 'wiecej niz piec lat', 1),
('od 18 do 21', '90123456789', 'Beata Zielińska', 'podstawowe', 'rok i mniej', 1),
('od 30 do 49', '01234567890', 'Wojciech Malinowski', 'wyzsze licencjackie / inzynierskie', 'miedzy dwa, a piec lat', 1);


INSERT INTO STUDENT (Login, NameAndSurname, AgeCategory, IsCurrent)
VALUES
('student1', 'Adam Adamowski', 'od 18 do 21', 1),
('student2', 'Magda Nowak', 'od 22 do 29', 1),
('student3', 'Kamil Kowalski', 'od 30 do 49', 1),
('student4', 'Aleksandra Zawisza', 'od 50 do 64', 1),
('student5', 'Piotr Wiśniewski', 'od 64', 0),
('student6', 'Karolina Malinowska', 'od 18 do 21', 1),
('student7', 'Tomasz Kaczmarek', 'od 22 do 29', 1),
('student8', 'Iwona Król', 'od 30 do 49', 1),
('student9', 'Jacek Adamczyk', 'od 50 do 64', 1),
('student10', 'Marta Szymańska', 'od 22 do 29', 1);


INSERT INTO OFFER (Subject, LevelCategory, DurationCategory)
VALUES
('matematyka', 'podstawowy / a', 'od 30 minut do 1 godziny'),
('fizyka', 'sredni / b', 'od 1 godziny do 1,5 godziny'),
('chemia', 'zaawansowany / c', 'od 1,5 godziny'),
('biologia', 'podstawowy / a', 'od 30 minut do 1 godziny'),
('geografia', 'sredni / b', 'od 1 godziny do 1,5 godziny'),
('historia', 'zaawansowany / c', 'od 1,5 godziny'),
('informatyka', 'podstawowy / a', 'od 30 minut do 1 godziny'),
('jezyk polski', 'sredni / b', 'od 1 godziny do 1,5 godziny'),
('jezyk angielski', 'zaawansowany / c', 'od 1,5 godziny'),
('jezyk niemiecki', 'podstawowy / a', 'od 30 minut do 1 godziny');


INSERT INTO CLASSRUN (ID_Date, ID_Time, ID_Teacher, ID_Student, ID_Offer, ID_Class, Feedback, Attendance, Level, Duration)
VALUES
(1, 1, 1, 1, 1, 1, 5, 1, 3, 60),
(2, 2, 2, 2, 2, 2, 4, 1, 2, 75),
(3, 3, 3, 3, 3, 3, 3, 0, 1, 45),
(4, 4, 4, 4, 4, 4, 5, 1, 3, 90),
(5, 5, 5, 5, 5, 5, 2, 1, 4, 60),
(6, 6, 6, 6, 6, 6, 3, 1, 2, 80),
(7, 7, 7, 7, 7, 7, 1, 0, 1, 50),
(8, 8, 8, 8, 8, 8, 4, 1, 3, 70),
(9, 9, 9, 9, 9, 9, 2, 1, 2, 60),
(10, 10, 10, 10, 10, 10, 5, 1, 4, 120);

