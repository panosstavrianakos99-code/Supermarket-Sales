CREATE DATABASE supermarket
USE supermarket
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerType VARCHAR(50),
    Gender VARCHAR(10),
    Age INT
);
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductLine VARCHAR(100)
);
CREATE TABLE Store (
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    Branch CHAR(1),
    City VARCHAR(50)
);
CREATE TABLE DimDate (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE,
    FullTime TIME,
    Day INT,
    Month INT,
    Year INT,
    Hour INT
);
CREATE TABLE Sales (
    InvoiceID VARCHAR(20) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID),
    StoreID INT FOREIGN KEY REFERENCES Store(StoreID),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    Total AS (UnitPrice * Quantity) PERSISTED,
    PaymentMethod VARCHAR(50)
);

CREATE TABLE excel (
    InvoiceID VARCHAR(20),
    Branch CHAR(1),
    City VARCHAR(50),
    CustomerType VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    ProductLine VARCHAR(100),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    Date VARCHAR(20),
    Time VARCHAR(20),
    Payment VARCHAR(50)
);

Importing csv using name of table supermarket_sales

INSERT INTO Customer (CustomerType, Gender, Age)
SELECT DISTINCT Customer_Type, Gender, Age
FROM supermarket_sales

INSERT INTO Product (ProductLine)
SELECT DISTINCT Product_Line
FROM supermarket_sales;

INSERT INTO Store (Branch, City)
SELECT DISTINCT Branch, City
FROM supermarket_sales;

INSERT INTO DimDate (FullDate, FullTime, Day, Month, Year, Hour)
SELECT 
    CONVERT(date, Date),
    CONVERT(time, Time),
    DAY(CONVERT(date, Date)),
    MONTH(CONVERT(date, Date)),
    YEAR(CONVERT(date, Date)),
    DATEPART(HOUR, CONVERT(time, Time))
FROM supermarket_sales;

Removing Duplication from DimDate table which was causing issue with uniqueness during the joining.
INSERT INTO Sales
(InvoiceID, CustomerID, ProductID, DateID, StoreID, UnitPrice, Quantity, PaymentMethod)
SELECT
    s.Invoice_ID,
    c.CustomerID,
    p.ProductID,
    d.DateID,
    st.StoreID,
    s.Unit_Price,
    s.Quantity,
    s.Payment
FROM supermarket_sales s
JOIN Customer c
    ON c.CustomerType = s.Customer_Type
   AND c.Gender = s.Gender
   AND c.Age = s.Age
JOIN Product p
    ON p.ProductLine = s.Product_Line
JOIN Store st
    ON st.Branch = s.Branch
   AND st.City = s.City
JOIN DimDate d
    ON d.FullDate = CONVERT(date, s.Date)
   AND d.FullTime = CONVERT(time, s.Time);