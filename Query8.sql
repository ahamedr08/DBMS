-------------------------------------------------------------------------
Instructor Table : Instructor_id, Instructor _Name, Department, Subject_Name
Marks Table : Student_id, Score, Grade

Query : To view the instructors who have been allotted more than two courses.

Procedure : To calculate a grade for each student and display the report course wise.
-------------------------------------------------------------------------

-- Create Instructor table
CREATE TABLE Instructors (
Instructor_id INT,
Instructor_Name VARCHAR(50),
Department VARCHAR(50),
Subject_Name VARCHAR(50)
);

-- Create Marks table
CREATE TABLE Marks (
Student_id INT,
Score INT,
Grade VARCHAR(2)
);

-- Insert sample records into Instructor table
INSERT INTO Instructors VALUES (1, 'John Doe', 'Mathematics', 'Algebra');
INSERT INTO Instructors VALUES (1, 'John Doe', 'Mathematics', 'Al');
INSERT INTO Instructors VALUES (1, 'John Doe', 'Mathematics', 'l');
INSERT INTO Instructors VALUES (2, 'Jane Smith', 'Science', 'Physics');
INSERT INTO Instructors VALUES (3, 'Mike Johnson', 'English', 'Literature');
INSERT INTO Instructors VALUES (4, 'Sarah Brown', 'Computer Science', 'Programming');
INSERT INTO Instructors VALUES (5, 'David Wilson', 'History', 'World History');

-- Insert sample records into Marks table
INSERT INTO Marks VALUES (1, 80, 'A');
INSERT INTO Marks VALUES (2, 75, 'B');
INSERT INTO Marks VALUES (3, 90, 'A');
INSERT INTO Marks VALUES (4, 85, 'B');
INSERT INTO Marks VALUES (5, 95, 'A');
INSERT INTO Marks VALUES (6, 70, 'C');
INSERT INTO Marks VALUES (7, 85, 'B');
INSERT INTO Marks VALUES (8, 90, 'A');
INSERT INTO Marks VALUES (9, 80, 'A');
INSERT INTO Marks VALUES (10, 65, 'D');

---------------------------------QUERY---------------------------------

SELECT Instructor_id, Instructor_Name
FROM Instructors
GROUP BY Instructor_id, Instructor_Name
HAVING COUNT(*) > 2;

----------------------------------------------------------------------
-------------------------------PROCEDURE------------------------------

CREATE OR REPLACE PROCEDURE CalculateGrades
IS
BEGIN
FOR course_rec IN (SELECT DISTINCT Subject_Name FROM Instructor)
LOOP
DBMS_OUTPUT.PUT_LINE('Course: ' || course_rec.Subject_Name);
DBMS_OUTPUT.PUT_LINE('-----------------------------');
FOR student_rec IN (SELECT m.Student_id, m.Score, m.Grade, i.Instructor_Name
FROM Marks m
JOIN Instructor i ON m.Student_id = i.Instructor_id
WHERE i.Subject_Name = course_rec.Subject_Name)
LOOP
DBMS_OUTPUT.PUT_LINE('Student ID: ' || student_rec.Student_id);
DBMS_OUTPUT.PUT_LINE('Student Name: ' || student_rec.Instructor_Name);
DBMS_OUTPUT.PUT_LINE('Score: ' || student_rec.Score);
DBMS_OUTPUT.PUT_LINE('Grade: ' || student_rec.Grade);
DBMS_OUTPUT.PUT_LINE('-----------------------------');
END LOOP;
DBMS_OUTPUT.NEW_LINE;
END LOOP;
END;

----------------------------------------------------------------------
---------------------- PROCEDURE EXECUTION-----------------------------

SET SERVEROUTPUT ON;
BEGIN
CalculateGrades;
END;

----------------------------------------------------------------------