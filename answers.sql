--QUESTION 1
SELECT 
    OrderID,
    CustomerName,
    LTRIM(RTRIM(value)) AS Product --LTRIM(RTRIM(value)) → removes extra spaces.
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');  --STRING_SPLIT(Products, ',') → breaks the Products column into multiple rows (splits by comma).

--QUESTTION 2
-- Creating Orders table (Customer depends only on OrderID)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Creating OrderProducts table (no partial dependency)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
