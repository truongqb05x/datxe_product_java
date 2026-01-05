<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page pageEncoding="UTF-8" %>
        <%@ page import="javax.servlet.http.HttpSession" %>
            <%@ page import="nntruong.data.model.Vehicle" %>
                <% HttpSession sessionObj=request.getSession(false); boolean isLoggedIn=false; String userName=null;
                    String userEmail=null; Integer userId=null; if (sessionObj !=null) { Object
                    isLoggedInObj=sessionObj.getAttribute("isLoggedIn"); if (isLoggedInObj !=null && isLoggedInObj
                    instanceof Boolean) { isLoggedIn=(Boolean) isLoggedInObj; if (isLoggedIn) { userName=(String)
                    sessionObj.getAttribute("userName"); userEmail=(String) sessionObj.getAttribute("userEmail");
                    userId=(Integer) sessionObj.getAttribute("userId"); } } } String loginError=(String)
                    request.getAttribute("loginError"); String registerError=(String)
                    request.getAttribute("registerError"); String registerSuccess=(String)
                    request.getAttribute("registerSuccess"); String bookingError=(String)
                    request.getAttribute("bookingError"); String bookingSuccess=request.getParameter("success"); String
                    bookingCode=request.getParameter("bookingCode"); String loginEmailValue=(String)
                    request.getAttribute("loginEmail"); String registerFullNameValue=(String)
                    request.getAttribute("registerFullName"); String registerPhoneValue=(String)
                    request.getAttribute("registerPhone"); String registerEmailValue=(String)
                    request.getAttribute("registerEmail"); String openModal=null; if (loginError !=null) {
                    openModal="login" ; } else if (registerError !=null) { openModal="register" ; } Vehicle
                    selectedVehicle=(Vehicle) request.getAttribute("selectedVehicle"); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Thuê Xe - RentCar</title>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/datxe.css">
                    </head>
                    <style>
                        /* Thêm style cho auth modal tương tự index.jsp */
                        .auth-modal {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0, 0, 0, 0.5);
                            z-index: 1000;
                            align-items: center;
                            justify-content: center;
                        }

                        .auth-modal.active {
                            display: flex;
                        }

                        .auth-container {
                            background-color: white;
                            border-radius: 8px;
                            width: 100%;
                            max-width: 500px;
                            padding: 30px;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                            position: relative;
                            max-height: 90vh;
                            overflow-y: auto;
                        }

                        .auth-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 20px;
                        }

                        .auth-header h2 {
                            margin: 0;
                            color: var(--primary);
                        }

                        .close-auth {
                            background: none;
                            border: none;
                            font-size: 28px;
                            cursor: pointer;
                            color: #666;
                        }

                        .auth-tabs {
                            display: flex;
                            margin-bottom: 20px;
                            border-bottom: 1px solid #eee;
                        }

                        .auth-tab {
                            padding: 10px 20px;
                            background: none;
                            border: none;
                            font-size: 16px;
                            cursor: pointer;
                            border-bottom: 3px solid transparent;
                        }

                        .auth-tab.active {
                            color: var(--primary);
                            border-bottom-color: var(--primary);
                        }

                        .auth-form {
                            display: none;
                        }

                        .auth-form.active {
                            display: block;
                        }

                        .form-row {
                            display: flex;
                            gap: 15px;
                            margin-bottom: 15px;
                        }

                        .form-row .form-group {
                            flex: 1;
                        }

                        .auth-submit {
                            width: 100%;
                            padding: 12px;
                            background-color: var(--primary);
                            color: white;
                            border: none;
                            border-radius: 4px;
                            cursor: pointer;
                            font-size: 16px;
                            margin-top: 10px;
                        }

                        .auth-footer {
                            text-align: center;
                            margin-top: 20px;
                            color: #666;
                        }

                        .auth-footer a {
                            color: var(--primary);
                            text-decoration: none;
                        }

                        .auth-message {
                            padding: 10px;
                            border-radius: 4px;
                            margin-bottom: 15px;
                            border: 1px solid;
                        }

                        .auth-error {
                            background-color: #fee;
                            color: #c33;
                            border-color: #fcc;
                        }

                        .auth-success {
                            background-color: #efe;
                            color: #3c3;
                            border-color: #cfc;
                        }

                        /* User avatar */
                        .user-avatar {
                            position: relative;
                            cursor: pointer;
                        }

                        .avatar-placeholder {
                            width: 40px;
                            height: 40px;
                            background-color: var(--primary);
                            color: white;
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-weight: bold;
                            font-size: 18px;
                        }

                        .user-dropdown {
                            display: none;
                            position: absolute;
                            top: 50px;
                            right: 0;
                            background-color: white;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                            border-radius: 4px;
                            width: 200px;
                            z-index: 100;
                        }

                        .user-avatar:hover .user-dropdown {
                            display: block;
                        }

                        .user-dropdown ul {
                            list-style: none;
                            margin: 0;
                            padding: 10px 0;
                        }

                        .user-dropdown li {
                            padding: 0;
                        }

                        .user-dropdown a {
                            display: flex;
                            align-items: center;
                            padding: 10px 15px;
                            color: #333;
                            text-decoration: none;
                        }

                        .user-dropdown a:hover {
                            background-color: #f5f5f5;
                        }

                        .user-dropdown i {
                            margin-right: 10px;
                            width: 20px;
                            text-align: center;
                        }

                        .divider {
                            height: 1px;
                            background-color: #eee;
                            margin: 5px 0;
                        }

                        /* Mobile menu */
                        .mobile-menu {
                            display: none;
                            background-color: white;
                            padding: 20px;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                        }

                        .mobile-menu.active {
                            display: block;
                        }

                        .mobile-menu ul {
                            list-style: none;
                            padding: 0;
                        }

                        .mobile-menu li {
                            margin-bottom: 10px;
                        }

                        .mobile-menu a {
                            display: block;
                            padding: 10px;
                            color: #333;
                            text-decoration: none;
                            border-radius: 4px;
                        }

                        .mobile-menu a:hover {
                            background-color: #f5f5f5;
                        }

                        .mobile-menu .auth-buttons-mobile {
                            margin-top: 20px;
                        }

                        .mobile-menu .user-avatar-mobile {
                            display: flex;
                            align-items: center;
                            gap: 15px;
                            padding: 10px;
                            background-color: #f9f9f9;
                            border-radius: 4px;
                            margin-top: 20px;
                        }

                        .mobile-menu .user-info p {
                            margin: 0;
                        }
                    </style>

                    <body>
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
                                        <li><a href="${pageContext.request.contextPath}/xeoto.jsp">Thuê Ô tô</a></li>
                                        <li><a href="${pageContext.request.contextPath}/datxe.jsp" class="active">Đặt
                                                Xe</a>
                                        </li>
                                    </ul>
                                </nav>
                                <!-- Auth Buttons - Ẩn nếu đã đăng nhập -->
                                <div class="auth-buttons" id="authButtons" <% if (isLoggedIn) { %> style="display:
                                    none;"<% } else { %> style="display: flex;"<% } %>>
                                            <button class="btn btn-outline" id="loginBtn">Đăng nhập</button>
                                            <button class="btn btn-primary" id="registerBtn">Đăng ký</button>
                                </div>

                                <!-- User Avatar - Hiển thị nếu đã đăng nhập -->
                                <div class="user-avatar" id="userAvatar" <% if (isLoggedIn) { %> style="display: block;"
                                    <% } else { %> style="display: none;"<% } %>>
                                            <div class="avatar-placeholder" id="avatarPlaceholder">
                                                <% if (userName !=null && !userName.isEmpty()) {
                                                    out.print(userName.substring(0, 1).toUpperCase()); } else {
                                                    out.print("U"); } %>
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
                                    <li><a href="${pageContext.request.contextPath}/xemay.jsp">Thuê Xe máy</a></li>
                                    <li><a href="${pageContext.request.contextPath}/xeoto.jsp">Thuê Ô tô</a></li>
                                    <li><a href="${pageContext.request.contextPath}/datxe.jsp" class="active">Đặt Xe</a>
                                    </li>
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

                        <!-- Auth Modal (giống như trong index.jsp) -->
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

                                <form class="auth-form active" id="loginForm"
                                    action="${pageContext.request.contextPath}/login" method="POST">
                                    <!-- Hiển thị thông báo lỗi đăng nhập -->
                                    <% if (loginError !=null) { %>
                                        <div class="auth-message auth-error" id="loginError">
                                            <i class="fas fa-exclamation-circle"></i>
                                            <%= loginError %>
                                        </div>
                                        <% } %>

                                            <div class="form-group">
                                                <label for="loginEmail">Email</label>
                                                <input type="email" id="loginEmail" name="email"
                                                    placeholder="Nhập email của bạn"
                                                    value="<%= loginEmailValue != null ? loginEmailValue : "" %>"
                                                    required>
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
                                                <a href="#" class="forgot-password">Quên mật khẩu?</a>
                                            </div>

                                            <button type="submit" class="auth-submit">Đăng nhập</button>

                                            <div class="auth-footer">
                                                Chưa có tài khoản? <a href="#" id="switchToRegister">Đăng ký ngay</a>
                                            </div>
                                </form>

                                <!-- Form đăng ký với layout 2 cột -->
                                <form class="auth-form" id="registerForm"
                                    action="${pageContext.request.contextPath}/register" method="POST">
                                    <!-- Hiển thị thông báo lỗi đăng ký -->
                                    <% if (registerError !=null) { %>
                                        <div class="auth-message auth-error" id="registerError">
                                            <i class="fas fa-exclamation-circle"></i>
                                            <%= registerError %>
                                        </div>
                                        <% } %>

                                            <!-- Hiển thị thông báo thành công đăng ký -->
                                            <% if (registerSuccess !=null) { %>
                                                <div class="auth-message auth-success" id="registerSuccess">
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
                                                            <label for="registerConfirmPassword">Xác nhận mật
                                                                khẩu</label>
                                                            <input type="password" id="registerConfirmPassword"
                                                                name="confirmPassword" placeholder="Xác nhận mật khẩu"
                                                                required>
                                                        </div>
                                                    </div>

                                                    <button type="submit" class="auth-submit">Đăng ký</button>

                                                    <div class="auth-footer">
                                                        Đã có tài khoản? <a href="#" id="switchToLogin">Đăng nhập
                                                            ngay</a>
                                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Breadcrumb -->
                        <div class="breadcrumb">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                                <li><a href="${pageContext.request.contextPath}/xemay.jsp">Xe máy</a></li>
                                <li>Đặt thuê xe</li>
                            </ul>
                        </div>

                        <!-- Booking Container -->
                        <div class="booking-container">
                            <!-- Booking Progress -->
                            <div class="booking-progress">
                                <div class="progress-steps">
                                    <div class="progress-bar" id="progressBar" style="width: 25%"></div>
                                    <div class="step active" id="step1">
                                        <div class="step-number">1</div>
                                        <span>Thông tin đặt xe</span>
                                    </div>
                                    <div class="step" id="step2">
                                        <div class="step-number">2</div>
                                        <span>Xác nhận thông tin</span>
                                    </div>
                                    <div class="step" id="step3">
                                        <div class="step-number">3</div>
                                        <span>Thanh toán</span>
                                    </div>
                                    <div class="step" id="step4">
                                        <div class="step-number">4</div>
                                        <span>Hoàn tất</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Booking Content -->
                            <div class="booking-content">
                                <!-- Booking Form -->
                                <div class="booking-form">
                                    <!-- Step 1: Thông tin đặt xe -->
                                    <div class="form-section active" id="section1">
                                        <h2 class="section-title">Thông tin đặt xe</h2>

                                        <% if (!isLoggedIn) { %>
                                            <!-- Thông báo yêu cầu đăng nhập -->
                                            <div class="auth-required-message"
                                                style="background-color: #fff8e1; border-left: 4px solid #ffc107; padding: 15px; margin-bottom: 20px; border-radius: 4px;">
                                                <h3 style="color: #ff9800; margin-top: 0;"><i
                                                        class="fas fa-exclamation-triangle"></i> Yêu cầu đăng nhập</h3>
                                                <p>Vui lòng đăng nhập để tiếp tục đặt xe. Nếu chưa có tài khoản, bạn có
                                                    thể
                                                    đăng ký miễn phí.</p>
                                                <div style="margin-top: 10px;">
                                                    <button class="btn btn-outline"
                                                        onclick="openAuthModalGlobal('login')">Đăng nhập</button>
                                                    <button class="btn btn-primary"
                                                        onclick="openAuthModalGlobal('register')">Đăng ký</button>
                                                </div>
                                            </div>
                                            <% } %>

                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="fullName">Họ và tên *</label>
                                                        <input type="text" id="fullName" placeholder="Nhập họ và tên"
                                                            value="<%= userName != null ? userName : "" %>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="phone">Số điện thoại *</label>
                                                        <input type="tel" id="phone" placeholder="Nhập số điện thoại"
                                                            required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="email">Email *</label>
                                                    <input type="email" id="email" placeholder="Nhập email"
                                                        value="<%= userEmail != null ? userEmail : "" %>" required>
                                                </div>

                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="pickupDate">Ngày nhận xe *</label>
                                                        <input type="date" id="pickupDate" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="returnDate">Ngày trả xe *</label>
                                                        <input type="date" id="returnDate" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="pickupLocation">Địa điểm nhận xe *</label>
                                                        <select id="pickupLocation" required>
                                                            <option value="">Chọn địa điểm nhận xe</option>
                                                            <option value="hq">Trụ sở chính - 123 ABC, Quận 1, TP.HCM
                                                            </option>
                                                            <option value="branch1">Chi nhánh 1 - 456 XYZ, Quận 3,
                                                                TP.HCM
                                                            </option>
                                                            <option value="branch2">Chi nhánh 2 - 789 DEF, Quận 5,
                                                                TP.HCM
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="returnLocation">Địa điểm trả xe *</label>
                                                        <select id="returnLocation" required>
                                                            <option value="">Chọn địa điểm trả xe</option>
                                                            <option value="hq">Trụ sở chính - 123 ABC, Quận 1, TP.HCM
                                                            </option>
                                                            <option value="branch1">Chi nhánh 1 - 456 XYZ, Quận 3,
                                                                TP.HCM
                                                            </option>
                                                            <option value="branch2">Chi nhánh 2 - 789 DEF, Quận 5,
                                                                TP.HCM
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="specialRequest">Yêu cầu đặc biệt (nếu có)</label>
                                                    <textarea id="specialRequest" rows="3"
                                                        placeholder="Nhập yêu cầu đặc biệt của bạn..."></textarea>
                                                </div>

                                                <div class="form-actions">
                                                    <button class="btn btn-outline" disabled>Quay lại</button>
                                                    <button class="btn btn-primary" onclick="nextStep(2)" <%=!isLoggedIn
                                                        ? "disabled" : "" %>>Tiếp tục</button>
                                                </div>
                                    </div>

                                    <!-- Step 2: Xác nhận thông tin -->
                                    <div class="form-section" id="section2">
                                        <h2 class="section-title">Xác nhận thông tin</h2>

                                        <div class="upload-section">
                                            <h3>Giấy tờ tùy thân</h3>
                                            <p>Vui lòng tải lên ảnh chụp CMND/CCCD mặt trước và mặt sau</p>

                                            <div class="upload-area" id="idCardUpload">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <p>Kéo thả hoặc nhấp để tải lên</p>
                                                <span>Hỗ trợ: JPG, PNG (Tối đa 5MB)</span>
                                            </div>

                                            <div class="uploaded-files" id="idCardFiles">
                                                <!-- Uploaded files will appear here -->
                                            </div>
                                        </div>

                                        <div class="upload-section">
                                            <h3>Bằng lái xe</h3>
                                            <p>Vui lòng tải lên ảnh chụp bằng lái xe mặt trước và mặt sau</p>

                                            <div class="upload-area" id="licenseUpload">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <p>Kéo thả hoặc nhấp để tải lên</p>
                                                <span>Hỗ trợ: JPG, PNG (Tối đa 5MB)</span>
                                            </div>

                                            <div class="uploaded-files" id="licenseFiles">
                                                <!-- Uploaded files will appear here -->
                                            </div>
                                        </div>

                                        <div class="form-actions">
                                            <button class="btn btn-outline" onclick="prevStep(1)">Quay lại</button>
                                            <button class="btn btn-primary" onclick="nextStep(3)">Tiếp tục</button>
                                        </div>
                                    </div>

                                    <!-- Step 3: Thanh toán -->
                                    <div class="form-section" id="section3">
                                        <h2 class="section-title">Phương thức thanh toán</h2>

                                        <div class="payment-methods">
                                            <div class="payment-method" onclick="selectPayment(this)">
                                                <input type="radio" name="payment" id="cash" checked>
                                                <div class="payment-icon">
                                                    <i class="fas fa-money-bill-wave"></i>
                                                </div>
                                                <div class="payment-info">
                                                    <h4>Thanh toán khi nhận xe</h4>
                                                    <p>Thanh toán trực tiếp khi nhận xe</p>
                                                </div>
                                            </div>

                                            <div class="payment-method" onclick="selectPayment(this)">
                                                <input type="radio" name="payment" id="bank">
                                                <div class="payment-icon">
                                                    <i class="fas fa-university"></i>
                                                </div>
                                                <div class="payment-info">
                                                    <h4>Chuyển khoản ngân hàng</h4>
                                                    <p>Chuyển khoản qua tài khoản ngân hàng</p>
                                                </div>
                                            </div>

                                            <div class="payment-method" onclick="selectPayment(this)">
                                                <input type="radio" name="payment" id="card">
                                                <div class="payment-icon">
                                                    <i class="fas fa-credit-card"></i>
                                                </div>
                                                <div class="payment-info">
                                                    <h4>Thẻ tín dụng/ghi nợ</h4>
                                                    <p>Thanh toán qua thẻ Visa, Mastercard</p>
                                                </div>
                                            </div>

                                            <div class="payment-method" onclick="selectPayment(this)">
                                                <input type="radio" name="payment" id="momo">
                                                <div class="payment-icon">
                                                    <i class="fas fa-mobile-alt"></i>
                                                </div>
                                                <div class="payment-info">
                                                    <h4>Ví điện tử MoMo</h4>
                                                    <p>Thanh toán qua ứng dụng MoMo</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="terms-section">
                                            <h3>Điều khoản và điều kiện</h3>
                                            <div class="terms-box">
                                                <p>1. Khách hàng phải có bằng lái xe hợp lệ và đủ điều kiện theo quy
                                                    định
                                                    của pháp luật.</p>
                                                <p>2. Khách hàng chịu trách nhiệm về mọi vi phạm giao thông trong thời
                                                    gian
                                                    thuê xe.</p>
                                                <p>3. Xe phải được trả đúng giờ và địa điểm đã thỏa thuận. Trễ hẹn sẽ bị
                                                    phụ
                                                    thu.</p>
                                                <p>4. Khách hàng chịu trách nhiệm bồi thường thiệt hại nếu xảy ra tai
                                                    nạn do
                                                    lỗi của mình.</p>
                                                <p>5. Phí bảo hiểm đã bao gồm trong giá thuê, tuy nhiên khách hàng vẫn
                                                    phải
                                                    chịu một phần chi phí khấu trừ trong trường hợp xảy ra sự cố.</p>
                                                <p>6. Không sử dụng xe cho mục đích bất hợp pháp, đua xe trái phép hoặc
                                                    các
                                                    hoạt động vi phạm pháp luật.</p>
                                                <p>7. Khách hàng đồng ý cho RentCar kiểm tra lịch sử lái xe và thông tin
                                                    cá
                                                    nhân khi cần thiết.</p>
                                            </div>
                                            <div class="agree-terms">
                                                <input type="checkbox" id="agreeTerms" required>
                                                <label for="agreeTerms">Tôi đã đọc và đồng ý với các điều khoản và điều
                                                    kiện
                                                    trên</label>
                                            </div>
                                        </div>

                                        <div class="form-actions">
                                            <button class="btn btn-outline" onclick="prevStep(2)">Quay lại</button>
                                            <button class="btn btn-primary" onclick="completeBooking()">Hoàn tất đặt
                                                xe</button>
                                        </div>
                                    </div>

                                    <!-- Step 4: Hoàn tất -->
                                    <div class="form-section" id="section4">
                                        <div class="success-message">
                                            <div class="success-icon">
                                                <i class="fas fa-check-circle"></i>
                                            </div>
                                            <h2>Đặt xe thành công!</h2>
                                            <p>Cảm ơn bạn đã sử dụng dịch vụ của RentCar. Chúng tôi sẽ liên hệ với bạn
                                                trong
                                                thời gian sớm nhất để xác nhận đơn đặt xe.</p>

                                            <div class="booking-details">
                                                <h3>Thông tin đặt xe</h3>
                                                <div class="detail-item">
                                                    <span>Mã đặt xe:</span>
                                                    <span><strong>RC20230001</strong></span>
                                                </div>
                                                <div class="detail-item">
                                                    <span>Xe thuê:</span>
                                                    <span>Honda Vision 2023</span>
                                                </div>
                                                <div class="detail-item">
                                                    <span>Ngày nhận:</span>
                                                    <span>15/11/2023</span>
                                                </div>
                                                <div class="detail-item">
                                                    <span>Ngày trả:</span>
                                                    <span>18/11/2023</span>
                                                </div>
                                                <div class="detail-item">
                                                    <span>Tổng cộng:</span>
                                                    <span><strong>600.000đ</strong></span>
                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button class="btn btn-outline" onclick="printBooking()">In hóa
                                                    đơn</button>
                                                <button class="btn btn-primary" onclick="goHome()">Về trang chủ</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Booking Summary -->
                                <div class="booking-summary">
                                    <h2 class="section-title">Thông tin xe</h2>

                                    <% if (selectedVehicle !=null) { String vehicleName=selectedVehicle.getFullName();
                                        String imageUrl=selectedVehicle.getMainImageUrl() !=null &&
                                        !selectedVehicle.getMainImageUrl().isEmpty() ? selectedVehicle.getMainImageUrl()
                                        : "https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&auto=format&fit=crop&w=1480&q=80"
                                        ; String fuelType=selectedVehicle.getFuelType() !=null ?
                                        selectedVehicle.getFuelType() : "Xăng" ; String
                                        transmission=selectedVehicle.getTransmission() !=null ?
                                        selectedVehicle.getTransmission() : "Tự động" ; int
                                        seatCapacity=selectedVehicle.getSeatCapacity() !=null ?
                                        selectedVehicle.getSeatCapacity() : 2; String
                                        engineCapacity=selectedVehicle.getEngineCapacity() !=null ?
                                        selectedVehicle.getEngineCapacity() : "110cc" ; String
                                        color=selectedVehicle.getColor() !=null ? selectedVehicle.getColor() : "Đen" ;
                                        String formattedPrice=selectedVehicle.getFormattedDailyRate(); %>

                                        <div class="vehicle-summary">
                                            <div class="vehicle-image">
                                                <img src="<%= imageUrl %>" alt="<%= vehicleName %>">
                                            </div>
                                            <div class="vehicle-info">
                                                <h3>
                                                    <%= vehicleName %>
                                                        <% if (selectedVehicle.getModelYear() !=null) { %>
                                                            <%= selectedVehicle.getModelYear() %>
                                                                <% } %>
                                                </h3>
                                                <div class="vehicle-details">
                                                    <div>
                                                        <%= fuelType %> • <%= transmission %> • <%= seatCapacity %>
                                                                    người
                                                    </div>
                                                    <div>
                                                        <%= engineCapacity %> • Màu: <%= color %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <% } else { %>

                                            <div class="vehicle-summary">
                                                <div class="vehicle-image">
                                                    <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&auto=format&fit=crop&w=1480&q=80"
                                                        alt="Xe">
                                                </div>
                                                <div class="vehicle-info">
                                                    <h3>Chọn xe để xem thông tin</h3>
                                                    <div class="vehicle-details">
                                                        <div>Vui lòng chọn xe từ trang chủ</div>
                                                    </div>
                                                </div>
                                            </div>

                                            <% } %>

                                                <div class="price-breakdown">
                                                    <h3>Chi tiết giá</h3>
                                                    <div class="price-item">
                                                        <span>Giá thuê (3 ngày)</span>
                                                        <span>450.000đ</span>
                                                    </div>
                                                    <div class="price-item">
                                                        <span>Phí bảo hiểm</span>
                                                        <span>90.000đ</span>
                                                    </div>
                                                    <div class="price-item">
                                                        <span>Phí dịch vụ</span>
                                                        <span>60.000đ</span>
                                                    </div>
                                                    <div class="price-total">
                                                        Tổng cộng: 600.000đ
                                                    </div>
                                                </div>

                                                <div class="rental-info">
                                                    <h3>Thông tin thuê</h3>
                                                    <div class="price-item">
                                                        <span>Ngày nhận:</span>
                                                        <span>15/11/2023</span>
                                                    </div>
                                                    <div class="price-item">
                                                        <span>Ngày trả:</span>
                                                        <span>18/11/2023</span>
                                                    </div>
                                                    <div class="price-item">
                                                        <span>Địa điểm nhận:</span>
                                                        <span>Trụ sở chính</span>
                                                    </div>
                                                    <div class="price-item">
                                                        <span>Địa điểm trả:</span>
                                                        <span>Trụ sở chính</span>
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
                                    <p>RentCar cung cấp dịch vụ cho thuê xe máy, xe điện và ô tô chất lượng cao với giá
                                        cả
                                        hợp lý.</p>
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
                                        <li><a href="index.html">Trang chủ</a></li>
                                        <li><a href="#">Về chúng tôi</a></li>
                                        <li><a href="xemay.html">Xe máy</a></li>
                                        <li><a href="#">Xe điện</a></li>
                                        <li><a href="#">Ô tô</a></li>
                                    </ul>
                                </div>
                                <div class="footer-col">
                                    <h3>Dịch Vụ</h3>
                                    <ul>
                                        <li><a href="xemay.html">Thuê xe máy</a></li>
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

                        <script>
                            // Global variables
                            var userLoggedIn = <%= isLoggedIn ? "true" : "false" %>;
                            var currentUser = null;

        // Nếu đã đăng nhập, lấy thông tin từ session
        <% if (isLoggedIn && userName != null) { %>
                                currentUser = {
                                    id: <%= userId != null ? userId : "null" %>,
                                        name: '<%= userName != null ? userName.replace("'", "\\'") : "" %>',
                                            email: '<%= userEmail != null ? userEmail.replace("'", "\\'") : "" %>'
                                };
        <% } %>

                                // Hàm mở modal đăng nhập
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



                            // Current step
                            let currentStep = 1;

                            // Check for success parameter in URL
                            document.addEventListener('DOMContentLoaded', function () {
                                const urlParams = new URLSearchParams(window.location.search);
                                const success = urlParams.get('success');
                                const bookingCode = urlParams.get('bookingCode');

                                if (success === 'true') {
                                    // Show success step directly
                                    currentStep = 4;
                                    showSection(4);
                                    updateStepIndicators(4);
                                    updateProgressBar(4);

                                    // Update booking code if element exists
                                    const bookingCodeElement = document.getElementById('bookingCodeDisplay');
                                    // Create element if not exists or update existing
                                    // Look for strong tag with RC code
                                    const strongTags = document.querySelectorAll('.booking-details strong');
                                    if (strongTags.length > 0 && bookingCode) {
                                        strongTags[0].textContent = bookingCode;
                                    }
                                }
                            });

                            // Update progress bar
                            function updateProgressBar(step) {
                                const progressBar = document.getElementById('progressBar');
                                const width = (step - 1) * 33.33 + '%';
                                progressBar.style.width = width;
                            }

                            // Update step indicators
                            function updateStepIndicators(step) {
                                // Reset all steps
                                for (let i = 1; i <= 4; i++) {
                                    const stepElement = document.getElementById('step' + i);
                                    stepElement.classList.remove('active', 'completed');
                                }

                                // Set current and completed steps
                                for (let i = 1; i <= step; i++) {
                                    const stepElement = document.getElementById('step' + i);
                                    if (i === step) {
                                        stepElement.classList.add('active');
                                    } else {
                                        stepElement.classList.add('completed');
                                    }
                                }
                            }

                            // Show current section
                            function showSection(step) {
                                // Hide all sections
                                for (let i = 1; i <= 4; i++) {
                                    document.getElementById('section' + i).classList.remove('active');
                                }

                                // Show current section
                                document.getElementById('section' + step).classList.add('active');
                            }

                            // Navigate to next step
                            function nextStep(step) {
                                if (!userLoggedIn) {
                                    openAuthModalGlobal('login');
                                    return;
                                }

                                // Validate current step before proceeding
                                if (!validateStep(currentStep)) {
                                    return;
                                }

                                if (step > currentStep) {
                                    currentStep = step;
                                    updateProgressBar(step);
                                    updateStepIndicators(step);
                                    showSection(step);
                                }
                            }

                            // Navigate to previous step
                            function prevStep(step) {
                                if (step < currentStep) {
                                    currentStep = step;
                                    updateProgressBar(step);
                                    updateStepIndicators(step);
                                    showSection(step);
                                }
                            }

                            // Validate current step
                            function validateStep(step) {
                                if (step === 1) {
                                    const fullName = document.getElementById('fullName').value.trim();
                                    const phone = document.getElementById('phone').value.trim();
                                    const email = document.getElementById('email').value.trim();
                                    const pickupDate = document.getElementById('pickupDate').value;
                                    const returnDate = document.getElementById('returnDate').value;

                                    if (!fullName || !phone || !email || !pickupDate || !returnDate) {
                                        alert('Vui lòng điền đầy đủ thông tin bắt buộc.');
                                        return false;
                                    }

                                    // Basic email validation
                                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                    if (!emailRegex.test(email)) {
                                        alert('Vui lòng nhập địa chỉ email hợp lệ.');
                                        return false;
                                    }

                                    // Date validation
                                    const today = new Date();
                                    today.setHours(0, 0, 0, 0);
                                    const pickup = new Date(pickupDate);
                                    const returnD = new Date(returnDate);

                                    if (pickup < today) {
                                        alert('Ngày nhận xe không được ở trong quá khứ.');
                                        return false;
                                    }

                                    if (returnD <= pickup) {
                                        alert('Ngày trả xe phải sau ngày nhận xe.');
                                        return false;
                                    }
                                }

                                return true;
                            }

                            // Select payment method
                            function selectPayment(element) {
                                // Remove selected class from all payment methods
                                const paymentMethods = document.querySelectorAll('.payment-method');
                                paymentMethods.forEach(method => {
                                    method.classList.remove('selected');
                                });

                                // Add selected class to clicked payment method
                                element.classList.add('selected');

                                // Check the radio button
                                const radio = element.querySelector('input[type="radio"]');
                                radio.checked = true;
                            }

                            // Complete booking
                            function completeBooking() {
                                if (!userLoggedIn) {
                                    openAuthModalGlobal('login');
                                    return;
                                }

                                const agreeTerms = document.getElementById('agreeTerms');

                                if (!agreeTerms.checked) {
                                    alert('Vui lòng đồng ý với điều khoản và điều kiện để tiếp tục.');
                                    return;
                                }

                                // Validate all required fields
                                if (!validateStep(1)) {
                                    alert('Vui lòng điền đầy đủ thông tin ở bước 1.');
                                    prevStep(1);
                                    return;
                                }

                                // Get form data
                                const vehicleId = getVehicleIdFromUrl();
                                const pickupDate = document.getElementById('pickupDate').value;
                                const returnDate = document.getElementById('returnDate').value;
                                const pickupLocation = document.getElementById('pickupLocation').value;
                                const returnLocation = document.getElementById('returnLocation').value;
                                const notes = document.getElementById('specialRequest').value;

                                // Get selected payment method
                                const selectedPayment = document.querySelector('input[name="payment"]:checked');
                                const paymentMethod = selectedPayment ? selectedPayment.id : 'cash';

                                // Create form and submit
                                const form = document.createElement('form');
                                form.method = 'POST';
                                form.action = '${pageContext.request.contextPath}/booking';

                                // Add form fields
                                const fields = {
                                    vehicleId: vehicleId,
                                    pickupDate: pickupDate,
                                    returnDate: returnDate,
                                    pickupLocation: pickupLocation,
                                    returnLocation: returnLocation,
                                    paymentMethod: paymentMethod,
                                    notes: notes
                                };

                                for (const [key, value] of Object.entries(fields)) {
                                    const input = document.createElement('input');
                                    input.type = 'hidden';
                                    input.name = key;
                                    input.value = value;
                                    form.appendChild(input);
                                }

                                document.body.appendChild(form);
                                form.submit();
                            }

                            // Get vehicle ID from URL parameter or default to 1
                            function getVehicleIdFromUrl() {
                                const urlParams = new URLSearchParams(window.location.search);
                                return urlParams.get('vehicleId') || '1';
                            }

                            // Print booking
                            function printBooking() {
                                window.print();
                            }

                            // Go to home page
                            function goHome() {
                                window.location.href = '${pageContext.request.contextPath}/';
                            }

                            // File upload functionality
                            function setupFileUpload(uploadAreaId, filesContainerId) {
                                const uploadArea = document.getElementById(uploadAreaId);
                                const filesContainer = document.getElementById(filesContainerId);

                                uploadArea.addEventListener('click', () => {
                                    const input = document.createElement('input');
                                    input.type = 'file';
                                    input.accept = 'image/*';
                                    input.multiple = true;

                                    input.addEventListener('change', (e) => {
                                        const files = e.target.files;

                                        for (let i = 0; i < files.length; i++) {
                                            const file = files[i];

                                            // Create file element
                                            const fileElement = document.createElement('div');
                                            fileElement.className = 'uploaded-file';

                                            fileElement.innerHTML = `
                            <i class="fas fa-file-image"></i>
                            <div class="file-name">${file.name}</div>
                            <div class="file-remove" onclick="this.parentElement.remove()">
                                <i class="fas fa-times"></i>
                            </div>
                        `;

                                            filesContainer.appendChild(fileElement);
                                        }
                                    });

                                    input.click();
                                });

                                // Drag and drop functionality
                                uploadArea.addEventListener('dragover', (e) => {
                                    e.preventDefault();
                                    uploadArea.style.borderColor = 'var(--secondary)';
                                    uploadArea.style.backgroundColor = 'rgba(52, 152, 219, 0.05)';
                                });

                                uploadArea.addEventListener('dragleave', () => {
                                    uploadArea.style.borderColor = '#ddd';
                                    uploadArea.style.backgroundColor = 'transparent';
                                });

                                uploadArea.addEventListener('drop', (e) => {
                                    e.preventDefault();
                                    uploadArea.style.borderColor = '#ddd';
                                    uploadArea.style.backgroundColor = 'transparent';

                                    const files = e.dataTransfer.files;

                                    for (let i = 0; i < files.length; i++) {
                                        const file = files[i];

                                        // Create file element
                                        const fileElement = document.createElement('div');
                                        fileElement.className = 'uploaded-file';

                                        fileElement.innerHTML = `
                        <i class="fas fa-file-image"></i>
                        <div class="file-name">${file.name}</div>
                        <div class="file-remove" onclick="this.parentElement.remove()">
                            <i class="fas fa-times"></i>
                        </div>
                    `;

                                        filesContainer.appendChild(fileElement);
                                    }
                                });
                            }

                            // Initialize when DOM is loaded
                            document.addEventListener('DOMContentLoaded', function () {
                                // Setup file upload areas
                                setupFileUpload('idCardUpload', 'idCardFiles');
                                setupFileUpload('licenseUpload', 'licenseFiles');

                                // Set default dates
                                const today = new Date();
                                const tomorrow = new Date(today);
                                tomorrow.setDate(tomorrow.getDate() + 1);

                                const pickupDate = document.getElementById('pickupDate');
                                const returnDate = document.getElementById('returnDate');

                                if (pickupDate && returnDate) {
                                    pickupDate.valueAsDate = today;
                                    returnDate.valueAsDate = tomorrow;

                                    // Set min dates
                                    pickupDate.min = today.toISOString().split('T')[0];
                                    returnDate.min = tomorrow.toISOString().split('T')[0];

                                    // Update return date min when pickup date changes
                                    pickupDate.addEventListener('change', () => {
                                        const newPickupDate = new Date(pickupDate.value);
                                        const newMinReturnDate = new Date(newPickupDate);
                                        newMinReturnDate.setDate(newMinReturnDate.getDate() + 1);

                                        returnDate.min = newMinReturnDate.toISOString().split('T')[0];

                                        // If current return date is before new min, update it
                                        if (new Date(returnDate.value) < newMinReturnDate) {
                                            returnDate.valueAsDate = newMinReturnDate;
                                        }
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
                                const avatarPlaceholder = document.getElementById('avatarPlaceholder');
                                const mobileMenuBtn = document.getElementById('mobileMenuBtn');
                                const mobileMenu = document.getElementById('mobileMenu');

                                // Mobile Menu Toggle
                                if (mobileMenuBtn && mobileMenu) {
                                    mobileMenuBtn.addEventListener('click', () => {
                                        mobileMenu.classList.toggle('active');
                                    });
                                }

                                // Auth modal functions
                                function openAuthModal(formType) {
                                    if (authModal) {
                                        authModal.classList.add('active');
                                        document.body.style.overflow = 'hidden';
                                        mobileMenu.classList.remove('active');

                                        if (formType === 'login' && loginTab) {
                                            loginTab.click();
                                        } else if (formType === 'register' && registerTab) {
                                            registerTab.click();
                                        }
                                    }
                                }

                                function closeAuthModal() {
                                    if (authModal) {
                                        authModal.classList.remove('active');
                                        document.body.style.overflow = 'auto';
                                    }
                                }

                                // Event listeners for auth buttons
                                if (loginBtn) loginBtn.addEventListener('click', () => openAuthModal('login'));
                                if (registerBtn) registerBtn.addEventListener('click', () => openAuthModal('register'));
                                if (loginBtnMobile) loginBtnMobile.addEventListener('click', () => openAuthModal('login'));
                                if (registerBtnMobile) registerBtnMobile.addEventListener('click', () => openAuthModal('register'));

                                if (closeAuth) closeAuth.addEventListener('click', closeAuthModal);

                                // Auth tabs switching
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

                                // Close modal when clicking outside
                                if (authModal) {
                                    window.addEventListener('click', (e) => {
                                        if (e.target === authModal) {
                                            closeAuthModal();
                                        }
                                    });
                                }

                                // Update UI based on login status
                                function updateUIAfterLogin() {
                                    if (userLoggedIn && currentUser) {
                                        // Update avatar placeholder with first letter of name
                                        if (avatarPlaceholder) {
                                            avatarPlaceholder.textContent = currentUser.name.charAt(0).toUpperCase();
                                        }

                                        // Show user avatar, hide auth buttons
                                        if (userAvatar) userAvatar.style.display = 'block';
                                        if (authButtons) authButtons.style.display = 'none';

                                        // Update mobile menu
                                        if (userAvatarMobile) userAvatarMobile.style.display = 'block';
                                        if (authButtonsMobile) authButtonsMobile.style.display = 'none';
                                        const mobileUserNameEl = document.getElementById('mobileUserName');
                                        if (mobileUserNameEl) mobileUserNameEl.textContent = currentUser.name;
                                    } else {
                                        // Hide user avatar, show auth buttons
                                        if (userAvatar) userAvatar.style.display = 'none';
                                        if (authButtons) authButtons.style.display = 'flex';
                                        if (userAvatarMobile) userAvatarMobile.style.display = 'none';
                                        if (authButtonsMobile) authButtonsMobile.style.display = 'block';
                                    }
                                }

                                // Call UI update on page load
                                updateUIAfterLogin();

                                // Clear error messages when user starts typing
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

            // Auto-open modal if there's an error from servlet
            <% if (openModal != null) { %>
                                    setTimeout(function () {
                <% if (openModal.equals("login")) { %>
                                            openAuthModal('login');
                <% } else if (openModal.equals("register")) { %>
                                            openAuthModal('register');
                <% } %>
            }, 100);
            <% } %>
        });
                        </script>
                    </body>

                    </html>