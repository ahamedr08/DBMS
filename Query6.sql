-------------------------------------------------------------------------
Staff Table : Staff_id , Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, No_Days, Type ( CL / ML /OD )

Function : To calculate the leave availed ( including all leave) by each staff.

Procedure : To display the leave calculated and returned by the function.
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

-------------------------------FUNCTION---------------------------------

CREATE OR REPLACE FUNCTION CalculateLeaveAvailed(p_StaffId INT)
RETURN NUMBER
IS
v_TotalLeave NUMBER;
BEGIN
SELECT SUM(No_Days)
INTO v_TotalLeave
FROM Leave_Avail
WHERE Staff_id = p_StaffId;
RETURN v_TotalLeave;
END;

----------------------------------------------------------------------
-------------------------------PROCEDURE------------------------------

CREATE OR REPLACE PROCEDURE DisplayLeaveAvailed
IS
v_StaffId Staff.Staff_id%TYPE;
v_LeaveAvailed NUMBER;
BEGIN
FOR staff_rec IN (SELECT Staff_id FROM Staff)
LOOP
v_StaffId := staff_rec.Staff_id;
v_LeaveAvailed := CalculateLeaveAvailed(v_StaffId);
DBMS_OUTPUT.PUT_LINE('Staff ID: ' || v_StaffId || ', Leave Availed: ' ||
v_LeaveAvailed);
END LOOP;
END;

----------------------------------------------------------------------
--------------------------------EXECUTION-----------------------------

SET SERVEROUTPUT ON;
BEGIN
DisplayLeaveAvailed;
END;

----------------------------------------------------------------------