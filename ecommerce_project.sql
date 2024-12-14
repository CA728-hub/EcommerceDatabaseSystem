-- Project: E-Commerce Database
-- Created by: Cody Anderson  
-- Date of Project: 7/30/24

-- Creating the required tables: Products, Customers, Orders, and OrderDetails

CREATE TABLE Products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(50) NOT NULL,
   Price DECIMAL(10, 2) NOT NULL,
   Stock INT NOT NULL
);

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
   FirstName VARCHAR(50) NOT NULL,
   LastName VARCHAR(50) NOT NULL,
   Email VARCHAR(50) UNIQUE NOT NULL,
   PhoneNumber VARCHAR(15),
   Address VARCHAR(100)
);

CREATE TABLE Orders (
   OrderID INT PRIMARY KEY,
   OrderDate DATE NOT NULL,
   CustomerID INT,
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
   OrderDetailID INT PRIMARY KEY,
   OrderID INT,
   ProductID INT,
   Quantity INT NOT NULL,
   FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inserting data into the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES 
    (1, 'Cody', 'Anderson', 'cody.anderson@example.com', '843-990-0610', '722 Sugar Hill RD, Holly Hill, SC'),
    (2, 'Jane', 'Doe', 'jane.doe@example.com', '555-432-1100', '150 Maple St, Anytown, NY'),
    (3, 'John', 'Smith', 'john.smith@example.com', '555-123-4567', '25 Oak St, Sometown, TX');

-- Inserting data into the Products table
INSERT INTO Products (ProductID, ProductName, Price, Stock)
VALUES 
    (1, 'Toy Airplane', 10.27, 12),
    (2, 'Cowboy Hat', 7.80, 20),
    (3, 'GameCube', 30.00, 5),
    (4, 'Socks', 2.99, 24),
    (5, 'Toothbrush', 5.67, 10);

-- Inserting data into the Orders table
INSERT INTO Orders (OrderID, OrderDate, CustomerID)
VALUES 
    (1, '2023-01-01', 1),
    (2, '2023-05-04', 2),
    (3, '2023-09-08', 1);

-- Inserting data into the OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES 
    (1, 1, 1, 2),
    (2, 2, 2, 1),
    (3, 3, 3, 1),
    (4, 1, 4, 5),
    (5, 2, 5, 10);

-- Queries:

-- 1. List all products with their details
SELECT * 
FROM Products;

-- 2. Find all customers who have placed orders
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 3. Calculate the total number of orders placed by each customer
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS 'Total Orders'
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 4. Find all products that are out of stock
SELECT ProductID, ProductName, Stock AS 'Out of Stock'
FROM Products
WHERE Stock = 0 OR Stock IS NULL;

-- 5. Calculate the total revenue generated from each product
SELECT p.ProductID, p.ProductName, SUM(od.Quantity * p.Price) AS 'Total Revenue'
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

-- 6. Find all orders placed in the last month
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y-%m-01') AND LAST_DAY(NOW() - INTERVAL 1 MONTH);

-- Project Completed
-- Date: 8/15/24
