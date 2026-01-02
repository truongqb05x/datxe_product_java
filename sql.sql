-- ============================================
-- CSDL: RentCar - Hệ thống cho thuê xe
-- Mô tả: Quản lý cho thuê xe máy, xe điện, ô tô
-- ============================================

-- Bảng người dùng
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,              -- ID người dùng
    email VARCHAR(100) UNIQUE NOT NULL,                  -- Email đăng nhập
    password_hash VARCHAR(255) NOT NULL,                 -- Mật khẩu đã mã hóa
    full_name VARCHAR(100) NOT NULL,                     -- Họ và tên
    phone_number VARCHAR(20) NOT NULL,                   -- Số điện thoại
    avatar_url VARCHAR(500),                             -- URL ảnh đại diện
    date_of_birth DATE,                                  -- Ngày sinh
    identity_card VARCHAR(20) UNIQUE,                    -- Số CMND/CCCD
    driver_license_number VARCHAR(20) UNIQUE,            -- Số bằng lái xe
    driver_license_type VARCHAR(10),                     -- Loại bằng lái (A1, A2, B1, B2, C...)
    address TEXT,                                        -- Địa chỉ
    is_verified BOOLEAN DEFAULT FALSE,                   -- Đã xác thực tài khoản chưa
    is_active BOOLEAN DEFAULT TRUE,                      -- Tài khoản có đang hoạt động không
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,      -- Ngày tạo tài khoản
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Ngày cập nhật
);

-- Bảng loại phương tiện
CREATE TABLE vehicle_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,          -- ID loại phương tiện
    category_name VARCHAR(50) NOT NULL,                  -- Tên loại (Xe máy, Xe điện, Ô tô)
    description TEXT,                                    -- Mô tả loại phương tiện
    icon_class VARCHAR(50),                              -- Class icon (fas fa-motorcycle, fas fa-car...)
    display_order INT DEFAULT 0,                         -- Thứ tự hiển thị
    is_active BOOLEAN DEFAULT TRUE                       -- Có đang hoạt động không
);

-- Bảng nhãn hiệu xe
CREATE TABLE vehicle_brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,             -- ID nhãn hiệu
    brand_name VARCHAR(50) NOT NULL,                     -- Tên nhãn hiệu (Honda, Yamaha, Toyota...)
    country VARCHAR(50),                                 -- Quốc gia
    logo_url VARCHAR(500),                               -- URL logo
    description TEXT,                                    -- Mô tả nhãn hiệu
    is_active BOOLEAN DEFAULT TRUE
);

-- Bảng phương tiện
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID phương tiện
    license_plate VARCHAR(20) UNIQUE NOT NULL,           -- Biển số xe
    brand_id INT NOT NULL,                               -- ID nhãn hiệu
    model_name VARCHAR(100) NOT NULL,                    -- Tên model (Vision, Exciter, Vios...)
    model_year YEAR,                                     -- Năm sản xuất
    category_id INT NOT NULL,                            -- ID loại phương tiện
    fuel_type VARCHAR(20),                               -- Loại nhiên liệu (Xăng, Điện, Dầu...)
    transmission VARCHAR(20),                            -- Hộp số (Số sàn, Tự động)
    engine_capacity VARCHAR(20),                         -- Dung tích xy-lanh (110cc, 150cc, 1.5L...)
    seat_capacity INT,                                   -- Số chỗ ngồi
    color VARCHAR(50),                                   -- Màu sắc
    daily_rate DECIMAL(12,2) NOT NULL,                   -- Giá thuê theo ngày (VNĐ)
    weekly_rate DECIMAL(12,2),                           -- Giá thuê theo tuần
    monthly_rate DECIMAL(12,2),                          -- Giá thuê theo tháng
    deposit_amount DECIMAL(12,2),                        -- Tiền cọc
    is_available BOOLEAN DEFAULT TRUE,                   -- Có sẵn để thuê không
    is_featured BOOLEAN DEFAULT FALSE,                   -- Có nổi bật không
    description TEXT,                                    -- Mô tả chi tiết
    specifications JSON,                                 -- Thông số kỹ thuật dạng JSON
    amenities JSON,                                      -- Tiện nghi (JSON array: ["Điều hòa", "Camera lùi"...])
    rating DECIMAL(3,2) DEFAULT 0.0,                     -- Đánh giá trung bình
    total_rentals INT DEFAULT 0,                         -- Tổng số lần thuê
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES vehicle_brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES vehicle_categories(category_id)
);

