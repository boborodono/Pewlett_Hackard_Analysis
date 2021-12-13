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

-- EXTRA QUERIES FOR SQL RESULTS
-- Total number of employees in each department
SELECT COUNT (e.emp_no),
	d.dept_name,
	de.dept_no, 
	de.to_date
INTO current_workers_by_dept
FROM employees as e
INNER JOIN dept_emp as de
	ON de.emp_no = e.emp_no
INNER JOIN departments as d
	ON d.dept_no = de.dept_no
WHERE (de.to_date = ('9999-01-01'))
GROUP BY d.dept_name, de.dept_no, de.to_date
ORDER BY d.dept_name;

-- Total number of potential retirees from each department
SELECT COUNT (ce.emp_no),
	d.dept_name,
	de.dept_no
INTO retires_by_dept
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
GROUP BY d.dept_name, de.dept_no
ORDER BY d.dept_name;