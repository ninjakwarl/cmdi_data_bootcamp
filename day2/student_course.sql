SELECT 
    concat(upper(s.first_name), ' ', upper(s.last_name)) AS full_name,
    concat(c.course_name, ' ', c.department) AS course_department,
    sc.course_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN (
    SELECT student_id, COUNT(course_id) AS course_count
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) > 1
) sc ON s.student_id = sc.student_id
ORDER BY sc.course_count DESC, e.enrollment_date DESC;
