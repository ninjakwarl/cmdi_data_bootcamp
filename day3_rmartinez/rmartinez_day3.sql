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


Task 1: Multi-table JOIN
SELECT 
    e.emp_name AS "Employee Name",
    d.dept_name AS "Department Name",
    p.project_name AS "Project Name"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.emp_name;

Task 2: Aggregation + JOIN
SELECT 
    d.dept_name AS "Department Name",
    COUNT(e.emp_id) AS "Total Employees"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

Task 3: Advanced Query
SELECT 
    d.dept_name AS "Department",
    ROUND(AVG(e.salary), 0) AS "Average Salary",
    COUNT(DISTINCT ep.project_id) AS "Total Projects handled"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

Task 4: CONCAT + Filtering
SELECT 
    CONCAT(e.emp_name, ' - ', d.dept_name) AS "Employee - Department"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_name;



PART 3: DML OPERATIONS
-- Insert
INSERT INTO employees (emp_name, salary, dept_id)
VALUES ('NewEmployee', 48000, 1);

-- Insert
UPDATE employees
SET salary = 70000
WHERE emp_name = 'Karl';

-- Delete
DELETE FROM employees
WHERE emp_name = 'Mark';



PART 4: LOGICAL BACKUP & RESTORE
Step 1: Backup
pg_dump -U postgres -d company_db -f company_backup.sql


Step 2: Drop Database
DROP DATABASE company_db;

Step 3: Recreate
CREATE DATABASE company_db;

Step 4: Restore
psql -U postgres -d company_db -f company_backup.sql


Step 5: Verify
\dt
SELECT * FROM employees;

PART 5: PHYSICAL BACKUP
pg_basebackup -U postgres -D C:\backup_lab3 -Fp -Xs -P

PART 6: VACUUM & MAINTENANCE
VACUUM ANALYZE employees;

PART 7: 
SELECT 
    e.emp_name AS "Employee Name",
    d.dept_name AS "Department",
    COUNT(ep.project_id) AS "Total Projects",
    RANK() OVER (ORDER BY e.salary DESC) AS "Rank by Salary"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.emp_name, e.salary, d.dept_name
ORDER BY "Rank by Salary";

