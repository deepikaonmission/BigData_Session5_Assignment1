-- Query 5:
/*
List of employees (employee id and employee name) having no entry in employee_expenses file.
*/


-- Solution to above query is as follows:

-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
emp_expenses = LOAD '/home/acadgild/Documents/pig/employee_expenses.txt' AS (id:int,expense:int);
-- Line 3
joinRelations = JOIN emp_details BY id LEFT,emp_expenses BY id;
-- Line 4
filterJoin = FILTER joinRelations By emp_expenses::id is NULL;
-- Line 5
task5_result = FOREACH filterJoin GENERATE emp_details::id,emp_details::name;
-- Line 6
DUMP task5_result;


/* Explanation:
Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig
Line 2: LOAD command loads employee_expenses.txt file where fields are delimited by '\t' in emp_expenses relation in pig
Line 3: JOIN operator joins emp_details and emp_expenses relations by their common id's and stores the result in joinRelations.
Line 4: FLITER operator filters only those rows from joinRelations where id field of emp_expenses bag is NULL, result is then stored in filterJoin
Line 5: FOREACH generates id and name of emp_details bag inside filterJoin relation and result is then stored in task5_result
Line 6: DUMP displays data inside task5_result relation
*/
