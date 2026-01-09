# TÀI LIỆU ÔN THI VẤN ĐÁP - BACKEND JAVA PROJECT
## Dự án: Hệ thống đặt xe (datxe_product)

Tài liệu này tổng hợp toàn bộ thông tin quan trọng về phần Backend của dự án để phục vụ ôn thi vấn đáp môn Lập trình Java Web.

---

### 1. Tổng quan kiến trúc (Architecture Overview)
Dự án được xây dựng theo mô hình **MVC (Model-View-Controller)** truyền thống, giúp tách biệt các lớp xử lý:
- **Model**: Đại diện cho các đối tượng dữ liệu (POJO) trong hệ thống (User, Vehicle, Booking...).
- **View**: Giao diện người dùng, sử dụng **JSP (JavaServer Pages)** kết hợp với HTML/CSS/JS.
- **Controller**: Điều hướng yêu cầu, sử dụng **Servlet** để tiếp nhận request từ View, gọi lớp DAO để xử lý dữ liệu và trả kết quả về View.

---

### 2. Cấu trúc Package (Package Structure)
- `nntruong.data.model`: Chứa các lớp thực thể (Entities) tương ứng với các bảng trong Database.
- `nntruong.data.dao`: Chứa các lớp Data Access Object để thực hiện truy vấn SQL (CRUD).
- `nntruong.servlet`: Chứa các Servlet xử lý các chức năng người dùng (Login, Register, DatXe...).
- `nntruong.controller.admin`: Chứa các Servlet và API xử lý chức năng quản trị.
- `nntruong.utils`: Các lớp tiện ích (Kết nối DB, Hash mật khẩu, Xử lý JSON).

---

### 3. Công nghệ sử dụng (Tech Stack)
- **Ngôn ngữ**: Java 8+.
- **Web Framework**: Java Servlet & JSP.
- **Database**: MySQL.
- **Thư viện kết nối**: JDBC (Java Database Connectivity).
- **Bảo mật**: SHA-256 (hashing password với Salt).
- **Khác**: Gson (xử lý JSON), Bootstrap/CSS cho Frontend.

---

### 4. Thành phần Backend quan trọng

#### A. Quản lý kết nối Database (`DatabaseConnection.java`)
- **Design Pattern**: Sử dụng **Singleton Pattern** để đảm bảo chỉ có duy nhất một instance quản lý việc kết nối, tiết kiệm tài nguyên.
- **Transaction**: Sử dụng `connection.setAutoCommit(false)` để quản lý giao dịch thủ công. Chỉ khi mọi thứ OK mới `commit()`, nếu lỗi sẽ `rollback()`.
- **JDBC Driver**: Sử dụng `com.mysql.cj.jdbc.Driver`.

#### B. Lớp DAO (Data Access Object)
- Mỗi bảng trong DB có một lớp DAO tương ứng (ví dụ: `UserDAO`, `VehicleDAO`).
- **Nghiệp vụ**: Chuyển đổi giữa các dòng trong Database (`ResultSet`) sang các đối tượng Java (`Model`).
- **An toàn**: Luôn sử dụng `PreparedStatement` thay vì `Statement` để ngăn chặn lỗi **SQL Injection**.

#### C. Xử lý Đăng nhập (`LoginServlet.java`)
1. Nhận `email` và `password` từ form POST.
2. Gọi `UserDAO.findByEmailAndPassword()`.
3. Kiểm tra mật khẩu (so sánh hash trong DB với hash của mật khẩu nhập vào kèm Salt).
4. Nếu đúng: Lưu đối tượng `User` vào `HttpSession`.
5. Nếu sai: Trả về thông báo lỗi qua `request.setAttribute()`.

#### D. Bảo mật mật khẩu (`PasswordUtil.java`)
- Hệ thống không lưu mật khẩu dạng văn bản thuần (plain text).
- **Quy trình**: 
    1. Khi đăng ký: Tạo một chuỗi ngẫu nhiên (**Salt**), kết hợp với mật khẩu, sau đó băm (Hash) bằng thuật toán **SHA-256**. Lưu trữ dạng `salt:hash`.
    2. Khi đăng nhập: Lấy Salt từ DB ra, kết hợp với mật khẩu người dùng vừa nhập, băm lại và so sánh với Hash trong DB.

