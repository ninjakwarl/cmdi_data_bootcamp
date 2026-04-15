PART 1: DATABASE SETUP
CREATE DATABASE company_db;

\c company_db

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100)
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMERIC,
    dept_id INT
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT
);

CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT
);


INSERT INTO departments (dept_name)
VALUES ('IT'), ('HR'), ('Finance'), ('Marketing');

INSERT INTO employees (emp_name, salary, dept_id)
VALUES
('Karl', 50000, 1),
('Ana', 45000, 2),
('John', 60000, 1),
('Lisa', 55000, 3),
('Mark', 40000, 4);

INSERT INTO projects (project_name, dept_id)
VALUES
('System Upgrade', 1),
('Recruitment Drive', 2),
('Budget Planning', 3),
('Ad Campaign', 4);

INSERT INTO employee_projects
VALUES
(1,1),(1,2),(2,2),(3,1),(4,3),(5,4);


PART 2: COMPLEX SQL QUERIES
SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;

SELECT d.dept_name AS Department_Name,
COUNT(e.emp_id) AS Total_Employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name

SELECT d.dept_name AS Department_Name,
ROUND(AVG(e.salary) AS average_salary,
COUNT(DISTINCT ep.project_id) AS total_projects_handled
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY d.dept_name;

SELECT CONCAT(e.emp_name, ' - ', d.dept_name) AS "employee_department"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id


PART 3: DML OPERATIONS
INSERT INTO employees (emp_name, salary, dept_id)
VALUES ('NewEmployee', 48000, 1);

UPDATE employees
SET salary = 70000
WHERE emp_name = 'Karl';

DELETE FROM employees
WHERE emp_name = 'Mark';

PART 4: LOGICAL BACKUP
& RESTORE

pg_dump -U postgres -d company_db -f company_backup.sql

DROP DATABASE company_db;

CREATE DATABASE company_db;

psql -U postgres -d company_db -f company_backup.sql

Step 5: Verify

\dt

SELECT * FROM employees;

PART 5: PHYSICAL BACKUP

pg_basebackup -h 127.0.0.1 -U postgres -D "/mnt/c/Program Files/PostgreSQL/17/backup_lab3" -Fp -Xs -P

PART 6: VACUUM &
MAINTENANCE

VACUUM ANALYZE employees;

PART 7:

SELECT
e.emp_name AS Employee_Name,
d.dept_name AS Department,
COUNT(DISTINCT ep.project_id) AS Total_Projects,
RANK() OVER (ORDER BY e.salary DESC) AS Salary_Rank
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_name, d.dept_name, e.salary
ORDER BY Salary_Rank;