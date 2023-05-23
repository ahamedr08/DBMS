-------------------------------------------------------------------------
Staff Table : Staff_id, Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, Leave_Type (CL / ML /OD )

Query : List the staff details who has availed more leave (including all leave)

Procedure : To compute and display the staff list for whom the leave has
exhausted. ( CL (2) , ML (3) , OD (1) per month )
-------------------------------------------------------------------------
-- Create Staff table
CREATE TABLE Staff (
Staff_id INT,
Staff_Name VARCHAR(50),
PRIMARY KEY (Staff_id)
);

-- Create Leave_Avail table
CREATE TABLE Leave_Avail (
Staff_id INT,
Avail_Date DATE,
Leave_Type VARCHAR(2),
FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id)
);

-- Insert sample records into Staff table
INSERT INTO Staff VALUES (1, 'John');
INSERT INTO Staff VALUES (2, 'Alice');
INSERT INTO Staff VALUES (3, 'Mike');
select * from staff;

-- Insert sample records into Leave_Avail table
INSERT INTO Leave_Avail VALUES (1, '07-08-2023', 'CL');
INSERT INTO Leave_Avail VALUES (1, '09-08-2023', 'CL');
INSERT INTO Leave_Avail VALUES (1, '02-01-2023', 'ML');
INSERT INTO Leave_Avail VALUES (1, '08-09-2023', 'ML');
INSERT INTO Leave_Avail VALUES (1, '01-01-2023', 'ML');
INSERT INTO Leave_Avail VALUES (1, '03-04-2023', 'OD');
INSERT INTO Leave_Avail VALUES (2, '09-04-2023', 'CL');
INSERT INTO Leave_Avail VALUES (2, '02-04-2023', 'OD');
INSERT INTO Leave_Avail VALUES (3, '09-09-2023', 'ML');
select * from Leave_Avail;

-------------------------------QUERY---------------------------------

SELECT s.Staff_id, s.Staff_Name, COUNT(l.Leave_Type) AS Total_Leaves
FROM Staff s
JOIN Leave_Avail l ON s.Staff_id = l.Staff_id
GROUP BY s.Staff_id, s.Staff_Name
ORDER BY Total_Leaves DESC;

----------------------------------------------------------------------
-------------------------------PROCEDURE------------------------------

CREATE OR REPLACE PROCEDURE Leave_Exhausted
IS
BEGIN
FOR staff_rec IN (
SELECT s.Staff_id, s.Staff_Name, COUNT(l.Leave_Type) AS Total_Leaves
FROM Staff s
JOIN Leave_Avail l ON s.Staff_id = l.Staff_id

GROUP BY s.Staff_id, s.Staff_Name
HAVING COUNT(l.Leave_Type) >= 6
ORDER BY Total_Leaves DESC
)
LOOP
DBMS_OUTPUT.PUT_LINE('Staff ID: ' || staff_rec.Staff_id || ', Staff Name: ' ||
staff_rec.Staff_Name || ', Total Leaves: ' || staff_rec.Total_Leaves);
END LOOP;
END;

----------------------------------------------------------------------
------------------------PROCEDURE EXECUTION---------------------------

SET SERVEROUTPUT ON;
EXEC Leave_Exhausted;

----------------------------------------------------------------------