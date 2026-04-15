Day 3 activity

Task 1: Multi-table JOIN

Show:

Employee Name
Department Name
Project Name

SELECT
e.emp_name AS employee_name,
d.dept_name AS department_name,
p.project_name AS project_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;


Task 2: Aggregation + JOIN

Show total employees per department	

SELECT
d.dept_name,
COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


Task 3: Advanced Query

Show:

Department
Average Salary
Total Projects handled

SELECT
d.dept_name AS department,
AVG(e.salary) AS average_salary,
COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name;


Task 4: CONCAT + Filtering

Show:

"Employee - Department" 

SELECT
e.emp_name || ' - ' || d.dept_name AS employee_department
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;


PART 3: DML OPERATIONS

Task:

Insert new employee
Update salary of one employee
Delete one employee

INSERT INTO employees (emp_name, salary, dept_id)
VALUES ('NewEmployee', 48000, 1);
INSERT 0 1
UPDATE employees
SET salary = 70000
WHERE emp_name = 'Karl';
UPDATE 1
DELETE FROM employees
WHERE emp_name = 'Mark';
DELETE 1

PART 4: LOGICAL BACKUP
& RESTORE

Step 1: Backup
pg_dump -U postgres -d company_db -f company_backup.sql


Step 2: Drop Database
DROP DATABASE company_db;

Step 3: Recreate
CREATE DATABASE company_db;

Step 4: Restore
psql -U postgres -d company_db -f company_backup.sql


PART 5: PHYSICAL BACKUP
Task:
Run:
pg_basebackup -U postgres -D C:\backup_lab3 -Fp -Xs -P


PART 6: VACUUM &
MAINTENANCE
VACUUM ANALYZE employees;


PART 7:

Task:
Show:
Employee Name
Department
Total Projects
Rank by Salary

SELECT
e.emp_name AS employee_name,
d.dept_name AS department,
COUNT(ep.project_id) AS total_projects,
RANK() OVER (ORDER BY e.salary DESC) AS salary_rank
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.emp_name, d.dept_name, e.salary;
