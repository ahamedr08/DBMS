-------------------------------------------------------------------------
Sales Table : Sales_id, Product_id, Qty, Price, Branch_Name, Salesperson_Name
Purchases Table : Purchase_id, Product_id, Qty, Purchase_date
Products Table : Product_id, Product_name, Reorder_level

Query : Find the product which has been purchased at the maximum on a day.

Trigger : Give an alert to intimate the purchase department to place the
          order when the reorder level for the product is reached.
-------------------------------------------------------------------------

-- Create Sales table
CREATE TABLE Sales (
 Sales_ID INT PRIMARY KEY,
 Product_ID INT,
 Qty INT,
 Price DECIMAL(10, 2),
 Branch_Name VARCHAR(50),
 Salesperson_Name VARCHAR(50),
 FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Purchases table
CREATE TABLE Purchases (
 Purchase_ID INT PRIMARY KEY,
 Product_ID INT,
 Qty INT,
 Purchase_date DATE,
 FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Products table
CREATE TABLE Products (
 Product_ID INT PRIMARY KEY,
 Product_Name VARCHAR(50),
 Reorder_Level INT
);

-- Insert sample products records
INSERT INTO Products VALUES (1, 'Product A', 15);
INSERT INTO Products VALUES (2, 'Product B', 10);
INSERT INTO Products VALUES (3, 'Product C', 20);

-- Insert sample sales records
INSERT INTO Sales VALUES (1, 1, 5, 10.50, 'Branch A', 'John Doe');
INSERT INTO Sales VALUES (2, 2, 3, 15.25, 'Branch B', 'Jane Smith');
INSERT INTO Sales VALUES (3, 1, 2, 10.50, 'Branch C', 'Mike Johnson');
INSERT INTO Sales VALUES (4, 3, 10, 5.75, 'Branch A', 'John Doe');

-- Insert sample purchase records
INSERT INTO Purchases VALUES (1, 1, 10, '13-05-2023');
 INSERT INTO Purchases VALUES (2, 2, 5, '13-05-2023');
 INSERT INTO Purchases VALUES (3, 1, 5, '13-05-2023');
 INSERT INTO Purchases VALUES (4, 3, 8, '13-05-2023');

------------------------------QUERY---------------------------------

SELECT p.Product_Name, MAX(pr.Qty) AS Max_Quantity
FROM Purchases pr
JOIN Products p ON pr.Product_ID = p.Product_ID
WHERE pr.Purchase_date = '13-05-2023'
GROUP BY p.Product_Name;

----------------------------------------------------------------------
--------------------------------TRIGGER-------------------------------

CREATE OR REPLACE TRIGGER ReorderAlert
AFTER INSERT ON Sales
FOR EACH ROW
DECLARE
 reorderQty INT;
 alertMsg VARCHAR2(100);
BEGIN
 SELECT Reorder_Level INTO reorderQty FROM Products WHERE Product_ID =
:NEW.Product_ID;
 IF :NEW.Qty >= reorderQty THEN
 -- Trigger an alert or take appropriate action
 -- For example, you can raise an error or insert into an alerts table
 -- Here, we will store the alert message in a variable
 alertMsg := 'Alert: Reorder level reached for Product ' || :NEW.Product_ID;

 -- Print the alert message (you can replace this with your desired action)
 DBMS_OUTPUT.PUT_LINE(alertMsg);
 END IF;
END;

----------------------------------------------------------------------
---------------------------TRIGGER EXECUTION------------------------

INSERT INTO Sales
VALUES (7, 1, 199, 10.50, 'Branch A', 'John Doe');

----------------------------------------------------------------------
