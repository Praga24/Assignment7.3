Loading Data


emp_det = LOAD '/home/acadgild/Downloads/employee_details.txt' USING PigStorage(',') AS (id:int, name:chararray, salary:int, rating:int);

emp_exp = LOAD '/home/acadgild/Downloads/employee_expenses.txt' USING PigStorage('\t') AS (id:int, expenses:int);


1. Top 5 employees (employee id and employee name) with highest rating. (In case two
employees have same rating, employee with name coming first in dictionary should get
preference) 

emp_order = order emp_det by rating desc, name asc;
lim = limit emp_order 5;
emp = foreach lim generate id, name;
dump emp;

2. Top 3 employees (employee id and employee name) with highest salary, whose employee id
is an odd number. (In case two employees have same salary, employee with name coming first
in dictionary should get preference) 

emp_fil = filter emp_det by (id % 2) != 0;
emp1_order = order emp_fil by salary desc;
lim1 = limit emp1_order 3;
emp1 = foreach lim1 generate id, name;
dump emp1;

3. Employee (employee id and employee name) with maximum expense (In case two
employees have same expense, employee with name coming first in dictionary should get
preference) 

emp_join1 = join emp_det by id, emp_exp by id;
emp2_order = order emp_join1 by expenses desc, name asc;
lim2 = limit emp2_order 1;
emp2 = foreach lim2 generate $0,$1;
dump emp2;

4. List of employees (employee id and employee name) having entries in employee_expenses
file. 

emp_join2 = join emp_det by id, emp_exp by id;
emp3 = foreach emp_join2 generate $0,$1;
distnct = distinct emp3;
dump distnct;

5.List of employees (employee id and employee name) having no entry in employee_expenses
file. 

emp_join3 = join emp_det by id left outer, emp_exp by id;
emp4_fil = filter emp_join3 by $4 is null and $5 is null;
emp4 = foreach emp4_fil generate $0,$1;
distnct1 = distinct emp4;
dump distnct1;
