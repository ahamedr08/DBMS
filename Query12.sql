-------------------------------------------------------------------------
Salespeople Table : Sid, Sname, City, Commission
Customer Table : Cno, Cname, City, Order_amount, Sid

Query : List the salesperson who has received the maximum commission.

Procedure : For calculating commission for each salesperson based on the number
            of customers and update the Salespeople Table.
-------------------------------------------------------------------------

-- Create Salespeople table
CREATE TABLE Salespeople (
 Sid INT PRIMARY KEY,
 Sname VARCHAR(50),
 City VARCHAR(50),
 Commission FLOAT
);

-- Create Customer table
CREATE TABLE Customer (
 Cno INT PRIMARY KEY,
 Cname VARCHAR(50),
 City VARCHAR(50),
 Order_amount FLOAT,
 Sid INT,
 FOREIGN KEY (Sid) REFERENCES Salespeople(Sid)
);

-- Insert sample records into Salespeople table
INSERT INTO Salespeople VALUES (1, 'John Smith', 'New York', 0.15);
INSERT INTO Salespeople VALUES (2, 'Jane Johnson', 'Los Angeles', 0.12);
INSERT INTO Salespeople VALUES (3, 'Mike Davis', 'Chicago', 0.10);
INSERT INTO Salespeople VALUES (4, 'Sarah Wilson', 'Houston', 0.08);

-- Insert sample records into Customer table
INSERT INTO Customer VALUES (1, 'ABC Company', 'New York', 1000.00, 1);
INSERT INTO Customer VALUES (2, 'XYZ Corporation', 'Los Angeles', 2000.00, 2);
INSERT INTO Customer VALUES (3, '123 Corporation', 'Chicago', 1500.00, 3);
INSERT INTO Customer VALUES (4, '456 Enterprises', 'Houston', 500.00, 4);
INSERT INTO Customer VALUES (5, 'DEF Inc.', 'New York', 3000.00, 1);

------------------------------QUERY---------------------------------

-- Query: List the salesperson who has received the maximum commission
SELECT Sname, Commission
FROM Salespeople
WHERE Commission = (
 SELECT MAX(Commission)
 FROM Salespeople
);

----------------------------------------------------------------------
------------------------------PROCEDURE-------------------------------

-- Create procedure to calculate commission for each salesperson
CREATE OR REPLACE PROCEDURE Calculate_Commission AS
BEGIN
 FOR sp IN (SELECT Sid FROM Salespeople)
 LOOP
 UPDATE Salespeople
 SET Commission = (
 SELECT COUNT(*) * 0.02
 FROM Customer
 WHERE Sid = sp.Sid
 )
 WHERE Sid = sp.Sid;
 END;

----------------------------------------------------------------------
---------------------------PROCEDURE EXECUTION------------------------

-- Execute the procedure to update the commission for each salesperson

BEGIN
 Calculate_Commission;
END;

SELECT Sid, Sname, Commission
FROM Salespeople;

----------------------------------------------------------------------