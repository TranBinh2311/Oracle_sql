--028-Các câu lệnh SELECT và SUB-QUERY với bảng employees
SELECT * FROM employees;
SELECT count(*) FROM departments;
--viết các câu lệnh cho bảng employees
--Lấy tất cả các nhân viên có lương lớn hơn 5000
SELECT *
FROM employees
WHERE salary > 5000
ORDER BY salary DESC;
--Lấy các nhân viên thuộc phòng ban có department_id là 30
SELECT *
FROM employees
WHERE department_id = 30;
--Lấy số lượng nhân viên trong mỗi phòng 
SELECT department_id, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;
--Lấy first_name, last_name và email của tất cả nhân viên:
SELECT 
    email,
    first_name, 
    last_name    
FROM employees;
--Lấy danh sách nhân viên mà có quản lý (manager_id khác NULL):
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;

SELECT * FROM employees
WHERE employee_id=100; --sếp tổng
--Lấy các nhân viên được thuê sau ngày 01/03/2008
SELECT *
FROM employees
WHERE hire_date > TO_DATE('2008-03-01', 'YYYY-MM-DD');
--Lấy các nhân viên có first_name bắt đầu bằng chữ 'A':
SELECT *
FROM employees
WHERE first_name LIKE 'A%';
--Lấy các nhân viên có email chứa 'gmail':
SELECT *
FROM employees
WHERE email LIKE '%gmail%';
--Lấy tất cả các nhân viên có lương lớn hơn 6000 và thuộc phòng ban 50
SELECT *
FROM employees
WHERE salary > 6000 AND department_id = 50;

--Lấy tất cả nhân viên có lương từ 2000 đến 4000 
--và thuộc phòng ban có department_id là 10 hoặc 20, hoặc 30
SELECT *
FROM employees
WHERE (salary BETWEEN 2000 AND 4000) 
        AND department_id IN (10, 20, 30);
        
--Lấy tất cả các nhân viên không phải là quản lý 
--(tức là manager_id của họ không xuất hiện trong danh sách manager_id) 
--và có lương dưới 3000

SELECT *
FROM employees
WHERE employee_id NOT IN 
    (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL)
      AND salary < 3000;
--Lấy tất cả các nhân viên được thuê sau ngày 01/01/2007 và có job_id là 'IT_PROG'    

SELECT *
FROM employees
WHERE hire_date > TO_DATE('2007-01-01', 'YYYY-MM-DD') AND job_id = 'IT_PROG';

--Lấy tất cả các nhân viên có hire_date nằm trong năm 2008 và job_id bắt đầu bằng 'SA'
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2008 AND UPPER(job_id) LIKE UPPER('SA%');

--Lấy tất cả các nhân viên thuộc phòng ban 10 hoặc 20, và có last_name kết thúc bằng 'tein'
SELECT *
FROM employees
WHERE department_id IN (10, 20) AND last_name LIKE '%tein';











