-- Query Tables
-- DELIVERABLE 1
-- Organize a database to capture the details of upcoming retirees
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO impending_retirement -- Export as csv
FROM employees AS e
INNER JOIN titles AS t 
	ON e.emp_no = t.emp_no
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Make a table to hold a list of the employees who are retiring by title
SELECT DISTINCT ON (ir.emp_no)
	ir.emp_no,
	ir.first_name,
	ir.last_name,
	ir.title
INTO unique_titles -- Export as csv
FROM impending_retirement as ir
ORDER BY ir.emp_no, ir.to_date DESC;

-- Retrieve the number of employees who are retiring by title and count the number of titles
SELECT COUNT(ut.title),
	ut.title
INTO retiring_titles -- Export as csv
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY COUNT (ut.title) DESC;


-- Deliverable 2
-- Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_program -- Export as csv
FROM employees as e
INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (de.to_date = ('9999-01-01')) 
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;