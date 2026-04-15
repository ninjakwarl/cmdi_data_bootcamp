SELECT 
    d.dept_name AS Department_Name,
    AVG(e.salary) AS Average_Salary,
    COUNT(DISTINCT ep.project_id) AS Total_Projects_Handled
FROM 
    departments d
JOIN 
    employees e ON d.dept_id = e.dept_id
LEFT JOIN 
    employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY 
    D.dept_name;
