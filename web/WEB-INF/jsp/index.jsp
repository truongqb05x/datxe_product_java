<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RentCar - Cho thuê xe máy, xe điện, ô tô</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/logo.png" type="image/x-icon">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/pages/index.css">
</head>
<body>
    <!-- Full Page Loading -->
    <div class="full-page-loading" id="fullPageLoading">
        <div class="loading-logo">
            <i class="fas fa-car"></i>
        </div>
        <div class="loading-text">Đang tải dữ liệu...</div>
        <div class="spinner"></div>
    </div>

    <!-- Header -->
    <header>
        <div class="header-container">
            <div class="logo">
                <i class="fas fa-car"></i>
                <h1>Rent<span>Car</span></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="#" class="active">Trang chủ</a></li>
                    <li><a href="#">Thuê Xe máy</a></li>
                    <li><a href="#">Thuê Ô tô</a></li>
                </ul>
            </nav>
            <div class="auth-buttons" id="authButtons">
                <button class="btn btn-outline" id="loginBtn">Đăng nhập</button>
                <button class="btn btn-primary" id="registerBtn">Đăng ký</button>
            </div>
            
            <!-- User Avatar (hidden by default) -->
            <div class="user-avatar" id="userAvatar" style="display: none;">
                <div class="avatar-placeholder" id="avatarPlaceholder">U</div>
                <div class="user-dropdown">
                    <ul>
                        <li><a href="#"><i class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="#"><i class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                        <li><a href="#"><i class="fas fa-heart"></i> Xe yêu thích</a></li>
                        <li class="divider"></li>
                        <li><a href="#" id="logoutBtn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
            
            <button class="mobile-menu-btn" id="mobileMenuBtn">
                <i class="fas fa-bars"></i>
            </button>
        </div>
        
        <!-- Mobile Menu -->
        <div class="mobile-menu" id="mobileMenu">
            <ul>
                <li><a href="#" class="active">Trang chủ</a></li>
                <li><a href="#">Xe máy</a></li>
                <li><a href="#">Xe điện</a></li>
                <li><a href="#">Ô tô</a></li>
                <li><a href="#">Về chúng tôi</a></li>
                <li><a href="#">Liên hệ</a></li>
                <li>
                    <div class="auth-buttons-mobile" id="authButtonsMobile">
                        <button class="btn btn-outline" id="loginBtnMobile" style="width: 100%; margin-bottom: 0.5rem;">Đăng nhập</button>
                        <button class="btn btn-primary" id="registerBtnMobile" style="width: 100%;">Đăng ký</button>
                    </div>
                    <div class="user-avatar-mobile" id="userAvatarMobile" style="display: none;">
                        <div class="avatar-placeholder">U</div>
                        <div class="user-info">
                            <p>Xin chào, <span id="mobileUserName">Người dùng</span></p>
                            <a href="#" class="btn btn-outline" style="width: 100%; margin-top: 0.5rem;" id="logoutBtnMobile">Đăng xuất</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </header>

    <!-- Auth Modal -->
    <div class="auth-modal" id="authModal">
        <div class="auth-container">
            <div class="auth-header">
                <h2 id="authTitle">Đăng nhập</h2>
                <button class="close-auth" id="closeAuth">&times;</button>
            </div>
            
            <div class="auth-tabs">
                <button class="auth-tab active" id="loginTab">Đăng nhập</button>
                <button class="auth-tab" id="registerTab">Đăng ký</button>
            </div>
            
            <form class="auth-form active" id="loginForm" action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <label for="loginEmail">Email</label>
                    <input type="email" id="loginEmail" name="email" placeholder="Nhập email của bạn" required>
                </div>
                
                <div class="form-group">
                    <label for="loginPassword">Mật khẩu</label>
                    <input type="password" id="loginPassword" name="password" placeholder="Nhập mật khẩu" required>
                </div>
                
                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="#" class="forgot-password">Quên mật khẩu?</a>
                </div>
                
                <button type="submit" class="auth-submit">Đăng nhập</button>
                
                <div class="auth-footer">
                    Chưa có tài khoản? <a href="#" id="switchToRegister">Đăng ký ngay</a>
                </div>
            </form>
            
            <!-- Form đăng ký với layout 2 cột -->
            <form class="auth-form" id="registerForm" action="${pageContext.request.contextPath}/register" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label for="registerName">Họ và tên</label>
                        <input type="text" id="registerName" name="fullName" placeholder="Nhập họ và tên" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="registerPhone">Số điện thoại</label>
                        <input type="tel" id="registerPhone" name="phone" placeholder="Nhập số điện thoại" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="registerEmail">Email</label>
                    <input type="email" id="registerEmail" name="email" placeholder="Nhập email của bạn" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="registerPassword">Mật khẩu</label>
                        <input type="password" id="registerPassword" name="password" placeholder="Tạo mật khẩu" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="registerConfirmPassword">Xác nhận mật khẩu</label>
                        <input type="password" id="registerConfirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                    </div>
                </div>
                
                <button type="submit" class="auth-submit">Đăng ký</button>
                
                <div class="auth-footer">
                    Đã có tài khoản? <a href="#" id="switchToLogin">Đăng nhập ngay</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h2>Thuê Xe Dễ Dàng - Di Chuyển Thoải Mái</h2>
            <p>Dịch vụ cho thuê xe máy, xe điện, ô tô chất lượng cao với giá cả hợp lý. Đặt xe ngay hôm nay!</p>
            
            <div class="search-box">
                <div class="search-field">
                    <label for="vehicle-type">Loại xe</label>
                    <select id="vehicle-type">
                        <option value="">Tất cả loại xe</option>
                        <option value="motorcycle">Xe máy</option>
                        <option value="electric">Xe điện</option>
                        <option value="car">Ô tô</option>
                    </select>
                </div>
                <div class="search-field">
                    <label for="pickup-date">Ngày nhận</label>
                    <input type="date" id="pickup-date">
                </div>
                <div class="search-field">
                    <label for="return-date">Ngày trả</label>
                    <input type="date" id="return-date">
                </div>
                <div class="search-field search-btn">
                    <button class="btn btn-primary" style="width: 100%;">Tìm kiếm</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories -->
    <section class="categories">
        <div class="section-title">
            <h2>Dịch Vụ Của Chúng Tôi</h2>
            <p>Lựa chọn phương tiện phù hợp với nhu cầu của bạn</p>
        </div>
        <div class="category-cards">
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Xe máy">
                </div>
                <div class="category-content">
                    <h3>Xe Máy</h3>
                    <p>Đa dạng các dòng xe máy từ phổ thông đến cao cấp, phù hợp với mọi nhu cầu di chuyển.</p>
                    <button class="btn btn-outline">Xem thêm</button>
                </div>
            </div>
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Xe điện">
                </div>
                <div class="category-content">
                    <h3>Xe Điện</h3>
                    <p>Xe điện thân thiện với môi trường, tiết kiệm nhiên liệu, dễ dàng sử dụng.</p>
                    <button class="btn btn-outline">Xem thêm</button>
                </div>
            </div>
            <div class="category-card">
                <div class="category-img">
                    <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Ô tô">
                </div>
                <div class="category-content">
                    <h3>Ô Tô</h3>
                    <p>Cho thuê ô tô tự lái với nhiều dòng xe từ 4 chỗ đến 7 chỗ, đáp ứng mọi nhu cầu.</p>
                    <button class="btn btn-outline">Xem thêm</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Vehicles -->
    <section class="featured-vehicles">
        <div class="vehicles-container">
            <div class="section-title">
                <h2>Xe Nổi Bật</h2>
                <p>Những phương tiện được thuê nhiều nhất</p>
            </div>
            <div class="vehicle-cards">
                <!-- Honda Vision -->
                <div class="vehicle-card">
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                        <div class="vehicle-tag">Phổ biến</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Honda Vision</h3>
                        
                        <!-- Rating System -->
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>4.5 (128 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge eco-friendly">♻️ Tiết kiệm</span>
                                <span class="badge popular">🔥 Phổ biến</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-gas-pump"></i> Xăng</span>
                            <span><i class="fas fa-user"></i> 2 người</span>
                            <span><i class="fas fa-cog"></i> Tự động</span>
                        </div>
                        <div class="vehicle-price">150.000đ <span>/ngày</span></div>
                        
                        <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('honda-vision')">Chi tiết xe</button>
                        <button class="btn btn-outline" style="width: 100%;">Thuê ngay</button>
                        
                        <!-- Social Features -->
                        <div class="social-features">
                            <button class="btn-share">
                                <i class="fas fa-share-alt"></i>
                                Chia sẻ
                            </button>
                            <button class="btn-wishlist">
                                <i class="fas fa-heart"></i>
                                Yêu thích
                            </button>
                            <div class="social-proof">
                                <span>👥 15 người đang xem</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Vinfast Klara -->
                <div class="vehicle-card">
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Vinfast Klara">
                        <div class="vehicle-tag">Tiết kiệm</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Vinfast Klara</h3>
                        
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <span>4.0 (96 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge eco-friendly">♻️ Thân thiện MT</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-bolt"></i> Điện</span>
                            <span><i class="fas fa-user"></i> 2 người</span>
                            <span><i class="fas fa-cog"></i> Tự động</span>
                        </div>
                        <div class="vehicle-price">120.000đ <span>/ngày</span></div>
                        
                        <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('vinfast-klara')">Chi tiết xe</button>
                        <button class="btn btn-outline" style="width: 100%;">Thuê ngay</button>
                        
                        <div class="social-features">
                            <button class="btn-share">
                                <i class="fas fa-share-alt"></i>
                                Chia sẻ
                            </button>
                            <button class="btn-wishlist">
                                <i class="fas fa-heart"></i>
                                Yêu thích
                            </button>
                            <div class="social-proof">
                                <span>👥 8 người đang xem</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Toyota Vios -->
                <div class="vehicle-card">
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Toyota Vios">
                        <div class="vehicle-tag">Ưa chuộng</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Toyota Vios</h3>
                        
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span>5.0 (204 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge popular">🔥 Bán chạy</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-gas-pump"></i> Xăng</span>
                            <span><i class="fas fa-user"></i> 5 người</span>
                            <span><i class="fas fa-cog"></i> Số sàn</span>
                        </div>
                        <div class="vehicle-price">600.000đ <span>/ngày</span></div>
                        
                        <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('toyota-vios')">Chi tiết xe</button>
                        <button class="btn btn-outline" style="width: 100%;">Thuê ngay</button>
                        
                        <div class="social-features">
                            <button class="btn-share">
                                <i class="fas fa-share-alt"></i>
                                Chia sẻ
                            </button>
                            <button class="btn-wishlist">
                                <i class="fas fa-heart"></i>
                                Yêu thích
                            </button>
                            <div class="social-proof">
                                <span>👥 22 người đang xem</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Yamaha Exciter -->
                <div class="vehicle-card">
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                        <div class="vehicle-tag">Thể thao</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Yamaha Exciter</h3>
                        
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>4.5 (167 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge popular">🔥 Thể thao</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-gas-pump"></i> Xăng</span>
                            <span><i class="fas fa-user"></i> 2 người</span>
                            <span><i class="fas fa-cog"></i> Số sàn</span>
                        </div>
                        <div class="vehicle-price">180.000đ <span>/ngày</span></div>
                        
                        <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('yamaha-exciter')">Chi tiết xe</button>
                        <button class="btn btn-outline" style="width: 100%;">Thuê ngay</button>
                        
                        <div class="social-features">
                            <button class="btn-share">
                                <i class="fas fa-share-alt"></i>
                                Chia sẻ
                            </button>
                            <button class="btn-wishlist">
                                <i class="fas fa-heart"></i>
                                Yêu thích
                            </button>
                            <div class="social-proof">
                                <span>👥 12 người đang xem</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Vehicle Modal -->
    <div class="modal" id="vehicleModal">
        <div class="modal-content">
            <button class="close-modal" id="closeModal">&times;</button>
            <div class="modal-header">
                <h2 id="modalVehicleName">Honda Vision 2023</h2>
                <div class="vehicle-rating">
                    <div class="rating-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span>4.5 (128 đánh giá)</span>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <div class="vehicle-gallery">
                    <div class="main-image">
                        <img id="mainImage" src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Xe chính">
                    </div>
                    <div class="thumbnail-container">
                        <img class="thumbnail" src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Hình 1" onclick="changeMainImage(this.src)">
                        <img class="thumbnail" src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Hình 2" onclick="changeMainImage(this.src)">
                        <img class="thumbnail" src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Hình 3" onclick="changeMainImage(this.src)">
                        <video class="thumbnail" onclick="playVideo(this)" poster="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80">
                            <source src="https://assets.mixkit.co/videos/preview/mixkit-white-sedan-on-a-road-34546-large.mp4" type="video/mp4">
                        </video>
                    </div>
                </div>

                <div class="vehicle-details-modal">
                    <div class="detail-section">
                        <h3>Thông số kỹ thuật</h3>
                        <div class="specs-grid">
                            <div class="spec-item">
                                <span class="spec-label">Loại xe:</span>
                                <span class="spec-value" id="specType">Xe máy</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Nhiên liệu:</span>
                                <span class="spec-value" id="specFuel">Xăng</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Số chỗ:</span>
                                <span class="spec-value" id="specSeats">2 người</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Hộp số:</span>
                                <span class="spec-value" id="specGear">Tự động</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Động cơ:</span>
                                <span class="spec-value" id="specEngine">110cc</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Màu sắc:</span>
                                <span class="spec-value" id="specColor">Đen, Trắng, Xanh</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h3>Tiện nghi & An toàn</h3>
                        <div class="specs-grid">
                            <div class="spec-item">
                                <span class="spec-label">Điều hòa:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Camera lùi:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Cảm biến va chạm:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Bluetooth:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">GPS:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Camera hành trình:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="pricing-section">
                    <h3>Bảng giá & Điều khoản</h3>
                    <div class="price-breakdown">
                        <div class="price-item">
                            <span>Giá thuê cơ bản (1 ngày):</span>
                            <span id="basePrice">150.000đ</span>
                        </div>
                        <div class="price-item">
                            <span>Phí bảo hiểm:</span>
                            <span id="insuranceFee">30.000đ</span>
                        </div>
                        <div class="price-item">
                            <span>Phí dịch vụ:</span>
                            <span id="serviceFee">20.000đ</span>
                        </div>
                        <div class="price-total">
                            Tổng cộng: <span id="totalPrice">200.000đ</span> / ngày
                        </div>
                    </div>
                    
                    <div class="modal-actions">
                        <button class="btn btn-outline">Thêm vào yêu thích</button>
                        <button class="btn btn-primary">Thuê ngay</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Nearby Vehicles Map -->
    <section class="nearby-vehicles">
        <div class="section-title">
            <h2>Xe Có Sẵn Gần Bạn</h2>
            <p>Chọn vị trí để xem các xe có sẵn trong khu vực</p>
        </div>
        <div class="map-container">
            <div id="vehicleMap"></div>
            <div class="location-finder">
                <button class="btn btn-outline" id="detectLocation">
                    <i class="fas fa-location-arrow"></i> Tự động phát hiện vị trí
                </button>
            </div>
        </div>
    </section>

    <!-- How it works -->
    <section class="how-it-works">
        <div class="section-title">
            <h2>Cách Thức Thuê Xe</h2>
            <p>Chỉ với 4 bước đơn giản để sở hữu chiếc xe yêu thích</p>
        </div>
        
        <!-- Booking Progress -->
        <div class="booking-progress">
            <div class="progress-steps">
                <div class="step active">
                    <div class="step-number">1</div>
                    <span>Chọn xe</span>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <span>Xác nhận</span>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <span>Thanh toán</span>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <span>Hoàn tất</span>
                </div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill" style="width: 25%"></div>
            </div>
        </div>
        
        <div class="steps">
            <div class="step">
                <div class="step-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3>Tìm Kiếm</h3>
                <p>Chọn loại xe và thời gian thuê phù hợp với nhu cầu của bạn</p>
            </div>
            <div class="step">
                <div class="step-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3>Đặt Xe</h3>
                <p>Điền thông tin và xác nhận đơn đặt xe trực tuyến</p>
            </div>
            <div class="step">
                <div class="step-icon">
                    <i class="fas fa-id-card"></i>
                </div>
                <h3>Xác Minh</h3>
                <p>Xuất trình giấy tờ tùy thân và bằng lái xe hợp lệ</p>
            </div>
            <div class="step">
                <div class="step-icon">
                    <i class="fas fa-key"></i>
                </div>
                <h3>Nhận Xe</h3>
                <p>Nhận xe và bắt đầu hành trình của bạn</p>
            </div>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonials">
        <div class="testimonials-container">
            <div class="section-title">
                <h2>Khách Hàng Nói Gì</h2>
                <p>Những đánh giá từ khách hàng đã sử dụng dịch vụ</p>
            </div>
            <div class="testimonial-cards">
                <div class="testimonial-card">
                    <div class="testimonial-text">
                        "Dịch vụ cho thuê xe rất chuyên nghiệp, xe mới và sạch sẽ. Nhân viên hỗ trợ nhiệt tình, tôi sẽ quay lại sử dụng dịch vụ."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Nguyễn Văn A">
                        </div>
                        <div class="author-info">
                            <h4>Nguyễn Văn A</h4>
                            <p>Khách thuê xe máy</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-text">
                        "Tôi đã thuê ô tô cho chuyến du lịch gia đình. Xe chạy êm, tiết kiệm nhiên liệu. Quy trình thuê xe nhanh chóng và thuận tiện."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Trần Thị B">
                        </div>
                        <div class="author-info">
                            <h4>Trần Thị B</h4>
                            <p>Khách thuê ô tô</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-text">
                        "Xe điện rất dễ sử dụng, phù hợp với nhu cầu di chuyển trong thành phố. Giá cả hợp lý và dịch vụ hỗ trợ 24/7 rất hữu ích."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://randomuser.me/api/portraits/men/76.jpg" alt="Lê Văn C">
                        </div>
                        <div class="author-info">
                            <h4>Lê Văn C</h4>
                            <p>Khách thuê xe điện</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-col">
                <h3>Về Chúng Tôi</h3>
                <p>RentCar cung cấp dịch vụ cho thuê xe máy, xe điện và ô tô chất lượng cao với giá cả hợp lý.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h3>Liên Kết Nhanh</h3>
                <ul>
                    <li><a href="#">Trang chủ</a></li>
                    <li><a href="#">Về chúng tôi</a></li>
                    <li><a href="#">Dịch vụ</a></li>
                    <li><a href="#">Xe nổi bật</a></li>
                    <li><a href="#">Blog</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Dịch Vụ</h3>
                <ul>
                    <li><a href="#">Thuê xe máy</a></li>
                    <li><a href="#">Thuê xe điện</a></li>
                    <li><a href="#">Thuê ô tô</a></li>
                    <li><a href="#">Thuê xe dài hạn</a></li>
                    <li><a href="#">Bảo hiểm xe</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Liên Hệ</h3>
                <ul>
                    <li><i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận 1, TP.HCM</li>
                    <li><i class="fas fa-phone"></i> +84 123 456 789</li>
                    <li><i class="fas fa-envelope"></i> info@rentcar.com</li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2023 RentCar. Tất cả các quyền được bảo lưu.</p>
        </div>
    </footer>

    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script>
        // Full Page Loading
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('fullPageLoading').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('fullPageLoading').style.display = 'none';
                }, 500);
            }, 2000); // 2 seconds loading
        });

        // Mobile Menu
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');
        
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('active');
        });

        // Auth Modal Functionality
        const authModal = document.getElementById('authModal');
        const loginBtn = document.getElementById('loginBtn');
        const registerBtn = document.getElementById('registerBtn');
        const loginBtnMobile = document.getElementById('loginBtnMobile');
        const registerBtnMobile = document.getElementById('registerBtnMobile');
        const closeAuth = document.getElementById('closeAuth');
        const loginTab = document.getElementById('loginTab');
        const registerTab = document.getElementById('registerTab');
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');
        const switchToRegister = document.getElementById('switchToRegister');
        const switchToLogin = document.getElementById('switchToLogin');
        const authTitle = document.getElementById('authTitle');
        const authButtons = document.getElementById('authButtons');
        const userAvatar = document.getElementById('userAvatar');
        const authButtonsMobile = document.getElementById('authButtonsMobile');
        const userAvatarMobile = document.getElementById('userAvatarMobile');
        const logoutBtn = document.getElementById('logoutBtn');
        const logoutBtnMobile = document.getElementById('logoutBtnMobile');
        const avatarPlaceholder = document.getElementById('avatarPlaceholder');

        // Check if user is logged in (for demo purposes)
        let isLoggedIn = false;
        let currentUser = null;

        function openAuthModal(formType) {
            authModal.classList.add('active');
            document.body.style.overflow = 'hidden';
            
            if (formType === 'login') {
                loginTab.click();
            } else {
                registerTab.click();
            }
        }

        function closeAuthModal() {
            authModal.classList.remove('active');
            document.body.style.overflow = 'auto';
            mobileMenu.classList.remove('active');
        }

        loginBtn.addEventListener('click', () => openAuthModal('login'));
        registerBtn.addEventListener('click', () => openAuthModal('register'));
        loginBtnMobile.addEventListener('click', () => openAuthModal('login'));
        registerBtnMobile.addEventListener('click', () => openAuthModal('register'));
        
        closeAuth.addEventListener('click', closeAuthModal);
        
        loginTab.addEventListener('click', () => {
            loginTab.classList.add('active');
            registerTab.classList.remove('active');
            loginForm.classList.add('active');
            registerForm.classList.remove('active');
            authTitle.textContent = 'Đăng nhập';
        });
        
        registerTab.addEventListener('click', () => {
            registerTab.classList.add('active');
            loginTab.classList.remove('active');
            registerForm.classList.add('active');
            loginForm.classList.remove('active');
            authTitle.textContent = 'Đăng ký';
        });
        
        switchToRegister.addEventListener('click', (e) => {
            e.preventDefault();
            registerTab.click();
        });
        
        switchToLogin.addEventListener('click', (e) => {
            e.preventDefault();
            loginTab.click();
        });
        
        window.addEventListener('click', (e) => {
            if (e.target === authModal) {
                closeAuthModal();
            }
        });

        // Form Submission
        loginForm.addEventListener('submit', (e) => {
            // Let the form submit normally to the server
            // Server-side validation will handle authentication
        });
        
        registerForm.addEventListener('submit', (e) => {
            // Let the form submit normally to the server
            // Server-side validation will handle registration
        });

        // Update UI after login
        function updateUIAfterLogin() {
            if (isLoggedIn && currentUser) {
                // Update avatar placeholder with first letter of name
                avatarPlaceholder.textContent = currentUser.name.charAt(0).toUpperCase();
                
                // Show user avatar, hide auth buttons
                userAvatar.style.display = 'block';
                authButtons.style.display = 'none';
                
                // Update mobile menu
                userAvatarMobile.style.display = 'block';
                authButtonsMobile.style.display = 'none';
                document.getElementById('mobileUserName').textContent = currentUser.name;
            }
        }

        // Logout functionality
        function logout() {
            // Redirect to logout servlet
            window.location.href = '${pageContext.request.contextPath}/logout';
        }

        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            logout();
        });

        logoutBtnMobile.addEventListener('click', (e) => {
            e.preventDefault();
            logout();
        });

        // Wishlist Toggle
        document.querySelectorAll('.btn-wishlist').forEach(button => {
            button.addEventListener('click', function() {
                this.classList.toggle('active');
                if (this.classList.contains('active')) {
                    this.innerHTML = '<i class="fas fa-heart"></i> Đã thích';
                } else {
                    this.innerHTML = '<i class="fas fa-heart"></i> Yêu thích';
                }
            });
        });

        // Vehicle Modal Functions
        const vehicleModal = document.getElementById('vehicleModal');
        const closeModal = document.getElementById('closeModal');
        
        function openVehicleModal(vehicleId) {
            // Hiển thị loading trong modal
            vehicleModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
            
            // Giả lập loading 2 giây
            setTimeout(() => {
                // Cập nhật thông tin xe dựa trên vehicleId
                updateModalContent(vehicleId);
            }, 2000);
        }
        
        function updateModalContent(vehicleId) {
            const vehicleData = {
                'honda-vision': {
                    name: 'Honda Vision 2023',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Tự động',
                    engine: '110cc',
                    color: 'Đen, Trắng, Xanh',
                    basePrice: '150.000đ',
                    insuranceFee: '30.000đ',
                    serviceFee: '20.000đ',
                    totalPrice: '200.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80'
                },
                'vinfast-klara': {
                    name: 'Vinfast Klara S',
                    type: 'Xe điện',
                    fuel: 'Điện',
                    seats: '2 người',
                    gear: 'Tự động',
                    engine: '1.2kW',
                    color: 'Trắng, Đỏ, Xanh',
                    basePrice: '120.000đ',
                    insuranceFee: '25.000đ',
                    serviceFee: '15.000đ',
                    totalPrice: '160.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
                'toyota-vios': {
                    name: 'Toyota Vios 2023',
                    type: 'Ô tô',
                    fuel: 'Xăng',
                    seats: '5 người',
                    gear: 'Số sàn',
                    engine: '1.5L',
                    color: 'Trắng, Đen, Bạc',
                    basePrice: '600.000đ',
                    insuranceFee: '100.000đ',
                    serviceFee: '50.000đ',
                    totalPrice: '750.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
                'yamaha-exciter': {
                    name: 'Yamaha Exciter 150',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Số sàn',
                    engine: '150cc',
                    color: 'Xanh, Đỏ, Đen',
                    basePrice: '180.000đ',
                    insuranceFee: '35.000đ',
                    serviceFee: '25.000đ',
                    totalPrice: '240.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                }
            };
            
            const data = vehicleData[vehicleId];
            if (data) {
                document.getElementById('modalVehicleName').textContent = data.name;
                document.getElementById('specType').textContent = data.type;
                document.getElementById('specFuel').textContent = data.fuel;
                document.getElementById('specSeats').textContent = data.seats;
                document.getElementById('specGear').textContent = data.gear;
                document.getElementById('specEngine').textContent = data.engine;
                document.getElementById('specColor').textContent = data.color;
                document.getElementById('basePrice').textContent = data.basePrice;
                document.getElementById('insuranceFee').textContent = data.insuranceFee;
                document.getElementById('serviceFee').textContent = data.serviceFee;
                document.getElementById('totalPrice').textContent = data.totalPrice;
                document.getElementById('mainImage').src = data.mainImage;
            }
        }
        
        function changeMainImage(src) {
            document.getElementById('mainImage').src = src;
        }
        
        function playVideo(video) {
            const mainImage = document.getElementById('mainImage');
            const videoContainer = document.createElement('div');
            videoContainer.className = 'main-image';
            videoContainer.innerHTML = `
                <video controls autoplay style="width: 100%; height: 250px; object-fit: cover; border-radius: 8px;">
                    <source src="${video.querySelector('source').src}" type="video/mp4">
                </video>
            `;
            mainImage.parentNode.replaceChild(videoContainer, mainImage);
        }
        
        closeModal.addEventListener('click', () => {
            vehicleModal.style.display = 'none';
            document.body.style.overflow = 'auto';
        });
        
        window.addEventListener('click', (e) => {
            if (e.target === vehicleModal) {
                vehicleModal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
        });

        // Initialize Map
        function initMap() {
            const map = L.map('vehicleMap').setView([10.8231, 106.6297], 12);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);
            
            const vehicles = [
                {lat: 10.8231, lng: 106.6297, name: 'Honda Vision', type: 'motorcycle'},
                {lat: 10.8000, lng: 106.6500, name: 'Toyota Vios', type: 'car'},
                {lat: 10.8400, lng: 106.6200, name: 'Vinfast Klara', type: 'electric'},
                {lat: 10.8100, lng: 106.6400, name: 'Yamaha Exciter', type: 'motorcycle'}
            ];
            
            vehicles.forEach(vehicle => {
                const iconColor = vehicle.type === 'motorcycle' ? 'blue' : 
                                 vehicle.type === 'electric' ? 'green' : 'red';
                
                const icon = L.divIcon({
    html: `<i class="fas fa-\${vehicle.type === 'motorcycle' ? 'motorcycle' :
                             vehicle.type === 'electric' ? 'bolt' : 'car'}"
          style="color: ${iconColor}; font-size: 18px;"></i>`,
    className: 'vehicle-marker',
    iconSize: [25, 25]
});

                
                L.marker([vehicle.lat, vehicle.lng], {icon: icon})
                    .addTo(map)
                    .bindPopup(`<b>${vehicle.name}</b><br>Loại: ${vehicle.type}`);
            });
            
            document.getElementById('detectLocation').addEventListener('click', () => {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(position => {
                        const {latitude, longitude} = position.coords;
                        map.setView([latitude, longitude], 13);
                        L.marker([latitude, longitude])
                            .addTo(map)
                            .bindPopup('Vị trí của bạn')
                            .openPopup();
                    });
                }
            });
        }
        
        window.addEventListener('load', initMap);

        // Chatbot functionality
        const chatbotToggle = document.getElementById('chatbotToggle');
        const chatbotWindow = document.getElementById('chatbotWindow');
        const closeChatbot = document.getElementById('closeChatbot');
        const chatbotMessages = document.getElementById('chatbotMessages');
        const chatbotInput = document.getElementById('chatbotInput');

        function getCurrentTime() {
            const now = new Date();
            return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
        }

        // Loading simulation for featured vehicles
        document.addEventListener('DOMContentLoaded', () => {
            const vehicleCards = document.querySelectorAll('.vehicle-card');
            
            vehicleCards.forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
            });

            setTimeout(() => {
                vehicleCards.forEach((card, index) => {
                    setTimeout(() => {
                        card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, index * 200);
                });
            }, 500);
        });
    </script>
</body>
</html>