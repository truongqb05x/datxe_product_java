<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
    
    // Lấy các thông báo lỗi/thành công từ request attributes
    String loginError = (String) request.getAttribute("loginError"); 
    String registerError = (String) request.getAttribute("registerError"); 
    String registerSuccess = (String) request.getAttribute("registerSuccess"); 
    
    // Lấy các giá trị đã nhập để giữ lại trong form khi có lỗi
    String loginEmailValue = (String) request.getAttribute("loginEmail"); 
    String registerFullNameValue = (String) request.getAttribute("registerFullName"); 
    String registerPhoneValue = (String) request.getAttribute("registerPhone"); 
    String registerEmailValue = (String) request.getAttribute("registerEmail"); 
    
    // Xác định modal nào cần mở nếu có lỗi
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
                <title>Thuê Xe Ô tô - RentCar</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/logo.png"
                    type="image/x-icon">
                <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/xeoto.css">
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
                                <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                                <li><a href="${pageContext.request.contextPath}/xemay.jsp">Thuê Xe máy</a></li>
                                <li><a href="${pageContext.request.contextPath}/xeoto.jsp" class="active">Thuê Ô tô</a>
                                </li>
                            </ul>
                        </nav>
                        <!-- Auth Buttons - Ẩn nếu đã đăng nhập -->
                        <div class="auth-buttons" id="authButtons" <% if (isLoggedIn) { %> style="display: none;"<% }
                                else { %> style="display: flex;"<% } %>>
                                    <button class="btn btn-outline" id="loginBtn">Đăng nhập</button>
                                    <button class="btn btn-primary" id="registerBtn">Đăng ký</button>
                        </div>

                        <!-- User Avatar - Hiển thị nếu đã đăng nhập -->
                        <div class="user-avatar" id="userAvatar" <% if (isLoggedIn) { %> style="display: block;"<% }
                                else { %> style="display: none;"<% } %>>
                                    <div class="avatar-placeholder" id="avatarPlaceholder">
                                        <% if (userName !=null && !userName.isEmpty()) { out.print(userName.substring(0,
                                            1).toUpperCase()); } else { out.print("U"); } %>
                                    </div>
                                    <div class="user-dropdown">
                                        <ul>
                                            <li><a href="${pageContext.request.contextPath}/trangcanhan.jsp"><i
                                                        class="fas fa-user"></i> Thông tin tài khoản</a></li>
                                            <li><a href="${pageContext.request.contextPath}/lichsu.jsp"><i
                                                        class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                                            <li><a href="${pageContext.request.contextPath}/yeuthich.jsp"><i
                                                        class="fas fa-heart"></i> Xe yêu thích</a></li>
                                            <li class="divider"></li>
                                            <li><a href="${pageContext.request.contextPath}/logout"><i
                                                        class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
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
                            <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                            <li><a href="${pageContext.request.contextPath}/xemay.jsp">Xe máy</a></li>
                            <li><a href="${pageContext.request.contextPath}/xeoto.jsp" class="active">Ô tô</a></li>
                            <li><a href="${pageContext.request.contextPath}/datxe.jsp">Đặt Xe</a></li>
                            <li><a href="${pageContext.request.contextPath}/timkiem.jsp">Tìm Kiếm</a></li>
                            <li><a href="${pageContext.request.contextPath}/yeuthich.jsp">Yêu Thích</a></li>
                            <li>
                                <!-- Auth Buttons Mobile - Ẩn nếu đã đăng nhập -->
                                <div class="auth-buttons-mobile" id="authButtonsMobile" <% if (isLoggedIn) { %>
                                    style="display: none;"<% } else { %> style="display: block;"<% } %>>
                                            <button class="btn btn-outline" id="loginBtnMobile"
                                                style="width: 100%; margin-bottom: 0.5rem;">Đăng nhập</button>
                                            <button class="btn btn-primary" id="registerBtnMobile"
                                                style="width: 100%;">Đăng ký</button>
                                </div>
                                <!-- User Avatar Mobile - Hiển thị nếu đã đăng nhập -->
                                <div class="user-avatar-mobile" id="userAvatarMobile" <% if (isLoggedIn) { %>
                                    style="display: block;"<% } else { %> style="display: none;"<% } %>>
                                            <div class="avatar-placeholder">
                                                <% if (userName !=null && !userName.isEmpty()) {
                                                    out.print(userName.substring(0, 1).toUpperCase()); } else {
                                                    out.print("U"); } %>
                                            </div>
                                            <div class="user-info">
                                                <p>Xin chào, <span id="mobileUserName">
                                                        <%= userName !=null ? userName : "Người dùng" %>
                                                    </span></p>
                                                <a href="${pageContext.request.contextPath}/logout"
                                                    class="btn btn-outline"
                                                    style="width: 100%; margin-top: 0.5rem;">Đăng xuất</a>
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

                        <form class="auth-form active" id="loginForm" action="${pageContext.request.contextPath}/login"
                            method="POST">
                            <!-- Hiển thị thông báo lỗi đăng nhập -->
                            <% if (loginError !=null) { %>
                                <div class="auth-message auth-error" id="loginError"
                                    style="background-color: #fee; color: #c33; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #fcc;">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <%= loginError %>
                                </div>
                                <% } %>

                                    <div class="form-group">
                                        <label for="loginEmail">Email</label>
                                        <input type="email" id="loginEmail" name="email"
                                            placeholder="Nhập email của bạn"
                                            value="<%= loginEmailValue != null ? loginEmailValue : "" %>" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="loginPassword">Mật khẩu</label>
                                        <input type="password" id="loginPassword" name="password"
                                            placeholder="Nhập mật khẩu" required>
                                    </div>

                                    <div class="form-options">
                                        <div class="remember-me">
                                            <input type="checkbox" id="rememberMe" name="rememberMe">
                                            <label for="rememberMe">Ghi nhớ đăng nhập</label>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/pages/forgot-password.jsp"
                                            class="forgot-password">Quên mật khẩu?</a>
                                    </div>

                                    <button type="submit" class="auth-submit">Đăng nhập</button>

                                    <div class="auth-footer">
                                        Chưa có tài khoản? <a href="#" id="switchToRegister">Đăng ký ngay</a>
                                    </div>
                        </form>

                        <!-- Form đăng ký với layout 2 cột -->
                        <form class="auth-form" id="registerForm" action="${pageContext.request.contextPath}/register"
                            method="POST">
                            <!-- Hiển thị thông báo lỗi đăng ký -->
                            <% if (registerError !=null) { %>
                                <div class="auth-message auth-error" id="registerError"
                                    style="background-color: #fee; color: #c33; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #fcc;">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <%= registerError %>
                                </div>
                                <% } %>

                                    <!-- Hiển thị thông báo thành công đăng ký -->
                                    <% if (registerSuccess !=null) { %>
                                        <div class="auth-message auth-success" id="registerSuccess"
                                            style="background-color: #efe; color: #3c3; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #cfc;">
                                            <i class="fas fa-check-circle"></i>
                                            <%= registerSuccess %>
                                        </div>
                                        <% } %>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="registerName">Họ và tên</label>
                                                    <input type="text" id="registerName" name="fullName"
                                                        placeholder="Nhập họ và tên"
                                                        value="<%= registerFullNameValue != null ? registerFullNameValue : "" %>"
                                                        required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="registerPhone">Số điện thoại</label>
                                                    <input type="tel" id="registerPhone" name="phone"
                                                        placeholder="Nhập số điện thoại"
                                                        value="<%= registerPhoneValue != null ? registerPhoneValue : "" %>"
                                                        required>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" id="registerEmail" name="email"
                                                    placeholder="Nhập email của bạn"
                                                    value="<%= registerEmailValue != null ? registerEmailValue : "" %>"
                                                    required>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="registerPassword">Mật khẩu</label>
                                                    <input type="password" id="registerPassword" name="password"
                                                        placeholder="Tạo mật khẩu" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="registerConfirmPassword">Xác nhận mật khẩu</label>
                                                    <input type="password" id="registerConfirmPassword"
                                                        name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
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
                        <li>Ô tô</li>
                    </ul>
                </div>

                <!-- Page Header -->
                <section class="page-header">
                    <h1>Danh Mục Xe Ô tô</h1>
                    <p>Khám phá bộ sưu tập xe ô tô đa dạng của chúng tôi, từ xe phổ thông đến cao cấp, phù hợp với mọi
                        nhu cầu di chuyển của bạn.</p>
                </section>

                <!-- Filter & Sort Section -->
                <section class="filter-sort-section">
                    <div class="filter-options">
                        <div class="filter-group">
                            <label for="brand-filter">Hãng xe</label>
                            <select id="brand-filter">
                                <option value="">Tất cả hãng</option>
                                <option value="toyota">Toyota</option>
                                <option value="honda">Honda</option>
                                <option value="ford">Ford</option>
                                <option value="hyundai">Hyundai</option>
                                <option value="mazda">Mazda</option>
                                <option value="mercedes">Mercedes</option>
                                <option value="bmw">BMW</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="type-filter">Loại xe</label>
                            <select id="type-filter">
                                <option value="">Tất cả loại</option>
                                <option value="sedan">Sedan</option>
                                <option value="suv">SUV</option>
                                <option value="hatchback">Hatchback</option>
                                <option value="mpv">MPV</option>
                                <option value="coupe">Coupe</option>
                                <option value="convertible">Convertible</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="price-filter">Mức giá</label>
                            <select id="price-filter">
                                <option value="">Tất cả giá</option>
                                <option value="0-500">Dưới 500.000đ</option>
                                <option value="500-1000">500.000đ - 1.000.000đ</option>
                                <option value="1000-1500">1.000.000đ - 1.500.000đ</option>
                                <option value="1500-2000">1.500.000đ - 2.000.000đ</option>
                                <option value="2000+">Trên 2.000.000đ</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="seats-filter">Số chỗ</label>
                            <select id="seats-filter">
                                <option value="">Tất cả</option>
                                <option value="4">4 chỗ</option>
                                <option value="5">5 chỗ</option>
                                <option value="7">7 chỗ</option>
                                <option value="9">9 chỗ trở lên</option>
                            </select>
                        </div>
                    </div>
                    <div class="sort-options">
                        <label for="sort-by">Sắp xếp theo:</label>
                        <select id="sort-by">
                            <option value="popular">Phổ biến nhất</option>
                            <option value="price-low">Giá thấp đến cao</option>
                            <option value="price-high">Giá cao đến thấp</option>
                            <option value="rating">Đánh giá cao nhất</option>
                            <option value="newest">Mới nhất</option>
                        </select>
                    </div>
                </section>

                <!-- Cars Grid -->
                <section class="motorcycles-section">
                    <div class="motorcycles-grid">
                        <!-- Toyota Vios -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="Toyota Vios">
                                <div class="motorcycle-tag">Phổ biến</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>Toyota Vios 2023</h3>

                                <!-- Rating System -->
                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span>4.5 (215 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge eco-friendly">♻️ Tiết kiệm</span>
                                        <span class="badge popular">🔥 Phổ biến</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Xăng</span>
                                    <span><i class="fas fa-user"></i> 5 người</span>
                                    <span><i class="fas fa-cog"></i> Số tự động</span>
                                </div>
                                <div class="motorcycle-price">850.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('toyota-vios')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('toyota-vios')">Thuê ngay</button>

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
                                        <span>👥 18 người đang xem</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Honda CR-V -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1553440569-bcc63803a83d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="Honda CR-V">
                                <div class="motorcycle-tag">SUV</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>Honda CR-V 2023</h3>

                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span>4.5 (189 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge popular">🔥 SUV</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Xăng</span>
                                    <span><i class="fas fa-user"></i> 7 người</span>
                                    <span><i class="fas fa-cog"></i> Số tự động</span>
                                </div>
                                <div class="motorcycle-price">1.200.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('honda-crv')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('honda-crv')">Thuê ngay</button>

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

                        <!-- Mercedes C200 -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="Mercedes C200">
                                <div class="motorcycle-tag">Cao cấp</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>Mercedes C200</h3>

                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <span>5.0 (156 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge popular">🔥 Cao cấp</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Xăng</span>
                                    <span><i class="fas fa-user"></i> 5 người</span>
                                    <span><i class="fas fa-cog"></i> Số tự động</span>
                                </div>
                                <div class="motorcycle-price">2.500.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('mercedes-c200')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('mercedes-c200')">Thuê ngay</button>

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

                        <!-- Ford Ranger -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="Ford Ranger">
                                <div class="motorcycle-tag">Bán tải</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>Ford Ranger Raptor</h3>

                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <span>4.0 (98 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge popular">🔥 Bán tải</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Diesel</span>
                                    <span><i class="fas fa-user"></i> 5 người</span>
                                    <span><i class="fas fa-cog"></i> Số tự động</span>
                                </div>
                                <div class="motorcycle-price">1.800.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('ford-ranger')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('ford-ranger')">Thuê ngay</button>

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
                                        <span>👥 10 người đang xem</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Hyundai Grand i10 -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="Hyundai Grand i10">
                                <div class="motorcycle-tag">Tiết kiệm</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>Hyundai Grand i10</h3>

                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span>4.5 (176 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge eco-friendly">♻️ Tiết kiệm</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Xăng</span>
                                    <span><i class="fas fa-user"></i> 5 người</span>
                                    <span><i class="fas fa-cog"></i> Số sàn</span>
                                </div>
                                <div class="motorcycle-price">650.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('hyundai-grandi10')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('hyundai-grandi10')">Thuê ngay</button>

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
                                        <span>👥 14 người đang xem</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- BMW X5 -->
                        <div class="motorcycle-card">
                            <div class="motorcycle-img">
                                <img src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                    alt="BMW X5">
                                <div class="motorcycle-tag">Luxury</div>
                            </div>
                            <div class="motorcycle-content">
                                <h3>BMW X5 2023</h3>

                                <div class="motorcycle-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <span>4.0 (89 đánh giá)</span>
                                    </div>
                                    <div class="rating-badges">
                                        <span class="badge popular">🔥 Luxury</span>
                                    </div>
                                </div>

                                <div class="motorcycle-details">
                                    <span><i class="fas fa-gas-pump"></i> Xăng</span>
                                    <span><i class="fas fa-user"></i> 7 người</span>
                                    <span><i class="fas fa-cog"></i> Số tự động</span>
                                </div>
                                <div class="motorcycle-price">3.200.000đ <span>/ngày</span></div>

                                <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;"
                                    onclick="openVehicleModal('bmw-x5')">Chi tiết xe</button>
                                <button class="btn btn-outline" style="width: 100%;"
                                    onclick="checkLoginAndRent('bmw-x5')">Thuê ngay</button>

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
                                        <span>👥 9 người đang xem</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <button class="active">1</button>
                        <button>2</button>
                        <button>3</button>
                        <button>...</button>
                        <button>10</button>
                        <button>></button>
                    </div>
                </section>

                <!-- Vehicle Modal -->
                <div class="modal" id="vehicleModal">
                    <div class="modal-content">
                        <button class="close-modal" id="closeModal">&times;</button>
                        <div class="modal-header">
                            <h2 id="modalVehicleName">Toyota Vios 2023</h2>
                            <div class="motorcycle-rating">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                    <span>4.5 (215 đánh giá)</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="vehicle-gallery">
                                <div class="main-image">
                                    <img id="mainImage"
                                        src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                        alt="Xe chính">
                                </div>
                                <div class="thumbnail-container">
                                    <img class="thumbnail"
                                        src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                        alt="Hình 1" onclick="changeMainImage(this.src)">
                                    <img class="thumbnail"
                                        src="https://images.unsplash.com/photo-1553440569-bcc63803a83d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                        alt="Hình 2" onclick="changeMainImage(this.src)">
                                    <img class="thumbnail"
                                        src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                                        alt="Hình 3" onclick="changeMainImage(this.src)">
                                    <video class="thumbnail" onclick="playVideo(this)"
                                        poster="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80">
                                        <source
                                            src="https://assets.mixkit.co/videos/preview/mixkit-white-sedan-on-a-road-34546-large.mp4"
                                            type="video/mp4">
                                    </video>
                                </div>
                            </div>

                            <div class="vehicle-details-modal">
                                <div class="detail-section">
                                    <h3>Thông số kỹ thuật</h3>
                                    <div class="specs-grid">
                                        <div class="spec-item">
                                            <span class="spec-label">Loại xe:</span>
                                            <span class="spec-value" id="specType">Sedan</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Nhiên liệu:</span>
                                            <span class="spec-value" id="specFuel">Xăng</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Số chỗ:</span>
                                            <span class="spec-value" id="specSeats">5 người</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Hộp số:</span>
                                            <span class="spec-value" id="specGear">Số tự động</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Động cơ:</span>
                                            <span class="spec-value" id="specEngine">1.5L</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Màu sắc:</span>
                                            <span class="spec-value" id="specColor">Đen, Trắng, Bạc</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="detail-section">
                                    <h3>Tiện nghi & An toàn</h3>
                                    <div class="specs-grid">
                                        <div class="spec-item">
                                            <span class="spec-label">Camera lùi:</span>
                                            <span class="spec-value">✓ Có</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Cảm biến áp suất lốp:</span>
                                            <span class="spec-value">✓ Có</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Camera hành trình:</span>
                                            <span class="spec-value">✓ Có</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Điều hòa tự động:</span>
                                            <span class="spec-value">✓ Có</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Phanh ABS:</span>
                                            <span class="spec-value">✓ Có</span>
                                        </div>
                                        <div class="spec-item">
                                            <span class="spec-label">Túi khí:</span>
                                            <span class="spec-value">✓ 7 túi khí</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="pricing-section">
                                <h3>Bảng giá & Điều khoản</h3>
                                <div class="price-breakdown">
                                    <div class="price-item">
                                        <span>Giá thuê cơ bản (1 ngày):</span>
                                        <span id="basePrice">850.000đ</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Phí bảo hiểm:</span>
                                        <span id="insuranceFee">150.000đ</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Phí dịch vụ:</span>
                                        <span id="serviceFee">100.000đ</span>
                                    </div>
                                    <div class="price-total">
                                        Tổng cộng: <span id="totalPrice">1.100.000đ</span> / ngày
                                    </div>
                                </div>

                                <div class="modal-actions">
                                    <button class="btn btn-outline">Thêm vào yêu thích</button>
                                    <button class="btn btn-primary" id="rentNowModalBtn">Thuê ngay</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer>
                    <div class="footer-container">
                        <div class="footer-col">
                            <h3>Về Chúng Tôi</h3>
                            <p>RentCar cung cấp dịch vụ cho thuê xe máy, xe điện và ô tô chất lượng cao với giá cả hợp
                                lý.</p>
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
                                <li><a href="#" class="active">Ô tô</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h3>Dịch Vụ</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/pages/xemay.jsp">Thuê xe máy</a></li>
                                <li><a href="${pageContext.request.contextPath}/pages/dienthoai.jsp">Thuê xe điện</a>
                                </li>
                                <li><a href="#" class="active">Thuê ô tô</a></li>
                                <li><a href="${pageContext.request.contextPath}/pages/long-term.jsp">Thuê xe dài hạn</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/pages/insurance.jsp">Bảo hiểm xe</a>
                                </li>
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
                    // Global variables
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
                                document.addEventListener('DOMContentLoaded', function () {
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

                    // Hàm kiểm tra đăng nhập và chuyển đến trang đặt xe
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

                    // Full Page Loading
                    window.addEventListener('load', function () {
                        setTimeout(function () {
                            document.getElementById('fullPageLoading').style.opacity = '0';
                            setTimeout(function () {
                                document.getElementById('fullPageLoading').style.display = 'none';
                            }, 500);
                        }, 1000);
                    });

                    // Wrap all DOM-related code in DOMContentLoaded
                    document.addEventListener('DOMContentLoaded', function () {

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
                                if (registerTab) registerTab.classList.remove('active');
                                if (loginForm) loginForm.classList.add('active');
                                if (registerForm) registerForm.classList.remove('active');
                                if (authTitle) authTitle.textContent = 'Đăng nhập';
                            });
                        }

                        if (registerTab) {
                            registerTab.addEventListener('click', () => {
                                registerTab.classList.add('active');
                                if (loginTab) loginTab.classList.remove('active');
                                if (registerForm) registerForm.classList.add('active');
                                if (loginForm) loginForm.classList.remove('active');
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

                        // Wishlist Toggle
                        document.querySelectorAll('.btn-wishlist').forEach(button => {
                            button.addEventListener('click', function () {
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
                        const rentNowModalBtn = document.getElementById('rentNowModalBtn');

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

                        // Thêm event listener cho nút "Thuê ngay" trong modal
                        if (rentNowModalBtn) {
                            rentNowModalBtn.addEventListener('click', function () {
                                if (currentVehicleId) {
                                    checkLoginAndRent(currentVehicleId);
                                }
                            });
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

                        // Filter Functionality
                        const brandFilter = document.getElementById('brand-filter');
                        const typeFilter = document.getElementById('type-filter');
                        const priceFilter = document.getElementById('price-filter');
                        const seatsFilter = document.getElementById('seats-filter');
                        const sortBy = document.getElementById('sort-by');

                        function applyFilters() {
                            // Logic for filtering and sorting cars
                            console.log('Applying filters...');
                            // In a real application, this would make an API call or filter the displayed items
                        }

                        if (brandFilter) brandFilter.addEventListener('change', applyFilters);
                        if (typeFilter) typeFilter.addEventListener('change', applyFilters);
                        if (priceFilter) priceFilter.addEventListener('change', applyFilters);
                        if (seatsFilter) seatsFilter.addEventListener('change', applyFilters);
                        if (sortBy) sortBy.addEventListener('change', applyFilters);

                        // Pagination
                        document.querySelectorAll('.pagination button').forEach(button => {
                            button.addEventListener('click', function () {
                                document.querySelectorAll('.pagination button').forEach(btn => {
                                    btn.classList.remove('active');
                                });
                                this.classList.add('active');
                                // In a real application, this would load the corresponding page
                            });
                        });

                        // Share functionality
                        document.querySelectorAll('.btn-share').forEach(button => {
                            button.addEventListener('click', function () {
                                if (navigator.share) {
                                    navigator.share({
                                        title: 'Thuê xe ô tô - RentCar',
                                        text: 'Xem xe ô tô chất lượng cao tại RentCar',
                                        url: window.location.href,
                                    })
                                        .then(() => console.log('Successful share'))
                                        .catch((error) => console.log('Error sharing:', error));
                                } else {
                                    // Fallback for browsers that don't support Web Share API
                                    alert('Chia sẻ: ' + window.location.href);
                                }
                            });
                        });

        // Tự động mở modal nếu có lỗi từ servlet
        <% if (openModal != null) { %>
                            window.addEventListener('load', function () {
                                // Đợi một chút để đảm bảo DOM đã load xong
                                setTimeout(function () {
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
                            loginEmailInput.addEventListener('input', function () {
                                loginErrorDiv.style.display = 'none';
                            });
                        }

                        const registerEmailInput = document.getElementById('registerEmail');
                        const registerErrorDiv = document.getElementById('registerError');
                        if (registerEmailInput && registerErrorDiv) {
                            registerEmailInput.addEventListener('input', function () {
                                registerErrorDiv.style.display = 'none';
                            });
                        }

                        // Giữ lại hàm openVehicleModal từ code gốc
                        window.openVehicleModal = function (vehicleId) {
                            currentVehicleId = vehicleId; // Lưu vehicleId vào biến global

                            // Hiển thị loading trong modal
                            if (vehicleModal) {
                                vehicleModal.style.display = 'block';
                                document.body.style.overflow = 'hidden';
                            }

                            // Giả lập loading 2 giây
                            setTimeout(() => {
                                // Cập nhật thông tin xe dựa trên vehicleId
                                updateModalContent(vehicleId);
                            }, 2000);
                        };

                        // Giữ lại hàm updateModalContent từ code gốc
                        window.updateModalContent = function (vehicleId) {
                            const vehicleData = {
                                'toyota-vios': {
                                    name: 'Toyota Vios 2023',
                                    type: 'Sedan',
                                    fuel: 'Xăng',
                                    seats: '5 người',
                                    gear: 'Số tự động',
                                    engine: '1.5L',
                                    color: 'Đen, Trắng, Bạc',
                                    basePrice: '850.000đ',
                                    insuranceFee: '150.000đ',
                                    serviceFee: '100.000đ',
                                    totalPrice: '1.100.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                                },
                                'honda-crv': {
                                    name: 'Honda CR-V 2023',
                                    type: 'SUV',
                                    fuel: 'Xăng',
                                    seats: '7 người',
                                    gear: 'Số tự động',
                                    engine: '1.5L Turbo',
                                    color: 'Đen, Trắng, Xám',
                                    basePrice: '1.200.000đ',
                                    insuranceFee: '200.000đ',
                                    serviceFee: '150.000đ',
                                    totalPrice: '1.550.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1553440569-bcc63803a83d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                                },
                                'mercedes-c200': {
                                    name: 'Mercedes C200',
                                    type: 'Sedan',
                                    fuel: 'Xăng',
                                    seats: '5 người',
                                    gear: 'Số tự động',
                                    engine: '2.0L Turbo',
                                    color: 'Đen, Trắng, Xám',
                                    basePrice: '2.500.000đ',
                                    insuranceFee: '350.000đ',
                                    serviceFee: '250.000đ',
                                    totalPrice: '3.100.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                                },
                                'ford-ranger': {
                                    name: 'Ford Ranger Raptor',
                                    type: 'Bán tải',
                                    fuel: 'Diesel',
                                    seats: '5 người',
                                    gear: 'Số tự động',
                                    engine: '2.0L Bi-Turbo',
                                    color: 'Cam, Đen, Trắng',
                                    basePrice: '1.800.000đ',
                                    insuranceFee: '250.000đ',
                                    serviceFee: '200.000đ',
                                    totalPrice: '2.250.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                                },
                                'hyundai-grandi10': {
                                    name: 'Hyundai Grand i10',
                                    type: 'Hatchback',
                                    fuel: 'Xăng',
                                    seats: '5 người',
                                    gear: 'Số sàn',
                                    engine: '1.2L',
                                    color: 'Đỏ, Xanh, Trắng',
                                    basePrice: '650.000đ',
                                    insuranceFee: '120.000đ',
                                    serviceFee: '80.000đ',
                                    totalPrice: '850.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                                },
                                'bmw-x5': {
                                    name: 'BMW X5 2023',
                                    type: 'SUV',
                                    fuel: 'Xăng',
                                    seats: '7 người',
                                    gear: 'Số tự động',
                                    engine: '3.0L Turbo',
                                    color: 'Đen, Trắng, Xanh',
                                    basePrice: '3.200.000đ',
                                    insuranceFee: '450.000đ',
                                    serviceFee: '350.000đ',
                                    totalPrice: '4.000.000đ',
                                    mainImage: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
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
                        };
                    }); // End of DOMContentLoaded


                </script>
            </body>

            </html>
