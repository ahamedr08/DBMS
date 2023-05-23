-------------------------------------------------------------------------
Staff Table : Staff_id , Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, No_Days, Type ( CL / ML /OD )

Query : Find the staff who has availed maximum OD leave.

Trigger : To restrict the CL to maximum 12 days.
-------------------------------------------------------------------------

-- Create Staff table
CREATE TABLE Staff(
Staff_id INT,
Staff_Name VARCHAR(50),
PRIMARY KEY (Staff_id)
);

-- Create Leave_Avail table
CREATE TABLE Leave_Avail (
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

SELECT Staff_id, Staff_Name, ODCount
FROM (
SELECT s.Staff_id, s.Staff_Name, COUNT(*) AS ODCount, RANK() OVER (ORDER BY
COUNT(*) DESC) AS Rank
FROM Staff s
JOIN Leave_Avail l ON s.Staff_id = l.Staff_id
WHERE l.Type = 'OD'
GROUP BY s.Staff_id, s.Staff_Name
)
WHERE Rank = 1;

----------------------------------------------------------------------
-------------------------------TRIGGER------------------------------

CREATE OR REPLACE TRIGGER Restrict_CL_Leave
BEFORE INSERT ON Leave_Avail
FOR EACH ROW
DECLARE
cl_count INT;
BEGIN
IF :NEW.Type = 'CL' THEN
SELECT COUNT(*) INTO cl_count
FROM Leave_Avail
WHERE Type = 'CL' AND Staff_id = :NEW.Staff_id;
IF cl_count >= 2 THEN
RAISE_APPLICATION_ERROR(-20001, 'CL leaves have reached the maximum limit of
2 days.');
END IF;
END IF;
END;

----------------------------------------------------------------------
------------------------TRIGGER EXECUTION---------------------------

INSERT INTO Leave_Avail VALUES (1, '09-08-2023',1, 'CL');

----------------------------------------------------------------------