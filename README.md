This repository contains a collection of queries and PL/SQL code that can be used for various database-related tasks. Whether you're a beginner looking to learn SQL or an experienced developer working on database projects, you'll find useful code snippets and queries here.

Questions:

(1) 
-------------------------------------------------------------------------
Course_Offering Table : Course_No, Year, Semester, Section, Instructor
Marks Table : Student_id, Score, Grade

Query : Find the number of students in each grade.

Procedure : To list the courses conducted , along with the instructors handled
for the year 2005.
-------------------------------------------------------------------------

(2)
-------------------------------------------------------------------------
Course_Offering Table : Course_No, Year, Semester, Section, Instructor
Marks Table : Student_id, Score, Grade

Query : List the minimum, maximum & average score secured by the students.

View : To list the courses conducted, along with the instructors handled
for the year 2005.
-------------------------------------------------------------------------

(3)
-------------------------------------------------------------------------
Staff Table : Staff_id, Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, Leave_Type (CL / ML /OD )

Query : List the staff details who has availed more leave (including all leave)

Procedure : To compute and display the staff list for whom the leave has
exhausted. ( CL (2) , ML (3) , OD (1) per month )
-------------------------------------------------------------------------

(4)
-------------------------------------------------------------------------
Staff Table : Staff_id , Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, No_Days, Type ( CL / ML /OD )

Query : Find the number of OD availed by the specified staff.

Procedure : To list the staff members who have availed more leave( including all leave).
-------------------------------------------------------------------------

(5)
-------------------------------------------------------------------------
Staff Table : Staff_id , Staff_Name
Leave_Avail Table : Staff_id, Avail_Date, No_Days, Type ( CL / ML /OD )

Query : Find the staff who has availed maximum OD leave.

Trigger : To restrict the CL to maximum 12 days.
-------------------------------------------------------------------------
