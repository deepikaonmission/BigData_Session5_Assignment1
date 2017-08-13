-- Query 4:
/*
List of employees (employee id and employee name) having entries in employee_expenses file.
*/


-- Solution to above query is as follows:

-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
emp_expenses = LOAD '/home/acadgild/Documents/pig/employee_expenses.txt' AS (id:int,expense:int);
-- Line 3
joinRelations = JOIN emp_details BY id,emp_expenses BY id;
-- Line 4
task4_result = DISTINCT (FOREACH joinRelations GENERATE emp_details::id,emp_details::name);
-- Line 5
DUMP task4_result;


/* Explanation:
Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig
Line 2: LOAD command loads employee_expenses.txt file where fields are delimited by '\t' in emp_expenses relation in pig
Line 3: JOIN operator joins emp_details and emp_expenses relations by their common id's and stores the result in joinRelations.
Line 4:
-> FOREACH generates id and name of emp_details bag inside joinRelations
-> DISTINCT takes input from FOREACH and finds only distinct rows
-> final result is stored in task4_result
Line 5: DUMP displays data inside task4_result
*/
