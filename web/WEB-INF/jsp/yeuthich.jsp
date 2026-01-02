<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xe Yêu Thích - RentCar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/wishlist.css">
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
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/xemay.jsp">Thuê Xe máy</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/oto.jsp">Thuê Ô tô</a></li>
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
                        <li><a href="${pageContext.request.contextPath}/pages/profile.jsp"><i class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/lichsu.jsp"><i class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/wishlist.jsp" class="active"><i class="fas fa-heart"></i> Xe yêu thích</a></li>
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
                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/xemay.jsp">Xe máy</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/dienthoai.jsp">Xe điện</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/oto.jsp">Ô tô</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/about.jsp">Về chúng tôi</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">Liên hệ</a></li>
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
                    <a href="${pageContext.request.contextPath}/pages/forgot-password.jsp" class="forgot-password">Quên mật khẩu?</a>
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

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/profile.jsp">Tài khoản</a></li>
            <li>Xe yêu thích</li>
        </ul>
    </div>

    <!-- Page Header -->
    <section class="page-header">
        <h1>Xe Yêu Thích</h1>
        <p>Quản lý danh sách những chiếc xe bạn quan tâm và muốn thuê trong tương lai</p>
    </section>

    <!-- Wishlist Container -->
    <section class="wishlist-container">
        <!-- Wishlist Actions -->
        <div class="wishlist-actions">
            <div class="wishlist-stats">
                <div class="wishlist-count">8 xe yêu thích</div>
                <div class="selected-count" id="selectedCount" style="display: none;">
                    <span id="selectedNumber">0</span> xe được chọn
                </div>
            </div>
            <div class="sort-options">
                <label for="sort-wishlist">Sắp xếp:</label>
                <select id="sort-wishlist">
                    <option value="newest">Mới nhất</option>
                    <option value="oldest">Cũ nhất</option>
                    <option value="price-low">Giá thấp đến cao</option>
                    <option value="price-high">Giá cao đến thấp</option>
                    <option value="name">Theo tên xe</option>
                </select>
                <button class="btn btn-outline" id="compareBtn" style="display: none;">So sánh xe</button>
                <button class="btn btn-danger" id="removeSelectedBtn" style="display: none;">Xóa đã chọn</button>
            </div>
        </div>

        <!-- Wishlist Content -->
        <div id="wishlistContent">
            <!-- Wishlist Grid -->
            <div class="wishlist-grid">
                <!-- Wishlist Item 1 -->
                <div class="wishlist-card featured">
                    <div class="featured-badge">Đề xuất</div>
                    <button class="wishlist-remove" onclick="removeFromWishlist(this)">
                        <i class="fas fa-times"></i>
                    </button>
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda SH">
                        <div class="vehicle-tag">Cao cấp</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Honda SH 150i</h3>
                        
                        <!-- Rating System -->
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span>5.0 (89 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge popular">🔥 Cao cấp</span>
                                <span class="badge new">Mới</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-gas-pump"></i> Xăng</span>
                            <span><i class="fas fa-user"></i> 2 người</span>
                            <span><i class="fas fa-cog"></i> Tự động</span>
                        </div>
                        <div class="vehicle-price">250.000đ <span>/ngày</span></div>
                        
                        <div class="vehicle-actions">
                            <button class="btn btn-outline" onclick="viewVehicleDetails('honda-sh')">Chi tiết</button>
                            <button class="btn btn-primary" onclick="rentVehicle('honda-sh')">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Wishlist Item 2 -->
                <div class="wishlist-card">
                    <button class="wishlist-remove" onclick="removeFromWishlist(this)">
                        <i class="fas fa-times"></i>
                    </button>
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                        <div class="vehicle-tag">Phổ biến</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Honda Vision</h3>
                        
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
                        
                        <div class="vehicle-actions">
                            <button class="btn btn-outline" onclick="viewVehicleDetails('honda-vision')">Chi tiết</button>
                            <button class="btn btn-primary" onclick="rentVehicle('honda-vision')">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Wishlist Item 3 -->
                <div class="wishlist-card">
                    <button class="wishlist-remove" onclick="removeFromWishlist(this)">
                        <i class="fas fa-times"></i>
                    </button>
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                        <div class="vehicle-tag">Thể thao</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Yamaha Exciter 150</h3>
                        
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
                        
                        <div class="vehicle-actions">
                            <button class="btn btn-outline" onclick="viewVehicleDetails('yamaha-exciter')">Chi tiết</button>
                            <button class="btn btn-primary" onclick="rentVehicle('yamaha-exciter')">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Wishlist Item 4 -->
                <div class="wishlist-card">
                    <button class="wishlist-remove" onclick="removeFromWishlist(this)">
                        <i class="fas fa-times"></i>
                    </button>
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Vinfast Klara">
                        <div class="vehicle-tag">Tiết kiệm</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Vinfast Klara S</h3>
                        
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
                        
                        <div class="vehicle-actions">
                            <button class="btn btn-outline" onclick="viewVehicleDetails('vinfast-klara')">Chi tiết</button>
                            <button class="btn btn-primary" onclick="rentVehicle('vinfast-klara')">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Wishlist Item 5 -->
                <div class="wishlist-card">
                    <button class="wishlist-remove" onclick="removeFromWishlist(this)">
                        <i class="fas fa-times"></i>
                    </button>
                    <div class="vehicle-img">
                        <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Piaggio Liberty">
                        <div class="vehicle-tag">Phong cách</div>
                    </div>
                    <div class="vehicle-content">
                        <h3>Piaggio Liberty</h3>
                        
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <span>4.0 (63 đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <span class="badge popular">🔥 Phong cách</span>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="fas fa-gas-pump"></i> Xăng</span>
                            <span><i class="fas fa-user"></i> 2 người</span>
                            <span><i class="fas fa-cog"></i> Tự động</span>
                        </div>
                        <div class="vehicle-price">200.000đ <span>/ngày</span></div>
                        
                        <div class="vehicle-actions">
                            <button class="btn btn-outline" onclick="viewVehicleDetails('piaggio-liberty')">Chi tiết</button>
                            <button class="btn btn-primary" onclick="rentVehicle('piaggio-liberty')">Thuê ngay</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Comparison Section -->
            <div class="comparison-section" id="comparisonSection">
                <div class="comparison-header">
                    <h2>So Sánh Xe</h2>
                    <button class="btn btn-outline" onclick="closeComparison()">Đóng</button>
                </div>
                <div class="comparison-grid" id="comparisonGrid">
                    <!-- Comparison content will be dynamically generated -->
                </div>
                <div class="comparison-actions">
                    <button class="btn btn-outline" onclick="clearComparison()">Xóa so sánh</button>
                    <button class="btn btn-primary" onclick="rentCompared()">Thuê xe được chọn</button>
                </div>
            </div>
        </div>

        <!-- Empty State (hidden by default) -->
        <div class="empty-state" id="emptyState" style="display: none;">
            <i class="fas fa-heart"></i>
            <h3>Danh sách yêu thích trống</h3>
            <p>Bạn chưa có xe nào trong danh sách yêu thích. Hãy khám phá và thêm những chiếc xe bạn quan tâm!</p>
            <button class="btn btn-primary" onclick="browseVehicles()">Khám phá xe ngay</button>
        </div>

        <!-- Recommendations Section -->
        <div class="recommendations-section">
            <h2 class="section-title">Có Thể Bạn Sẽ Thích</h2>
            <div class="recommendations-grid">
                <!-- Recommendation items would go here -->
                <!-- This would typically be populated dynamically based on user preferences -->
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
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/about.jsp">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/xemay.jsp">Xe máy</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/dienthoai.jsp">Xe điện</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/oto.jsp">Ô tô</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Dịch Vụ</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/pages/xemay.jsp">Thuê xe máy</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/dienthoai.jsp">Thuê xe điện</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/oto.jsp">Thuê ô tô</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/long-term.jsp">Thuê xe dài hạn</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/insurance.jsp">Bảo hiểm xe</a></li>
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

    <script>
        // Full Page Loading
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('fullPageLoading').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('fullPageLoading').style.display = 'none';
                }, 500);
            }, 1000);
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
        });
        
        registerForm.addEventListener('submit', (e) => {
            // Let the form submit normally to the server
        });

        // Logout functionality
        function logout() {
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

        // Wishlist management
        let selectedVehicles = new Set();
        
        document.addEventListener('DOMContentLoaded', () => {
            // Check if user is logged in (for demo, we'll assume they are)
            const isLoggedIn = true;
            
            if (isLoggedIn) {
                document.getElementById('authButtons').style.display = 'none';
                document.getElementById('userAvatar').style.display = 'block';
            }
            
            // Check if wishlist is empty
            updateEmptyState();
        });
        
        // Remove vehicle from wishlist
        function removeFromWishlist(button) {
            const card = button.closest('.wishlist-card');
            card.style.animation = 'fadeOut 0.3s ease';
            
            setTimeout(() => {
                card.remove();
                updateWishlistCount();
                updateEmptyState();
                
                // Show confirmation message
                showNotification('Đã xóa xe khỏi danh sách yêu thích', 'success');
            }, 300);
        }
        
        // Update wishlist count
        function updateWishlistCount() {
            const count = document.querySelectorAll('.wishlist-card').length;
            document.querySelector('.wishlist-count').textContent = count + ' xe yêu thích';
            
            return count;
        }
        
        // Update empty state visibility
        function updateEmptyState() {
            const count = updateWishlistCount();
            const emptyState = document.getElementById('emptyState');
            const wishlistContent = document.getElementById('wishlistContent');
            
            if (count === 0) {
                emptyState.style.display = 'block';
                wishlistContent.style.display = 'none';
            } else {
                emptyState.style.display = 'none';
                wishlistContent.style.display = 'block';
            }
        }
        
        // View vehicle details
        function viewVehicleDetails(vehicleId) {
            window.location.href = '${pageContext.request.contextPath}/pages/chitietxe.jsp?id=' + vehicleId;
        }
        
        // Rent vehicle
        function rentVehicle(vehicleId) {
            window.location.href = '${pageContext.request.contextPath}/pages/datxe.jsp?vehicle=' + vehicleId;
        }
        
        // Browse vehicles
        function browseVehicles() {
            window.location.href = '${pageContext.request.contextPath}/pages/xemay.jsp';
        }
        
        // Show notification
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.innerHTML = `
                <div class="notification-content">
                    <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'}"></i>
                    <span>${message}</span>
                </div>
                <button class="notification-close" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            `;
            
            notification.style.cssText = `
                position: fixed;
                top: 100px;
                right: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                padding: 1rem;
                display: flex;
                align-items: center;
                gap: 1rem;
                z-index: 10000;
                animation: slideIn 0.3s ease;
                border-left: 4px solid ${type === 'success' ? 'var(--success)' : 'var(--secondary)'};
                max-width: 350px;
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 5000);
        }
        
        // Comparison functionality
        function toggleVehicleComparison(card) {
            const vehicleId = card.querySelector('h3').textContent;
            
            if (selectedVehicles.has(vehicleId)) {
                selectedVehicles.delete(vehicleId);
                card.classList.remove('selected');
            } else {
                if (selectedVehicles.size >= 3) {
                    showNotification('Chỉ có thể so sánh tối đa 3 xe', 'info');
                    return;
                }
                selectedVehicles.add(vehicleId);
                card.classList.add('selected');
            }
            
            updateComparisonUI();
        }
        
        function updateComparisonUI() {
            const selectedCount = document.getElementById('selectedCount');
            const selectedNumber = document.getElementById('selectedNumber');
            const compareBtn = document.getElementById('compareBtn');
            const removeSelectedBtn = document.getElementById('removeSelectedBtn');
            
            selectedNumber.textContent = selectedVehicles.size;
            
            if (selectedVehicles.size > 0) {
                selectedCount.style.display = 'block';
                compareBtn.style.display = 'inline-block';
                removeSelectedBtn.style.display = 'inline-block';
            } else {
                selectedCount.style.display = 'none';
                compareBtn.style.display = 'none';
                removeSelectedBtn.style.display = 'none';
            }
        }
        
        function showComparison() {
            if (selectedVehicles.size < 2) {
                showNotification('Vui lòng chọn ít nhất 2 xe để so sánh', 'info');
                return;
            }
            
            const comparisonSection = document.getElementById('comparisonSection');
            const comparisonGrid = document.getElementById('comparisonGrid');
            
            comparisonGrid.innerHTML = generateComparisonContent();
            
            comparisonSection.classList.add('active');
            
            comparisonSection.scrollIntoView({ behavior: 'smooth' });
        }
        
        function generateComparisonContent() {
            const features = [
                { name: 'Giá thuê/ngày', key: 'price' },
                { name: 'Loại nhiên liệu', key: 'fuel' },
                { name: 'Số chỗ ngồi', key: 'seats' },
                { name: 'Hộp số', key: 'transmission' },
                { name: 'Phân khối', key: 'engine' },
                { name: 'Đánh giá', key: 'rating' },
                { name: 'Tiện ích', key: 'features' }
            ];
            
            const vehiclesData = {
                'Honda SH 150i': {
                    price: '250.000đ',
                    fuel: 'Xăng',
                    seats: '2',
                    transmission: 'Tự động',
                    engine: '150cc',
                    rating: '5.0 (89 đánh giá)',
                    features: 'ABS, Khóa thông minh, LED'
                },
                'Honda Vision': {
                    price: '150.000đ',
                    fuel: 'Xăng',
                    seats: '2',
                    transmission: 'Tự động',
                    engine: '110cc',
                    rating: '4.5 (128 đánh giá)',
                    features: 'Tiết kiệm nhiên liệu, Cốp rộng'
                },
                'Yamaha Exciter 150': {
                    price: '180.000đ',
                    fuel: 'Xăng',
                    seats: '2',
                    transmission: 'Số sàn',
                    engine: '150cc',
                    rating: '4.5 (167 đánh giá)',
                    features: 'Thể thao, Phanh đĩa'
                }
            };
            
            let html = '<div class="comparison-item"><div class="feature-name"></div></div>';
            
            Array.from(selectedVehicles).forEach(vehicleName => {
                const vehicle = vehiclesData[vehicleName] || {};
                html += `
                    <div class="comparison-item">
                        <div class="comparison-vehicle">
                            <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="${vehicleName}">
                            <h4>${vehicleName}</h4>
                            <div class="price">${vehicle.price}</div>
                        </div>
                    </div>
                `;
            });
            
            features.forEach(feature => {
                html += `<div class="comparison-item"><div class="feature-name">${feature.name}</div></div>`;
                
                Array.from(selectedVehicles).forEach(vehicleName => {
                    const vehicle = vehiclesData[vehicleName] || {};
                    html += `
                        <div class="comparison-item">
                            <div class="feature-value">${vehicle[feature.key] || '—'}</div>
                        </div>
                    `;
                });
            });
            
            return html;
        }
        
        function closeComparison() {
            document.getElementById('comparisonSection').classList.remove('active');
        }
        
        function clearComparison() {
            selectedVehicles.clear();
            document.querySelectorAll('.wishlist-card').forEach(card => {
                card.classList.remove('selected');
            });
            updateComparisonUI();
            closeComparison();
        }
        
        function rentCompared() {
            alert('Thuê các xe đã chọn trong so sánh');
        }
        
        // Add CSS for animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeOut {
                from { opacity: 1; transform: translateY(0); }
                to { opacity: 0; transform: translateY(20px); }
            }
            
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            
            .wishlist-card.selected {
                border: 2px solid var(--secondary);
            }
            
            .notification-close {
                background: none;
                border: none;
                cursor: pointer;
                color: #666;
            }
        `;
        document.head.appendChild(style);
        
        // Initialize comparison buttons
        document.getElementById('compareBtn').addEventListener('click', showComparison);
    </script>
</body>
</html>