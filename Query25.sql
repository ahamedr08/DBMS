-------------------------------------------------------------------------

SCHEMA STRUCTURE:

STUDENT (StudentID, StudentName, Age, Grade)
COURSE (CourseID, CourseName, Credits)
ENROLLMENT (StudentID, CourseID, Semester, Grade)
INSTRUCTOR (InstructorID, InstructorName, Department)

QUERIES:

1. Display the names of all courses and the number of students enrolled in each course.
2. Find the students who have achieved the highest grade in any course.
3. Display the names of instructors and the number of courses they are teaching.

-------------------------------------------------------------------------

-- To display the names of all courses and the number of students enrolled in each course.

SELECT CourseName, COUNT(*) AS EnrollmentCount
FROM ENROLLMENT
JOIN COURSE ON ENROLLMENT.CourseID = COURSE.CourseID
GROUP BY CourseName;

-- To find the students who have achieved the highest grade in any course.

SELECT StudentName, Grade
FROM ENROLLMENT
JOIN STUDENT ON ENROLLMENT.StudentID = STUDENT.StudentID
WHERE Grade = (SELECT MAX(Grade) FROM ENROLLMENT);

-- To display the names of instructors and the number of courses they are teaching.

SELECT InstructorName, COUNT(*) AS CourseCount
FROM INSTRUCTOR
JOIN COURSE ON INSTRUCTOR.InstructorID = COURSE.InstructorID
GROUP BY InstructorName;
