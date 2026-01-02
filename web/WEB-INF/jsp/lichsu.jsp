<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử Thuê Xe - RentCar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../../static/css/pages/lichsu.css">
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
                <div class="avatar-placeholder" id="avatarPlaceholder">U</div>
                <div class="user-dropdown">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/trangcanhan.jsp"><i class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="${pageContext.request.contextPath}/lichsu.jsp" class="active"><i class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                        <li><a href="${pageContext.request.contextPath}/yeuthich.jsp"><i class="fas fa-heart"></i> Xe yêu thích</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <ul>
            <li><a href="index.html">Trang chủ</a></li>
            <li><a href="profile.html">Tài khoản</a></li>
            <li>Lịch sử thuê xe</li>
        </ul>
    </div>

    <!-- Page Header -->
    <section class="page-header">
        <h1>Lịch sử Thuê Xe</h1>
        <p>Theo dõi và quản lý tất cả các lần thuê xe của bạn tại một nơi</p>
    </section>

    <!-- History Container -->
    <section class="history-container">
        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-options">
                <div class="filter-group">
                    <label for="time-filter">Thời gian</label>
                    <select id="time-filter">
                        <option value="all">Tất cả thời gian</option>
                        <option value="month">Tháng này</option>
                        <option value="3months">3 tháng gần đây</option>
                        <option value="year">Năm nay</option>
                        <option value="custom">Tùy chọn</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="vehicle-filter">Loại xe</label>
                    <select id="vehicle-filter">
                        <option value="all">Tất cả loại xe</option>
                        <option value="motorcycle">Xe máy</option>
                        <option value="electric">Xe điện</option>
                        <option value="car">Ô tô</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status-filter">Trạng thái</label>
                    <select id="status-filter">
                        <option value="all">Tất cả trạng thái</option>
                        <option value="upcoming">Sắp tới</option>
                        <option value="active">Đang thuê</option>
                        <option value="completed">Đã hoàn thành</option>
                        <option value="cancelled">Đã hủy</option>
                    </select>
                </div>
                <div class="filter-actions">
                    <button class="btn btn-outline">Đặt lại</button>
                    <button class="btn btn-primary">Áp dụng</button>
                </div>
            </div>
        </div>

        <!-- History Tabs -->
        <div class="history-tabs">
            <button class="history-tab active" onclick="showTab('all')">
                Tất cả
                <span class="badge">8</span>
            </button>
            <button class="history-tab" onclick="showTab('upcoming')">
                Sắp tới
                <span class="badge">2</span>
            </button>
            <button class="history-tab" onclick="showTab('active')">
                Đang thuê
                <span class="badge">1</span>
            </button>
            <button class="history-tab" onclick="showTab('completed')">
                Đã hoàn thành
                <span class="badge">4</span>
            </button>
            <button class="history-tab" onclick="showTab('cancelled')">
                Đã hủy
                <span class="badge">1</span>
            </button>
        </div>

        <!-- History Content -->
        <div class="history-content active" id="tab-all">
            <div class="booking-cards">
                <!-- Upcoming Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda SH">
                            </div>
                            <div class="booking-details">
                                <h3>Honda SH 150i</h3>
                                <p>Mã đặt xe: RC20230015</p>
                            </div>
                        </div>
                        <div class="booking-status status-upcoming">Sắp tới</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">15/12/2023 08:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">18/12/2023 18:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Trụ sở chính</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">990.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('honda-sh', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="cancelBooking('RC20230015')">Hủy đặt xe</button>
                        <button class="btn btn-primary" onclick="modifyBooking('RC20230015')">Chỉnh sửa</button>
                    </div>
                </div>

                <!-- Active Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                            </div>
                            <div class="booking-details">
                                <h3>Honda Vision</h3>
                                <p>Mã đặt xe: RC20230014</p>
                            </div>
                        </div>
                        <div class="booking-status status-active">Đang thuê</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">10/12/2023 09:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">14/12/2023 17:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Chi nhánh 1</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">600.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('honda-vision', this)">Xem chi tiết xe</button>
                        <button class="btn btn-primary" onclick="extendBooking('RC20230014')">Gia hạn</button>
                        <button class="btn btn-primary" onclick="contactSupport()">Liên hệ hỗ trợ</button>
                    </div>
                </div>

                <!-- Completed Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                            </div>
                            <div class="booking-details">
                                <h3>Yamaha Exciter 150</h3>
                                <p>Mã đặt xe: RC20230012</p>
                            </div>
                        </div>
                        <div class="booking-status status-completed">Đã hoàn thành</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">25/11/2023 10:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">28/11/2023 16:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Trụ sở chính</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">720.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('yamaha-exciter', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="downloadInvoice('RC20230012')">Tải hóa đơn</button>
                        <button class="btn btn-primary" onclick="rateBooking('RC20230012')">Đánh giá</button>
                    </div>
                </div>

                <!-- Another Completed Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Vinfast Klara">
                            </div>
                            <div class="booking-details">
                                <h3>Vinfast Klara S</h3>
                                <p>Mã đặt xe: RC20230010</p>
                            </div>
                        </div>
                        <div class="booking-status status-completed">Đã hoàn thành</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">15/11/2023 08:30</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">17/11/2023 18:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Chi nhánh 2</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">480.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('vinfast-klara', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="downloadInvoice('RC20230010')">Tải hóa đơn</button>
                        <button class="btn btn-primary" onclick="rebookVehicle('RC20230010')">Thuê lại</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upcoming Tab -->
        <div class="history-content" id="tab-upcoming">
            <div class="booking-cards">
                <!-- Upcoming Booking 1 -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda SH">
                            </div>
                            <div class="booking-details">
                                <h3>Honda SH 150i</h3>
                                <p>Mã đặt xe: RC20230015</p>
                            </div>
                        </div>
                        <div class="booking-status status-upcoming">Sắp tới</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">15/12/2023 08:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">18/12/2023 18:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Trụ sở chính</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">990.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('honda-sh', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="cancelBooking('RC20230015')">Hủy đặt xe</button>
                        <button class="btn btn-primary" onclick="modifyBooking('RC20230015')">Chỉnh sửa</button>
                    </div>
                </div>

                <!-- Upcoming Booking 2 -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Piaggio Liberty">
                            </div>
                            <div class="booking-details">
                                <h3>Piaggio Liberty</h3>
                                <p>Mã đặt xe: RC20230016</p>
                            </div>
                        </div>
                        <div class="booking-status status-upcoming">Sắp tới</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">20/12/2023 09:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">22/12/2023 17:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Chi nhánh 1</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">600.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('piaggio-liberty', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="cancelBooking('RC20230016')">Hủy đặt xe</button>
                        <button class="btn btn-primary" onclick="modifyBooking('RC20230016')">Chỉnh sửa</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Active Tab -->
        <div class="history-content" id="tab-active">
            <div class="booking-cards">
                <!-- Active Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                            </div>
                            <div class="booking-details">
                                <h3>Honda Vision</h3>
                                <p>Mã đặt xe: RC20230014</p>
                            </div>
                        </div>
                        <div class="booking-status status-active">Đang thuê</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">10/12/2023 09:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">14/12/2023 17:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Chi nhánh 1</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">600.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('honda-vision', this)">Xem chi tiết xe</button>
                        <button class="btn btn-primary" onclick="extendBooking('RC20230014')">Gia hạn</button>
                        <button class="btn btn-primary" onclick="contactSupport()">Liên hệ hỗ trợ</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Completed Tab -->
        <div class="history-content" id="tab-completed">
            <div class="booking-cards">
                <!-- Completed Booking 1 -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                            </div>
                            <div class="booking-details">
                                <h3>Yamaha Exciter 150</h3>
                                <p>Mã đặt xe: RC20230012</p>
                            </div>
                        </div>
                        <div class="booking-status status-completed">Đã hoàn thành</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">25/11/2023 10:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">28/11/2023 16:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Trụ sở chính</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">720.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('yamaha-exciter', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="downloadInvoice('RC20230012')">Tải hóa đơn</button>
                        <button class="btn btn-primary" onclick="rateBooking('RC20230012')">Đánh giá</button>
                    </div>
                </div>

                <!-- Completed Booking 2 -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Vinfast Klara">
                            </div>
                            <div class="booking-details">
                                <h3>Vinfast Klara S</h3>
                                <p>Mã đặt xe: RC20230010</p>
                            </div>
                        </div>
                        <div class="booking-status status-completed">Đã hoàn thành</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">15/11/2023 08:30</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">17/11/2023 18:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Chi nhánh 2</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">480.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('vinfast-klara', this)">Xem chi tiết xe</button>
                        <button class="btn btn-outline" onclick="downloadInvoice('RC20230010')">Tải hóa đơn</button>
                        <button class="btn btn-primary" onclick="rebookVehicle('RC20230010')">Thuê lại</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cancelled Tab -->
        <div class="history-content" id="tab-cancelled">
            <div class="booking-cards">
                <!-- Cancelled Booking -->
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <div class="booking-image">
                                <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda Wave">
                            </div>
                            <div class="booking-details">
                                <h3>Honda Wave RSX</h3>
                                <p>Mã đặt xe: RC20230008</p>
                            </div>
                        </div>
                        <div class="booking-status status-cancelled">Đã hủy</div>
                    </div>
                    <div class="booking-body">
                        <div class="booking-detail">
                            <span class="detail-label">Ngày nhận</span>
                            <span class="detail-value">05/11/2023 09:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Ngày trả</span>
                            <span class="detail-value">08/11/2023 17:00</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Địa điểm nhận</span>
                            <span class="detail-value">Trụ sở chính</span>
                        </div>
                        <div class="booking-detail">
                            <span class="detail-label">Tổng tiền</span>
                            <span class="detail-value">390.000đ</span>
                        </div>
                    </div>
                    <div class="booking-actions">
                        <button class="btn btn-outline" onclick="openVehicleModal('honda-wave', this)">Xem chi tiết xe</button>
                        <button class="btn btn-primary" onclick="rebookVehicle('RC20230008')">Đặt lại</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Vehicle Detail Modal (Tương tự trang index.html) -->
    <div class="vehicle-modal" id="vehicleModal">
        <div class="vehicle-modal-content">
            <button class="close-vehicle-modal" id="closeVehicleModal">&times;</button>
            <div class="vehicle-modal-header">
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
            <div class="vehicle-modal-body">
                <div class="vehicle-gallery">
                    <div class="vehicle-main-image">
                        <img id="vehicleMainImage" src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Xe chính">
                    </div>
                    <div class="thumbnail-container">
                        <img class="vehicle-thumbnail" src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Hình 1" onclick="changeMainImage(this.src)">
                        <img class="vehicle-thumbnail" src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Hình 2" onclick="changeMainImage(this.src)">
                        <img class="vehicle-thumbnail" src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Hình 3" onclick="changeMainImage(this.src)">
                        <video class="vehicle-thumbnail" onclick="playVideo(this)" poster="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80">
                            <source src="https://assets.mixkit.co/videos/preview/mixkit-white-sedan-on-a-road-34546-large.mp4" type="video/mp4">
                        </video>
                    </div>
                </div>

                <div class="vehicle-details-modal">
                    <div class="vehicle-detail-section">
                        <h3>Thông số kỹ thuật</h3>
                        <div class="vehicle-specs-grid">
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Loại xe:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecType">Xe máy</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Nhiên liệu:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecFuel">Xăng</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Số chỗ:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecSeats">2 người</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Hộp số:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecGear">Tự động</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Động cơ:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecEngine">110cc</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Màu sắc:</span>
                                <span class="vehicle-spec-value" id="vehicleSpecColor">Đen, Trắng, Xanh</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="vehicle-detail-section">
                        <h3>Tiện nghi & An toàn</h3>
                        <div class="vehicle-specs-grid">
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Điều hòa:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Camera lùi:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Cảm biến va chạm:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Bluetooth:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">GPS:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                            <div class="vehicle-spec-item">
                                <span class="vehicle-spec-label">Camera hành trình:</span>
                                <span class="vehicle-spec-value">✓ Có</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="vehicle-pricing-section">
                    <h3>Bảng giá & Điều khoản</h3>
                    <div class="vehicle-price-breakdown">
                        <div class="vehicle-price-item">
                            <span>Giá thuê cơ bản (1 ngày):</span>
                            <span id="vehicleBasePrice">150.000đ</span>
                        </div>
                        <div class="vehicle-price-item">
                            <span>Phí bảo hiểm:</span>
                            <span id="vehicleInsuranceFee">30.000đ</span>
                        </div>
                        <div class="vehicle-price-item">
                            <span>Phí dịch vụ:</span>
                            <span id="vehicleServiceFee">20.000đ</span>
                        </div>
                        <div class="vehicle-price-total">
                            Tổng cộng: <span id="vehicleTotalPrice">200.000đ</span> / ngày
                        </div>
                    </div>
                    
                    <div class="vehicle-modal-actions">
                        <button class="btn btn-outline">Thêm vào yêu thích</button>
                        <button class="btn btn-primary">Thuê lại</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Rating Modal -->
    <div class="modal" id="ratingModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Đánh giá dịch vụ</h2>
                <button class="close-modal" onclick="closeModal('ratingModal')">&times;</button>
            </div>
            <div class="modal-body">
                <div class="rating-section">
                    <p class="rating-text">Bạn hài lòng như thế nào với dịch vụ thuê xe?</p>
                    <div class="rating-stars-input">
                        <i class="fas fa-star rating-star-input" data-rating="1"></i>
                        <i class="fas fa-star rating-star-input" data-rating="2"></i>
                        <i class="fas fa-star rating-star-input" data-rating="3"></i>
                        <i class="fas fa-star rating-star-input" data-rating="4"></i>
                        <i class="fas fa-star rating-star-input" data-rating="5"></i>
                    </div>
                    <div class="form-group">
                        <label for="reviewComment">Nhận xét của bạn (tùy chọn)</label>
                        <textarea id="reviewComment" rows="4" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline" onclick="closeModal('ratingModal')">Hủy</button>
                <button class="btn btn-primary" onclick="submitRating()">Gửi đánh giá</button>
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
        // Show/hide tabs
        function showTab(tabName) {
            // Hide all tabs
            const tabs = document.querySelectorAll('.history-content');
            tabs.forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Show selected tab
            document.getElementById('tab-' + tabName).classList.add('active');
            
            // Update active tab button
            const tabButtons = document.querySelectorAll('.history-tab');
            tabButtons.forEach(button => {
                button.classList.remove('active');
            });
            
            event.target.classList.add('active');
        }
        
        // Vehicle Modal Functions
        const vehicleModal = document.getElementById('vehicleModal');
        const closeVehicleModal = document.getElementById('closeVehicleModal');
        
        function openVehicleModal(vehicleId, element) {
            // Hiển thị loading trong modal
            vehicleModal.classList.add('active');
            document.body.style.overflow = 'hidden';
            
            // Giả lập loading 2 giây
            setTimeout(() => {
                // Cập nhật thông tin xe dựa trên vehicleId
                updateModalContent(vehicleId);
            }, 500);
        }
        
        function updateModalContent(vehicleId) {
            const vehicleData = {
                'honda-sh': {
                    name: 'Honda SH 150i 2023',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Tự động',
                    engine: '150cc',
                    color: 'Đen, Trắng, Xám',
                    basePrice: '330.000đ',
                    insuranceFee: '60.000đ',
                    serviceFee: '50.000đ',
                    totalPrice: '440.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
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
                'piaggio-liberty': {
                    name: 'Piaggio Liberty',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Tự động',
                    engine: '125cc',
                    color: 'Trắng, Đỏ, Xanh',
                    basePrice: '200.000đ',
                    insuranceFee: '40.000đ',
                    serviceFee: '30.000đ',
                    totalPrice: '270.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
                'honda-wave': {
                    name: 'Honda Wave RSX',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Số sàn',
                    engine: '110cc',
                    color: 'Đỏ, Xanh, Bạc',
                    basePrice: '130.000đ',
                    insuranceFee: '25.000đ',
                    serviceFee: '20.000đ',
                    totalPrice: '175.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                }
            };
            
            const data = vehicleData[vehicleId];
            if (data) {
                document.getElementById('modalVehicleName').textContent = data.name;
                document.getElementById('vehicleSpecType').textContent = data.type;
                document.getElementById('vehicleSpecFuel').textContent = data.fuel;
                document.getElementById('vehicleSpecSeats').textContent = data.seats;
                document.getElementById('vehicleSpecGear').textContent = data.gear;
                document.getElementById('vehicleSpecEngine').textContent = data.engine;
                document.getElementById('vehicleSpecColor').textContent = data.color;
                document.getElementById('vehicleBasePrice').textContent = data.basePrice;
                document.getElementById('vehicleInsuranceFee').textContent = data.insuranceFee;
                document.getElementById('vehicleServiceFee').textContent = data.serviceFee;
                document.getElementById('vehicleTotalPrice').textContent = data.totalPrice;
                document.getElementById('vehicleMainImage').src = data.mainImage;
            }
        }
        
        function changeMainImage(src) {
            document.getElementById('vehicleMainImage').src = src;
        }
        
        function playVideo(video) {
            const mainImage = document.getElementById('vehicleMainImage');
            const videoContainer = document.createElement('div');
            videoContainer.className = 'vehicle-main-image';
            videoContainer.innerHTML = `
                <video controls autoplay style="width: 100%; height: 250px; object-fit: cover; border-radius: 8px;">
                    <source src="${video.querySelector('source').src}" type="video/mp4">
                </video>
            `;
            mainImage.parentNode.replaceChild(videoContainer, mainImage);
        }
        
        closeVehicleModal.addEventListener('click', () => {
            vehicleModal.classList.remove('active');
            document.body.style.overflow = 'auto';
        });
        
        window.addEventListener('click', (e) => {
            if (e.target === vehicleModal) {
                vehicleModal.classList.remove('active');
                document.body.style.overflow = 'auto';
            }
        });

        // Modal functions
        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }
        
        // Rating functionality
        let currentRating = 0;
        
        document.querySelectorAll('.rating-star-input').forEach(star => {
            star.addEventListener('click', function() {
                const rating = parseInt(this.getAttribute('data-rating'));
                currentRating = rating;
                
                // Update stars
                document.querySelectorAll('.rating-star-input').forEach(s => {
                    const sRating = parseInt(s.getAttribute('data-rating'));
                    if (sRating <= rating) {
                        s.classList.add('active');
                    } else {
                        s.classList.remove('active');
                    }
                });
            });
            
            star.addEventListener('mouseover', function() {
                const rating = parseInt(this.getAttribute('data-rating'));
                
                document.querySelectorAll('.rating-star-input').forEach(s => {
                    const sRating = parseInt(s.getAttribute('data-rating'));
                    if (sRating <= rating) {
                        s.style.color = 'var(--warning)';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
            
            star.addEventListener('mouseout', function() {
                document.querySelectorAll('.rating-star-input').forEach(s => {
                    const sRating = parseInt(s.getAttribute('data-rating'));
                    if (sRating <= currentRating) {
                        s.style.color = 'var(--warning)';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
        });
        
        // Action functions
        function viewDetails(bookingId) {
            alert('Xem chi tiết đơn thuê: ' + bookingId);
            // In a real app, this would navigate to a detailed view
        }
        
        function cancelBooking(bookingId) {
            if (confirm('Bạn có chắc chắn muốn hủy đơn thuê ' + bookingId + '?')) {
                alert('Đã hủy đơn thuê: ' + bookingId);
                // In a real app, this would make an API call
            }
        }
        
        function modifyBooking(bookingId) {
            alert('Chỉnh sửa đơn thuê: ' + bookingId);
            // In a real app, this would navigate to the booking modification page
        }
        
        function extendBooking(bookingId) {
            alert('Gia hạn đơn thuê: ' + bookingId);
            // In a real app, this would open an extension modal
        }
        
        function contactSupport() {
            alert('Liên hệ hỗ trợ');
            // In a real app, this would open a contact form or chat
        }
        
        function downloadInvoice(bookingId) {
            alert('Tải hóa đơn: ' + bookingId);
            // In a real app, this would download the invoice PDF
        }
        
        function rateBooking(bookingId) {
            openModal('ratingModal');
            // In a real app, this would set the booking ID for the rating
        }
        
        function rebookVehicle(bookingId) {
            alert('Thuê lại xe từ đơn: ' + bookingId);
            // In a real app, this would navigate to the booking page with pre-filled data
        }
        
        function submitRating() {
            if (currentRating === 0) {
                alert('Vui lòng chọn số sao đánh giá');
                return;
            }
            
            const comment = document.getElementById('reviewComment').value;
            alert('Cảm ơn bạn đã đánh giá! Đánh giá: ' + currentRating + ' sao\nNhận xét: ' + comment);
            
            closeModal('ratingModal');
            // In a real app, this would submit the rating to the server
        }
        
        // Initialize user state (for demo purposes)
        document.addEventListener('DOMContentLoaded', () => {
            // Check if user is logged in (for demo, we'll assume they are)
            const isLoggedIn = true;
            
            if (isLoggedIn) {
                document.getElementById('authButtons').style.display = 'none';
                document.getElementById('userAvatar').style.display = 'block';
            }
        });
    </script>
</body>
</html>