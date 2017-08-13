-- Query 1:
/*
Top 5 employees (employee id and employee name) with highest rating. (In case two employees have same rating, employee with name coming first in dictionary should get preference).
*/

-- First way to solve query, Uncomment (remove /* and */) the below five lines to see the execution
/*
-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
orderEmpDetails = ORDER emp_details BY rating DESC,name ASC;
-- Line 3
limitTuples = LIMIT orderEmpDetails 5;
-- Line 4
task1_result = FOREACH limitTuples GENERATE id,name;
-- Line 5
DUMP task1_result;
*/

/* Explanation:

Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig

Line 2: ORDER BY operator works on rating and name fields of emp_details relation, in desc and asc orders respectively, and result is stored in orderEmpDetails relation

Line 3: LIMIT operator limits tuples of orderEmpDetails to 5 and result is stored in limitTuples relation

Line 4: FOREACH operator words on limitTuples relation and generates id and name of employees and stores the result in task1_result relation

LINE 5: DUMP command dumps the data inside task1_result

*/


--************************************************************************************************

-- Second way to execute query is 

-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
task1_result = FOREACH (LIMIT (ORDER emp_details BY rating DESC,name ASC) 5) GENERATE id,name;
-- Line 3
DUMP task1_result;


/* Explanation:
Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig

Line 2: 
-> First of all ORDER BY operator works on rating and name fields of emp_details relation, in desc and asc orders respectively
-> LIMIT operator limits the tuples/rows of ordered relation to 5
-> FOREACH operator takes limited tuples from LIMIT operator and generates id and name of employees
-> finally the result is stored in task1_result relation

LINE 3: DUMP command dumps the data inside task1_result
*/