-- Bảng hình ảnh phương tiện
CREATE TABLE vehicle_images (
    image_id INT PRIMARY KEY AUTO_INCREMENT,             -- ID hình ảnh
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    image_url VARCHAR(500) NOT NULL,                     -- URL hình ảnh
    image_type VARCHAR(20),                              -- Loại (main, thumbnail, interior, exterior)
    display_order INT DEFAULT 0,                         -- Thứ tự hiển thị
    is_video BOOLEAN DEFAULT FALSE,                      -- Có phải video không
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

-- Bảng vị trí phương tiện
CREATE TABLE vehicle_locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,          -- ID vị trí
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    address TEXT NOT NULL,                               -- Địa chỉ
    latitude DECIMAL(10,8),                              -- Vĩ độ
    longitude DECIMAL(11,8),                             -- Kinh độ
    city VARCHAR(100),                                   -- Thành phố
    district VARCHAR(100),                               -- Quận/Huyện
    is_pickup_point BOOLEAN DEFAULT TRUE,                -- Có phải điểm nhận xe không
    is_return_point BOOLEAN DEFAULT TRUE,                -- Có phải điểm trả xe không
    operating_hours TEXT,                                -- Giờ hoạt động
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

-- Bảng đơn đặt xe
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID đơn đặt
    booking_code VARCHAR(20) UNIQUE NOT NULL,            -- Mã đơn đặt (RENT20230001)
    user_id INT NOT NULL,                                -- ID người đặt
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    pickup_location_id INT NOT NULL,                     -- ID điểm nhận xe
    return_location_id INT NOT NULL,                     -- ID điểm trả xe
    pickup_date DATETIME NOT NULL,                       -- Ngày giờ nhận xe
    return_date DATETIME NOT NULL,                       -- Ngày giờ trả xe
    total_days INT,                                      -- Tổng số ngày thuê
    daily_rate DECIMAL(12,2) NOT NULL,                   -- Giá thuê/ngày tại thời điểm đặt
    base_amount DECIMAL(12,2) NOT NULL,                  -- Tổng tiền thuê cơ bản
    insurance_fee DECIMAL(12,2),                         -- Phí bảo hiểm
    service_fee DECIMAL(12,2),                           -- Phí dịch vụ
    discount_amount DECIMAL(12,2) DEFAULT 0,             -- Số tiền giảm giá
    total_amount DECIMAL(12,2) NOT NULL,                 -- Tổng số tiền phải thanh toán
    deposit_amount DECIMAL(12,2),                        -- Tiền cọc
    status VARCHAR(20) DEFAULT 'pending',                -- Trạng thái: pending, confirmed, paid, active, completed, cancelled
    payment_status VARCHAR(20) DEFAULT 'unpaid',         -- Trạng thái thanh toán: unpaid, partially_paid, paid, refunded
    payment_method VARCHAR(50),                          -- Phương thức thanh toán
    notes TEXT,                                          -- Ghi chú
    cancellation_reason TEXT,                            -- Lý do hủy
    cancelled_at TIMESTAMP,                              -- Thời điểm hủy
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (pickup_location_id) REFERENCES vehicle_locations(location_id),
    FOREIGN KEY (return_location_id) REFERENCES vehicle_locations(location_id)
);

