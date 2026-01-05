<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="nntruong.data.model.Vehicle" %>
<%@ page import="java.math.BigDecimal" %>
<%
    // Kiểm tra session để xác định user đã đăng nhập chưa
    HttpSession sessionObj = request.getSession(false);
    boolean isLoggedIn = false;
    String userName = null;
    String userEmail = null;
    Integer userId = null;
    
    // Kiểm tra session và các attribute
    if (sessionObj != null) {
        Object isLoggedInObj = sessionObj.getAttribute("isLoggedIn");
        if (isLoggedInObj != null && isLoggedInObj instanceof Boolean) {
            isLoggedIn = (Boolean) isLoggedInObj;
            if (isLoggedIn) {
                userName = (String) sessionObj.getAttribute("userName");
                userEmail = (String) sessionObj.getAttribute("userEmail");
                userId = (Integer) sessionObj.getAttribute("userId");
            }
        }
    }
    
    // Lấy các thông báo lỗi/thành công từ request attributes (từ servlet)
    String loginError = (String) request.getAttribute("loginError");
    String registerError = (String) request.getAttribute("registerError");
    String registerSuccess = (String) request.getAttribute("registerSuccess");
    
    // Lấy các giá trị đã nhập để giữ lại trong form khi có lỗi
    String loginEmailValue = (String) request.getAttribute("loginEmail");
    String registerFullNameValue = (String) request.getAttribute("registerFullName");
    String registerPhoneValue = (String) request.getAttribute("registerPhone");
    String registerEmailValue = (String) request.getAttribute("registerEmail");
    
    // Lấy danh sách xe nổi bật từ request attribute (từ IndexServlet)
    @SuppressWarnings("unchecked")
    List<Vehicle> featuredVehicles = (List<Vehicle>) request.getAttribute("featuredVehicles");
    
    // Xác định modal nào cần mở (nếu có lỗi)
    String openModal = null;
    if (loginError != null) {
        openModal = "login";
    } else if (registerError != null) {
        openModal = "register";
    }
