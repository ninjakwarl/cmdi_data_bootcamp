--Part 1
CREATE DATABASE company_db;

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

--Part 2
--Task 1: Multi-table join
SELECT 
    e.emp_name AS employee_name,
    d.dept_name AS department_name,
    p.project_name AS project_name
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
JOIN projects p 
    ON ep.project_id = p.project_id;
	
--Task 2: Show total employees per department
SELECT 
    d.dept_name AS department_name,
    COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e 
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY d.dept_name;

--Task 3: Advanced query
SELECT 
    d.dept_name AS department,
    AVG(e.salary) AS average_salary,
    COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e 
    ON d.dept_id = e.dept_id
LEFT JOIN projects p 
    ON d.dept_id = p.dept_id
GROUP BY d.dept_name
ORDER BY d.dept_name;

--Task 4: Concat + Filtering
SELECT 
    CONCAT(e.emp_name, ' - ', d.dept_name) AS employee_department
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id;

--Part 3
--insert
INSERT INTO employees (emp_name, salary, dept_id)
VALUES ('NewEmployee', 48000, 1);

--update
UPDATE employees
SET salary = 70000
WHERE emp_name = 'Karl';

--delete
DELETE FROM employees
WHERE emp_name = 'Mark';

--Part 4
--Backup database
--pg_dump -U postgres -d company_db -f company_backup.sql

--Drop database
DROP DATABASE company_db;

--Create database
CREATE DATABASE company_db;

--Restore
--psql -U postgres -d company_db -f company_backup.sql

--Part 5
--Pg_baseback
--pg_basebackup -U postgres -D C:\Users\j.tan\Documents\backup\backup -Fp -Xs -P

--Part 6
VACUUM ANALYZE employees;

--Part 7
SELECT 
    e.emp_name AS employee_name,
    d.dept_name AS department,
    COUNT(ep.project_id) AS total_projects,
    RANK() OVER (ORDER BY e.salary DESC) AS salary_rank
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
GROUP BY 
    e.emp_id, e.emp_name, d.dept_name, e.salary
ORDER BY salary_rank;



