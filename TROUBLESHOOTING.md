# Hướng dẫn xử lý lỗi

## Lỗi: java.nio.file.NoSuchFileException: cglib-2.2.jar

### Nguyên nhân:
1. File JAR bị corrupt hoặc bị lock bởi process khác
2. BookingServlet được khai báo trong web.xml nhưng class không tồn tại (đã fix)

### Giải pháp:

#### 1. Clean và Rebuild Project (Khuyến nghị)
- Trong NetBeans: Menu `Build` → `Clean and Build Project`
- Hoặc click chuột phải vào project → `Clean and Build`

#### 2. Xóa thư mục build và rebuild
```bash
# Xóa thư mục build
rmdir /s /q build

# Sau đó rebuild project
```

#### 3. Kiểm tra file cglib-2.2.jar
- Kiểm tra xem file có bị corrupt không
- Nếu cần, tải lại file từ Maven Central Repository:
  - https://mvnrepository.com/artifact/cglib/cglib/2.2

#### 4. Restart Tomcat Server
- Dừng server Tomcat hoàn toàn
- Xóa thư mục work và temp của Tomcat (nếu có)
- Khởi động lại server

#### 5. Kiểm tra BookingServlet
- BookingServlet đã được comment out trong web.xml vì class chưa tồn tại
- Khi tạo BookingServlet sau này, uncomment phần đó trong web.xml

### Lỗi đã được fix:
- ✅ BookingServlet đã được comment out trong web.xml (dòng 41-49)

### Các bước tiếp theo:
1. Clean và rebuild project
2. Restart Tomcat server
3. Deploy lại ứng dụng
4. Kiểm tra log để xem có lỗi gì khác không

