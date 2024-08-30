--031-Thực hành truy vấn từ View JOIN 4 bảng, sử dụng DISTINCT, MIN, MAX
SELECT * FROM job_history;
--Tạo view với dữ liệu từ 4 bảng
DROP VIEW all_employee_details;
CREATE VIEW all_employee_details AS
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name, 
    e.job_id, 
    d.location_id,
    e.salary,
    d.department_name, 
    d.department_id,
    j.job_title, 
    jh.start_date, 
    jh.end_date
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
INNER JOIN job_history jh ON e.employee_id = jh.employee_id;

SELECT * FROM all_employee_details;

--Lấy thông tin của nhân viên đã làm việc trong bộ phận 'Sales'
SELECT *
FROM all_employee_details
WHERE department_name = 'Sales';

--Lấy thông tin của nhân viên có lịch sử làm việc từ trước năm 2009
SELECT *
FROM all_employee_details
WHERE start_date < TO_DATE('2009-01-01', 'YYYY-MM-DD');
--Lấy thông tin của nhân viên có lịch sử làm việc không quá 1 năm
SELECT *
FROM all_employee_details
WHERE (end_date - start_date) < 365;

--Lấy thông tin của nhân viên đã làm cùng một công việc trong nhiều hơn một phòng ban
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    job_id
FROM all_employee_details
GROUP BY employee_id, first_name, last_name, job_id
HAVING COUNT(department_id) > 1;
-- danh sách tất cả nhân viên đang giữ vị trí "AD_VP"
SELECT *
FROM all_employee_details
WHERE job_id = 'AD_VP';

--danh sách nhân viên làm việc tại bộ phận 'Sales' ,'Executive', hoặc 'Shipping'
SELECT *
FROM all_employee_details
WHERE department_name IN ('Sales' ,'Executive', 'Shipping');

--danh sách nhân viên không làm việc tại bộ phận 'Executive'
SELECT *
FROM all_employee_details
WHERE department_name != 'Executive';

--DISTINCT: Câu lệnh này trả về tất cả các giá trị duy nhất trong một cột
SELECT DISTINCT job_id
FROM all_employee_details;
--lấy 10 nhân viên đầu tiên từ view
--ROWNUM: ROWNUM được Oracle Database tự động gán cho mỗi hàng trong một kết quả truy vấn.
SELECT *
FROM all_employee_details
WHERE ROWNUM <= 10;

--MIN: Hàm này trả về giá trị nhỏ nhất của một cột số
SELECT MIN(salary)
FROM all_employee_details;
--MAX: Hàm này trả về giá trị lớn nhất của một cột số
SELECT MAX(salary)
FROM all_employee_details;

--Tính tổng lương phải trả cho toàn bộ nv tháng này
SELECT SUM(salary)
FROM all_employee_details;

--Trả về tất cả các địa điểm (location_id) duy nhất mà nhân viên đã làm việc
SELECT DISTINCT location_id
FROM all_employee_details;

-- danh sách nhân viên có mức lương nằm trong khoảng từ 3000 đến 6000
SELECT *
FROM all_employee_details
WHERE salary BETWEEN 3000 AND 6000;






