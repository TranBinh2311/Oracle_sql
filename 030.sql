/*
030-View là gì, tạo View để JOIN giữa 2 hoặc nhiều bảng
Tạo view trong SQL giúp bạn lưu các truy vấn phức tạp như là một đối tượng cơ sở dữ liệu. 
Điều này rất hữu ích khi bạn muốn chạy một câu truy vấn phức tạp nhiều lần
*/
--Tạo một view có tên là view_employee_department, 
--chứa tên nhân viên, tên phòng ban và lương
CREATE VIEW view_employee_department AS
SELECT 
    employees.first_name, 
    employees.last_name,     
    departments.department_name, 
    employees.salary
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

SELECT * FROM view_employee_department;

--bạn có thể tạo một view bao gồm tất cả các trường từ cả hai bảng 
--sau đó thực hiện các truy vấn có điều kiện trên view đó
CREATE VIEW view_all_employee_department AS
SELECT 
    employees.employee_id,
    employees.first_name,
    employees.last_name,
    employees.email,
    employees.phone_number,
    employees.hire_date,
    employees.job_id,
    employees.salary,
    employees.commission_pct,
    employees.manager_id AS employee_manager_id,
    departments.department_name,
    departments.manager_id AS department_manager_id,
    departments.location_id
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

--DROP VIEW view_all_employee_department;
--Lấy tất cả các nhân viên trong phòng ban 'Shipping'
SELECT * 
FROM view_all_employee_department 
WHERE department_name = 'Shipping';

--Lấy tất cả các nhân viên được thuê vào năm 2004
SELECT *
FROM view_all_employee_department
WHERE EXTRACT(YEAR FROM hire_date) = 2004;
/*
Chúng ta có thể tạo một view bằng cách thực hiện join giữa 3 bảng employees, departments và locations.
*/

CREATE VIEW view_all_employee_info AS
SELECT 
    employees.employee_id,
    employees.first_name,
    employees.last_name,
    employees.email,
    employees.phone_number,
    employees.hire_date,
    employees.job_id,
    employees.salary,
    employees.commission_pct,
    employees.manager_id AS employee_manager_id,
    departments.department_name,
    departments.manager_id AS department_manager_id,
    locations.street_address,
    locations.postal_code,
    locations.city,
    locations.state_province,
    locations.country_id
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN locations
ON departments.location_id = locations.location_id;

--Lấy thông tin của nhân viên thuộc thành phố 'Seattle'
SELECT * FROM view_all_employee_info
WHERE city = 'Seattle';
--Lấy thông tin của nhân viên thuộc phòng 'Accounting' 
--và có mức lương dưới 3000
SELECT * 
FROM view_all_employee_info
WHERE department_name = 'Accounting' AND salary > 3000;

--Lấy thông tin của nhân viên có quản lý (có manager_id)
SELECT * 
FROM view_all_employee_info
WHERE employee_manager_id IS NULL;









