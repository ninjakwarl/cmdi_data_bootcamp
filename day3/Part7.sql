SELECT 
    e.emp_name AS employee_name,
    d.dept_name AS department,
    COUNT(ep.project_id) AS total_projects,
    RANK() OVER (ORDER BY e.salary DESC) AS salary_rank
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.emp_name, d.dept_name, e.salary
ORDER BY salary_rank;