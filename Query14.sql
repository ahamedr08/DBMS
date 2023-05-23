-------------------------------------------------------------------------
Salespeople Table : Sid, Sname, City, Commission, Contact_no (varray)
Customer Table : Cno, Cname, City, Order_amount, Sid

Query : List the salespeople and customers located in the same city.

Function : Calculate commission for each salesperson based on the number
           of customers and update the Salespeople Table.
-------------------------------------------------------------------------

-- Create Varray
CREATE TYPE ContactNumberType AS VARRAY(5) OF VARCHAR(20);

-- Create Salespeople table
CREATE TABLE Salespeople (
 Sid INT PRIMARY KEY,
 Sname VARCHAR(50),
 City VARCHAR(50),
 Commission NUMBER,
 Contact_no ContactNumberType
);

-- Create Customer table
CREATE TABLE Customer (
 Cno INT PRIMARY KEY,
 Cname VARCHAR(50),
 City VARCHAR(50),
 Order_amount NUMBER,
 Sid INT,
 FOREIGN KEY (Sid) REFERENCES Salespeople(Sid)
);

-- Insert some sample records into Salespeople table
INSERT INTO Salespeople VALUES (1, 'John Doe', 'New York', 0.0, ContactNumberType('1234567890'));
INSERT INTO Salespeople VALUES (2, 'Jane Smith', 'San Francisco', 0.0, ContactNumberType('9876543210'));

-- Insert some sample records into Customer table
INSERT INTO Customer VALUES (1, 'Alice Johnson', 'New York', 1000, 1);
INSERT INTO Customer VALUES (2, 'Bob Williams', 'San Francisco', 1500, 2);
INSERT INTO Customer VALUES (3, 'Charlie Brown', 'San Francisco', 2000, 2);

-- Display
SELECT Sid, Sname, City, Commission, COLUMN_VALUE AS Contact_no
FROM Salespeople, TABLE(Contact_no);

------------------------------QUERY---------------------------------

-- Query: List salespeople and customers in the same city
SELECT S.Sid, S.Sname AS Salesperson, S.City, C.Cno, C.Cname AS Customer
FROM Salespeople S
JOIN Customer C ON S.City = C.City;

----------------------------------------------------------------------
--------------------------------FUNCTION-------------------------------

CREATE OR REPLACE FUNCTION CalculateCommission
RETURN NUMBER
IS
 commission NUMBER;
BEGIN
 FOR s IN (SELECT Sid, COUNT(*) AS NumCustomers
 FROM Customer
 GROUP BY Sid)
 LOOP
 commission := CASE
 WHEN s.NumCustomers >= 5 THEN 0.1
 WHEN s.NumCustomers >= 3 THEN 0.08
 ELSE 0.05
 END;
 END LOOP;

 RETURN commission;
END;

----------------------------------------------------------------------
---------------------------FUNCTION EXECUTION------------------------

DECLARE
 commission_value NUMBER;
BEGIN
 commission_value := CalculateCommission();

 UPDATE Salespeople
 SET Commission = commission_value;

 COMMIT; -- Commit the changes to make them permanent
END;

select * from salespeople;

----------------------------------------------------------------------