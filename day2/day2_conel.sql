Create a query that:
Shows FULL NAME (UPPERCASE) 

1. Combine Name and uppercase it
SELECT UPPER(first_name || ' ' || last_name) AS full_name_uppercase
FROM students;


Shows COURSE + DEPARTMENT combined

SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id IS NULL;

Shows number of courses per student 


SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY total_courses DESC;


Only include students enrolled in more than 1 course

SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1;