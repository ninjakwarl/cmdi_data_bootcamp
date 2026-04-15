SELECT 
    e.emp_name AS Employee_Name,
    d.dept_name AS Department_Name,
    p.project_name AS Project_Name
FROM 
    employees e
JOIN 
    departments d ON e.dept_id = d.dept_id
JOIN 
    employee_projects ep ON e.emp_id = ep.emp_id
JOIN 
    projects p ON ep.project_id = p.project_id;
