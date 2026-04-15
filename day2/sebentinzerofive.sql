SELECT
    UPPER(CONCAT(s.first_name, ' ', s.last_name)) AS full_name,
    STRING_AGG(c.course_name || ' - ' || c.department, ', ') AS courses_and_departments,
    COUNT(e.enrollment_id) AS number_of_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.enrollment_id) > 1;