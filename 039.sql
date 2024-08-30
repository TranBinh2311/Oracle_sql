--039-Quản lý lỗi(Exception) trong PL-SQL
--bạn có thể sử dụng khối EXCEPTION để bắt và xử lý các lỗi có thể xảy ra

--Xử lý lỗi chia 0
BEGIN
  DECLARE
    a NUMBER(2) := 50;
    b NUMBER(2) := 0;
    c NUMBER(3);
  BEGIN
    c := a / b;
    DBMS_OUTPUT.PUT_LINE('haha, good');
  EXCEPTION
    WHEN ZERO_DIVIDE THEN
      dbms_output.put_line('Error: Chia cho 0');
  END;
END;
/

--Xử lý lỗi truy cập vào dữ liệu không tồn tại
--cố tình nhập vào 1 bài hát ko tồn tại
CREATE OR REPLACE PROCEDURE find_song_by_name (
              p_song_name SONGS.SONG_NAME%TYPE)
AS
  song_id SONGS.SONG_ID%TYPE;
BEGIN
  SELECT SONG_ID INTO song_id
  FROM SONGS WHERE LOWER(SONG_NAME) = LOWER(p_song_name);
  -- Hàm LOWER chuyển cả SONG_NAME và p_song_name về chữ thường khi so sánh
  dbms_output.put_line('Song ID: ' || song_id);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Error: Không tìm thấy bài hát với tên ' || p_song_name);
END;
/

SELECT * FROM songs;
--EXECUTE find_song_by_name('Paint my love');
--EXECUTE find_song_by_name('Chiều mưa tím');

--Lỗi VALUE_ERROR xảy ra khi một biến 
--hoặc một trường bản ghi không thể chứa giá trị đã được gán cho nó.

DECLARE
  v_number NUMBER(3);
BEGIN
  v_number := 1000;  -- This will cause a VALUE_ERROR
EXCEPTION
  WHEN VALUE_ERROR THEN
    dbms_output.put_line('Lỗi: Giá trị quá lớn cho biến');
  WHEN OTHERS THEN
    dbms_output.put_line('Lỗi không xác định: ' || SQLCODE || ' : ' || SQLERRM); 
    --SQL Error Message = SQLERRM
END;
/ 
