USE Warehouse
GO

-- Wyłączenie sprawdzania kluczy obcych
ALTER TABLE CLASSRUN NOCHECK CONSTRAINT ALL;
ALTER TABLE OFFER NOCHECK CONSTRAINT ALL;
ALTER TABLE STUDENT NOCHECK CONSTRAINT ALL;
ALTER TABLE TEACHER NOCHECK CONSTRAINT ALL;

-- Usuwanie danych
DELETE FROM CLASSRUN;
DELETE FROM OFFER;
DELETE FROM STUDENT;
DELETE FROM TEACHER;