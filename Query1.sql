-------------------------------------------------------------------------
Course_Offering Table : Course_No, Year, Semester, Section, Instructor
Marks Table : Student_id, Score, Grade

Query : Find the number of students in each grade.

Procedure : To list the courses conducted , along with the instructors handled
for the year 2005.
-------------------------------------------------------------------------
-- Creating the Course_Offering table
CREATE TABLE Course_Offering (
Course_No INT,
Year INT,
Semester VARCHAR(10)
Section VARCHAR(10),
Instructor VARCHAR(100)
);

-- Inserting sample records into the Course_Offering table
INSERT INTO Course_Offering VALUES (101, 2005, 'Spring', 'A', 'John Smith');
INSERT INTO Course_Offering VALUES (201, 2005, 'Spring', 'B', 'Jane Doe');
INSERT INTO Course_Offering VALUES (102, 2005, 'Fall', 'A', 'David Johnson');
INSERT INTO Course_Offering VALUES (202, 2005, 'Fall', 'B', 'Sarah Williams');
INSERT INTO Course_Offering VALUES (103, 2005, 'Spring', 'A', 'John Smith');
INSERT INTO Course_Offering VALUES (203, 2005, 'Spring', 'B', 'Jane Doe');

-- Creating the Marks table
CREATE TABLE Marks (
Student_id INT PRIMARY KEY,
Score INT,
Grade VARCHAR(2)
);

-- Inserting sample records into the Marks table
INSERT INTO Marks values(1, 85, 'A');
INSERT INTO Marks values (2, 76, 'B+');
INSERT INTO Marks values (3, 92, 'A');
INSERT INTO Marks values (4, 80, 'A-');
INSERT INTO Marks values(5, 62, 'C');
INSERT INTO Marks values(6, 88, 'A');
INSERT INTO Marks values(7, 79, 'B+');
INSERT INTO Marks values(8, 95, 'A+');
INSERT INTO Marks values(9, 70, 'B-');
INSERT INTO Marks values (10, 84, 'A-');
INSERT INTO Marks values (11, 91, 'A');
INSERT INTO Marks values(12, 68, 'C+');

-------------------------------QUERY---------------------------------

SELECT Grade, COUNT(*) AS Student_Count
FROM Marks
GROUP BY Grade;

----------------------------------------------------------------------
-------------------------------PROCEDURE------------------------------

CREATE OR REPLACE PROCEDURE ListCourses_Instructors(p_Year IN INT) IS
BEGIN
-- Declare a cursor to fetch the result set
DECLARE
CURSOR c_courses IS
SELECT Course_No, Year, Semester, Section, Instructor
FROM Course_Offering
WHERE Year = p_Year;
BEGIN
-- Loop through the result set and output each row
FOR course IN c_courses LOOP
DBMS_OUTPUT.PUT_LINE('Course No: ' || course.Course_No);
DBMS_OUTPUT.PUT_LINE('Year: ' || course.Year);
DBMS_OUTPUT.PUT_LINE('Semester: ' || course.Semester);
DBMS_OUTPUT.PUT_LINE('Section: ' || course.Section);
DBMS_OUTPUT.PUT_LINE('Instructor: ' || course.Instructor);
DBMS_OUTPUT.PUT_LINE('-----------------------------');
END LOOP;
END;
END;

----------------------------------------------------------------------
------------------------PROCEDURE EXECUTION---------------------------

SET SERVEROUTPUT ON;
BEGIN
ListCourses_Instructors(2005);
END;

----------------------------------------------------------------------