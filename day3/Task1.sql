SELECT 
    e.emp_name AS employee_name,
    d.dept_name AS department_name,
    p.project_name AS project_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;