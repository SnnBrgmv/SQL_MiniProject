CREATE DATABASE Library
GO

USE Library

CREATE TABLE Books(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100) CHECK(LEN(Name) >= 2 AND LEN(Name) <= 100),
[PageCount] INT CHECK(PageCount >= 10)
)

INSERT INTO Books VALUES
('Crime and Punishment', 527),
('White Nights', 420),
('Pride and Prejudice', 450),
('Emma', 1036),
('Nineteen Eighty-Four', 328),
('Animal Farm', 160),
('Anna Karenina', 864),
('War and Peace', 1225),
('The Talisman', 646),
('The War: An Intimate History, 1941-1945', 480)


CREATE TABLE Authors(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(50),
Surname NVARCHAR (50)
)

INSERT INTO Authors VALUES
('Fyodor','Dostoevsky'),
('Jane','Austen'),
('George', 'Orwell'),
('Leo', 'Tolstoy'),
('Stephen', 'King'),
('Peter', 'Straub'),
('Geoffrey C.', 'Ward'),
('Ken', 'Burns')

CREATE TABLE BookAuthor(
ID INT IDENTITY,
BookID INT FOREIGN KEY REFERENCES Books(ID),
AuthorID INT FOREIGN KEY REFERENCES Authors(ID)
)

INSERT INTO BookAuthor VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(9, 6),
(10, 7),
(10, 8)

--SELECT * FROM Books
--SELECT * FROM Authors
--SELECT * FROM BookAuthor
GO

CREATE VIEW BooksAndAuthors
AS
SELECT B.ID, B.[Name], B.[PageCount], CONCAT(A.[Name],' ',A.Surname) AS FullName 
FROM Books AS B 
JOIN 
BookAuthor AS BA ON  B.ID = BA.BookID
JOIN
Authors AS A ON A.ID = BA.AuthorID
GO

SELECT * FROM BooksAndAuthors
GO

CREATE VIEW AuthorDetails
AS
SELECT A.ID,  CONCAT(A.[Name],' ',A.Surname) AS FullName, COUNT(B.ID) AS BooksCount, SUM(B.PageCount) AS MaxPageCount
FROM Authors AS A 
JOIN 
BookAuthor AS BA ON  A.ID = BA.AuthorID
JOIN
Books AS B ON B.ID = BA.BookID
GROUP BY A.ID, A.[Name], A.Surname
GO

SELECT * FROM AuthorDetails
GO

CREATE PROCEDURE sp_GetAuthorDetails @name NVARCHAR(50)
AS
BEGIN
SELECT B.ID, B.[Name], B.[PageCount], CONCAT(A.[Name],' ',A.Surname) AS FullName 
FROM Authors AS A
JOIN
BookAuthor AS BA ON  A.ID = BA.AuthorID
JOIN
Books AS B ON B.ID = BA.BookID
 WHERE A.[Name] = @name
END

--EXEC sp_GetAuthorDetails @name = 'stephen'
GO

CREATE PROCEDURE sp_InsertToAuthor @insName NVARCHAR(50), @insSurname NVARCHAR(50)
AS
BEGIN
INSERT INTO Authors VALUES
(@insName, @insSurname)
END

--EXEC sp_InsertToAuthor @insName = 'Chingiz', @insSurname = 'Aitmatov'
GO

CREATE PROCEDURE sp_UpdateOnAuthor @id INT, @updName NVARCHAR(50), @updSurname NVARCHAR(50)
AS
BEGIN
UPDATE Authors SET [Name] = @updName, Surname = @updSurname
WHERE ID = @id
END

--EXEC sp_UpdateOnAuthor @id=9, @updName = 'Jalil', @updSurname = 'Mammadguluzadeh'
GO

CREATE PROCEDURE sp_DeleteFromAuthor @delId INT
AS
BEGIN
DELETE FROM Authors WHERE ID = @delId
END

--EXEC sp_DeleteFromAuthor @delId=9