-- Bảng thanh toán
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID thanh toán
    booking_id INT NOT NULL,                             -- ID đơn đặt
    payment_code VARCHAR(50) UNIQUE,                     -- Mã thanh toán
    amount DECIMAL(12,2) NOT NULL,                       -- Số tiền thanh toán
    payment_method VARCHAR(50) NOT NULL,                 -- Phương thức thanh toán
    payment_gateway VARCHAR(50),                         -- Cổng thanh toán
    transaction_id VARCHAR(100),                         -- ID giao dịch từ cổng
    payment_date TIMESTAMP,                              -- Ngày thanh toán
    status VARCHAR(20) DEFAULT 'pending',                -- Trạng thái: pending, completed, failed, refunded
    notes TEXT,                                          -- Ghi chú
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Bảng đánh giá và xếp hạng
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,            -- ID đánh giá
    booking_id INT UNIQUE NOT NULL,                      -- ID đơn đặt (1 booking chỉ được đánh giá 1 lần)
    user_id INT NOT NULL,                                -- ID người đánh giá
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 0 AND rating <= 5), -- Điểm đánh giá (0-5)
    title VARCHAR(200),                                  -- Tiêu đề đánh giá
    comment TEXT,                                        -- Nội dung đánh giá
    cleanliness_rating INT CHECK (cleanliness_rating >= 0 AND cleanliness_rating <= 5), -- Vệ sinh
    condition_rating INT CHECK (condition_rating >= 0 AND condition_rating <= 5),       -- Tình trạng xe
    service_rating INT CHECK (service_rating >= 0 AND service_rating <= 5),             -- Dịch vụ
    is_verified BOOLEAN DEFAULT FALSE,                   -- Đánh giá đã xác thực (chỉ user đã thuê mới được đánh)
    helpful_count INT DEFAULT 0,                         -- Số người thấy hữu ích
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Bảng danh sách yêu thích
CREATE TABLE wishlists (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,          -- ID yêu thích
    user_id INT NOT NULL,                                -- ID người dùng
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_wishlist (user_id, vehicle_id),    -- Mỗi user chỉ thích 1 xe 1 lần
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

-- Bảng chia sẻ/xem phương tiện
CREATE TABLE vehicle_shares (
    share_id INT PRIMARY KEY AUTO_INCREMENT,             -- ID chia sẻ
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    user_id INT,                                         -- ID người chia sẻ (có thể NULL nếu chưa đăng nhập)
    share_platform VARCHAR(50),                          -- Nền tảng chia sẻ (facebook, twitter...)
    ip_address VARCHAR(45),                              -- Địa chỉ IP
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Bảng xem phương tiện real-time
CREATE TABLE vehicle_views (
    view_id INT PRIMARY KEY AUTO_INCREMENT,              -- ID lượt xem
    vehicle_id INT NOT NULL,                             -- ID phương tiện
    user_id INT,                                         -- ID người xem (NULL nếu khách)
    session_id VARCHAR(100),                             -- ID phiên
    ip_address VARCHAR(45),                              -- Địa chỉ IP
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       -- Thời điểm xem
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Bảng tin nhắn chatbot
CREATE TABLE chatbot_messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID tin nhắn
    session_id VARCHAR(100) NOT NULL,                    -- ID phiên chatbot
    user_id INT,                                         -- ID người dùng (NULL nếu chưa đăng nhập)
    message_type VARCHAR(10) NOT NULL,                   -- Loại: user, bot
    message_content TEXT NOT NULL,                       -- Nội dung tin nhắn
    intent VARCHAR(50),                                  -- Mục đích tin nhắn (hỏi giá, dịch vụ...)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Bảng chủ đề bài viết/blog
CREATE TABLE blog_posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,              -- ID bài viết
    title VARCHAR(200) NOT NULL,                         -- Tiêu đề
    slug VARCHAR(200) UNIQUE NOT NULL,                   -- URL slug
    excerpt TEXT,                                        -- Tóm tắt
    content LONGTEXT NOT NULL,                           -- Nội dung đầy đủ
    author_id INT,                                       -- ID tác giả
    category VARCHAR(50),                                -- Danh mục
    featured_image VARCHAR(500),                         -- Ảnh đại diện
    is_published BOOLEAN DEFAULT FALSE,                  -- Đã xuất bản chưa
    published_at TIMESTAMP,                              -- Thời điểm xuất bản
    view_count INT DEFAULT 0,                            -- Số lượt xem
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(user_id)
);

-- Bảng liên hệ/phản hồi
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID liên hệ
    full_name VARCHAR(100) NOT NULL,                     -- Họ tên
    email VARCHAR(100) NOT NULL,                         -- Email
    phone VARCHAR(20),                                   -- Số điện thoại
    subject VARCHAR(200) NOT NULL,                       -- Chủ đề
    message TEXT NOT NULL,                               -- Nội dung
    status VARCHAR(20) DEFAULT 'unread',                 -- Trạng thái: unread, read, replied
    replied_at TIMESTAMP,                                -- Thời điểm phản hồi
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng cài đặt hệ thống
CREATE TABLE settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,           -- ID cài đặt
    setting_key VARCHAR(100) UNIQUE NOT NULL,            -- Khóa cài đặt
    setting_value TEXT,                                  -- Giá trị cài đặt
    setting_type VARCHAR(20) DEFAULT 'text',             -- Loại: text, number, boolean, json
    category VARCHAR(50) DEFAULT 'general',              -- Nhóm: general, email, payment, seo
    description TEXT,                                    -- Mô tả
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- Dữ liệu mẫu cơ bản
-- ============================================

-- Thêm loại phương tiện
INSERT INTO vehicle_categories (category_name, description, icon_class, display_order) VALUES
('Xe máy', 'Đa dạng các dòng xe máy từ phổ thông đến cao cấp', 'fas fa-motorcycle', 1),
('Xe điện', 'Xe điện thân thiện với môi trường, tiết kiệm nhiên liệu', 'fas fa-bolt', 2),
('Ô tô', 'Cho thuê ô tô tự lái với nhiều dòng xe', 'fas fa-car', 3);

-- Thêm nhãn hiệu
INSERT INTO vehicle_brands (brand_name, country, description) VALUES
('Honda', 'Nhật Bản', 'Hãng xe máy và ô tô hàng đầu Nhật Bản'),
('Yamaha', 'Nhật Bản', 'Hãng xe máy thể thao nổi tiếng'),
('Vinfast', 'Việt Nam', 'Hãng xe Việt Nam chất lượng cao'),
('Toyota', 'Nhật Bản', 'Hãng ô tô uy tín toàn cầu');

-- Thêm cài đặt hệ thống
INSERT INTO settings (setting_key, setting_value, setting_type, category, description) VALUES
('site_name', 'RentCar', 'text', 'general', 'Tên website'),
('contact_email', 'info@rentcar.com', 'text', 'general', 'Email liên hệ'),
('contact_phone', '+84 123 456 789', 'text', 'general', 'Số điện thoại'),
('default_insurance_fee_percent', '20', 'number', 'payment', 'Phần trăm phí bảo hiểm mặc định'),
('default_service_fee', '20000', 'number', 'payment', 'Phí dịch vụ mặc định (VNĐ)');

-- ============================================
-- Các INDEX để tối ưu hiệu suất
-- ============================================

-- Index cho bảng users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone_number);

-- Index cho bảng vehicles
CREATE INDEX idx_vehicles_category ON vehicles(category_id);
CREATE INDEX idx_vehicles_brand ON vehicles(brand_id);
CREATE INDEX idx_vehicles_availability ON vehicles(is_available, is_featured);
CREATE INDEX idx_vehicles_price ON vehicles(daily_rate);

-- Index cho bảng bookings
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_vehicle ON bookings(vehicle_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_dates ON bookings(pickup_date, return_date);

-- Index cho bảng reviews
CREATE INDEX idx_reviews_vehicle ON reviews(vehicle_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- Index cho bảng wishlists
CREATE INDEX idx_wishlists_user ON wishlists(user_id);
CREATE INDEX idx_wishlists_vehicle ON wishlists(vehicle_id);

-- ============================================
-- VIEWS cho báo cáo
-- ============================================

-- View thống kê doanh thu theo tháng
CREATE VIEW monthly_revenue AS
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    COUNT(payment_id) AS total_transactions,
    SUM(amount) AS total_revenue
FROM payments 
WHERE status = 'completed'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m');

-- View xe được yêu thích nhất
CREATE VIEW popular_vehicles AS
SELECT 
    v.vehicle_id,
    v.license_plate,
    v.model_name,
    b.brand_name,
    COUNT(w.wishlist_id) AS wishlist_count,
    COUNT(r.review_id) AS review_count,
    AVG(r.rating) AS avg_rating
FROM vehicles v
LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id
LEFT JOIN wishlists w ON v.vehicle_id = w.vehicle_id
LEFT JOIN reviews r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id
ORDER BY wishlist_count DESC, avg_rating DESC;

-- View đánh giá xe chi tiết
CREATE VIEW vehicle_reviews_summary AS
SELECT 
    v.vehicle_id,
    v.model_name,
    b.brand_name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating,
    AVG(r.cleanliness_rating) AS avg_cleanliness,
    AVG(r.condition_rating) AS avg_condition,
    AVG(r.service_rating) AS avg_service
FROM vehicles v
LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id
LEFT JOIN reviews r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id;