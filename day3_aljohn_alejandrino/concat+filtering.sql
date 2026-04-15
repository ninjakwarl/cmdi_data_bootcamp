SELECT 
    CONCAT(e.emp_name, ' - ', d.dept_name) AS "Employee - Department"
FROM 
    employees e
JOIN 
    departments d ON e.dept_id = d.dept_id
WHERE 
    e.salary > 45000;
