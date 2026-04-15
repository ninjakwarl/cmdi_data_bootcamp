SELECT
UPPER(s.first_name || ' ' || s.last_name) AS full_name,
c.course_name || ' - ' || c.department AS course_department,
sub.total_courses
FROM students s
JOIN (
SELECT student_id, COUNT(course_id) AS total_courses
FROM enrollments
GROUP BY student_id
HAVING COUNT(course_id) > 1
) sub ON s.student_id = sub.student_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;