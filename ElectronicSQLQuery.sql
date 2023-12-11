CREATE DATABASE Electronic
GO

USE Electronic

CREATE TABLE Brands(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30)
)

INSERT INTO Brands VALUES
('Apple'),
('Samsung'),
('HP'),
('Lenovo'),
('Asus')

CREATE TABLE Laptops(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30),
Price NUMERIC,
BrandID INT FOREIGN KEY REFERENCES Brands(ID)
)

INSERT INTO Laptops VALUES
('MacBook Air13', 2300, 1),
('Samsung Book3 Pro 360', 1500, 2),
('HP Probook', 1900, 3),
('Lenovo ThinkPad', 2100, 4),
('ASUS Zenbook Pro', 5600, 5),
('MacBook Air15', 3200, 1),
('Samsung Book1', 1000, 2),
('HP Pavilion', 1500, 3),
('Lenovo Legion', 2700, 4),
('ASUS TUF Dash', 2500, 5),
('MacBook Pro', 3500, 1),
('MacBook Pro M1', 4000, 1),
('ASUS F515', 1100, 5)


CREATE TABLE Phones(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30),
Price NUMERIC,
BrandID INT FOREIGN KEY REFERENCES Brands(ID)
)

INSERT INTO Phones VALUES
('iPhone11', 800, 1),
('Galaxy S23', 2600, 2),
('HP Slate6', 900, 3),
('Lenovo ThinkPhone', 1200, 4),
('ASUS ROG7', 1100, 5),
('iPhone15 Pro Max', 3000, 1),
('Galaxy A54', 1000, 2),
('HP Elite X3', 1500, 3),
('Lenovo K14 Plus', 1600, 4),
('ASUS ZenFone', 1900, 5)

--SELECT * FROM Brands
--SELECT * FROM Laptops
--SELECT * FROM Phones



--Task 3
--Laptops Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT L.[Name], B.[Name] AS BrandName, L.Price 
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID

--Task 4
--Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT P.[Name], B.[Name] AS BrandName, P.Price 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID

--Task5
--Brand Adinin Terkibinde s Olan Butun Laptoplari Cixardan Query.
SELECT * FROM Brands
WHERE [Name] LIKE '%s%'

--Task6
--Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Laptoplari Cixardan Query.
SELECT * FROM Laptops
WHERE (Price BETWEEN 2000 AND 5000) OR Price>5000

--Task7
--Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
SELECT * FROM Phones
WHERE (Price BETWEEN 1000 AND 1500) OR Price>1500

--Task8
--Her Branda Aid Nece dene Laptop Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT B.[Name], COUNT(L.ID) AS LaptopCount
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID
GROUP BY B.[Name]

--Task9
--Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT B.[Name], COUNT(P.ID) AS PhoneCount 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID
GROUP BY B.[Name]

--Task10
--Hem Phone Hem de Laptoplda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
SELECT [Name], BrandID FROM Phones 
UNION 
SELECT [Name], BrandID FROM Laptops

--Task11
--Phone ve Laptop da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
SELECT * FROM Phones
UNION ALL
SELECT * FROM Laptops
GO

--Create VIEW
--
CREATE VIEW AllDevice
AS
SELECT
    'Phone' AS DeviceType,
    P.ID AS DeviceId,
    P.[Name] AS DeviceName, 
    P.Price AS DevicePrice,
    B.[Name] AS BrandName 
FROM Phones AS P
JOIN Brands AS B ON P.BrandID = B.ID

UNION ALL

SELECT
    'Laptop' AS DeviceType,
    L.ID AS DeviceId,
    L.[Name] AS DeviceName, 
    L.Price AS DevicePrice,
	B.[Name] AS BrandName 
FROM Laptops AS L
JOIN Brands AS B ON L.BrandID = B.ID
GO
--
--

--Task12
--Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
SELECT * FROM AllDevice

--Task13
-- Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
SELECT * FROM AllDevice
WHERE DevicePrice > 1000

--Task14
--Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan
SELECT B.[Name] AS BrandName, SUM(P.Price) AS TotalPrice, COUNT(P.ID) AS ProductCount 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID
GROUP BY B.[Name]

--Task15
--Laptops Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan 
SELECT B.[Name] AS BrandName, SUM(L.Price) AS TotalPrice, COUNT(L.ID) AS ProductCount 
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID
GROUP BY B.[Name]
HAVING COUNT(L.ID) >= 3
