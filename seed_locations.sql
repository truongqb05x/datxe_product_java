USE datxe;

-- Thêm dữ liệu mẫu cho bảng vehicle_locations để tránh lỗi Foreign Key
-- Giả sử vehicle_id = 1 hoặc 2 đã tồn tại (nếu chưa có thì cần thêm xe trước)
-- Các ID 1, 2, 3 tương ứng với hardcoded logic trong BookingServlet: HQ, Branch1, Branch2

INSERT INTO vehicle_locations (location_id, vehicle_id, address, city, district, is_pickup_point, is_return_point, operating_hours) 
VALUES 
(1, 2, 'Trụ sở chính: 100 Nguyễn Văn Linh', 'Đà Nẵng', 'Thanh Khê', TRUE, TRUE, '07:30 - 21:00'),
(2, 2, 'Chi nhánh 1: 50 Bạch Đằng', 'Đà Nẵng', 'Hải Châu', TRUE, TRUE, '08:00 - 20:00'),
(3, 2, 'Chi nhánh 2: 20 Hùng Vương', 'Huế', 'Phú Nhuận', TRUE, TRUE, '08:00 - 18:00')
ON DUPLICATE KEY UPDATE address = VALUES(address);