%>
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
                    <li><a href="${pageContext.request.contextPath}/" class="active">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/xemay.jsp">Thuê Xe máy</a></li>
                    <li><a href="${pageContext.request.contextPath}/xeoto.jsp">Thuê Ô tô</a></li>
                </ul>
            </nav>
            <!-- Auth Buttons - Ẩn nếu đã đăng nhập -->
            <div class="auth-buttons" id="authButtons"<% if (isLoggedIn) { %> style="display: none;"<% } else { %> style="display: flex;"<% } %>>
                <button class="btn btn-outline" id="loginBtn">Đăng nhập</button>
                <button class="btn btn-primary" id="registerBtn">Đăng ký</button>
            </div>
            
            <!-- User Avatar - Hiển thị nếu đã đăng nhập -->
            <div class="user-avatar" id="userAvatar"<% if (isLoggedIn) { %> style="display: block;"<% } else { %> style="display: none;"<% } %>>
                <div class="avatar-placeholder" id="avatarPlaceholder"><% 
                    if (userName != null && !userName.isEmpty()) { 
                        out.print(userName.substring(0, 1).toUpperCase());
                    } else {
                        out.print("U");
                    }
                %></div>
                <div class="user-dropdown">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/trangcanhan.jsp"><i class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="${pageContext.request.contextPath}/lichsu.jsp"><i class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                        <li><a href="${pageContext.request.contextPath}/yeuthich.jsp"><i class="fas fa-heart"></i> Xe yêu thích</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
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
                    <!-- Auth Buttons Mobile - Ẩn nếu đã đăng nhập -->
                    <div class="auth-buttons-mobile" id="authButtonsMobile"<% if (isLoggedIn) { %> style="display: none;"<% } else { %> style="display: block;"<% } %>>
                        <button class="btn btn-outline" id="loginBtnMobile" style="width: 100%; margin-bottom: 0.5rem;">Đăng nhập</button>
                        <button class="btn btn-primary" id="registerBtnMobile" style="width: 100%;">Đăng ký</button>
                    </div>
                    <!-- User Avatar Mobile - Hiển thị nếu đã đăng nhập -->
                    <div class="user-avatar-mobile" id="userAvatarMobile"<% if (isLoggedIn) { %> style="display: block;"<% } else { %> style="display: none;"<% } %>>
                        <div class="avatar-placeholder"><% 
                            if (userName != null && !userName.isEmpty()) { 
                                out.print(userName.substring(0, 1).toUpperCase());
                            } else {
                                out.print("U");
                            }
                        %></div>
                        <div class="user-info">
                            <p>Xin chào, <span id="mobileUserName"><%= userName != null ? userName : "Người dùng" %></span></p>
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
                <!-- Hiển thị thông báo lỗi đăng nhập -->
                <% if (loginError != null) { %>
                <div class="auth-message auth-error" id="loginError" style="background-color: #fee; color: #c33; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #fcc;">
                    <i class="fas fa-exclamation-circle"></i> <%= loginError %>
                </div>
                <% } %>
                
                <div class="form-group">
                    <label for="loginEmail">Email</label>
                    <input type="email" id="loginEmail" name="email" placeholder="Nhập email của bạn" value="<%= loginEmailValue != null ? loginEmailValue : "" %>" required>
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
                <!-- Hiển thị thông báo lỗi đăng ký -->
                <% if (registerError != null) { %>
                <div class="auth-message auth-error" id="registerError" style="background-color: #fee; color: #c33; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #fcc;">
                    <i class="fas fa-exclamation-circle"></i> <%= registerError %>
                </div>
                <% } %>
                
                <!-- Hiển thị thông báo thành công đăng ký -->
                <% if (registerSuccess != null) { %>
                <div class="auth-message auth-success" id="registerSuccess" style="background-color: #efe; color: #3c3; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #cfc;">
                    <i class="fas fa-check-circle"></i> <%= registerSuccess %>
                </div>
                <% } %>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="registerName">Họ và tên</label>
                        <input type="text" id="registerName" name="fullName" placeholder="Nhập họ và tên" value="<%= registerFullNameValue != null ? registerFullNameValue : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="registerPhone">Số điện thoại</label>
                        <input type="tel" id="registerPhone" name="phone" placeholder="Nhập số điện thoại" value="<%= registerPhoneValue != null ? registerPhoneValue : "" %>" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="registerEmail">Email</label>
                    <input type="email" id="registerEmail" name="email" placeholder="Nhập email của bạn" value="<%= registerEmailValue != null ? registerEmailValue : "" %>" required>
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
                <%
                    // Kiểm tra xem có danh sách xe nổi bật không
                    if (featuredVehicles != null && !featuredVehicles.isEmpty()) {
                        for (Vehicle vehicle : featuredVehicles) {
                            // Lấy thông tin xe
                            String vehicleName = vehicle.getFullName();
                            String imageUrl = vehicle.getMainImageUrl() != null && !vehicle.getMainImageUrl().isEmpty() 
                                ? vehicle.getMainImageUrl() 
                                : "https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80";
                            
                            BigDecimal rating = vehicle.getRating() != null ? vehicle.getRating() : BigDecimal.ZERO;
                            double ratingValue = rating.doubleValue();
                            int fullStars = (int) ratingValue;
                            boolean hasHalfStar = (ratingValue - fullStars) >= 0.5;
                            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
                            
                            String fuelType = vehicle.getFuelType() != null ? vehicle.getFuelType() : "Xăng";
                            String fuelIcon = fuelType.toLowerCase().contains("điện") ? "fas fa-bolt" : "fas fa-gas-pump";
                            
                            int seatCapacity = vehicle.getSeatCapacity() != null ? vehicle.getSeatCapacity() : 2;
                            String transmission = vehicle.getTransmission() != null ? vehicle.getTransmission() : "Tự động";
                            
                            String categoryName = vehicle.getCategoryName() != null ? vehicle.getCategoryName() : "";
                            String vehicleTag = "";
                            if (categoryName.contains("Xe máy")) {
                                vehicleTag = "Phổ biến";
                            } else if (categoryName.contains("Xe điện")) {
                                vehicleTag = "Tiết kiệm";
                            } else if (categoryName.contains("Ô tô")) {
                                vehicleTag = "Ưa chuộng";
                            }
                            
                            String formattedPrice = vehicle.getFormattedDailyRate();
                            int totalRentals = vehicle.getTotalRentals();
                %>
                <!-- Vehicle Card: <%= vehicleName %> -->
                <div class="vehicle-card">
                    <div class="vehicle-img">
                        <img src="<%= imageUrl %>" alt="<%= vehicleName %>">
                        <% if (!vehicleTag.isEmpty()) { %>
                        <div class="vehicle-tag"><%= vehicleTag %></div>
                        <% } %>
                    </div>
                    <div class="vehicle-content">
                        <h3><%= vehicleName %><% if (vehicle.getModelYear() != null) { %> <%= vehicle.getModelYear() %><% } %></h3>
                        
                        <!-- Rating System -->
                        <div class="vehicle-rating">
                            <div class="rating-stars">
                                <% for (int i = 0; i < fullStars; i++) { %>
                                <i class="fas fa-star"></i>
                                <% } %>
                                <% if (hasHalfStar) { %>
                                <i class="fas fa-star-half-alt"></i>
                                <% } %>
                                <% for (int i = 0; i < emptyStars; i++) { %>
                                <i class="far fa-star"></i>
                                <% } %>
                                <span><%= String.format("%.1f", ratingValue) %> (<%= totalRentals %> đánh giá)</span>
                            </div>
                            <div class="rating-badges">
                                <% if (fuelType.toLowerCase().contains("điện")) { %>
                                <span class="badge eco-friendly">♻️ Thân thiện MT</span>
                                <% } else { %>
                                <span class="badge eco-friendly">♻️ Tiết kiệm</span>
                                <% } %>
                                <% if (totalRentals > 100) { %>
                                <span class="badge popular">🔥 Phổ biến</span>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="vehicle-details">
                            <span><i class="<%= fuelIcon %>"></i> <%= fuelType %></span>
                            <span><i class="fas fa-user"></i> <%= seatCapacity %> người</span>
                            <span><i class="fas fa-cog"></i> <%= transmission %></span>
                        </div>
                        <div class="vehicle-price"><%= formattedPrice %> <span>/ngày</span></div>
                        
                        <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal(<%= vehicle.getVehicleId() %>)">Chi tiết xe</button>
                        <button class="btn btn-outline" style="width: 100%; display: block; text-align: center;" onclick="checkLoginAndRent(<%= vehicle.getVehicleId() %>)">Thuê ngay</button>
                        
                        <!-- Social Features -->
                        <div class="social-features">
                            <button class="btn-share" onclick="shareVehicle(<%= vehicle.getVehicleId() %>, '<%= vehicleName %>')">
                                <i class="fas fa-share-alt"></i>
                                Chia sẻ
                            </button>
                            <button class="btn-wishlist" onclick="toggleWishlist(<%= vehicle.getVehicleId() %>)">
                                <i class="fas fa-heart"></i>
                                Yêu thích
                            </button>
                            <div class="social-proof">
                                <span>👥 <%= (int)(Math.random() * 20 + 5) %> người đang xem</span>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                        // Nếu không có dữ liệu, hiển thị thông báo
                %>
                <div style="text-align: center; padding: 40px; color: #666;">
                    <p>Hiện tại chưa có xe nổi bật. Vui lòng quay lại sau.</p>
                </div>
                <%
                    }
                %>
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
                        <button class="btn btn-primary" id="rentNowModalBtn" onclick="checkLoginAndRentFromModal()">Thuê ngay</button>
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
        // Global variables - cần được định nghĩa trước để các hàm có thể truy cập
        var userLoggedIn = <%= isLoggedIn ? "true" : "false" %>;
        var currentUser = null;
        var currentVehicleId = null; // Lưu vehicleId hiện tại trong modal
        
        // Nếu đã đăng nhập, lấy thông tin từ session
        <% if (isLoggedIn && userName != null) { %>
        currentUser = {
            id: <%= userId != null ? userId : "null" %>,
            name: '<%= userName != null ? userName.replace("'", "\\'") : "" %>',
            email: '<%= userEmail != null ? userEmail.replace("'", "\\'") : "" %>'
        };
        <% } %>
        
        // Hàm mở modal đăng nhập - Phải ở global scope
        function openAuthModalGlobal(formType) {
            // Đợi DOM load xong
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', function() {
                    openAuthModalGlobal(formType);
                });
                return;
            }
            
            const authModal = document.getElementById('authModal');
            const loginTab = document.getElementById('loginTab');
            const registerTab = document.getElementById('registerTab');
            
            if (authModal) {
                authModal.classList.add('active');
                document.body.style.overflow = 'hidden';
                
                if (formType === 'login' && loginTab) {
                    loginTab.click();
                } else if (formType === 'register' && registerTab) {
                    registerTab.click();
                }
            }
        }
        
        // Hàm kiểm tra đăng nhập và chuyển đến trang đặt xe - Phải ở global scope để có thể gọi từ onclick
        function checkLoginAndRent(vehicleId) {
            if (!userLoggedIn) {
                // Chưa đăng nhập, mở modal đăng nhập
                openAuthModalGlobal('login');
                // Lưu vehicleId để sau khi đăng nhập có thể redirect
                sessionStorage.setItem('pendingRentVehicleId', vehicleId);
            } else {
                // Đã đăng nhập, chuyển đến trang đặt xe
                window.location.href = '${pageContext.request.contextPath}/datxe.jsp?vehicleId=' + vehicleId;
            }
        }
        
        // Hàm kiểm tra đăng nhập từ modal (khi click nút "Thuê ngay" trong modal)
        function checkLoginAndRentFromModal() {
            if (currentVehicleId) {
                checkLoginAndRent(currentVehicleId);
            }
        }
        
        // Hàm cập nhật nội dung modal - Phải ở global scope
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
                const modalVehicleName = document.getElementById('modalVehicleName');
                const specType = document.getElementById('specType');
                const specFuel = document.getElementById('specFuel');
                const specSeats = document.getElementById('specSeats');
                const specGear = document.getElementById('specGear');
                const specEngine = document.getElementById('specEngine');
                const specColor = document.getElementById('specColor');
                const basePrice = document.getElementById('basePrice');
                const insuranceFee = document.getElementById('insuranceFee');
                const serviceFee = document.getElementById('serviceFee');
                const totalPrice = document.getElementById('totalPrice');
                const mainImage = document.getElementById('mainImage');
                
                if (modalVehicleName) modalVehicleName.textContent = data.name;
                if (specType) specType.textContent = data.type;
                if (specFuel) specFuel.textContent = data.fuel;
                if (specSeats) specSeats.textContent = data.seats;
                if (specGear) specGear.textContent = data.gear;
                if (specEngine) specEngine.textContent = data.engine;
                if (specColor) specColor.textContent = data.color;
                if (basePrice) basePrice.textContent = data.basePrice;
                if (insuranceFee) insuranceFee.textContent = data.insuranceFee;
                if (serviceFee) serviceFee.textContent = data.serviceFee;
                if (totalPrice) totalPrice.textContent = data.totalPrice;
                if (mainImage) mainImage.src = data.mainImage;
            }
        }
        
        // Hàm mở modal chi tiết xe - Phải ở global scope để có thể gọi từ onclick
        function openVehicleModal(vehicleId) {
            // Đợi DOM load xong
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', function() {
                    openVehicleModal(vehicleId);
                });
                return;
            }
            
            const vehicleModal = document.getElementById('vehicleModal');
            if (!vehicleModal) return;
            
            currentVehicleId = vehicleId; // Lưu vehicleId vào biến global
            // Hiển thị loading trong modal
            vehicleModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
            
            // Giả lập loading 2 giây
            setTimeout(() => {
                // Cập nhật thông tin xe dựa trên vehicleId
                updateModalContent(vehicleId);
            }, 2000);
        }
        
        // Full Page Loading
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('fullPageLoading').style.opacity = '0';
                setTimeout(function() {
                    document.getElementById('fullPageLoading').style.display = 'none';
                }, 500);
            }, 2000); // 2 seconds loading
        });

        // Wrap all DOM-related code in DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile Menu
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const mobileMenu = document.getElementById('mobileMenu');
            
            if (mobileMenuBtn && mobileMenu) {
                mobileMenuBtn.addEventListener('click', () => {
                    mobileMenu.classList.toggle('active');
                });
            }

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

        // Cập nhật biến global từ server-side (đã được định nghĩa ở trên)
        // Nếu đã đăng nhập, cập nhật thông tin user
        <% if (isLoggedIn && userName != null) { %>
        currentUser = {
            id: <%= userId != null ? userId : "null" %>,
            name: '<%= userName != null ? userName.replace("'", "\\'") : "" %>',
            email: '<%= userEmail != null ? userEmail.replace("'", "\\'") : "" %>'
        };
        <% } %>

        function openAuthModal(formType) {
            authModal.classList.add('active');
            document.body.style.overflow = 'hidden';
            
            if (formType === 'login') {
                loginTab.click();
            } else if (formType === 'register') {
                registerTab.click();
            }
        }

        function closeAuthModal() {
            authModal.classList.remove('active');
            document.body.style.overflow = 'auto';
            mobileMenu.classList.remove('active');
        }

        // Chỉ thêm event listener nếu phần tử tồn tại
        if (loginBtn) {
            loginBtn.addEventListener('click', () => openAuthModal('login'));
        }
        if (registerBtn) {
            registerBtn.addEventListener('click', () => openAuthModal('register'));
        }
        if (loginBtnMobile) {
            loginBtnMobile.addEventListener('click', () => openAuthModal('login'));
        }
        if (registerBtnMobile) {
            registerBtnMobile.addEventListener('click', () => openAuthModal('register'));
        }
        
        if (closeAuth) {
            closeAuth.addEventListener('click', closeAuthModal);
        }
        
        if (loginTab) {
            loginTab.addEventListener('click', () => {
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
                loginForm.classList.add('active');
                registerForm.classList.remove('active');
                if (authTitle) authTitle.textContent = 'Đăng nhập';
            });
        }
        
        if (registerTab) {
            registerTab.addEventListener('click', () => {
                registerTab.classList.add('active');
                loginTab.classList.remove('active');
                registerForm.classList.add('active');
                loginForm.classList.remove('active');
                if (authTitle) authTitle.textContent = 'Đăng ký';
            });
        }
        
        if (switchToRegister) {
            switchToRegister.addEventListener('click', (e) => {
                e.preventDefault();
                if (registerTab) registerTab.click();
            });
        }
        
        if (switchToLogin) {
            switchToLogin.addEventListener('click', (e) => {
                e.preventDefault();
                if (loginTab) loginTab.click();
            });
        }
        
        if (authModal) {
            window.addEventListener('click', (e) => {
                if (e.target === authModal) {
                    closeAuthModal();
                }
            });
        }

        // Form Submission
        if (loginForm) {
            loginForm.addEventListener('submit', (e) => {
                // Let the form submit normally to the server
                // Server-side validation will handle authentication
            });
        }
        
        if (registerForm) {
            registerForm.addEventListener('submit', (e) => {
                // Let the form submit normally to the server
                // Server-side validation will handle registration
            });
        }

        // Cập nhật UI dựa trên trạng thái đăng nhập
        function updateUIAfterLogin() {
            if (userLoggedIn && currentUser) {
                // Cập nhật avatar placeholder với chữ cái đầu của tên
                if (avatarPlaceholder) {
                    avatarPlaceholder.textContent = currentUser.name.charAt(0).toUpperCase();
                }
                
                // Hiển thị user avatar, ẩn auth buttons
                if (userAvatar) userAvatar.style.display = 'block';
                if (authButtons) authButtons.style.display = 'none';
                
                // Cập nhật mobile menu
                if (userAvatarMobile) userAvatarMobile.style.display = 'block';
                if (authButtonsMobile) authButtonsMobile.style.display = 'none';
                const mobileUserNameEl = document.getElementById('mobileUserName');
                if (mobileUserNameEl) mobileUserNameEl.textContent = currentUser.name;
                
                // Kiểm tra nếu có vehicleId đang chờ (sau khi đăng nhập)
                const pendingVehicleId = sessionStorage.getItem('pendingRentVehicleId');
                if (pendingVehicleId) {
                    // Xóa vehicleId khỏi sessionStorage
                    sessionStorage.removeItem('pendingRentVehicleId');
                    // Redirect đến trang đặt xe
                    window.location.href = '${pageContext.request.contextPath}/datxe.jsp?vehicleId=' + pendingVehicleId;
                    return; // Dừng lại để không cập nhật UI nữa vì sẽ redirect
                }
            } else {
                // Ẩn user avatar, hiển thị auth buttons
                if (userAvatar) userAvatar.style.display = 'none';
                if (authButtons) authButtons.style.display = 'flex';
                if (userAvatarMobile) userAvatarMobile.style.display = 'none';
                if (authButtonsMobile) authButtonsMobile.style.display = 'block';
            }
        }
        
        // Gọi hàm cập nhật UI khi trang load
        updateUIAfterLogin();

        // Logout functionality
        function logout() {
            // Redirect to logout servlet
            window.location.href = '${pageContext.request.contextPath}/logout';
        }

        // Chỉ thêm event listener nếu phần tử tồn tại
        if (logoutBtn) {
            logoutBtn.addEventListener('click', (e) => {
                e.preventDefault();
                logout();
            });
        }

        if (logoutBtnMobile) {
            logoutBtnMobile.addEventListener('click', (e) => {
                e.preventDefault();
                logout();
            });
        }

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

        // Vehicle Modal Functions - Các biến và hàm cần thiết
        const vehicleModal = document.getElementById('vehicleModal');
        const closeModal = document.getElementById('closeModal');
        
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
        
        if (closeModal && vehicleModal) {
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
        }

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
            
            const detectLocationBtn = document.getElementById('detectLocation');
            if (detectLocationBtn) {
                detectLocationBtn.addEventListener('click', () => {
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
        }
        
        window.addEventListener('load', initMap);
        
        // Tự động mở modal nếu có lỗi từ servlet
        <% if (openModal != null) { %>
        window.addEventListener('load', function() {
            // Đợi một chút để đảm bảo DOM đã load xong
            setTimeout(function() {
                <% if (openModal.equals("login")) { %>
                openAuthModal('login');
                <% } else if (openModal.equals("register")) { %>
                openAuthModal('register');
                <% } %>
            }, 100);
        });
        <% } %>
        
        // Xóa thông báo lỗi khi user bắt đầu nhập lại
        const loginEmailInput = document.getElementById('loginEmail');
        const loginErrorDiv = document.getElementById('loginError');
        if (loginEmailInput && loginErrorDiv) {
            loginEmailInput.addEventListener('input', function() {
                loginErrorDiv.style.display = 'none';
            });
        }
        
        const registerEmailInput = document.getElementById('registerEmail');
        const registerErrorDiv = document.getElementById('registerError');
        if (registerEmailInput && registerErrorDiv) {
            registerEmailInput.addEventListener('input', function() {
                registerErrorDiv.style.display = 'none';
            });
        }

        // Chatbot functionality (nếu có)
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
        }); // End of DOMContentLoaded
    </script>
</body>
</html>