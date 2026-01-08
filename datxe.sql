-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 08, 2026 lúc 07:53 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `datxe`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `blog_posts`
--

CREATE TABLE `blog_posts` (
  `post_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `featured_image` varchar(500) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT 0,
  `published_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `booking_code` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `pickup_location_id` int(11) NOT NULL,
  `return_location_id` int(11) NOT NULL,
  `pickup_date` datetime NOT NULL,
  `return_date` datetime NOT NULL,
  `total_days` int(11) DEFAULT NULL,
  `daily_rate` decimal(12,2) NOT NULL,
  `base_amount` decimal(12,2) NOT NULL,
  `insurance_fee` decimal(12,2) DEFAULT NULL,
  `service_fee` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL,
  `deposit_amount` decimal(12,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `payment_status` varchar(20) DEFAULT 'unpaid',
  `payment_method` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `cancelled_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `bookings`
--

INSERT INTO `bookings` (`booking_id`, `booking_code`, `user_id`, `vehicle_id`, `pickup_location_id`, `return_location_id`, `pickup_date`, `return_date`, `total_days`, `daily_rate`, `base_amount`, `insurance_fee`, `service_fee`, `discount_amount`, `total_amount`, `deposit_amount`, `status`, `payment_status`, `payment_method`, `notes`, `cancellation_reason`, `cancelled_at`, `created_at`, `updated_at`) VALUES
(2, 'RENT20260001', 1, 1, 1, 1, '2026-01-08 17:00:00', '2026-01-09 17:00:00', 1, 120000.00, 120000.00, 24000.00, 20000.00, 0.00, 164000.00, 120000.00, 'pending', 'unpaid', 'cash', NULL, NULL, '2026-01-08 18:52:04', '2026-01-08 18:52:04', '2026-01-08 18:52:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chatbot_messages`
--

CREATE TABLE `chatbot_messages` (
  `message_id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message_type` varchar(10) NOT NULL,
  `message_content` text NOT NULL,
  `intent` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(20) DEFAULT 'unread',
  `replied_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `monthly_revenue`
-- (See below for the actual view)
--
CREATE TABLE `monthly_revenue` (
`month` varchar(7)
,`total_transactions` bigint(21)
,`total_revenue` decimal(34,2)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `payment_code` varchar(50) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_gateway` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `popular_vehicles`
-- (See below for the actual view)
--
CREATE TABLE `popular_vehicles` (
`vehicle_id` int(11)
,`license_plate` varchar(20)
,`model_name` varchar(100)
,`brand_name` varchar(50)
,`wishlist_count` bigint(21)
,`review_count` bigint(21)
,`avg_rating` decimal(7,6)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `rating` decimal(3,2) NOT NULL CHECK (`rating` >= 0 and `rating` <= 5),
  `title` varchar(200) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `cleanliness_rating` int(11) DEFAULT NULL CHECK (`cleanliness_rating` >= 0 and `cleanliness_rating` <= 5),
  `condition_rating` int(11) DEFAULT NULL CHECK (`condition_rating` >= 0 and `condition_rating` <= 5),
  `service_rating` int(11) DEFAULT NULL CHECK (`service_rating` >= 0 and `service_rating` <= 5),
  `is_verified` tinyint(1) DEFAULT 0,
  `helpful_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `settings`
--

CREATE TABLE `settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` varchar(20) DEFAULT 'text',
  `category` varchar(50) DEFAULT 'general',
  `description` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `settings`
--

INSERT INTO `settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `category`, `description`, `updated_at`) VALUES
(1, 'site_name', 'RentCar', 'text', 'general', 'Tên website', '2026-01-08 18:30:39'),
(2, 'contact_email', 'info@rentcar.com', 'text', 'general', 'Email liên hệ', '2026-01-08 18:30:39'),
(3, 'contact_phone', '+84 123 456 789', 'text', 'general', 'Số điện thoại', '2026-01-08 18:30:39'),
(4, 'default_insurance_fee_percent', '20', 'number', 'payment', 'Phần trăm phí bảo hiểm mặc định', '2026-01-08 18:30:39'),
(5, 'default_service_fee', '20000', 'number', 'payment', 'Phí dịch vụ mặc định (VNĐ)', '2026-01-08 18:30:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `avatar_url` varchar(500) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `identity_card` varchar(20) DEFAULT NULL,
  `driver_license_number` varchar(20) DEFAULT NULL,
  `driver_license_type` varchar(10) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `email`, `password_hash`, `full_name`, `phone_number`, `avatar_url`, `date_of_birth`, `identity_card`, `driver_license_number`, `driver_license_type`, `address`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'truongqb05x@gmail.com', 't9bsmGn95P48yRlT2xjV/w==:9ES4V7uB3QbE3/CtgiyJM+tD1w4HlbR2Lw5C0x86Njw=', 'truong ngoc', '0945748231', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2026-01-08 18:49:46', '2026-01-08 18:49:46');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` int(11) NOT NULL,
  `license_plate` varchar(20) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `model_year` year(4) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `fuel_type` varchar(20) DEFAULT NULL,
  `transmission` varchar(20) DEFAULT NULL,
  `engine_capacity` varchar(20) DEFAULT NULL,
  `seat_capacity` int(11) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `daily_rate` decimal(12,2) NOT NULL,
  `weekly_rate` decimal(12,2) DEFAULT NULL,
  `monthly_rate` decimal(12,2) DEFAULT NULL,
  `deposit_amount` decimal(12,2) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `is_featured` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `specifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`specifications`)),
  `amenities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`amenities`)),
  `rating` decimal(3,2) DEFAULT 0.00,
  `total_rentals` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `vehicles`
--

INSERT INTO `vehicles` (`vehicle_id`, `license_plate`, `brand_id`, `model_name`, `model_year`, `category_id`, `fuel_type`, `transmission`, `engine_capacity`, `seat_capacity`, `color`, `daily_rate`, `weekly_rate`, `monthly_rate`, `deposit_amount`, `is_available`, `is_featured`, `description`, `specifications`, `amenities`, `rating`, `total_rentals`, `created_at`, `updated_at`) VALUES
(1, '75-H1-12345', 1, 'Vision', '2023', 1, 'Xăng', 'Tự động', '110cc', 2, 'Trắng', 120000.00, 750000.00, 2500000.00, 1000000.00, 1, 1, 'Honda Vision đời mới, tiết kiệm xăng, phù hợp di chuyển trong thành phố', '{\"Công suất\": \"8.8 HP\", \"Mức tiêu hao\": \"1.9L/100km\"}', '[\"Khóa thông minh\", \"Cốp rộng\"]', 4.60, 120, '2026-01-08 18:31:33', '2026-01-08 18:31:33'),
(2, '75-Y2-67890', 2, 'Exciter 155', '2022', 1, 'Xăng', 'Số sàn', '155cc', 2, 'Xanh GP', 180000.00, 1100000.00, 3600000.00, 1500000.00, 1, 1, 'Yamaha Exciter 155 mạnh mẽ, phong cách thể thao', '{\"Công suất\": \"17.7 HP\", \"ABS\": \"Có\"}', '[\"ABS\", \"Đồng hồ LCD\"]', 4.80, 95, '2026-01-08 18:31:33', '2026-01-08 18:31:33'),
(3, '75-VF-E01', 3, 'VinFast Evo200', '2023', 2, 'Điện', 'Tự động', '2000W', 2, 'Đỏ', 150000.00, 900000.00, 2800000.00, 1200000.00, 1, 1, 'Xe điện VinFast Evo200, pin bền, chạy êm, thân thiện môi trường', '{\"Quãng đường\": \"200km\", \"Thời gian sạc\": \"8 giờ\"}', '[\"Pin Lithium\", \"Định vị GPS\"]', 4.50, 60, '2026-01-08 18:31:33', '2026-01-08 18:31:33'),
(4, '75A-99999', 4, 'Vios', '2021', 3, 'Xăng', 'Tự động', '1.5L', 5, 'Đen', 850000.00, 5200000.00, 15000000.00, 5000000.00, 1, 1, 'Toyota Vios số tự động, xe gia đình rộng rãi, tiết kiệm nhiên liệu', '{\"Túi khí\": \"6\", \"Mức tiêu hao\": \"5.7L/100km\"}', '[\"Điều hòa\", \"Camera lùi\", \"Màn hình Android\"]', 4.70, 140, '2026-01-08 18:31:33', '2026-01-08 18:31:33');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_brands`
--

CREATE TABLE `vehicle_brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(50) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `vehicle_brands`
--

INSERT INTO `vehicle_brands` (`brand_id`, `brand_name`, `country`, `logo_url`, `description`, `is_active`) VALUES
(1, 'Honda', 'Nhật Bản', NULL, 'Hãng xe máy và ô tô hàng đầu Nhật Bản', 1),
(2, 'Yamaha', 'Nhật Bản', NULL, 'Hãng xe máy thể thao nổi tiếng', 1),
(3, 'Vinfast', 'Việt Nam', NULL, 'Hãng xe Việt Nam chất lượng cao', 1),
(4, 'Toyota', 'Nhật Bản', NULL, 'Hãng ô tô uy tín toàn cầu', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `icon_class` varchar(50) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`category_id`, `category_name`, `description`, `icon_class`, `display_order`, `is_active`) VALUES
(1, 'Xe máy', 'Đa dạng các dòng xe máy từ phổ thông đến cao cấp', 'fas fa-motorcycle', 1, 1),
(2, 'Xe điện', 'Xe điện thân thiện với môi trường, tiết kiệm nhiên liệu', 'fas fa-bolt', 2, 1),
(3, 'Ô tô', 'Cho thuê ô tô tự lái với nhiều dòng xe', 'fas fa-car', 3, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_images`
--

CREATE TABLE `vehicle_images` (
  `image_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `image_type` varchar(20) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_video` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `vehicle_images`
--

INSERT INTO `vehicle_images` (`image_id`, `vehicle_id`, `image_url`, `image_type`, `display_order`, `is_video`, `created_at`) VALUES
(1, 1, 'https://cdn.rentcar.com/vision/main.jpg', 'main', 1, 0, '2026-01-08 18:31:42'),
(2, 2, 'https://cdn.rentcar.com/exciter/main.jpg', 'main', 1, 0, '2026-01-08 18:31:42'),
(3, 3, 'https://cdn.rentcar.com/evo200/main.jpg', 'main', 1, 0, '2026-01-08 18:31:42'),
(4, 4, 'https://cdn.rentcar.com/vios/main.jpg', 'main', 1, 0, '2026-01-08 18:31:42');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_locations`
--

CREATE TABLE `vehicle_locations` (
  `location_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `address` text NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `is_pickup_point` tinyint(1) DEFAULT 1,
  `is_return_point` tinyint(1) DEFAULT 1,
  `operating_hours` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `vehicle_locations`
--

INSERT INTO `vehicle_locations` (`location_id`, `vehicle_id`, `address`, `latitude`, `longitude`, `city`, `district`, `is_pickup_point`, `is_return_point`, `operating_hours`, `created_at`) VALUES
(1, 1, '123 Đường ABC, Quận 1', 10.77565800, 106.70175500, 'Hồ Chí Minh', 'Quận 1', 1, 1, NULL, '2026-01-08 18:51:39'),
(2, 2, '456 Đường XYZ, Quận 2', 10.78701100, 106.74917800, 'Hồ Chí Minh', 'Quận 2', 1, 1, NULL, '2026-01-08 18:51:39'),
(3, 3, '789 Đường LMN, Quận 3', 10.78219200, 106.68600500, 'Hồ Chí Minh', 'Quận 3', 1, 1, NULL, '2026-01-08 18:51:39'),
(4, 4, '321 Đường DEF, Quận 4', 10.76262200, 106.70528200, 'Hồ Chí Minh', 'Quận 4', 1, 1, NULL, '2026-01-08 18:51:39');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `vehicle_reviews_summary`
-- (See below for the actual view)
--
CREATE TABLE `vehicle_reviews_summary` (
`vehicle_id` int(11)
,`model_name` varchar(100)
,`brand_name` varchar(50)
,`total_reviews` bigint(21)
,`average_rating` decimal(7,6)
,`avg_cleanliness` decimal(14,4)
,`avg_condition` decimal(14,4)
,`avg_service` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_shares`
--

CREATE TABLE `vehicle_shares` (
  `share_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `share_platform` varchar(50) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vehicle_views`
--

CREATE TABLE `vehicle_views` (
  `view_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` varchar(100) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `wishlists`
--

CREATE TABLE `wishlists` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `monthly_revenue`
--
DROP TABLE IF EXISTS `monthly_revenue`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `monthly_revenue`  AS SELECT date_format(`payments`.`payment_date`,'%Y-%m') AS `month`, count(`payments`.`payment_id`) AS `total_transactions`, sum(`payments`.`amount`) AS `total_revenue` FROM `payments` WHERE `payments`.`status` = 'completed' GROUP BY date_format(`payments`.`payment_date`,'%Y-%m') ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `popular_vehicles`
--
DROP TABLE IF EXISTS `popular_vehicles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `popular_vehicles`  AS SELECT `v`.`vehicle_id` AS `vehicle_id`, `v`.`license_plate` AS `license_plate`, `v`.`model_name` AS `model_name`, `b`.`brand_name` AS `brand_name`, count(`w`.`wishlist_id`) AS `wishlist_count`, count(`r`.`review_id`) AS `review_count`, avg(`r`.`rating`) AS `avg_rating` FROM (((`vehicles` `v` left join `vehicle_brands` `b` on(`v`.`brand_id` = `b`.`brand_id`)) left join `wishlists` `w` on(`v`.`vehicle_id` = `w`.`vehicle_id`)) left join `reviews` `r` on(`v`.`vehicle_id` = `r`.`vehicle_id`)) GROUP BY `v`.`vehicle_id` ORDER BY count(`w`.`wishlist_id`) DESC, avg(`r`.`rating`) DESC ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `vehicle_reviews_summary`
--
DROP TABLE IF EXISTS `vehicle_reviews_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vehicle_reviews_summary`  AS SELECT `v`.`vehicle_id` AS `vehicle_id`, `v`.`model_name` AS `model_name`, `b`.`brand_name` AS `brand_name`, count(`r`.`review_id`) AS `total_reviews`, avg(`r`.`rating`) AS `average_rating`, avg(`r`.`cleanliness_rating`) AS `avg_cleanliness`, avg(`r`.`condition_rating`) AS `avg_condition`, avg(`r`.`service_rating`) AS `avg_service` FROM ((`vehicles` `v` left join `vehicle_brands` `b` on(`v`.`brand_id` = `b`.`brand_id`)) left join `reviews` `r` on(`v`.`vehicle_id` = `r`.`vehicle_id`)) GROUP BY `v`.`vehicle_id` ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`post_id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `author_id` (`author_id`);

--
-- Chỉ mục cho bảng `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD UNIQUE KEY `booking_code` (`booking_code`),
  ADD KEY `pickup_location_id` (`pickup_location_id`),
  ADD KEY `return_location_id` (`return_location_id`),
  ADD KEY `idx_bookings_user` (`user_id`),
  ADD KEY `idx_bookings_vehicle` (`vehicle_id`),
  ADD KEY `idx_bookings_status` (`status`),
  ADD KEY `idx_bookings_dates` (`pickup_date`,`return_date`);

--
-- Chỉ mục cho bảng `chatbot_messages`
--
ALTER TABLE `chatbot_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `payment_code` (`payment_code`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `booking_id` (`booking_id`),
  ADD KEY `idx_reviews_vehicle` (`vehicle_id`),
  ADD KEY `idx_reviews_user` (`user_id`),
  ADD KEY `idx_reviews_rating` (`rating`);

--
-- Chỉ mục cho bảng `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `identity_card` (`identity_card`),
  ADD UNIQUE KEY `driver_license_number` (`driver_license_number`),
  ADD KEY `idx_users_email` (`email`),
  ADD KEY `idx_users_phone` (`phone_number`);

--
-- Chỉ mục cho bảng `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `license_plate` (`license_plate`),
  ADD KEY `idx_vehicles_category` (`category_id`),
  ADD KEY `idx_vehicles_brand` (`brand_id`),
  ADD KEY `idx_vehicles_availability` (`is_available`,`is_featured`),
  ADD KEY `idx_vehicles_price` (`daily_rate`);

--
-- Chỉ mục cho bảng `vehicle_brands`
--
ALTER TABLE `vehicle_brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Chỉ mục cho bảng `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `vehicle_images`
--
ALTER TABLE `vehicle_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- Chỉ mục cho bảng `vehicle_locations`
--
ALTER TABLE `vehicle_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- Chỉ mục cho bảng `vehicle_shares`
--
ALTER TABLE `vehicle_shares`
  ADD PRIMARY KEY (`share_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `vehicle_views`
--
ALTER TABLE `vehicle_views`
  ADD PRIMARY KEY (`view_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD UNIQUE KEY `unique_wishlist` (`user_id`,`vehicle_id`),
  ADD KEY `idx_wishlists_user` (`user_id`),
  ADD KEY `idx_wishlists_vehicle` (`vehicle_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `chatbot_messages`
--
ALTER TABLE `chatbot_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `settings`
--
ALTER TABLE `settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `vehicle_brands`
--
ALTER TABLE `vehicle_brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `vehicle_images`
--
ALTER TABLE `vehicle_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `vehicle_locations`
--
ALTER TABLE `vehicle_locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `vehicle_shares`
--
ALTER TABLE `vehicle_shares`
  MODIFY `share_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `vehicle_views`
--
ALTER TABLE `vehicle_views`
  MODIFY `view_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`pickup_location_id`) REFERENCES `vehicle_locations` (`location_id`),
  ADD CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`return_location_id`) REFERENCES `vehicle_locations` (`location_id`);

--
-- Các ràng buộc cho bảng `chatbot_messages`
--
ALTER TABLE `chatbot_messages`
  ADD CONSTRAINT `chatbot_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`);

--
-- Các ràng buộc cho bảng `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `vehicle_brands` (`brand_id`),
  ADD CONSTRAINT `vehicles_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `vehicle_categories` (`category_id`);

--
-- Các ràng buộc cho bảng `vehicle_images`
--
ALTER TABLE `vehicle_images`
  ADD CONSTRAINT `vehicle_images_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `vehicle_locations`
--
ALTER TABLE `vehicle_locations`
  ADD CONSTRAINT `vehicle_locations_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `vehicle_shares`
--
ALTER TABLE `vehicle_shares`
  ADD CONSTRAINT `vehicle_shares_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`),
  ADD CONSTRAINT `vehicle_shares_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `vehicle_views`
--
ALTER TABLE `vehicle_views`
  ADD CONSTRAINT `vehicle_views_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`),
  ADD CONSTRAINT `vehicle_views_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlists_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
