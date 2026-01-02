# Tóm tắt các thay đổi cho file index.jsp

## Các tính năng đã thêm vào index.jsp để tích hợp với backend:

### 1. **JSP Scriptlet ở đầu file** (Dòng 1-36)
   - Kiểm tra session để xác định user đã đăng nhập chưa
   - Lấy thông tin user từ session (userName, userEmail, userId)
   - Lấy các thông báo lỗi/thành công từ request attributes (từ servlet)
   - Lấy các giá trị đã nhập để giữ lại trong form khi có lỗi
   - Xác định modal nào cần mở tự động (nếu có lỗi)

### 2. **Cập nhật Header** (Dòng 73-81)
   - Hiển thị/ẩn auth buttons và user avatar dựa trên trạng thái đăng nhập
   - Hiển thị chữ cái đầu của tên user trong avatar placeholder
   - Sử dụng JSP scriptlet để điều khiển style display

### 3. **Cập nhật Mobile Menu** (Dòng 96-115)
   - Tương tự như header, hiển thị/ẩn auth buttons và user info
   - Hiển thị tên user trong mobile menu

### 4. **Form Đăng nhập** (Dòng 128-155)
   - Thêm div hiển thị thông báo lỗi từ servlet
   - Giữ lại giá trị email đã nhập khi có lỗi (sử dụng value attribute)

### 5. **Form Đăng ký** (Dòng 158-197)
   - Thêm div hiển thị thông báo lỗi từ servlet
   - Thêm div hiển thị thông báo thành công
   - Giữ lại các giá trị đã nhập (fullName, phone, email) khi có lỗi

### 6. **Cập nhật JavaScript** (Dòng 865-1000)
   - Khai báo biến `userLoggedIn` từ JSP scriptlet
   - Tạo object `currentUser` từ session data
   - Cập nhật function `updateUIAfterLogin()` để sử dụng biến mới
   - Gọi `updateUIAfterLogin()` khi trang load để cập nhật UI ban đầu
   - Tự động mở modal đăng nhập/đăng ký nếu có lỗi từ servlet
   - Xóa thông báo lỗi khi user bắt đầu nhập lại

## Các request attributes từ servlet được sử dụng:

### Từ LoginServlet:
- `loginError`: Thông báo lỗi đăng nhập
- `loginEmail`: Email đã nhập để giữ lại trong form

### Từ RegisterServlet:
- `registerError`: Thông báo lỗi đăng ký
- `registerSuccess`: Thông báo thành công (tự động đăng nhập)
- `registerFullName`: Họ tên đã nhập
- `registerPhone`: Số điện thoại đã nhập
- `registerEmail`: Email đã nhập

### Session attributes được sử dụng:
- `isLoggedIn`: Boolean - trạng thái đăng nhập
- `userName`: String - tên đầy đủ của user
- `userEmail`: String - email của user
- `userId`: Integer - ID của user

## Lưu ý:

1. **Lỗi Linter**: Các lỗi linter về JSP scriptlet trong JavaScript là bình thường. Linter JavaScript không hiểu JSP syntax, nhưng code sẽ chạy đúng khi được server render.

2. **Escape Characters**: Khi hiển thị user name/email trong JavaScript string, cần escape các ký tự đặc biệt (như dấu nháy đơn) để tránh lỗi JavaScript.

3. **Session Management**: UI sẽ tự động cập nhật dựa trên session. Khi user đăng nhập/đăng xuất, trang sẽ reload và hiển thị trạng thái mới.

4. **Form Validation**: Backend validation được xử lý bởi servlet. Frontend chỉ hiển thị thông báo lỗi từ server.

## Flow hoạt động:

### Đăng nhập:
1. User nhập email/password và submit form
2. Form POST đến `/login`
3. LoginServlet xử lý và tạo session nếu thành công
4. Nếu lỗi: Forward về `/` với `loginError` và `loginEmail`
5. index.jsp hiển thị modal với thông báo lỗi và giá trị đã nhập
6. Nếu thành công: Redirect về `/`, session được tạo, UI hiển thị user avatar

### Đăng ký:
1. User nhập thông tin và submit form
2. Form POST đến `/register`
3. RegisterServlet xử lý và tạo user mới
4. Nếu lỗi: Forward về `/` với các error attributes và giá trị đã nhập
5. index.jsp hiển thị modal với thông báo lỗi
6. Nếu thành công: Tự động đăng nhập, redirect về `/`, UI hiển thị user avatar

### Đăng xuất:
1. User click nút đăng xuất
2. GET/POST đến `/logout`
3. LogoutServlet invalidate session
4. Redirect về `/`
5. UI hiển thị auth buttons, ẩn user avatar

