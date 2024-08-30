--029-Các lệnh JOIN và SUB QUERY với bảng departments và employees
--lệnh SQL JOIN có thể sử dụng để kết hợp dữ liệu từ hai bảng employees và departments
--INNER JOIN - Lấy tất cả các nhân viên và thông tin về phòng ban mà họ làm việc
SELECT 
    employees.first_name, 
    employees.last_name, 
    departments.department_name, 
    employees.salary
FROM employees
--LEFT JOIN 
--FULL OUTER JOIN -- Lấy tất cả thông tin từ cả hai bảng, bất kể liệu nhân viên có phòng ban hoặc phòng ban có nhân viên:
INNER JOIN departments
ON employees.department_id = departments.department_id;
--aggregation
--Lấy tên phòng ban và số lượng nhân viên trong mỗi phòng

--Để sắp xếp kết quả theo số lượng nhân viên (COUNT(employees.employee_id)), 
--bạn có thể sử dụng mệnh đề ORDER BY trong câu lệnh SQL
SELECT 
    departments.department_name, 
    COUNT(employees.employee_id) AS employee_count
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY employee_count ASC;

--Lấy thông tin về các phòng ban mà không có nhân viên nào
SELECT departments.department_name 
FROM departments
LEFT JOIN employees
ON departments.department_id = employees.department_id
WHERE employees.employee_id IS NULL;

--SELECT * FROM departments WHERE department_name='Treasury';
--SELECT * FROM employees WHERE department_id=120;
--Lấy tên phòng ban và lương trung bình của nhân viên trong mỗi phòng
SELECT 
    departments.department_name, 
    ROUND(AVG(employees.salary),2)
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id
GROUP BY departments.department_name;

--Lấy thông tin về những nhân viên có lương cao nhất trong mỗi phòng
--sử dụng sub-query và inner-join
SELECT 
    departments.department_name, 
    employees.first_name, 
    employees.last_name, 
    employees.salary
FROM employees
INNER JOIN (
    SELECT department_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
) emp_max_salary
ON employees.department_id = emp_max_salary.department_id AND employees.salary = emp_max_salary.max_salary
INNER JOIN departments
ON employees.department_id = departments.department_id;

--Lấy tất cả các nhân viên có lương lớn hơn 5000 và thông tin về phòng ban mà họ làm việc
SELECT 
    employees.first_name, 
    employees.last_name, 
    employees.salary,
    departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id
WHERE employees.salary > 5000;

--Lấy thông tin về những phòng ban có ít hơn 10 nhân viên nhưng ko được trống
SELECT 
    departments.department_name, 
    COUNT(employees.employee_id) AS employee_count
FROM employees
RIGHT JOIN departments
ON employees.department_id = departments.department_id
GROUP BY departments.department_name
HAVING COUNT(employees.employee_id) < 10 AND COUNT(employees.employee_id) > 0;
/*
Trong SQL, có nhiều loại join, bao gồm INNER JOIN, LEFT JOIN (hoặc LEFT OUTER JOIN), 
RIGHT JOIN (hoặc RIGHT OUTER JOIN) và FULL JOIN (hoặc FULL OUTER JOIN). 
Trong thực tế, INNER JOIN và LEFT JOIN được sử dụng nhiều nhất. */






















