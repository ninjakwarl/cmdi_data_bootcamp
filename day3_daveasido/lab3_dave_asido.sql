-- Show: Employee Name, Department Name, Project Name

SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.dept_id = p.dept_id;

-- Show total employees per department.

SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Show: Department, Average Salary, Total Projects handled

SELECT 
    d.dept_name,
    AVG(e.salary) AS average_salary,
    COUNT(p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
LEFT JOIN projects p
    ON d.dept_id = p.dept_id
GROUP BY d.dept_name;

-- Show: “Employee - Department" 

SELECT
CONCAT(e.emp_name, '-' ,d.dept_name) AS employee_department
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- Show: Employee Name, Department, Total Projects, Rank by Salary

SELECT
    e.emp_name,
    d.dept_name,
    COUNT(ep.project_id) AS total_projects,
    e.salary
FROM employees e
LEFT JOIN departments d 
    ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
GROUP BY e.emp_name, d.dept_name, e.salary
ORDER BY e.salary DESC;
