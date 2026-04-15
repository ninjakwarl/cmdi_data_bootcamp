SELECT 
e.emp_name AS employee_name,
d.dept_name AS department_name,
p.project_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;

SELECT 
d.dept_name,
COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT 
d.dept_name AS department,
AVG(e.salary) AS average_salary,
COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name;

SELECT 
CONCAT(e.emp_name, ' - ', d.dept_name) AS "Employee - Department"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

SELECT 
e.emp_name AS employee_name,
d.dept_name AS department,
COUNT(ep.project_id) AS total_projects,
RANK() OVER (ORDER BY e.salary DESC) AS salary_rank
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY 
e.emp_id, e.emp_name, d.dept_name, e.salary
ORDER BY salary_rank;
