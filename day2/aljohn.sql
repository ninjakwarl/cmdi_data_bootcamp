SELECT
    UPPER(CONCAT(s.first_name, ' ', s.last_name)) AS full_name,
    STRING_AGG(CONCAT(c.course_name, ' - ', d.department_name), ', ') AS course_department,
    COUNT(e.course_id) AS number_of_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.department_id = d.department_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1;