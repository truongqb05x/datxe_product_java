<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RentCar Admin - Quản lý đơn đặt xe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/dondatxe.css">
    <style>
        /* Additional styles for JSP specific elements */
        .hidden {
            display: none;
        }
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-car"></i>
            <h2>RentCar Admin</h2>
        </div>
        
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/vehicles" class="nav-link">
                    <i class="fas fa-car"></i>
                    <span>Quản lý xe</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link active">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Đơn đặt xe</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Người dùng</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    <span>Báo cáo</span>
                </a>
            </li>
        </ul>
        
        <div class="sidebar-footer">
            <div class="user-info">
                <div class="user-avatar">
                    <c:choose>
                        <c:when test="${not empty sessionScope.adminUser.fullName}">
                            ${fn:substring(sessionScope.adminUser.fullName, 0, 1)}
                        </c:when>
                        <c:otherwise>A</c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <h4>
                        <c:choose>
                            <c:when test="${not empty sessionScope.adminUser.fullName}">
                                ${sessionScope.adminUser.fullName}
                            </c:when>
                            <c:otherwise>Admin User</c:otherwise>
                        </c:choose>
                    </h4>
                    <p>Quản trị viên</p>
                </div>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <header class="header">
            <div class="header-left">
                <h1><i class="fas fa-calendar-alt"></i> Quản lý đơn đặt xe</h1>
                <p>Quản lý tất cả đơn đặt xe trong hệ thống</p>
            </div>
            
            <div class="header-right">
                <button class="btn btn-primary" id="createBookingBtn">
                    <i class="fas fa-plus"></i> Tạo đơn đặt mới
                </button>
            </div>
        </header>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon icon-total">
                    <i class="fas fa-receipt"></i>
                </div>
                <div class="stat-info">
                    <h3>Tổng đơn đặt</h3>
                    <div class="stat-value" id="totalBookings">
                        <c:choose>
                            <c:when test="${not empty stats.totalBookings}">${stats.totalBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon icon-pending">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>Chờ xác nhận</h3>
                    <div class="stat-value" id="pendingBookings">
                        <c:choose>
                            <c:when test="${not empty stats.pendingBookings}">${stats.pendingBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon icon-confirmed">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>Đã xác nhận</h3>
                    <div class="stat-value" id="confirmedBookings">
                        <c:choose>
                            <c:when test="${not empty stats.confirmedBookings}">${stats.confirmedBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon icon-active">
                    <i class="fas fa-car"></i>
                </div>
                <div class="stat-info">
                    <h3>Đang hoạt động</h3>
                    <div class="stat-value" id="activeBookings">
                        <c:choose>
                            <c:when test="${not empty stats.activeBookings}">${stats.activeBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon icon-completed">
                    <i class="fas fa-flag-checkered"></i>
                </div>
                <div class="stat-info">
                    <h3>Đã hoàn thành</h3>
                    <div class="stat-value" id="completedBookings">
                        <c:choose>
                            <c:when test="${not empty stats.completedBookings}">${stats.completedBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon icon-cancelled">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>Đã hủy</h3>
                    <div class="stat-value" id="cancelledBookings">
                        <c:choose>
                            <c:when test="${not empty stats.cancelledBookings}">${stats.cancelledBookings}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Calendar View -->
        <section class="calendar-view" id="calendarView">
            <div class="calendar-header">
                <h3><i class="fas fa-calendar"></i> Lịch đặt xe <span id="calendarMonthYear">Tháng 12/2023</span></h3>
                <div class="calendar-nav">
                    <button class="btn btn-outline" id="prevMonth">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <button class="btn btn-outline" id="todayBtn">Hôm nay</button>
                    <button class="btn btn-outline" id="nextMonth">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
            
            <div class="calendar-grid" id="calendarGrid">
                <!-- Calendar will be generated dynamically -->
            </div>
        </section>

        <!-- Filters Section -->
        <section class="filters-section">
            <div class="filters-header">
                <h3><i class="fas fa-filter"></i> Bộ lọc đơn đặt</h3>
                <div class="quick-actions">
                    <button class="action-btn ${empty param.status or param.status == 'all' ? 'active' : ''}" data-status="all">
                        <i class="fas fa-list"></i> Tất cả
                    </button>
                    <button class="action-btn ${param.status == 'PENDING' ? 'active' : ''}" data-status="PENDING">
                        <i class="fas fa-clock"></i> Chờ xác nhận
                    </button>
                    <button class="action-btn ${param.status == 'CONFIRMED' ? 'active' : ''}" data-status="CONFIRMED">
                        <i class="fas fa-check-circle"></i> Đã xác nhận
                    </button>
                    <button class="action-btn ${param.status == 'ACTIVE' ? 'active' : ''}" data-status="ACTIVE">
                        <i class="fas fa-car"></i> Đang hoạt động
                    </button>
                    <button class="action-btn ${param.status == 'COMPLETED' ? 'active' : ''}" data-status="COMPLETED">
                        <i class="fas fa-flag-checkered"></i> Đã hoàn thành
                    </button>
                    <button class="action-btn ${param.status == 'CANCELLED' ? 'active' : ''}" data-status="CANCELLED">
                        <i class="fas fa-times-circle"></i> Đã hủy
                    </button>
                </div>
            </div>
            
            <div class="filter-grid">
                <div class="filter-group">
                    <label for="filterDateRange">Khoảng thời gian</label>
                    <input type="text" id="filterDateRange" placeholder="Chọn khoảng thời gian..." 
                           value="${param.startDate}${not empty param.startDate and not empty param.endDate ? ' to ' : ''}${param.endDate}">
                </div>
                
                <div class="filter-group">
                    <label for="filterCustomer">Khách hàng</label>
                    <select id="filterCustomer">
                        <option value="">Tất cả khách hàng</option>
                        <c:forEach var="customer" items="${customers}">
                            <option value="${customer.id}" ${param.customerId == customer.id ? 'selected' : ''}>
                                ${customer.fullName} (${customer.phone})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="filterVehicle">Xe</label>
                    <select id="filterVehicle">
                        <option value="">Tất cả xe</option>
                        <c:forEach var="vehicle" items="${vehicles}">
                            <option value="${vehicle.id}" ${param.vehicleId == vehicle.id ? 'selected' : ''}>
                                ${vehicle.name} - ${vehicle.licensePlate}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="filterPayment">Trạng thái thanh toán</label>
                    <select id="filterPayment">
                        <option value="">Tất cả</option>
                        <option value="PAID" ${param.paymentStatus == 'PAID' ? 'selected' : ''}>Đã thanh toán</option>
                        <option value="PARTIAL" ${param.paymentStatus == 'PARTIAL' ? 'selected' : ''}>Thanh toán một phần</option>
                        <option value="UNPAID" ${param.paymentStatus == 'UNPAID' ? 'selected' : ''}>Chưa thanh toán</option>
                        <option value="REFUNDED" ${param.paymentStatus == 'REFUNDED' ? 'selected' : ''}>Đã hoàn tiền</option>
                    </select>
                </div>
            </div>
            
            <div class="filter-actions">
                <button class="btn btn-primary" id="applyFilters">
                    <i class="fas fa-search"></i> Áp dụng bộ lọc
                </button>
                <button class="btn btn-outline" id="resetFilters">
                    <i class="fas fa-redo"></i> Đặt lại
                </button>
                <button class="btn btn-success" id="exportBookingsBtn">
                    <i class="fas fa-file-export"></i> Xuất báo cáo
                </button>
                <button class="btn btn-warning" id="sendRemindersBtn">
                    <i class="fas fa-bell"></i> Gửi nhắc nhở
                </button>
            </div>
        </section>

        <!-- Bookings Table -->
        <div class="bookings-table-container">
            <div class="table-toolbar">
                <div class="table-info">
                    Hiển thị <span id="tableCount">${bookings.size()}</span> trên tổng số <span id="tableTotal">${stats.totalBookings}</span> đơn đặt
                </div>
                <div class="table-actions">
                    <button class="btn btn-outline" id="printSelectedBtn">
                        <i class="fas fa-print"></i> In hợp đồng
                    </button>
                    <button class="btn btn-danger" id="cancelSelectedBtn">
                        <i class="fas fa-ban"></i> Hủy đã chọn
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table id="bookingsTable" class="display">
                    <thead>
                        <tr>
                            <th style="width: 50px;">
                                <input type="checkbox" class="select-checkbox" id="selectAllCheckbox">
                            </th>
                            <th style="width: 120px;">Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Xe</th>
                            <th style="width: 150px;">Thời gian thuê</th>
                            <th style="width: 120px;">Tổng tiền</th>
                            <th style="width: 120px;">Trạng thái</th>
                            <th style="width: 120px;">Thanh toán</th>
                            <th style="width: 100px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="bookingsTableBody">
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>
                                    <input type="checkbox" class="select-checkbox select-booking" data-id="${booking.id}">
                                </td>
                                <td>
                                    <div class="booking-code">${booking.bookingCode}</div>
                                    <div style="font-size: 0.8rem; color: #666;">
                                        <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </td>
                                <td class="customer-info">
                                    <div class="customer-name">${booking.customer.fullName}</div>
                                    <div class="customer-contact">${booking.customer.phone}</div>
                                    <div class="customer-contact">${booking.customer.email}</div>
                                </td>
                                <td class="vehicle-info">
                                    <div class="vehicle-name">${booking.vehicle.name}</div>
                                    <div class="vehicle-details">${booking.vehicle.licensePlate} • ${booking.vehicle.color}</div>
                                    <div class="vehicle-details">
                                        <fmt:formatNumber value="${booking.vehicle.dailyRate}" type="currency" currencyCode="VND" />
                                        /ngày
                                    </div>
                                </td>
                                <td class="date-info">
                                    <div class="date-range">
                                        <fmt:formatDate value="${booking.pickupDate}" pattern="dd/MM/yyyy" /> 
                                        → 
                                        <fmt:formatDate value="${booking.returnDate}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <div class="days-count">${booking.totalDays} ngày (${booking.totalHours} giờ)</div>
                                </td>
                                <td class="amount-info">
                                    <div class="amount-total">
                                        <fmt:formatNumber value="${booking.totalAmount}" type="currency" currencyCode="VND" />
                                    </div>
                                    <div class="amount-breakdown">
                                        Cọc: <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencyCode="VND" />
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.status == 'PENDING'}">
                                            <span class="status-badge status-pending">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                            <span class="status-badge status-confirmed">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'ACTIVE'}">
                                            <span class="status-badge status-active">Đang hoạt động</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'COMPLETED'}">
                                            <span class="status-badge status-completed">Đã hoàn thành</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'CANCELLED'}">
                                            <span class="status-badge status-cancelled">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.paymentStatus == 'PAID'}">
                                            <span class="payment-badge payment-paid">Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${booking.paymentStatus == 'PARTIAL'}">
                                            <span class="payment-badge payment-partial">Thanh toán một phần</span>
                                        </c:when>
                                        <c:when test="${booking.paymentStatus == 'UNPAID'}">
                                            <span class="payment-badge payment-unpaid">Chưa thanh toán</span>
                                        </c:when>
                                        <c:when test="${booking.paymentStatus == 'REFUNDED'}">
                                            <span class="payment-badge payment-refunded">Đã hoàn tiền</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="payment-badge payment-unpaid">${booking.paymentStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn-small view-booking" data-id="${booking.id}" title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn-small edit-booking" data-id="${booking.id}" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <c:if test="${booking.status == 'PENDING'}">
                                            <button class="action-btn-small confirm-booking" data-id="${booking.id}" title="Xác nhận đơn">
                                                <i class="fas fa-check-circle"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${booking.status != 'CANCELLED' && booking.status != 'COMPLETED'}">
                                            <button class="action-btn-small delete-booking" data-id="${booking.id}" title="Hủy đơn">
                                                <i class="fas fa-ban"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 20px;">
                                    <i class="fas fa-info-circle" style="color: #666; margin-right: 8px;"></i>
                                    Không có đơn đặt nào
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/admin/bookings?page=${currentPage-1}&status=${param.status}&customerId=${param.customerId}&vehicleId=${param.vehicleId}&paymentStatus=${param.paymentStatus}&startDate=${param.startDate}&endDate=${param.endDate}" 
                           class="page-btn">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${currentPage == i}">
                                <span class="page-btn active">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/bookings?page=${i}&status=${param.status}&customerId=${param.customerId}&vehicleId=${param.vehicleId}&paymentStatus=${param.paymentStatus}&startDate=${param.startDate}&endDate=${param.endDate}" 
                                   class="page-btn">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/bookings?page=${currentPage+1}&status=${param.status}&customerId=${param.customerId}&vehicleId=${param.vehicleId}&paymentStatus=${param.paymentStatus}&startDate=${param.startDate}&endDate=${param.endDate}" 
                           class="page-btn">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>

        <!-- Booking Detail Modal -->
        <div class="modal" id="bookingDetailModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalBookingTitle">Đơn đặt #RENT20230045</h3>
                    <button class="close-modal" id="closeDetailModal">&times;</button>
                </div>
                
                <div class="modal-body">
                    <div class="booking-detail-grid">
                        <div>
                            <div class="detail-section">
                                <h4>Thông tin đơn đặt</h4>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Mã đơn</div>
                                        <div class="info-value booking-code" id="detailBookingCode">RENT20230045</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Ngày đặt</div>
                                        <div class="info-value" id="detailBookingDate">05/12/2023 14:30</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Trạng thái</div>
                                        <div class="info-value">
                                            <span class="status-badge status-confirmed" id="detailBookingStatus">Đã xác nhận</span>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Trạng thái thanh toán</div>
                                        <div class="info-value">
                                            <span class="payment-badge payment-paid" id="detailPaymentStatus">Đã thanh toán</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="detail-section">
                                <h4>Thông tin khách hàng</h4>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Họ tên</div>
                                        <div class="info-value" id="detailCustomerName">Nguyễn Văn A</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Số điện thoại</div>
                                        <div class="info-value" id="detailCustomerPhone">0912345678</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Email</div>
                                        <div class="info-value" id="detailCustomerEmail">nguyenvana@email.com</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Số CMND/CCCD</div>
                                        <div class="info-value" id="detailCustomerId">025123456789</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Bằng lái xe</div>
                                        <div class="info-value" id="detailCustomerLicense">A1234567 - Hạng B2</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Địa chỉ</div>
                                        <div class="info-value" id="detailCustomerAddress">123 Đường ABC, Quận 1, TP.HCM</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="detail-section">
                                <h4>Thông tin xe</h4>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Xe</div>
                                        <div class="info-value" id="detailVehicleName">Toyota Vios 2023</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Biển số</div>
                                        <div class="info-value" id="detailVehiclePlate">51A-12345</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Màu sắc</div>
                                        <div class="info-value" id="detailVehicleColor">Trắng</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Loại nhiên liệu</div>
                                        <div class="info-value" id="detailVehicleFuel">Xăng</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="detail-section">
                                <h4>Thời gian & Địa điểm</h4>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Ngày nhận xe</div>
                                        <div class="info-value" id="detailPickupDate">15/12/2023 08:00</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Ngày trả xe</div>
                                        <div class="info-value" id="detailReturnDate">20/12/2023 18:00</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Tổng số ngày</div>
                                        <div class="info-value" id="detailTotalDays">5 ngày</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Điểm nhận xe</div>
                                        <div class="info-value" id="detailPickupLocation">123 Đường ABC, Quận 1, TP.HCM</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Điểm trả xe</div>
                                        <div class="info-value" id="detailReturnLocation">456 Đường XYZ, Quận 3, TP.HCM</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div>
                            <div class="detail-section">
                                <h4>Tiến trình đơn hàng</h4>
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-dot active">
                                            <i class="fas fa-calendar-plus"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Đơn đặt được tạo</div>
                                            <div class="timeline-time" id="timelineCreated">05/12/2023 14:30</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-dot active">
                                            <i class="fas fa-check-circle"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Đơn đặt đã xác nhận</div>
                                            <div class="timeline-time" id="timelineConfirmed">05/12/2023 16:15</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-dot">
                                            <i class="fas fa-money-check-alt"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Thanh toán</div>
                                            <div class="timeline-time" id="timelinePayment">Chờ thanh toán</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-dot">
                                            <i class="fas fa-car"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Nhận xe</div>
                                            <div class="timeline-time" id="timelinePickup">15/12/2023 08:00</div>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-dot">
                                            <i class="fas fa-flag-checkered"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <div class="timeline-title">Hoàn thành</div>
                                            <div class="timeline-time" id="timelineCompleted">20/12/2023 18:00</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="detail-section">
                                <h4>Chi tiết thanh toán</h4>
                                <div class="price-breakdown">
                                    <div class="price-item">
                                        <span>Giá thuê cơ bản (5 ngày):</span>
                                        <span id="priceBase">3.000.000 ₫</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Phí bảo hiểm:</span>
                                        <span id="priceInsurance">500.000 ₫</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Phí dịch vụ:</span>
                                        <span id="priceService">100.000 ₫</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Phụ phí (nếu có):</span>
                                        <span id="priceExtra">0 ₫</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Giảm giá:</span>
                                        <span id="priceDiscount">-150.000 ₫</span>
                                    </div>
                                    <div class="price-total">
                                        Tổng cộng: <span id="priceTotal">3.450.000 ₫</span>
                                    </div>
                                    <div class="price-item" style="margin-top: 1rem;">
                                        <span>Tiền cọc:</span>
                                        <span id="priceDeposit">5.000.000 ₫</span>
                                    </div>
                                    <div class="price-item">
                                        <span>Số tiền đã thanh toán:</span>
                                        <span id="pricePaid">3.450.000 ₫</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="detail-section">
                                <h4>Ghi chú & Điều khoản</h4>
                                <div id="bookingNotes" style="background: #f8f9fa; padding: 1rem; border-radius: 6px; font-size: 0.9rem; color: #666;">
                                    Khách hàng yêu cầu chuẩn bị xe sạch sẽ, đầy đủ nhiên liệu. Giao xe tại địa điểm đã thỏa thuận.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button class="btn btn-outline" id="printContractBtn">
                        <i class="fas fa-print"></i> In hợp đồng
                    </button>
                    <button class="btn btn-warning" id="editBookingBtn">
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </button>
                    <button class="btn btn-primary" id="confirmBookingBtn">
                        <i class="fas fa-check-circle"></i> Xác nhận đơn
                    </button>
                    <button class="btn btn-danger" id="cancelBookingBtn">
                        <i class="fas fa-ban"></i> Hủy đơn
                    </button>
                </div>
            </div>
        </div>

        <!-- Create/Edit Booking Modal -->
        <div class="modal" id="bookingFormModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalFormTitle">Tạo đơn đặt mới</h3>
                    <button class="close-modal" id="closeFormModal">&times;</button>
                </div>
                
                <div class="modal-body">
                    <form id="bookingForm" action="${pageContext.request.contextPath}/admin/bookings/save" method="POST">
                        <input type="hidden" id="bookingId" name="id">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                            <div>
                                <div class="detail-section">
                                    <h4>Thông tin khách hàng</h4>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label for="customerSelect">Chọn khách hàng *</label>
                                            <select id="customerSelect" name="customerId" required>
                                                <option value="">Chọn khách hàng</option>
                                                <c:forEach var="customer" items="${customers}">
                                                    <option value="${customer.id}">${customer.fullName} (${customer.phone})</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="info-item">
                                            <label for="newCustomerBtn">Hoặc tạo mới</label>
                                            <button type="button" class="btn btn-outline" id="newCustomerBtn" style="width: 100%;">
                                                <i class="fas fa-user-plus"></i> Thêm khách hàng mới
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h4>Thông tin xe</h4>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label for="vehicleSelect">Chọn xe *</label>
                                            <select id="vehicleSelect" name="vehicleId" required>
                                                <option value="">Chọn xe</option>
                                                <c:forEach var="vehicle" items="${vehicles}">
                                                    <option value="${vehicle.id}" data-daily-rate="${vehicle.dailyRate}">
                                                        ${vehicle.name} (${vehicle.licensePlate}) - 
                                                        <fmt:formatNumber value="${vehicle.dailyRate}" type="currency" currencyCode="VND" />
                                                        /ngày
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="info-item">
                                            <label for="vehicleAvailability">Tình trạng</label>
                                            <input type="text" id="vehicleAvailability" value="Có sẵn" readonly style="background: #f5f5f5;">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h4>Thời gian thuê</h4>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label for="pickupDate">Ngày nhận xe *</label>
                                            <input type="datetime-local" id="pickupDate" name="pickupDate" required>
                                        </div>
                                        <div class="info-item">
                                            <label for="returnDate">Ngày trả xe *</label>
                                            <input type="datetime-local" id="returnDate" name="returnDate" required>
                                        </div>
                                        <div class="info-item">
                                            <label for="totalDays">Tổng số ngày</label>
                                            <input type="text" id="totalDays" value="0 ngày" readonly style="background: #f5f5f5;">
                                        </div>
                                        <div class="info-item">
                                            <label for="totalHours">Tổng số giờ</label>
                                            <input type="text" id="totalHours" value="0 giờ" readonly style="background: #f5f5f5;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div>
                                <div class="detail-section">
                                    <h4>Địa điểm</h4>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label for="pickupLocation">Điểm nhận xe *</label>
                                            <select id="pickupLocation" name="pickupLocation" required>
                                                <option value="">Chọn điểm nhận xe</option>
                                                <option value="1">123 Đường ABC, Quận 1, TP.HCM</option>
                                                <option value="2">456 Đường XYZ, Quận 3, TP.HCM</option>
                                                <option value="3">Chi nhánh sân bay Tân Sơn Nhất</option>
                                            </select>
                                        </div>
                                        <div class="info-item">
                                            <label for="returnLocation">Điểm trả xe *</label>
                                            <select id="returnLocation" name="returnLocation" required>
                                                <option value="">Chọn điểm trả xe</option>
                                                <option value="1">123 Đường ABC, Quận 1, TP.HCM</option>
                                                <option value="2">456 Đường XYZ, Quận 3, TP.HCM</option>
                                                <option value="3">Chi nhánh sân bay Tân Sơn Nhất</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h4>Tính toán giá</h4>
                                    <div class="price-breakdown">
                                        <div class="price-item">
                                            <span>Giá thuê cơ bản:</span>
                                            <span id="calcBasePrice">0 ₫</span>
                                            <input type="hidden" id="baseAmount" name="baseAmount" value="0">
                                        </div>
                                        <div class="price-item">
                                            <span>Phí bảo hiểm (20%):</span>
                                            <span id="calcInsurance">0 ₫</span>
                                            <input type="hidden" id="insuranceFee" name="insuranceFee" value="0">
                                        </div>
                                        <div class="price-item">
                                            <span>Phí dịch vụ:</span>
                                            <span id="calcService">20.000 ₫</span>
                                            <input type="hidden" id="serviceFee" name="serviceFee" value="20000">
                                        </div>
                                        <div class="price-item">
                                            <label for="discountCode">Mã giảm giá</label>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <input type="text" id="discountCode" placeholder="Nhập mã" style="flex: 1;">
                                                <button type="button" class="btn btn-outline" id="applyDiscount">Áp dụng</button>
                                            </div>
                                        </div>
                                        <div class="price-item">
                                            <span>Giảm giá:</span>
                                            <span id="calcDiscount">0 ₫</span>
                                            <input type="hidden" id="discountAmount" name="discountAmount" value="0">
                                        </div>
                                        <div class="price-total">
                                            Tổng cộng: <span id="calcTotalPrice">0 ₫</span>
                                            <input type="hidden" id="totalAmount" name="totalAmount" value="0">
                                        </div>
                                        <div class="price-item" style="margin-top: 1rem;">
                                            <span>Tiền cọc:</span>
                                            <span id="calcDeposit">0 ₫</span>
                                            <input type="hidden" id="depositAmount" name="depositAmount" value="0">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h4>Thanh toán</h4>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label for="paymentMethod">Phương thức thanh toán *</label>
                                            <select id="paymentMethod" name="paymentMethod" required>
                                                <option value="">Chọn phương thức</option>
                                                <option value="CASH">Tiền mặt</option>
                                                <option value="BANK_TRANSFER">Chuyển khoản</option>
                                                <option value="CREDIT_CARD">Thẻ tín dụng</option>
                                                <option value="MOMO">Ví MoMo</option>
                                            </select>
                                        </div>
                                        <div class="info-item">
                                            <label for="paymentStatus">Trạng thái thanh toán *</label>
                                            <select id="paymentStatus" name="paymentStatus" required>
                                                <option value="UNPAID">Chưa thanh toán</option>
                                                <option value="PARTIAL">Thanh toán một phần</option>
                                                <option value="PAID">Đã thanh toán</option>
                                            </select>
                                        </div>
                                        <div class="info-item">
                                            <label for="paidAmount">Số tiền đã thanh toán</label>
                                            <input type="number" id="paidAmount" name="paidAmount" min="0" value="0">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h4>Ghi chú</h4>
                                    <textarea id="bookingNotesField" name="notes" rows="4" placeholder="Ghi chú về đơn đặt..."></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                
                <div class="modal-footer">
                    <button class="btn btn-outline" id="cancelFormBtn">Hủy</button>
                    <button class="btn btn-primary" id="saveBookingBtn">Lưu đơn đặt</button>
                </div>
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal" id="confirmationModal">
            <div class="modal-content" style="max-width: 500px;">
                <div class="modal-header">
                    <h3 id="confirmationTitle"><i class="fas fa-exclamation-circle"></i> Xác nhận</h3>
                    <button class="close-modal" id="closeConfirmationModal">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage">Bạn có chắc chắn muốn thực hiện hành động này?</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" id="cancelConfirmationBtn">Hủy</button>
                    <button class="btn btn-primary" id="confirmActionBtn">Xác nhận</button>
                </div>
            </div>
        </div>

        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="modal" style="background: rgba(0,0,0,0.5); display: none;">
            <div class="modal-content" style="max-width: 200px; text-align: center; background: transparent; box-shadow: none;">
                <div class="loading"></div>
                <p style="color: white; margin-top: 10px;">Đang xử lý...</p>
            </div>
        </div>
    </main>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/vn.js"></script>
    <script>
        // API URLs
        const API_BASE = '${pageContext.request.contextPath}/api';
        const BOOKINGS_API = API_BASE + '/bookings';
        const CUSTOMERS_API = API_BASE + '/customers';
        const VEHICLES_API = API_BASE + '/vehicles';

        // Global variables
        let currentBookingId = null;
        let selectedBookings = new Set();
        let currentMonth = new Date().getMonth();
        let currentYear = new Date().getFullYear();
        let currentAction = null;
        let calendarBookings = [];

        // Format currency
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { 
                style: 'currency', 
                currency: 'VND' 
            }).format(amount);
        }

        // Format date
        function formatDate(dateString, includeTime = true) {
            if (!dateString) return '';
            const date = new Date(dateString);
            const options = { 
                day: '2-digit', 
                month: '2-digit', 
                year: 'numeric' 
            };
            
            if (includeTime) {
                options.hour = '2-digit';
                options.minute = '2-digit';
            }
            
            return date.toLocaleDateString('vi-VN', options);
        }

        // Format date for input
        function formatDateForInput(dateString) {
            if (!dateString) return '';
            const date = new Date(dateString);
            return date.toISOString().slice(0, 16);
        }

        // Show loading
        function showLoading() {
            $('#loadingOverlay').show();
        }

        // Hide loading
        function hideLoading() {
            $('#loadingOverlay').hide();
        }

        // Load calendar bookings
        function loadCalendarBookings(year, month) {
            showLoading();
            $.ajax({
                url: BOOKINGS_API + '/calendar',
                method: 'GET',
                data: { year: year, month: month + 1 },
                success: function(data) {
                    calendarBookings = data;
                    renderCalendar();
                    hideLoading();
                },
                error: function(xhr) {
                    console.error('Error loading calendar:', xhr.responseText);
                    hideLoading();
                }
            });
        }

        // Generate calendar
        function renderCalendar() {
            const monthNames = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
                              "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];
            
            const dayNames = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
            
            // Update calendar header
            $('#calendarMonthYear').text(`${monthNames[currentMonth]}/${currentYear}`);
            
            // Clear calendar
            const calendarGrid = document.getElementById('calendarGrid');
            calendarGrid.innerHTML = '';
            
            // Add day headers
            dayNames.forEach(day => {
                const dayHeader = document.createElement('div');
                dayHeader.className = 'calendar-day-header';
                dayHeader.textContent = day;
                calendarGrid.appendChild(dayHeader);
            });
            
            // Get first day of month
            const firstDay = new Date(currentYear, currentMonth, 1);
            const lastDay = new Date(currentYear, currentMonth + 1, 0);
            
            // Calculate starting day (0 = Sunday, 1 = Monday, etc.)
            let startDay = firstDay.getDay();
            
            // Add empty cells for days before the first day of month
            for (let i = 0; i < startDay; i++) {
                const emptyDay = document.createElement('div');
                emptyDay.className = 'calendar-day';
                calendarGrid.appendChild(emptyDay);
            }
            
            // Add days of month
            const today = new Date();
            const isCurrentMonth = today.getMonth() === currentMonth && today.getFullYear() === currentYear;
            
            for (let day = 1; day <= lastDay.getDate(); day++) {
                const dayCell = document.createElement('div');
                dayCell.className = 'calendar-day';
                
                // Check if today
                if (isCurrentMonth && day === today.getDate()) {
                    dayCell.classList.add('today');
                }
                
                // Check if weekend
                const dayOfWeek = new Date(currentYear, currentMonth, day).getDay();
                if (dayOfWeek === 0 || dayOfWeek === 6) {
                    dayCell.classList.add('weekend');
                }
                
                // Add day number
                const dayNumber = document.createElement('div');
                dayNumber.className = 'day-number';
                dayNumber.textContent = day;
                dayCell.appendChild(dayNumber);
                
                // Add events for this day
                const dateStr = `${currentYear}-${(currentMonth + 1).toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
                
                calendarBookings.forEach(event => {
                    const eventStart = new Date(event.startDate);
                    const eventEnd = new Date(event.endDate);
                    const currentDate = new Date(dateStr);
                    
                    // Check if current date is within event range
                    if (currentDate >= eventStart && currentDate <= eventEnd) {
                        const eventElement = document.createElement('div');
                        eventElement.className = `calendar-event ${event.status.toLowerCase()}`;
                        eventElement.textContent = event.vehicleName;
                        eventElement.title = `${event.bookingCode} - ${event.customerName} (${event.status})`;
                        eventElement.addEventListener('click', () => viewBookingDetail(event.id));
                        dayCell.appendChild(eventElement);
                    }
                });
                
                calendarGrid.appendChild(dayCell);
            }
        }

        // Load booking detail
        function viewBookingDetail(id) {
            showLoading();
            $.ajax({
                url: BOOKINGS_API + '/' + id,
                method: 'GET',
                success: function(booking) {
                    populateBookingDetailModal(booking);
                    $('#bookingDetailModal').addClass('active');
                    hideLoading();
                },
                error: function(xhr) {
                    alert('Lỗi tải thông tin đơn đặt: ' + xhr.responseText);
                    hideLoading();
                }
            });
        }

        // Populate booking detail modal
        function populateBookingDetailModal(booking) {
            // Update modal title
            $('#modalBookingTitle').text(`Đơn đặt ${booking.bookingCode}`);
            
            // Update booking info
            $('#detailBookingCode').text(booking.bookingCode);
            $('#detailBookingDate').text(formatDate(booking.createdAt));
            $('#detailBookingStatus').text(getStatusText(booking.status));
            $('#detailBookingStatus').attr('class', `status-badge status-${booking.status.toLowerCase()}`);
            $('#detailPaymentStatus').text(getPaymentText(booking.paymentStatus));
            $('#detailPaymentStatus').attr('class', `payment-badge payment-${booking.paymentStatus.toLowerCase()}`);
            
            // Update customer info
            $('#detailCustomerName').text(booking.customer.fullName);
            $('#detailCustomerPhone').text(booking.customer.phone);
            $('#detailCustomerEmail').text(booking.customer.email);
            $('#detailCustomerId').text(booking.customer.idCard || 'Chưa cập nhật');
            $('#detailCustomerLicense').text(booking.customer.driverLicense || 'Chưa cập nhật');
            $('#detailCustomerAddress').text(booking.customer.address || 'Chưa cập nhật');
            
            // Update vehicle info
            $('#detailVehicleName').text(booking.vehicle.name);
            $('#detailVehiclePlate').text(booking.vehicle.licensePlate);
            $('#detailVehicleColor').text(booking.vehicle.color);
            $('#detailVehicleFuel').text(booking.vehicle.fuelType || 'Chưa cập nhật');
            
            // Update date info
            $('#detailPickupDate').text(formatDate(booking.pickupDate));
            $('#detailReturnDate').text(formatDate(booking.returnDate));
            $('#detailTotalDays').text(`${booking.totalDays} ngày (${booking.totalHours} giờ)`);
            $('#detailPickupLocation').text(booking.pickupLocation);
            $('#detailReturnLocation').text(booking.returnLocation);
            
            // Update timeline
            const timeline = booking.timeline || [];
            $('#timelineCreated').text(timeline.find(t => t.action === 'CREATED') ? 
                formatDate(timeline.find(t => t.action === 'CREATED').time) : formatDate(booking.createdAt));
            $('#timelineConfirmed').text(timeline.find(t => t.action === 'CONFIRMED') ? 
                formatDate(timeline.find(t => t.action === 'CONFIRMED').time) : 'Chờ...');
            $('#timelinePayment').text(timeline.find(t => t.action === 'PAYMENT') ? 
                formatDate(timeline.find(t => t.action === 'PAYMENT').time) : 'Chờ...');
            $('#timelinePickup').text(timeline.find(t => t.action === 'PICKUP') ? 
                formatDate(timeline.find(t => t.action === 'PICKUP').time) : formatDate(booking.pickupDate));
            $('#timelineCompleted').text(timeline.find(t => t.action === 'COMPLETED') ? 
                formatDate(timeline.find(t => t.action === 'COMPLETED').time) : formatDate(booking.returnDate));
            
            // Update price breakdown
            $('#priceBase').text(formatCurrency(booking.baseAmount));
            $('#priceInsurance').text(formatCurrency(booking.insuranceFee));
            $('#priceService').text(formatCurrency(booking.serviceFee));
            $('#priceExtra').text(formatCurrency(booking.extraFee || 0));
            $('#priceDiscount').text(`-${formatCurrency(booking.discountAmount)}`);
            $('#priceTotal').text(formatCurrency(booking.totalAmount));
            $('#priceDeposit').text(formatCurrency(booking.depositAmount));
            $('#pricePaid').text(formatCurrency(booking.paidAmount));
            
            // Update notes
            $('#bookingNotes').text(booking.notes || 'Không có ghi chú.');
            
            // Update action buttons
            currentBookingId = booking.id;
            
            const confirmBtn = $('#confirmBookingBtn');
            const cancelBtn = $('#cancelBookingBtn');
            const editBtn = $('#editBookingBtn');
            
            if (booking.status === 'PENDING') {
                confirmBtn.show();
                cancelBtn.show();
                editBtn.show();
            } else if (booking.status === 'CONFIRMED') {
                confirmBtn.hide();
                cancelBtn.show();
                editBtn.show();
            } else {
                confirmBtn.hide();
                cancelBtn.hide();
                editBtn.show();
            }
        }

        // Get status text
        function getStatusText(status) {
            const texts = {
                'PENDING': 'Chờ xác nhận',
                'CONFIRMED': 'Đã xác nhận',
                'ACTIVE': 'Đang hoạt động',
                'COMPLETED': 'Đã hoàn thành',
                'CANCELLED': 'Đã hủy'
            };
            return texts[status] || status;
        }

        // Get payment text
        function getPaymentText(paymentStatus) {
            const texts = {
                'PAID': 'Đã thanh toán',
                'PARTIAL': 'Thanh toán một phần',
                'UNPAID': 'Chưa thanh toán',
                'REFUNDED': 'Đã hoàn tiền'
            };
            return texts[paymentStatus] || paymentStatus;
        }

        // Calculate prices based on selection
        function calculatePrices() {
            const vehicleSelect = $('#vehicleSelect');
            const pickupDate = $('#pickupDate').val();
            const returnDate = $('#returnDate').val();
            
            if (!vehicleSelect.val() || !pickupDate || !returnDate) {
                resetPrices();
                return;
            }
            
            // Get vehicle daily rate
            const selectedOption = vehicleSelect.find('option:selected');
            const dailyRate = parseFloat(selectedOption.data('daily-rate') || 0);
            
            // Calculate days and hours
            const startDate = new Date(pickupDate);
            const endDate = new Date(returnDate);
            
            if (startDate >= endDate) {
                resetPrices();
                return;
            }
            
            const diffTime = Math.abs(endDate - startDate);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            const diffHours = Math.ceil(diffTime / (1000 * 60 * 60));
            
            $('#totalDays').val(`${diffDays} ngày`);
            $('#totalHours').val(`${diffHours} giờ`);
            
            // Calculate prices
            const baseAmount = dailyRate * diffDays;
            const insuranceFee = baseAmount * 0.2; // 20%
            const serviceFee = 20000;
            const discount = parseFloat($('#calcDiscount').text().replace(/[^\d.-]/g, '')) || 0;
            const totalAmount = baseAmount + insuranceFee + serviceFee - discount;
            const depositAmount = dailyRate * 3; // 3 days deposit
            
            // Update display
            $('#calcBasePrice').text(formatCurrency(baseAmount));
            $('#calcInsurance').text(formatCurrency(insuranceFee));
            $('#calcService').text(formatCurrency(serviceFee));
            $('#calcTotalPrice').text(formatCurrency(totalAmount));
            $('#calcDeposit').text(formatCurrency(depositAmount));
            
            // Update hidden inputs
            $('#baseAmount').val(baseAmount);
            $('#insuranceFee').val(insuranceFee);
            $('#serviceFee').val(serviceFee);
            $('#totalAmount').val(totalAmount);
            $('#depositAmount').val(depositAmount);
        }

        function resetPrices() {
            $('#calcBasePrice').text('0 ₫');
            $('#calcInsurance').text('0 ₫');
            $('#calcService').text('20.000 ₫');
            $('#calcDiscount').text('0 ₫');
            $('#calcTotalPrice').text('0 ₫');
            $('#calcDeposit').text('0 ₫');
            
            // Reset hidden inputs
            $('#baseAmount').val(0);
            $('#insuranceFee').val(0);
            $('#serviceFee').val(20000);
            $('#discountAmount').val(0);
            $('#totalAmount').val(0);
            $('#depositAmount').val(0);
        }

        // Create new booking
        function createNewBooking() {
            currentBookingId = null;
            $('#modalFormTitle').text('Tạo đơn đặt mới');
            $('#bookingForm')[0].reset();
            $('#bookingId').val('');
            
            // Set default dates (tomorrow and day after tomorrow)
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            tomorrow.setHours(8, 0, 0, 0);
            
            const dayAfterTomorrow = new Date(tomorrow);
            dayAfterTomorrow.setDate(dayAfterTomorrow.getDate() + 3);
            dayAfterTomorrow.setHours(18, 0, 0, 0);
            
            $('#pickupDate').val(formatDateForInput(tomorrow));
            $('#returnDate').val(formatDateForInput(dayAfterTomorrow));
            $('#vehicleAvailability').val('Có sẵn');
            $('#totalDays').val('0 ngày');
            $('#totalHours').val('0 giờ');
            $('#paymentStatus').val('UNPAID');
            $('#paidAmount').val('0');
            
            resetPrices();
            
            $('#bookingFormModal').addClass('active');
        }

        // Load booking for edit
        function editBooking(id) {
            showLoading();
            $.ajax({
                url: BOOKINGS_API + '/' + id,
                method: 'GET',
                success: function(booking) {
                    populateBookingForm(booking);
                    $('#bookingFormModal').addClass('active');
                    hideLoading();
                },
                error: function(xhr) {
                    alert('Lỗi tải thông tin đơn đặt: ' + xhr.responseText);
                    hideLoading();
                }
            });
        }

        // Populate booking form
        function populateBookingForm(booking) {
            $('#bookingId').val(booking.id);
            $('#modalFormTitle').text('Chỉnh sửa đơn đặt ' + booking.bookingCode);
            $('#customerSelect').val(booking.customer.id).trigger('change');
            $('#vehicleSelect').val(booking.vehicle.id).trigger('change');
            $('#vehicleAvailability').val('Có sẵn');
            
            // Format dates for datetime-local input
            $('#pickupDate').val(formatDateForInput(booking.pickupDate));
            $('#returnDate').val(formatDateForInput(booking.returnDate));
            $('#totalDays').val(`${booking.totalDays} ngày`);
            $('#totalHours').val(`${booking.totalHours} giờ`);
            
            $('#pickupLocation').val(booking.pickupLocation || '1');
            $('#returnLocation').val(booking.returnLocation || '2');
            
            // Calculate and display prices
            setTimeout(() => {
                calculatePrices();
                
                // Apply discount if exists
                if (booking.discountAmount > 0) {
                    $('#calcDiscount').text(`-${formatCurrency(booking.discountAmount)}`);
                    $('#discountAmount').val(booking.discountAmount);
                    $('#discountCode').val('RENTCAR10'); // Example discount code
                }
            }, 500);
            
            $('#paymentMethod').val(booking.paymentMethod);
            $('#paymentStatus').val(booking.paymentStatus);
            $('#paidAmount').val(booking.paidAmount);
            $('#bookingNotesField').val(booking.notes || '');
            
            // Update hidden inputs
            $('#baseAmount').val(booking.baseAmount);
            $('#insuranceFee').val(booking.insuranceFee);
            $('#serviceFee').val(booking.serviceFee);
            $('#totalAmount').val(booking.totalAmount);
            $('#depositAmount').val(booking.depositAmount);
        }

        // Confirm booking action
        function confirmBookingAction(id, action) {
            currentBookingId = id;
            currentAction = action;
            
            let message = '';
            let title = '';
            
            if (action === 'confirm') {
                title = 'Xác nhận đơn đặt';
                message = 'Bạn có chắc chắn muốn xác nhận đơn đặt này?';
            } else if (action === 'cancel') {
                title = 'Hủy đơn đặt';
                message = 'Bạn có chắc chắn muốn hủy đơn đặt này? Hành động này không thể hoàn tác.';
            }
            
            $('#confirmationTitle').html('<i class="fas fa-exclamation-circle"></i> ' + title);
            $('#confirmationMessage').text(message);
            $('#confirmationModal').addClass('active');
        }

        // Execute confirmed action
        function executeAction() {
            if (!currentBookingId || !currentAction) return;
            
            showLoading();
            const url = BOOKINGS_API + '/' + currentBookingId + '/' + 
                       (currentAction === 'confirm' ? 'confirm' : 'cancel');
            
            $.ajax({
                url: url,
                method: 'POST',
                success: function() {
                    alert('Thao tác thành công!');
                    location.reload();
                },
                error: function(xhr) {
                    alert('Lỗi: ' + xhr.responseText);
                    hideLoading();
                }
            });
        }

        // Cancel selected bookings
        function cancelSelectedBookings() {
            if (selectedBookings.size === 0) {
                alert('Vui lòng chọn ít nhất một đơn đặt để hủy.');
                return;
            }
            
            if (confirm(`Bạn có chắc chắn muốn hủy ${selectedBookings.size} đơn đặt đã chọn?`)) {
                showLoading();
                const bookingsToCancel = Array.from(selectedBookings);
                
                $.ajax({
                    url: BOOKINGS_API + '/bulk-cancel',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ bookingIds: bookingsToCancel }),
                    success: function() {
                        alert(`Đã hủy ${selectedBookings.size} đơn đặt thành công!`);
                        location.reload();
                    },
                    error: function(xhr) {
                        alert('Lỗi: ' + xhr.responseText);
                        hideLoading();
                    }
                });
            }
        }

        // Print selected contracts
        function printSelectedContracts() {
            if (selectedBookings.size === 0) {
                alert('Vui lòng chọn ít nhất một đơn đặt để in hợp đồng.');
                return;
            }
            
            const bookingsToPrint = Array.from(selectedBookings);
            const url = BOOKINGS_API + '/print?ids=' + bookingsToPrint.join(',');
            window.open(url, '_blank');
        }

        // Update selected count
        function updateSelectedCount() {
            const cancelBtn = $('#cancelSelectedBtn');
            const printBtn = $('#printSelectedBtn');
            
            if (selectedBookings.size > 0) {
                cancelBtn.html('<i class="fas fa-ban"></i> Hủy (' + selectedBookings.size + ')');
                printBtn.html('<i class="fas fa-print"></i> In (' + selectedBookings.size + ')');
            } else {
                cancelBtn.html('<i class="fas fa-ban"></i> Hủy đã chọn');
                printBtn.html('<i class="fas fa-print"></i> In hợp đồng');
            }
        }

        // Initialize
        $(document).ready(function() {
            // Initialize DataTable
            const table = $('#bookingsTable').DataTable({
                "pageLength": 10,
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
                },
                "columnDefs": [
                    { "orderable": false, "targets": [0, 8] }
                ],
                "order": [[1, 'desc']]
            });
            
            // Initialize Flatpickr
            flatpickr("#filterDateRange", {
                mode: "range",
                locale: "vn",
                dateFormat: "d/m/Y",
                placeholder: "Chọn khoảng thời gian...",
                defaultDate: [
                    "${param.startDate}",
                    "${param.endDate}"
                ].filter(Boolean)
            });
            
            // Initialize Select2
            $('#filterCustomer, #filterVehicle, #filterPayment, #customerSelect, #vehicleSelect, #pickupLocation, #returnLocation, #paymentMethod, #paymentStatus').select2({
                width: '100%',
                placeholder: 'Chọn...'
            });
            
            // Load calendar data
            loadCalendarBookings(currentYear, currentMonth);
            
            // Event listeners
            $('#createBookingBtn').click(createNewBooking);
            
            // View booking detail
            $(document).on('click', '.view-booking', function() {
                const id = $(this).data('id');
                viewBookingDetail(id);
            });
            
            // Edit booking
            $(document).on('click', '.edit-booking', function() {
                const id = $(this).data('id');
                editBooking(id);
            });
            
            // Confirm booking
            $(document).on('click', '.confirm-booking', function() {
                const id = $(this).data('id');
                confirmBookingAction(id, 'confirm');
            });
            
            // Cancel booking
            $(document).on('click', '.delete-booking', function() {
                const id = $(this).data('id');
                confirmBookingAction(id, 'cancel');
            });
            
            // Date change listeners for booking form
            $('#pickupDate, #returnDate, #vehicleSelect').change(calculatePrices);
            
            // Apply discount button
            $('#applyDiscount').click(function() {
                const discountCode = $('#discountCode').val();
                if (discountCode === 'RENTCAR10') {
                    const baseAmount = parseFloat($('#baseAmount').val()) || 0;
                    const discount = baseAmount * 0.05; // 5% discount
                    $('#calcDiscount').text(`-${formatCurrency(discount)}`);
                    $('#discountAmount').val(discount);
                    calculatePrices();
                    alert('Áp dụng mã giảm giá thành công!');
                } else {
                    alert('Mã giảm giá không hợp lệ.');
                }
            });
            
            // Calendar navigation
            $('#prevMonth').click(function() {
                currentMonth--;
                if (currentMonth < 0) {
                    currentMonth = 11;
                    currentYear--;
                }
                loadCalendarBookings(currentYear, currentMonth);
            });
            
            $('#nextMonth').click(function() {
                currentMonth++;
                if (currentMonth > 11) {
                    currentMonth = 0;
                    currentYear++;
                }
                loadCalendarBookings(currentYear, currentMonth);
            });
            
            $('#todayBtn').click(function() {
                const today = new Date();
                currentMonth = today.getMonth();
                currentYear = today.getFullYear();
                loadCalendarBookings(currentYear, currentMonth);
            });
            
            // Modal close buttons
            $('#closeDetailModal, #closeFormModal, #closeConfirmationModal').click(function() {
                $(this).closest('.modal').removeClass('active');
            });
            
            $('#cancelFormBtn').click(function() {
                $('#bookingFormModal').removeClass('active');
            });
            
            $('#cancelConfirmationBtn').click(function() {
                $('#confirmationModal').removeClass('active');
            });
            
            // Form submission
            $('#saveBookingBtn').click(function() {
                if ($('#bookingForm')[0].checkValidity()) {
                    showLoading();
                    $('#bookingForm').submit();
                } else {
                    alert('Vui lòng điền đầy đủ thông tin bắt buộc (*)');
                }
            });
            
            // Action buttons in detail modal
            $('#confirmBookingBtn').click(function() {
                confirmBookingAction(currentBookingId, 'confirm');
            });
            
            $('#cancelBookingBtn').click(function() {
                confirmBookingAction(currentBookingId, 'cancel');
            });
            
            $('#printContractBtn').click(function() {
                if (currentBookingId) {
                    const url = BOOKINGS_API + '/print?ids=' + currentBookingId;
                    window.open(url, '_blank');
                }
            });
            
            // Confirmation modal action
            $('#confirmActionBtn').click(executeAction);
            
            // Bulk actions
            $('#cancelSelectedBtn').click(cancelSelectedBookings);
            $('#printSelectedBtn').click(printSelectedContracts);
            
            // Select all checkbox
            $('#selectAllCheckbox').change(function(e) {
                const isChecked = $(this).is(':checked');
                $('.select-booking').prop('checked', isChecked);
                
                if (isChecked) {
                    $('.select-booking').each(function() {
                        selectedBookings.add(parseInt($(this).data('id')));
                    });
                } else {
                    selectedBookings.clear();
                }
                
                updateSelectedCount();
            });
            
            // Individual checkbox
            $(document).on('change', '.select-booking', function() {
                const id = parseInt($(this).data('id'));
                if ($(this).is(':checked')) {
                    selectedBookings.add(id);
                } else {
                    selectedBookings.delete(id);
                }
                
                // Update select all checkbox
                const totalCheckboxes = $('.select-booking').length;
                const checkedCount = $('.select-booking:checked').length;
                $('#selectAllCheckbox').prop('checked', totalCheckboxes === checkedCount);
                
                updateSelectedCount();
            });
            
            // Quick actions
            $('.quick-actions .action-btn').click(function() {
                $('.quick-actions .action-btn').removeClass('active');
                $(this).addClass('active');
                
                const status = $(this).data('status');
                if (status === 'all') {
                    window.location.href = '${pageContext.request.contextPath}/admin/bookings';
                } else {
                    window.location.href = '${pageContext.request.contextPath}/admin/bookings?status=' + status;
                }
            });
            
            // Filter buttons
            $('#applyFilters').click(function() {
                const dateRange = $('#filterDateRange').val();
                const customer = $('#filterCustomer').val();
                const vehicle = $('#filterVehicle').val();
                const payment = $('#filterPayment').val();
                
                let url = '${pageContext.request.contextPath}/admin/bookings?';
                const params = [];
                
                if (dateRange) {
                    const dates = dateRange.split(' to ');
                    if (dates[0]) params.push('startDate=' + encodeURIComponent(dates[0]));
                    if (dates[1]) params.push('endDate=' + encodeURIComponent(dates[1]));
                }
                
                if (customer) params.push('customerId=' + customer);
                if (vehicle) params.push('vehicleId=' + vehicle);
                if (payment) params.push('paymentStatus=' + payment);
                
                // Add status from quick actions
                const activeStatus = $('.quick-actions .action-btn.active').data('status');
                if (activeStatus && activeStatus !== 'all') {
                    params.push('status=' + activeStatus);
                }
                
                window.location.href = url + params.join('&');
            });
            
            $('#resetFilters').click(function() {
                window.location.href = '${pageContext.request.contextPath}/admin/bookings';
            });
            
            // Export and reminder buttons
            $('#exportBookingsBtn').click(function() {
                showLoading();
                const url = BOOKINGS_API + '/export?' + window.location.search.substring(1);
                window.location.href = url;
                setTimeout(hideLoading, 2000);
            });
            
            $('#sendRemindersBtn').click(function() {
                if (confirm('Gửi nhắc nhở đến tất cả khách hàng có đơn đặt sắp tới?')) {
                    showLoading();
                    $.ajax({
                        url: BOOKINGS_API + '/send-reminders',
                        method: 'POST',
                        success: function() {
                            alert('Đã gửi nhắc nhở thành công!');
                            hideLoading();
                        },
                        error: function(xhr) {
                            alert('Lỗi: ' + xhr.responseText);
                            hideLoading();
                        }
                    });
                }
            });
            
            // New customer button
            $('#newCustomerBtn').click(function() {
                alert('Chức năng thêm khách hàng mới sẽ được mở trong cửa sổ mới.');
                // In real app: window.open('${pageContext.request.contextPath}/admin/customers/new', '_blank');
            });
            
            // Close modals when clicking outside
            $('.modal').click(function(e) {
                if (e.target === this) {
                    $(this).removeClass('active');
                }
            });
            
            // Initialize total hours and days calculation
            calculatePrices();
        });
    </script>
</body>
</html>