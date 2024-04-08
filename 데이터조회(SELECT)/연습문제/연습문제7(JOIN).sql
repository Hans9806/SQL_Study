-- JOIN
-- employees 데이터베이스에서 연습해보세요.
USE employees;
SELECT * FROM employees;
DESC employees;
-- employees(first_name, last_name, emp_no), titles(emp_no, title, to_date)
-- dept_emp(dept_no, emp_no, to_date), salaries(emp_no, salary, to_date)
-- departments(dept_no, dept_name)

-- 문제 1: 직원의 이름(first_name, last_name)과 직원의 현재 직책(title)을 조회하세요.
SELECT e.first_name, e.last_name, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01';
-- 문제 2: 각 부서의 이름(dept_name)과 그 부서에 현재 속해있는 직원 수를 조회하세요.
SELECT d.dept_name, count(de.emp_no) 직원수
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY dept_name;
-- 문제 3: 현재 직원 중 급여가 80000 이상인 직원의 이름(first_name, last_name)과 급여(salary)를 조회하세요.
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary >= 80000 AND s.to_date = '9999-01-01';
-- 문제 4: 'Marketing' 부서에 현재 속해있는 직원의 이름(first_name, last_name)과 부서 이름(dept_name)을 조회하세요.
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' AND d.dept_name = 'Marketing';

-- 문제 5: 각 직원의 이름과 해당 직원이 현재 속한 부서 이름을 조회하세요. (LEFT JOIN 사용)
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01';