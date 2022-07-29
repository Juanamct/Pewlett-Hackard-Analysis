-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no)e.emp_no,
e.first_name,
e.last_name,
tl.title,
tl.from_date,
tl.to_date

--INTO retirement_title
FROM employees as e
JOIN titles as tl
ON (tl.emp_no = e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, e.emp_no DESC;
