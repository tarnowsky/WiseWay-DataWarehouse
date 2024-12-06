CREATE DATABASE WiseDB;
GO
USE WiseDB;

CREATE TABLE student (
	student_id INT PRIMARY KEY NOT NULL,
	[name] NVARCHAR(255),
	surname NVARCHAR(255),
	age INT,
    [login] NVARCHAR(255)
);
GO

CREATE TABLE subject (
    subject_id INT PRIMARY KEY NOT NULL,
    [name] NVARCHAR(255)
);
GO

CREATE TABLE offer (
    offer_id INT PRIMARY KEY NOT NULL,
    subject_id INT,
    teacher_id INT,
    [level] INT,
    duration INT,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);
GO

CREATE TABLE class (
    class_id INT PRIMARY KEY NOT NULL,
    offer_id INT,
    student_id INT,
    [date] DATETIME,
    FOREIGN KEY (offer_id) REFERENCES offer(offer_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);
GO

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY NOT NULL,
    class_id INT,
    present BIT,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);
GO

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY NOT NULL,
    class_id INT,
    feedback INT,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);
GO