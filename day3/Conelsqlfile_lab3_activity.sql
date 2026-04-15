Task 1: Multi-table JOIN

SELECT 
    e.emp_name AS "Employee Name", 
    d.dept_name AS "Department Name", 
    p.project_name AS "Project Name"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN projects p ON d.dept_id = p.dept_id;


Task 2: Aggregation + JOIN


Show total employees
per department

SELECT 
    d.dept_name AS "Department", 
    COUNT(e.emp_id) AS "Total Employees"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY "Total Employees" DESC;


Task 3: Advanced Query
Show:

Department
Average
Salary
Total
Projects handled

SELECT 
    d.dept_name AS "Department", 
    ROUND(AVG(e.salary), 2) AS "Average Salary", 
    COUNT(DISTINCT p.project_id) AS "Total Projects Handled"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name; 

Task 4: CONCAT + Filtering


Show:

"Employee
- Department" 

SELECT 
    e.emp_name || ' - ' || d.dept_name AS "Employee - Department"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name ASC, e.emp_name ASC;

