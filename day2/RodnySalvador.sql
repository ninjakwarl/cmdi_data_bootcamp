SELECT
    UPPER(CONCAT(s.first_name, ' ', s.last_name)) AS full_name,
    CONCAT(c.course_name, ' - ', c.department) AS course_department,
    COUNT(e.course_id) OVER (PARTITION BY s.student_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id IN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) > 1
);