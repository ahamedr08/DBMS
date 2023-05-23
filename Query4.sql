-------------------------------------------------------------------------
Staff Table : Staff_id , Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, No_Days, Type ( CL / ML /OD )

Query : Find the number of OD availed by the specified staff.

Procedure : To list the staff members who have availed more leave( including all leave).
-------------------------------------------------------------------------

-- Create Staff table
CREATE TABLE Staff(
Staff_id INT,
Staff_Name VARCHAR(50),
PRIMARY KEY (Staff_id)
);

-- Create Leave_Avail table
CREATE TABLE Leave_Avail2 (
Staff_id INT,
Avail_Date DATE,
No_days INT,
Type VARCHAR(2),
FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id)
);

-- Insert sample records into Staff table
INSERT INTO Staff VALUES (1, 'John');
INSERT INTO Staff VALUES (2, 'Alice');
INSERT INTO Staff VALUES (3, 'Mike');
select * from staff;

-- Insert sample records into Leave_Avail table
INSERT INTO Leave_Avail VALUES (1, '07-08-2023', 1,'CL');
INSERT INTO Leave_Avail VALUES (1, '09-08-2023',2, 'CL');
INSERT INTO Leave_Avail VALUES (1, '02-01-2023', 1,'ML');
INSERT INTO Leave_Avail VALUES (1, '08-09-2023', 1,'ML');
INSERT INTO Leave_Avail VALUES (1, '01-01-2023', 1,'ML');
INSERT INTO Leave_Avail VALUES (1, '03-04-2023',1, 'OD');
INSERT INTO Leave_Avail VALUES (2, '09-04-2023',1, 'CL');
INSERT INTO Leave_Avail VALUES (2, '02-04-2023',1, 'OD');
INSERT INTO Leave_Avail VALUES (3, '09-09-2023', 1,'ML');
select * from Leave_Avail;

-------------------------------QUERY---------------------------------

SELECT SUM(No_Days) AS Total_OD_Availed
FROM Leave_Avail
WHERE Staff_id = '1'
AND Type = 'OD';

----------------------------------------------------------------------
-------------------------------PROCEDURE------------------------------

CREATE OR REPLACE PROCEDURE List_Staff_With_More_Leave
IS
BEGIN
FOR staff_rec IN (
SELECT s.Staff_id, s.Staff_Name, COUNT(l.Type) AS Total_Leaves
FROM Staff s
JOIN Leave_Avail l ON s.Staff_id = l.Staff_id
GROUP BY s.Staff_id, s.Staff_Name
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
EXEC List_Staff_With_More_Leave;

----------------------------------------------------------------------
