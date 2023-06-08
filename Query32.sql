--------------------------------------------------------------------------------------------------------------------------------------------------------
Taxes 

You are working on the Employees table, which stores the names and salaries of employees.
You need to calculate the taxes for the salaries and output them as a new column.
The tax percentage is based on the salary amount:

0 - 1500    : 10%
1501 - 2000 : 20%
2001+       : 30%

Output the firstname, lastname, salary and tax columns of the table, sorted by the lastname column in ascending order.

Hint: To calculate the percentage of a number, simply multiply it by the percentage divided by 100. For example, to get 10%, multiply the number by 0.1
--------------------------------------------------------------------------------------------------------------------------------------------------------
Solution :

SELECT firstname, lastname, salary,
CASE 
 WHEN salary >= 0 AND salary <= 1500 THEN salary*0.1
 WHEN salary >= 1501 AND salary <= 2000 THEN salary*0.2 
 ELSE salary*0.3
END AS tax
FROM Employees
ORDER BY lastname ASC

--------------------------------------------------------------------------------------------------------------------------------------------------------