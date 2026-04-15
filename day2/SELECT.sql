Query 1

SELECT
s.first_name || ' ' || s.last_name AS full_name,
c.course_name || ' - ' || c.department AS course_department,
e.enrollment_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.age > 21
ORDER BY e.enrollment_date DESC;


Query 2

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