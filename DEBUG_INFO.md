# Debug thông tin deployment error

## Lỗi gặp:
- FAIL - Deployed application at context path [/WebApplication1] but context failed to start

## Các bước kiểm tra:

### 1. Xem Tomcat logs
- Mở Tomcat trên NetBeans: Services tab → Servers → Tomcat → View → Logs
- Hoặc kiểm tra file logs trong thư mục Tomcat installation

### 2. Kiểm tra các file cấu hình chính:
- ✓ web.xml - Có DispatcherServlet
- ⚠ applicationContext.xml - DataSource bean bị comment, cần uncomment
- ✓ dispatcher-servlet.xml - Cấu hình OK

### 3. Giải pháp:
Cần uncomment phần database configuration trong applicationContext.xml
và tạo file jdbc.properties từ jdbc.properties.example

### 4. Kiểm tra Spring/MySQL JAR files
- Đảm bảo có mysql-connector-java JAR trong WEB-INF/lib
- Đảm bảo Spring JAR files đầy đủ

## Các lỗi thường gặp:
1. Missing MySQL JDBC driver
2. Missing Spring JAR files
3. Cấu hình XML không hợp lệ
4. Database không khả dụng
5. Classpath issues
