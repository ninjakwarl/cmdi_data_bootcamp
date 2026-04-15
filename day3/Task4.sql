SELECT 
    CONCAT(e.emp_name, ' - ', d.dept_name) AS employee_department
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;