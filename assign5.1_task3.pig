-- Query 3:
/*
Employee (employee id and employee name) with maximum expense. (In case two employees have same expense, employee with name coming first in dictionary should get preference).
*/


-- Solution to above query is as follows:

-- Line 1
emp_details = LOAD '/home/acadgild/Documents/pig/employee_details.txt' USING PigStorage(',') AS (id:int,name:chararray,salary:long,rating:int);
-- Line 2
emp_expenses = LOAD '/home/acadgild/Documents/pig/employee_expenses.txt' AS (id:int,expense:int);
-- Line 3
groupExpenses = GROUP emp_expenses BY id;
-- Line 4
sumOfExpenses = FOREACH groupExpenses GENERATE group as id,SUM(emp_expenses.expense) as expense;
-- Line 5
joinRelations = JOIN emp_details BY id,sumOfExpenses BY id;
-- Line 6
task3_result = FOREACH (LIMIT (ORDER joinRelations BY sumOfExpenses::expense DESC,emp_details::name ASC) 1) GENERATE emp_details::id,emp_details::name;
-- Line 7
DUMP task3_result;


/* Explanation:
Line 1: LOAD command loads employee_details.txt file where fields are delimited by ',' in emp_details relation in pig
Line 2: LOAD command loads employee_expenses.txt file where fields are delimited by '\t' in emp_expenses relation in pig
Line 3: GROUP operator groups emp_expenses by id and stores the result in groupExpenses.
Using DUMP and DESCRIBE on groupExpenses relation, we can see the result as below:
--DUMP groupExpenses;
(101,{(101,100),(101,200)})
(102,{(102,400),(102,100)})
(104,{(104,300)})
(105,{(105,100)})
(110,{(110,400)})
(114,{(114,200)})
(119,{(119,200)})
--DESCRIBE groupExpenses;
groupExpenses: {group: int,emp_expenses: {(id: int,expense: int)}}

LINE 4: FOREACH operator works on each row of groupExpenses relation and generates group i.e. id and sum of expenses inside each bag. Using DUMP and describe on sumOfExpenses relation, we can see the result as follows:
--DUMP sumOfExpenses;
(101,300)
(102,500)
(104,300)
(105,100)
(110,400)
(114,200)
(119,200)
--DESCRIBE sumOfExpenses;
sumOfExpenses: {id: int,expense: long}

Line 5: JOIN operator joins emp_details and sumOfExpenses relations by their common id's and stores the result in joinRelations. Using DUMP and describe on joinRelations, we can see the result as follows:
--DUMP joinRelations;
(101,Amitabh,20000,1,101,300)
(102,Shahrukh,10000,2,102,500)
(104,Anubhav,5000,4,104,300)
(105,Pawan,2500,5,105,100)
(110,Priyanka,2000,5,110,400)
(114,Madhuri,2000,2,114,200)
--DESCRIBE joinRelations;
joinRelations: {emp_details::id: int,emp_details::name: chararray,emp_details::salary: long,emp_details::rating: int,sumOfExpenses::id: int,sumOfExpenses::expense: long}

Line 6:
-> First of all ORDER BY operator orders expense and name fields in desc and asc way
-> LIMIT operator then limits the ordered row to 1 only
-> FOREACH takes limited relation as input and generates id and name. 
Using DUMP and describe on task3_result, we can see the result as follows:
--DUMP task3_result;
(102,Shahrukh)
--DESCRIBE task3_result;
task3_result: {emp_details::id: int,emp_details::name: chararray}

Line 7: DUMP displays data inside task3_result
*/


