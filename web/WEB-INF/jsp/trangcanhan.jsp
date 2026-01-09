<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Cá Nhân - RentCar</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/trangcanhan.css">
</head>

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
                </ul>
            </nav>
            <div class="auth-buttons" id="authButtons">
                <button class="btn btn-outline" id="loginBtn">Đăng nhập</button>
                <button class="btn btn-primary" id="registerBtn">Đăng ký</button>
            </div>

            <!-- User Avatar (hidden by default) -->
            <div class="user-avatar" id="userAvatar" style="display: none;">
                <div class="avatar-placeholder" id="avatarPlaceholder">N</div>
                <div class="user-dropdown">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/trangcanhan.jsp" class="active"><i
                                    class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="${pageContext.request.contextPath}/lichsu.jsp"><i class="fas fa-history"></i> Lịch
                                sử thuê xe</a></li>
                        <li><a href="${pageContext.request.contextPath}/yeuthich.jsp"><i class="fas fa-heart"></i> Xe
                                yêu thích</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng
                                xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <ul>
            <li><a href="index.html">Trang chủ</a></li>
            <li>Thông tin tài khoản</li>
        </ul>
    </div>

    <!-- Profile Container -->
    <div class="profile-container">
        <!-- Profile Sidebar -->
        <div class="profile-sidebar">
            <div class="profile-header">
                <div class="profile-avatar">
                    <div class="avatar-placeholder-large">N</div>
                </div>
                <h2>Nguyễn Văn A</h2>
                <p>Thành viên từ 15/08/2023</p>
            </div>
            <div class="profile-menu">
                <ul>
                    <li><a href="#" class="active" onclick="showSection('overview')">
                            <i class="fas fa-user-circle"></i>
                            Tổng quan
                        </a></li>
                    <li><a href="#" onclick="showSection('personal')">
                            <i class="fas fa-user-edit"></i>
                            Thông tin cá nhân
                        </a></li>
                    <li><a href="#" onclick="showSection('security')">
                            <i class="fas fa-shield-alt"></i>
                            Bảo mật
                        </a></li>
                    <li><a href="#" onclick="showSection('verification')">
                            <i class="fas fa-id-card"></i>
                            Xác minh danh tính
                        </a></li>
                    <li><a href="#" onclick="showSection('notifications')">
                            <i class="fas fa-bell"></i>
                            Thông báo
                        </a></li>
                    <li><a href="#" onclick="showSection('preferences')">
                            <i class="fas fa-cog"></i>
                            Tùy chọn
                        </a></li>
                </ul>
            </div>
        </div>

        <!-- Profile Content -->
        <div class="profile-content">
            <!-- Overview Section -->
            <div class="content-section active" id="overview">
                <div class="section-header">
                    <h2>Tổng quan tài khoản</h2>
                    <button class="btn btn-primary" onclick="showSection('personal')">
                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                    </button>
                </div>

                <!-- Statistics -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <i class="fas fa-car"></i>
                        <h3>12</h3>
                        <p>Lần thuê xe</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-heart"></i>
                        <h3>8</h3>
                        <p>Xe yêu thích</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-star"></i>
                        <h3>4.8</h3>
                        <p>Đánh giá trung bình</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-award"></i>
                        <h3>Vàng</h3>
                        <p>Cấp độ thành viên</p>
                    </div>
                </div>

                <!-- Profile Information -->
                <div class="profile-info-grid">
                    <div class="info-card">
                        <i class="fas fa-user"></i>
                        <h3>Thông tin cơ bản</h3>
                        <p>Đã cập nhật đầy đủ</p>
                    </div>
                    <div class="info-card">
                        <i class="fas fa-shield-alt"></i>
                        <h3>Bảo mật</h3>
                        <p>Mật khẩu mạnh</p>
                    </div>
                    <div class="info-card">
                        <i class="fas fa-id-card"></i>
                        <h3>Xác minh</h3>
                        <p>Đã xác minh số điện thoại</p>
                    </div>
                    <div class="info-card">
                        <i class="fas fa-bell"></i>
                        <h3>Thông báo</h3>
                        <p>Đang bật tất cả</p>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="section-header">
                    <h2>Hoạt động gần đây</h2>
                </div>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Đã thuê Honda Vision</h4>
                            <p>Mã đơn: RC20230014 • 10/12/2023 - 14/12/2023</p>
                        </div>
                        <div class="activity-time">2 ngày trước</div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Đã thêm vào yêu thích</h4>
                            <p>Honda SH 150i đã được thêm vào danh sách yêu thích</p>
                        </div>
                        <div class="activity-time">5 ngày trước</div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Đã đánh giá dịch vụ</h4>
                            <p>Đánh giá 5 sao cho Yamaha Exciter 150</p>
                        </div>
                        <div class="activity-time">1 tuần trước</div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Đã cập nhật hồ sơ</h4>
                            <p>Thông tin cá nhân đã được cập nhật</p>
                        </div>
                        <div class="activity-time">2 tuần trước</div>
                    </div>
                </div>
            </div>

            <!-- Personal Information Section -->
            <div class="content-section" id="personal">
                <div class="section-header">
                    <h2>Thông tin cá nhân</h2>
                </div>

                <div class="form-section">
                    <h3>Thông tin cơ bản</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Họ và tên *</label>
                            <input type="text" id="fullName" value="Nguyễn Văn A" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại *</label>
                            <input type="tel" id="phone" value="0912345678" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" value="nguyenvana@email.com" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="birthday">Ngày sinh</label>
                            <input type="date" id="birthday" value="1990-05-15">
                        </div>
                        <div class="form-group">
                            <label for="gender">Giới tính</label>
                            <select id="gender">
                                <option value="male" selected>Nam</option>
                                <option value="female">Nữ</option>
                                <option value="other">Khác</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>Địa chỉ</h3>
                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" value="123 Đường ABC, Quận 1, TP.HCM">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">Thành phố</label>
                            <input type="text" id="city" value="TP. Hồ Chí Minh">
                        </div>
                        <div class="form-group">
                            <label for="district">Quận/Huyện</label>
                            <input type="text" id="district" value="Quận 1">
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-outline" onclick="showSection('overview')">Hủy</button>
                    <button class="btn btn-primary" onclick="savePersonalInfo()">Lưu thay đổi</button>
                </div>
            </div>

            <!-- Security Section -->
            <div class="content-section" id="security">
                <div class="section-header">
                    <h2>Bảo mật tài khoản</h2>
                </div>

                <div class="security-item">
                    <div class="security-info">
                        <h4>Mật khẩu</h4>
                        <p>Cập nhật mật khẩu định kỳ để bảo vệ tài khoản</p>
                    </div>
                    <button class="btn btn-outline" onclick="changePassword()">Đổi mật khẩu</button>
                </div>

                <div class="security-item">
                    <div class="security-info">
                        <h4>Xác thực 2 yếu tố</h4>
                        <p>Thêm lớp bảo mật bổ sung cho tài khoản của bạn</p>
                    </div>
                    <button class="btn btn-outline">Bật 2FA</button>
                </div>

                <div class="security-item">
                    <div class="security-info">
                        <h4>Thiết bị đã đăng nhập</h4>
                        <p>Quản lý các thiết bị đã đăng nhập vào tài khoản</p>
                    </div>
                    <button class="btn btn-outline">Xem thiết bị</button>
                </div>

                <div class="security-item">
                    <div class="security-info">
                        <h4>Hoạt động đăng nhập</h4>
                        <p>Xem lịch sử đăng nhập và phát hiện hoạt động bất thường</p>
                    </div>
                    <button class="btn btn-outline">Xem lịch sử</button>
                </div>
            </div>

            <!-- Verification Section -->
            <div class="content-section" id="verification">
                <div class="section-header">
                    <h2>Xác minh danh tính</h2>
                </div>

                <div class="verification-status">
                    <div class="status-item">
                        <div class="status-info">
                            <div class="status-icon verified">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="status-details">
                                <h4>Số điện thoại</h4>
                                <p>Đã xác minh - 0912345678</p>
                            </div>
                        </div>
                        <button class="btn btn-outline">Thay đổi</button>
                    </div>

                    <div class="status-item">
                        <div class="status-info">
                            <div class="status-icon verified">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="status-details">
                                <h4>Email</h4>
                                <p>Đã xác minh - nguyenvana@email.com</p>
                            </div>
                        </div>
                        <button class="btn btn-outline">Thay đổi</button>
                    </div>

                    <div class="status-item">
                        <div class="status-info">
                            <div class="status-icon pending">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="status-details">
                                <h4>CMND/CCCD</h4>
                                <p>Đang chờ xác minh - Gửi ngày 10/12/2023</p>
                            </div>
                        </div>
                        <button class="btn btn-outline">Tải lên lại</button>
                    </div>

                    <div class="status-item">
                        <div class="status-info">
                            <div class="status-icon unverified">
                                <i class="fas fa-times"></i>
                            </div>
                            <div class="status-details">
                                <h4>Bằng lái xe</h4>
                                <p>Chưa xác minh - Cần thiết để thuê xe</p>
                            </div>
                        </div>
                        <button class="btn btn-primary">Tải lên</button>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-primary" onclick="uploadDocuments()">Tải lên tài liệu</button>
                </div>
            </div>

            <!-- Notifications Section -->
            <div class="content-section" id="notifications">
                <div class="section-header">
                    <h2>Cài đặt thông báo</h2>
                </div>

                <div class="notification-category">
                    <h4>Thông báo thuê xe</h4>
                    <div class="notification-item">
                        <div class="notification-info">
                            <h5>Xác nhận đặt xe</h5>
                            <p>Thông báo khi đặt xe thành công</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                    <div class="notification-item">
                        <div class="notification-info">
                            <h5>Nhắc nhở trả xe</h5>
                            <p>Thông báo trước khi đến hạn trả xe</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                    <div class="notification-item">
                        <div class="notification-info">
                            <h5>Khuyến mãi đặc biệt</h5>
                            <p>Nhận thông báo về các ưu đãi đặc biệt</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox">
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                </div>

                <div class="notification-category">
                    <h4>Thông báo hệ thống</h4>
                    <div class="notification-item">
                        <div class="notification-info">
                            <h5>Cập nhật ứng dụng</h5>
                            <p>Thông báo khi có phiên bản mới</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                    <div class="notification-item">
                        <div class="notification-info">
                            <h5>Bảo trì hệ thống</h5>
                            <p>Thông báo lịch bảo trì hệ thống</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox">
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-primary" onclick="saveNotificationSettings()">Lưu cài đặt</button>
                </div>
            </div>

            <!-- Preferences Section -->
            <div class="content-section" id="preferences">
                <div class="section-header">
                    <h2>Tùy chọn cá nhân</h2>
                </div>

                <div class="form-section">
                    <h3>Ngôn ngữ & Vùng</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="language">Ngôn ngữ</label>
                            <select id="language">
                                <option value="vi" selected>Tiếng Việt</option>
                                <option value="en">English</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="timezone">Múi giờ</label>
                            <select id="timezone">
                                <option value="+7" selected>GMT+7 (Việt Nam)</option>
                                <option value="+8">GMT+8</option>
                                <option value="+9">GMT+9</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>Tùy chọn hiển thị</h3>
                    <div class="form-group">
                        <label for="theme">Chủ đề</label>
                        <select id="theme">
                            <option value="light" selected>Sáng</option>
                            <option value="dark">Tối</option>
                            <option value="auto">Tự động</option>
                        </select>
                    </div>
                </div>

                <div class="form-section">
                    <h3>Xóa tài khoản</h3>
                    <div class="form-group">
                        <p style="color: #666; margin-bottom: 1rem;">
                            Khi xóa tài khoản, tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể khôi phục.
                            Hãy chắc chắn trước khi thực hiện thao tác này.
                        </p>
                        <button class="btn btn-danger" onclick="deleteAccount()">Xóa tài khoản</button>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-primary" onclick="savePreferences()">Lưu tùy chọn</button>
                </div>
            </div>
        </div>
    </div>

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
        // Initialize user state (for demo purposes)
        document.addEventListener('DOMContentLoaded', () => {
            // Check if user is logged in (for demo, we'll assume they are)
            const isLoggedIn = true;

            if (isLoggedIn) {
                document.getElementById('authButtons').style.display = 'none';
                document.getElementById('userAvatar').style.display = 'block';
            }
        });

        // Show/hide sections
        function showSection(sectionId) {
            // Hide all sections
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(section => {
                section.classList.remove('active');
            });

            // Show selected section
            document.getElementById(sectionId).classList.add('active');

            // Update active menu item
            const menuItems = document.querySelectorAll('.profile-menu a');
            menuItems.forEach(item => {
                item.classList.remove('active');
            });

            event.target.classList.add('active');
        }

        // Save personal information
        function savePersonalInfo() {
            // In a real app, this would make an API call to save the data
            alert('Thông tin cá nhân đã được cập nhật thành công!');
            showSection('overview');
        }

        // Change password
        function changePassword() {
            const newPassword = prompt('Nhập mật khẩu mới:');
            if (newPassword && newPassword.length >= 6) {
                alert('Mật khẩu đã được thay đổi thành công!');
            } else if (newPassword) {
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
            }
        }

        // Upload documents
        function uploadDocuments() {
            alert('Chức năng tải lên tài liệu sẽ được mở trong cửa sổ mới.');
            // In a real app, this would open a file upload interface
        }

        // Save notification settings
        function saveNotificationSettings() {
            alert('Cài đặt thông báo đã được lưu thành công!');
        }

        // Save preferences
        function savePreferences() {
            alert('Tùy chọn cá nhân đã được lưu thành công!');
        }

        // Delete account
        function deleteAccount() {
            const confirmDelete = confirm('Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác!');
            if (confirmDelete) {
                alert('Tài khoản đã được đánh dấu để xóa. Chúng tôi sẽ xử lý yêu cầu của bạn trong vòng 24 giờ.');
                // In a real app, this would make an API call to delete the account
            }
        }

        // Show notification
        function showNotification(message, type = 'info') {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.innerHTML = `
                <div class="notification-content">
                    <i class="fas fa-${type == 'success' ? 'check-circle' : 'info-circle'}"></i>
                    <span>${message}</span>
                </div>
                <button class="notification-close" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            `;

            // Add styles for notification
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
                border-left: 4px solid ${type == 'success' ? 'var(--success)' : 'var(--secondary)'};
                max-width: 350px;
            `;

            document.body.appendChild(notification);

            // Auto remove after 5 seconds
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 5000);
        }

        // Add CSS for animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            
            .notification-close {
                background: none;
                border: none;
                cursor: pointer;
                color: #666;
            }
        `;
        document.head.appendChild(style);
    </script>
</body>

</html>