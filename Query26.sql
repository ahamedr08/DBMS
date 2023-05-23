-------------------------------------------------------------------------

SCHEMA STRUCTURE:

STUDENT (StudentID, StudentName, Age, Grade)
COURSE (CourseID, CourseName, Credits)
ENROLLMENT (EnrollmentID, StudentID, CourseID, Semester)

QUERIES:

1. Count the number of students enrolled in each course.
2. Calculate the average age of all students.
3. Retrieve the course names along with the total number of credits for each course.
4. Get the names of students who have not enrolled in any course.

-------------------------------------------------------------------------

-- To count the number of students enrolled in each course

SELECT CourseID, COUNT(StudentID) AS NUMBER_OF_STUDENTS_ENROLLED
FROM ENROLLMENT
GROUP BY CourseID;

-- To calculate the average age of all students

SELECT AVG(Age) AS AVERAGE_AGE
FROM STUDENT;

-- To retrieve the course names along with the total number of credits for each course

SELECT c.CourseName, SUM(Credits) AS TOTAL_CREDITS
FROM COURSE c
JOIN ENROLLMENT e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- To get the names of students who have not enrolled in any course

SELECT StudentName
FROM STUDENT
WHERE StudentID NOT IN (SELECT StudentID FROM ENROLLMENT);