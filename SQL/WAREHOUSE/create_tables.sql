USE Warehouse
GO

CREATE TABLE DATE (
    ID_Date INT PRIMARY KEY IDENTITY(1,1),
	Date DATE NOT NULL,
    Year INT NOT NULL CHECK (Year BETWEEN 1000 AND 9999),
    Month VARCHAR(20) NOT NULL CHECK (Month IN ('styczen', 'luty', 'marzec', 'kwiecien', 'maj', 'czerwiec', 'lipiec', 'sierpien', 'wrzesien', 'pazdziernik', 'listopad', 'grudzien')),
    MonthNo INT NOT NULL CHECK (MonthNo BETWEEN 1 AND 12),
    DayOfWeek VARCHAR(20) NOT NULL CHECK (DayOfWeek IN ('poniedzialek', 'wtorek', 'sroda', 'czwartek', 'piatek', 'sobota', 'niedziela')),
    DayOfWeekNo INT NOT NULL CHECK (DayOfWeekNo BETWEEN 1 AND 7),
    WorkingDay VARCHAR(15) NOT NULL CHECK (WorkingDay IN ('dzien wolny', 'dzien roboczy')),
    Vacation VARCHAR(20) NOT NULL CHECK (Vacation IN ('dni robocze', 'ferie zimowe', 'wakacje')),
    Holiday VARCHAR(50) NULL CHECK (Holiday IN ('boze narodzenie', 'dzien babci', 'dzien dziadka', 'wigilia', 'dzien mamy', 'dzien dziecka', 'dzien taty', 'weekend', 'nowy rok', 'walentynki')),
    BeforeHolidayDay VARCHAR(62) NULL CHECK (BeforeHolidayDay LIKE 'jutro jest%')
);


CREATE TABLE TIME (
    ID_Time INT PRIMARY KEY IDENTITY(1,1),
    Hour INT NOT NULL CHECK (Hour BETWEEN 0 AND 23),
    TimeOfDay VARCHAR(20) NOT NULL CHECK (TimeOfDay IN ('od 0 do 8', 'od 9 do 12', 'od 13 do 15', 'od 16 do 20', 'od 21 do 23'))
);


CREATE TABLE TEACHER (
    ID_Teacher INT PRIMARY KEY IDENTITY(1,1),
	AgeCategory VARCHAR(20) CHECK (AgeCategory IN ('od 18 do 21', 'od 22 do 29', 'od 30 do 49', 'od 50 do 64', 'od 64')),
    PESEL VARCHAR(11) UNIQUE,
    NameAndSurname VARCHAR(100),
    Education VARCHAR(100) CHECK (Education IN ('podstawowe', 'srednie ogolne', 'srednie zawodowe', 'pomaturalne', 'wyzsze licencjackie / inzynierskie', 'wyzsze magisterskie', 'doktoranckie')),
    WorkExperience VARCHAR(50) CHECK (WorkExperience IN ('rok i mniej', 'miedzy dwa, a piec lat', 'wiecej niz piec lat')),
    IsCurrent BIT NOT NULL
);


CREATE TABLE STUDENT (
    ID_Student INT PRIMARY KEY IDENTITY(1,1),
    Login VARCHAR(50) UNIQUE,
    NameAndSurname VARCHAR(100),
    AgeCategory VARCHAR(20) NOT NULL CHECK (AgeCategory IN ('od 18 do 21', 'od 22 do 29', 'od 30 do 49', 'od 50 do 64', 'od 64')),
    IsCurrent BIT NOT NULL
);


CREATE TABLE OFFER (
    ID_Offer INT PRIMARY KEY IDENTITY(1,1),
    Subject VARCHAR(40) NOT NULL CHECK (Subject IN ('matematyka', 'fizyka', 'chemia', 'biologia', 'geografia', 'historia', 'informatyka', 'jezyk polski', 'jezyk angielski', 'jezyk niemiecki')),
    LevelCategory VARCHAR(30) NOT NULL CHECK (LevelCategory IN ('podstawowy / a', 'sredni / b', 'zaawansowany / c')),
    DurationCategory VARCHAR(30) NOT NULL CHECK (DurationCategory IN ('od 30 minut do 1 godziny', 'od 1 godziny do 1,5 godziny', 'od 1,5 godziny'))
);


CREATE TABLE CLASSRUN (
    ID_Date INT NOT NULL,
    ID_Time INT NOT NULL,
    ID_Teacher INT NOT NULL,
    ID_Student INT NOT NULL,
    ID_Offer INT NOT NULL,
    ID_Class INT NOT NULL,
    Feedback INT NOT NULL,
    Attendance BIT NOT NULL,
    Level INT NOT NULL,
    Duration INT NOT NULL,
	FOREIGN KEY (ID_Date) REFERENCES DATE(ID_Date),
    FOREIGN KEY (ID_Time) REFERENCES TIME(ID_Time),
    FOREIGN KEY (ID_Teacher) REFERENCES TEACHER(ID_Teacher),
    FOREIGN KEY (ID_Student) REFERENCES STUDENT(ID_Student),
    FOREIGN KEY (ID_Offer) REFERENCES OFFER(ID_Offer)
);