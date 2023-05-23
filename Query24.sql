-------------------------------------------------------------------------

SCHEMA STRUCTURE:

EMPLOYEE (EmpID, EmpName, Department, Salary)
PROJECT (ProjectID, ProjectName, StartDate, EndDate)
TASK (TaskID, TaskDescription, ProjectID)
EMPLOYEE_TASK (EmpID, TaskID, HoursWorked)

QUERIES:

1. Display the names of all employees in the "IT" department.
2. Find the project with the highest number of tasks.
3. Find the average salary of employees in each department.
4. Display the total number of hours worked by each employee.
5. Find the employees who have worked on multiple projects.

-------------------------------------------------------------------------

-- To display the names of all employees in the "IT" department.

SELECT EmpName FROM EMPLOYEE WHERE Department = 'IT';

-- To find the project with the highest number of tasks.

SELECT ProjectID, ProjectName, COUNT(*) AS TaskCount
FROM TASK
GROUP BY ProjectID, ProjectName
ORDER BY TaskCount DESC
FETCH FIRST 1 ROW ONLY;

-- To find the average salary of employees in each department.

SELECT Department, AVG(Salary) AS AverageSalary
FROM EMPLOYEE
GROUP BY Department;

-- To display the total number of hours worked by each employee.

SELECT EmpID, SUM(HoursWorked) AS TotalHoursWorked
FROM EMPLOYEE_TASK
GROUP BY EmpID;

-- To find the employees who have worked on multiple projects.

SELECT EmpID, COUNT(DISTINCT ProjectID) AS ProjectCount
FROM EMPLOYEE_TASK
GROUP BY EmpID
HAVING ProjectCount > 1;