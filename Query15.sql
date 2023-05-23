-------------------------------------------------------------------------
Salespeople Table : Sid, Sname, Contact_no
Sales Table : Sale_date, Product_id, Qty, Price, Branch_id, Sid

Query : Find the salesperson who had maximum sales in a particular year.

Procedure : Display the sales report for the past two years branch wise, year wise
            and salesperson wise
-------------------------------------------------------------------------

-- Create Salespeople table
CREATE TABLE Salespeople (
 Sid INT PRIMARY KEY,
 Sname VARCHAR(50),
 Contact_no VARCHAR(20)
);

-- Create Sales table
CREATE TABLE Sal(
 Sale_date DATE,
 Product_id INT,
 Qty INT,
 Price DECIMAL(10, 2),
 Branch_id INT,
 Sid INT,
 FOREIGN KEY (Sid) REFERENCES Salespeople(Sid)
);

-- Inserting records into Salespeople table
INSERT INTO Salespeople values(1, 'John Doe', '1234567890');
INSERT INTO Salespeople values(2, 'Jane Smith', '9876543210');
INSERT INTO Salespeople values(3, 'Michael Johnson', '5555555555');

-- Inserting records into Sales table
INSERT INTO Sales values('01-01-2022', 1, 5, 10.99, 1, 1);
INSERT INTO Sales values ('02-01-2022', 2, 3, 5.99, 1, 1);
INSERT INTO Sales values('08-09-2023', 3, 2, 8.99, 2, 1);
INSERT INTO Sales values('08-07-2023', 1, 1, 10.99, 1, 2);

------------------------------QUERY---------------------------------

SELECT Sname, TotalSales
FROM (
 SELECT SP.Sname, SUM(S.Qty * S.Price) AS TotalSales
 FROM Sales S
 JOIN Salespeople SP ON S.Sid = SP.Sid
 WHERE EXTRACT(YEAR FROM S.Sale_date) = 2023 -- Replace 2023 with the desired year
 GROUP BY SP.Sid, SP.Sname
 ORDER BY TotalSales DESC
)
WHERE ROWNUM = 1;

----------------------------------------------------------------------
--------------------------------PROCEDURE-------------------------------

CREATE OR REPLACE PROCEDURE SalesReport AS
 current_year NUMBER;
 previous_year NUMBER;

 -- Variables to store query results
 current_year_sales NUMBER;
 previous_year_sales NUMBER;
BEGIN
 current_year := EXTRACT(YEAR FROM SYSDATE);
 previous_year := current_year - 1;

 -- Sales report for the current year
 SELECT SUM(S.Qty * S.Price) INTO current_year_sales
 FROM Sales S
 WHERE EXTRACT(YEAR FROM S.Sale_date) = current_year;

 -- Sales report for the previous year
 SELECT SUM(S.Qty * S.Price) INTO previous_year_sales
 FROM Sales S
 WHERE EXTRACT(YEAR FROM S.Sale_date) = previous_year;

 -- Display the sales report
 DBMS_OUTPUT.PUT_LINE('Sales Report:');
 DBMS_OUTPUT.PUT_LINE('----------------');
 DBMS_OUTPUT.PUT_LINE('Current Year Sales: ' || current_year_sales);
 DBMS_OUTPUT.PUT_LINE('Previous Year Sales: ' || previous_year_sales);

END;

----------------------------------------------------------------------
---------------------------PROCEDURE EXECUTION------------------------

BEGIN
SalesReport();
END;

----------------------------------------------------------------------