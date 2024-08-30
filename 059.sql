/*
059-tối ưu hóa truy vấn dữ liệu với Materialized views
Materialized views trong Oracle là một cách hiệu quả để tối ưu hóa truy vấn dữ liệu. 
Materialized view (MV) lưu trữ kết quả của một truy vấn và có thể được cập nhật khi dữ liệu gốc thay đổi. 
MV thích hợp khi bạn có những truy vấn phức tạp thực hiện nhiều lần trên cùng một dữ liệu.
*/
--Tạo ra một Materialized View có tên là mv_employee_data dựa trên kết quả truy vấn.
CREATE MATERIALIZED VIEW mv_employee_data AS
SELECT 
    department_id, 
    job_id, 
    COUNT(*) num_employees, 
    AVG(salary) avg_salary
FROM employees
GROUP BY department_id, job_id;

--GRANT CREATE MATERIALIZED VIEW TO C##HR;
--Truy vấn Materialized View cũng giống như truy vấn một bảng thông thường
SELECT * FROM mv_employee_data;

--Khi dữ liệu gốc thay đổi,cần làm mới Materialized View để đảm bảo nó phản ánh đúng dữ liệu mới nhất
--Câu lệnh này sẽ làm mới mv_employee_data dựa trên dữ liệu mới nhất từ bảng employees.
EXEC DBMS_MVIEW.REFRESH('mv_employee_data');
DROP MATERIALIZED VIEW mv_employee_data;

--Tạo Materialized View với đặc tính ENABLE QUERY REWRITE
--Đặc tính ENABLE QUERY REWRITE cho phép Oracle sử dụng Materialized View 
--để tối ưu hóa truy vấn dựa trên nội dung của Materialized View
CREATE MATERIALIZED VIEW mv_employee_data
ENABLE QUERY REWRITE AS
SELECT department_id, job_id, COUNT(*) num_employees, AVG(salary) avg_salary
FROM employees
GROUP BY department_id, job_id;

--Để sử dụng Materialized View với REFRESH FAST, 
--"REFRESH FAST" là một tùy chọn của Materialized View, cho phép cập nhật nhanh chóng 
--và hiệu quả Materialized View mỗi khi dữ liệu gốc thay đổi.

--Trái với "REFRESH COMPLETE" - tùy chọn mà Oracle sẽ xóa và tính toán lại toàn bộ Materialized View, 
--"REFRESH FAST" chỉ cập nhật các thay đổi từ lần cập nhật cuối cùng.

--bạn cần tạo một Materialized View LOG trên bảng gốc
DROP MATERIALIZED VIEW LOG ON employees;
CREATE MATERIALIZED VIEW LOG ON employees;

--Materialized View có thể sử dụng truy vấn phức tạp bao gồm JOIN
CREATE MATERIALIZED VIEW mv_employee_dept_data AS
SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id;