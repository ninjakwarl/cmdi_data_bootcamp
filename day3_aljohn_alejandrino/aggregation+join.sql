SELECT 
    d.dept_name AS Department_Name,
    COUNT(e.emp_id) AS Total_Employees
FROM 
    departments d
LEFT JOIN 
    employees e ON d.dept_id = e.dept_id
GROUP BY 
    D.dept_name;
