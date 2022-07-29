-- Create # of Retiring Employees by Title

-- 1. Create list (table) of # of retiring employees by title
-- a. Create a Retirement Titles table
SELECT 
e.emp_no,
e.first_name,
e.last_name,
tl.title,
tl.from_date,
tl.to_date

INTO retirement_title
FROM employees as e
LEFT JOIN titles as tl
ON (tl.emp_no = e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no

-- b. Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_title as rt
WHERE rt.to_date=('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- c/ Retrieve # of employees about to retire by their most recent job title
SELECT COUNT(u.title), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY COUNT DESC;


-- 2. Create list (table) of mentorship eligible employees

SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
tl.title

INTO mentorship_eligible
FROM employees as e
LEFT JOIN dept_emp as de
on (de.emp_no = e.emp_no)
LEFT JOIN titles as tl
ON (tl.emp_no = e.emp_no)
WHERE de.to_date=('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- c/ Retrieve # of employees eligible for mentorship by their most recent job title
SELECT COUNT(me.title), me.title
--INTO Mentor_eligible_count
FROM mentorship_eligible as me
GROUP BY me.title
ORDER BY COUNT DESC;


-- 3. ANALYSIS queries
-- # of retirement employees
SELECT COUNT (u.title)
FROM unique_titles as u
ORDER BY COUNT;

-- # of mentorship eligible employees
SELECT COUNT (me.title)
FROM mentorship_eligible as me
ORDER BY COUNT;


-- 2. ADJUSTED list (table) of mentorship eligible employees 
--    (changed age requirement to born between 1962 & 1968)

SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
tl.title

INTO mentorship_eligible2
FROM employees as e
LEFT JOIN dept_emp as de
on (de.emp_no = e.emp_no)
LEFT JOIN titles as tl
ON (tl.emp_no = e.emp_no)
WHERE de.to_date=('9999-01-01')
AND (e.birth_date BETWEEN '1962-01-01' AND '1968-12-31')
ORDER BY e.emp_no;

-- c/ Retrieve # of employees eligible2 for mentorship by their most recent job title
SELECT COUNT(me.title), me.title
--INTO Mentor_eligible_count2
FROM mentorship_eligible2 as me
GROUP BY me.title
ORDER BY COUNT DESC;

-- # of mentorship eligible2 employees
SELECT COUNT (me.title)
FROM mentorship_eligible2 as me
ORDER BY COUNT;


-- TOTAL Employees by title
SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
tl.to_date,
tl.title

INTO Curr_emp_title
FROM employees as e
LEFT JOIN titles as tl
on (tl.emp_no = e.emp_no)
WHERE tl.to_date=('9999-01-01')
ORDER BY e.emp_no; 

-- c/ Retrieve # of current employees by their most recent job title
SELECT COUNT(cet.title), cet.title
--INTO count_curr_emp_title
FROM curr_emp_title as cet
GROUP BY cet.title
ORDER BY COUNT DESC;

-- # of current employees
SELECT COUNT (cet.title)
FROM curr_emp_title as cet
ORDER BY COUNT;