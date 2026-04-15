SELECT 
    d.dept_name AS department,
    AVG(e.salary) FILTER (WHERE e.salary >= 50000) AS average_salary,
    COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e 
    ON d.dept_id = e.dept_id
LEFT JOIN projects p 
    ON d.dept_id = p.dept_id
GROUP BY d.dept_name
ORDER BY d.dept_name;
