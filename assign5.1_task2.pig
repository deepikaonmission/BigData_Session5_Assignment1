-- Query 2:
/*
Top 3 employees (employee id and employee name) with highest salary,whose employee id is an odd number. (In case two employees have same salary, employee with name coming first in dictionary should get preference).
*/


-- Solution to above query is as follows:

-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
task2_result = FOREACH (LIMIT (ORDER (FILTER emp_details BY (id%2!=0)) BY salary DESC,name ASC) 3) GENERATE id,name;
-- Line 3
DUMP task2_result;


/* Explanation:
Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig

Line 2: 
-> First of all FILTER operator filters only those tuples from emp_details relation where id is odd (i.e. id%2!=0)
-> then, ORDER BY operator works on rating and name fields of filtered relation, in desc and asc orders respectively
-> LIMIT operator takes ordered relation and limits the tuples/rows to 3
-> FOREACH operator takes limited tuples and generates id and name of employees
-> finally the result is stored in task2_result relation

LINE 3: DUMP command dumps the data inside task2_result relation
*/