---

### 5. Bộ câu hỏi ôn tập vấn đáp (Oral Exam Q&A)

**Câu 1: Dự án này sử dụng mô hình gì? Ưu điểm của nó?**
- **Trả lời**: Dự án sử dụng mô hình MVC. Ưu điểm là tách biệt code giao diện (JSP) và code xử lý (Servlet/DAO), giúp dễ bảo trì, mở rộng và làm việc nhóm hiệu quả hơn.

**Câu 2: Servlet đóng vai trò gì trong hệ thống?**
- **Trả lời**: Servlet đóng vai trò là Controller. Nó tiếp nhận request từ Browser, đọc dữ liệu gửi lên (tham số form), gọi DAO để xử lý dữ liệu và cuối cùng là điều hướng (Forward/Redirect) người dùng đến View hoặc Servlet khác.

**Câu 3: Tại sao bạn sử dụng DAO Pattern?**
- **Trả lời**: Để quản lý riêng các logic truy vấn cơ sở dữ liệu. Giúp Servlet không phải viết code SQL loằng ngoằng, làm code sạch hơn. Nếu sau này thay đổi Database (ví dụ từ MySQL sang PostgreSQL), ta chỉ cần sửa ở lớp DAO mà không ảnh hưởng đến Servlet.

**Câu 4: Bạn xử lý Session như thế nào khi đăng nhập?**
- **Trả lời**: Khi người dùng đăng nhập thành công, tôi sử dụng `request.getSession()` để tạo session. Sau đó dùng `session.setAttribute("user", userObject)` để lưu thông tin người dùng. Khi muốn kiểm tra đã đăng nhập chưa, tôi chỉ cần kiểm tra attribute này có tồn tại không.

**Câu 5: Làm thế nào để ngăn chặn SQL Injection trong dự án?**
- **Trả lời**: Tôi sử dụng `PreparedStatement` thay vì nối chuỗi trực tiếp vào câu lệnh SQL. Các dấu hỏi chấm (`?`) đóng vai trò là placeholder và JDBC sẽ tự động xử lý (escape) các ký tự đặc biệt để đảm bảo an toàn.

**Câu 6: Singleton Pattern trong `DatabaseConnection` dùng để làm gì?**
- **Trả lời**: Để đảm bảo trong suốt vòng đời ứng dụng chỉ có một đối tượng duy nhất khởi tạo kết nối. Điều này giúp quản lý tập trung và tránh lãng phí bộ nhớ khi tạo quá nhiều đối tượng kết nối dư thừa.

**Câu 7: Forward và Redirect khác nhau thế nào trong Servlet?**
- **Trả lời**: 
    - `Forward`: Chuyển yêu cầu trong nội bộ Server, URL trên trình duyệt không đổi. Thường dùng sau khi lấy dữ liệu xong và muốn hiển thị JSP.
    - `Redirect`: Yêu cầu Browser gửi một request mới tới URL khác, URL đổi. Thường dùng sau khi thực hiện hành động ảnh hưởng đến dữ liệu (như Login, Update) để tránh người dùng nhấn F5 bị gửi lại form.

**Câu 8: Interface `HttpServlet` có các phương thức chính nào?**
- **Trả lời**: Có `doGet()` (xử lý yêu cầu lấy dữ liệu) và `doPost()` (xử lý yêu cầu gửi/lưu dữ liệu).

**Câu 9: Transaction là gì và bạn dùng nó khi nào?**
- **Trả lời**: Transaction đảm bảo một nhóm các câu lệnh SQL hoặc là thành công hết, hoặc là thất bại hết. Tôi dùng nó ở `DatabaseConnection` với `setAutoCommit(false)`. Ví dụ khi thanh toán, ta phải trừ tiền khách và cộng tiền cửa hàng, nếu một trong hai lỗi thì phải `rollback` hết.

**Câu 10: Làm thế nào để truyền dữ liệu từ Servlet sang JSP?**
- **Trả lời**: Sử dụng `request.setAttribute("key", value)` sau đó dùng `RequestDispatcher.forward()` để chuyển sang JSP. Ở JSP có thể dùng Expression Language (EL) ví dụ `${key}` để lấy ra hiển thị.

---
*Chúc bạn thi tốt!*
