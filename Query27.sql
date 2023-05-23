-------------------------------------------------------------------------

SCHEMA STRUCTURE:

PRODUCT (ProductID, ProductName, Category, Price)
ORDER (OrderID, ProductID, CustomerName, Quantity)

QUERIES:

1. Calculate the total price of each order.
2. Find the products with the highest price.
3. Retrieve the customer name and quantity for each order.
4.. Get the products that have not been ordered.

-------------------------------------------------------------------------

-- To calculate the total price of each order

SELECT OrderID, SUM(Price * Quantity) AS TotalPrice
FROM ORDER o
JOIN PRODUCT p ON o.ProductID = p.ProductID
GROUP BY OrderID;

-- To find the products with the highest price

SELECT *
FROM PRODUCT
WHERE Price = (SELECT MAX(Price) FROM PRODUCT);

-- To retrieve the customer name and quantity for each order

SELECT OrderID, CustomerName, Quantity
FROM ORDER;

-- To get the products that have not been ordered

SELECT *
FROM PRODUCT
WHERE ProductID NOT IN (SELECT ProductID FROM ORDER);