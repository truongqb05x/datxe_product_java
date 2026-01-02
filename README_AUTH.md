# Hướng dẫn sử dụng hệ thống Authentication

## Cấu trúc các file đã tạo

### 1. Utility Classes
- **`src/java/nntruong/utils/DatabaseConnection.java`**: Quản lý kết nối database (Singleton pattern)
- **`src/java/nntruong/utils/PasswordUtil.java`**: Xử lý mã hóa và xác thực mật khẩu (SHA-256 với salt)

### 2. Model Classes
- **`src/java/nntruong/data/model/User.java`**: Model class đại diện cho bảng users

### 3. DAO Classes
- **`src/java/nntruong/data/dao/UserDAO.java`**: Data Access Object để tương tác với bảng users

### 4. Servlet Classes
- **`src/java/nntruong/servlet/LoginServlet.java`**: Xử lý đăng nhập (POST /login)
- **`src/java/nntruong/servlet/RegisterServlet.java`**: Xử lý đăng ký (POST /register)
- **`src/java/nntruong/servlet/LogoutServlet.java`**: Xử lý đăng xuất (GET/POST /logout)

## Cấu hình Database

1. **Tạo database**: Chạy file `sql.sql` để tạo database và các bảng cần thiết

2. **Cấu hình kết nối**: 
   - Mở file `src/java/nntruong/utils/DatabaseConnection.java`
   - Sửa các thông tin kết nối:
     ```java
     private static final String DB_URL = "jdbc:mysql://localhost:3306/rentcar?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
     private static final String DB_USERNAME = "root";
     private static final String DB_PASSWORD = "";
     ```

## Cách hoạt động

### Đăng nhập (Login)
1. User nhập email và password vào form trong `index.jsp`
2. Form submit POST request đến `/login`
3. `LoginServlet` nhận request, gọi `UserDAO.findByEmailAndPassword()`
4. `UserDAO` kiểm tra email và hash password, so sánh với database
5. Nếu đúng: Tạo session, lưu thông tin user, redirect về trang chủ
6. Nếu sai: Hiển thị thông báo lỗi

### Đăng ký (Register)
1. User nhập thông tin vào form đăng ký trong `index.jsp`
2. Form submit POST request đến `/register`
3. `RegisterServlet` validate dữ liệu, kiểm tra email đã tồn tại chưa
4. Nếu hợp lệ: Tạo User mới, hash password, lưu vào database
5. Tự động đăng nhập sau khi đăng ký thành công

### Đăng xuất (Logout)
1. User click nút đăng xuất
2. Request GET/POST đến `/logout`
3. `LogoutServlet` invalidate session
4. Redirect về trang chủ

## Lưu ý quan trọng

1. **Mật khẩu**: Hiện tại sử dụng SHA-256 với salt. Trong production nên dùng BCrypt hoặc Argon2 để an toàn hơn.

2. **Session**: Thông tin user được lưu trong session với các key:
   - `user`: User object
   - `userId`: ID của user
   - `userEmail`: Email của user
   - `userName`: Tên đầy đủ của user
   - `isLoggedIn`: Flag đăng nhập

3. **Password Storage**: Password được lưu trong database với format `salt:hash` trong cột `password_hash`

4. **Database Transaction**: Tất cả các thao tác database đều sử dụng transaction (auto-commit = false) để đảm bảo tính toàn vẹn dữ liệu

## URL Mapping (đã cấu hình trong web.xml)
- `/login` → LoginServlet (POST)
- `/register` → RegisterServlet (POST)
- `/logout` → LogoutServlet (GET/POST)

