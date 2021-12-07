-- Query Tables
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM impending_retirement;

DROP impending_retirement CASCADE;

-- DELIVERABLE 1
-- Organize a database to capture the details of upcoming retirees
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO impending_retirement
FROM employees AS e
INNER JOIN titles AS t 
	ON e.emp_no = t.emp_no
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;