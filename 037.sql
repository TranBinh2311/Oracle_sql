--037-Viết các thủ tục cho bảng playlists, kết hợp bắt EXCEPTION
CREATE OR REPLACE PROCEDURE add_new_playlist(        
    --IN: đây là hướng của tham số: IN, OUT, hoặc IN OUT    
    p_user_id IN playlists.user_id%TYPE,--tham số sẽ luôn có cùng kiểu dữ liệu với cột mà nó liên quan    
    p_playlist_name IN playlists.playlist_name%TYPE
)
IS
  v_count NUMBER; -- Biến đếm số lượng user_id
  v_playlist_name playlists.playlist_name%TYPE;
BEGIN  
  -- Nếu user_id không tồn tại, thì báo lỗi
  SELECT COUNT(*)
  INTO v_count
  FROM users
  WHERE user_id = p_user_id;  
  
  IF v_count = 0 THEN
    --20001 là một mã lỗi người dùng định nghĩa (User-Defined Exception Code).
  --sử dụng số từ -20000 đến -20999   
    RAISE_APPLICATION_ERROR(-20001, 'User ID không tồn tại trong bảng USERS');
  END IF;  
  
  -- Kiểm tra xem playlist_name đã tồn tại trong bảng PLAYLISTS hay không  
  BEGIN
    SELECT playlist_name INTO v_playlist_name FROM playlists WHERE playlist_name = p_playlist_name;
     --Oracle sẽ sinh ra ngoại lệ NO_DATA_FOUND, và chương trình sẽ dừng ngay lập tức
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_playlist_name := NULL;
  END;
 
  IF v_playlist_name IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20002, 'playlist_name đã tồn tại trong bảng PLAYLISTS');
  END IF; 

  -- Thêm một playlist mới vào bảng playlists
  INSERT INTO playlists (user_id, playlist_name, date_created)
  VALUES (p_user_id, p_playlist_name, SYSDATE);
  
  COMMIT; -- Xác nhận thay đổi
END add_new_playlist;
/

--SELECT * FROM USERS WHERE USER_ID=1;
EXECUTE add_new_playlist(1, 'My Playlist haha');--Phương thức 1: Sử dụng lệnh EXECUTE

--Phương thức 2: Sử dụng khối PL/SQL
BEGIN
  add_new_playlist(1, 'My Playlist haha');
END;
/
/*
Để kiểm tra xem một user có quyền thực thi (execute) một thủ tục cụ thể, 
bạn có thể thực hiện truy vấn sau 
trên bảng hệ thống USER_TAB_PRIVS hoặc ALL_TAB_PRIVS
*/
SELECT *
FROM USER_TAB_PRIVS
WHERE TABLE_NAME = 'ADD_NEW_PLAYLIST' AND PRIVILEGE = 'EXECUTE';

--Để cấp quyền thực thi (EXECUTE) cho một user trên một thủ tục cụ thể
-- nhớ phải đăng nhập user sys
GRANT EXECUTE ON add_new_playlist TO C##HOANGND;

--DELETE FROM PLAYLISTS WHERE PLAYLIST_ID IN (64);
SELECT * FROM PLAYLISTS;
COMMIT;