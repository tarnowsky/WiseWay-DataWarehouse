USE Warehouse
GO

CREATE TABLE DATE (
    ID_Date INTEGER IDENTITY(1,1) PRIMARY KEY,
    Date datetime unique,
	Year varchar(4),
	Month varchar(10),
	MonthNo int,
	DayOfWeek varchar(15),
	DayOfWeekNo int,
	WorkingDay varchar(128),
	Vacation varchar(128),
	Holiday varchar(128),
	BeforeHolidayDay varchar(128)
);


CREATE TABLE Time (
	ID_Time INTEGER IDENTITY(1,1) PRIMARY KEY,
	Hour INTEGER UNIQUE NOT NULL,
	TimeOfDay varchar(20) NOT NULL,
);

CREATE TABLE TEACHER (
    ID_Teacher INT PRIMARY KEY IDENTITY(1,1),
	AgeCategory VARCHAR(20),
    PESEL VARCHAR(11) UNIQUE,
    NameAndSurname VARCHAR(100),
    Education VARCHAR(100),
    WorkExperience VARCHAR(50),
    IsCurrent BIT NOT NULL
);


CREATE TABLE STUDENT (
    ID_Student INT PRIMARY KEY IDENTITY(1,1),
    [Login] VARCHAR(50),
    NameAndSurname VARCHAR(100),
    AgeCategory VARCHAR(20) NOT NULL,
    IsCurrent BIT NOT NULL
);


CREATE TABLE OFFER (
    ID_Offer INT PRIMARY KEY IDENTITY(1,1),
    [Subject] VARCHAR(40) NOT NULL,
    LevelCategory VARCHAR(30) NOT NULL,
    DurationCategory VARCHAR(30) NOT NULL
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
    [Level] INT NOT NULL,
    Duration INT NOT NULL,
	FOREIGN KEY (ID_Date) REFERENCES DATE(ID_Date),
    FOREIGN KEY (ID_Time) REFERENCES TIME(ID_Time),
    FOREIGN KEY (ID_Teacher) REFERENCES TEACHER(ID_Teacher),
    FOREIGN KEY (ID_Student) REFERENCES STUDENT(ID_Student),
    FOREIGN KEY (ID_Offer) REFERENCES OFFER(ID_Offer)
);