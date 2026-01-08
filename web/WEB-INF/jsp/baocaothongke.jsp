<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>RentCar Admin - Báo cáo & Thống kê</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/baocaothongke.css">
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
                                <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Đơn đặt xe</span>
                                </a>
                            </li>

                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link active">
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
                    </li>
                    </ul>

                    <div class="sidebar-footer">
                        <div class="user-info">
                            <div class="user-avatar">A</div>
                            <div>
                                <h4>${sessionScope.user.fullName}</h4>
                                <p>${sessionScope.user.role}</p>
                            </div>
                        </div>
                    </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <header class="header">
                            <div class="header-left">
                                <h1><i class="fas fa-chart-bar"></i> Báo cáo & Thống kê</h1>
                                <p>Phân tích dữ liệu và xuất báo cáo chi tiết</p>
                            </div>

                            <div class="header-right">
                                <button class="btn btn-primary" id="refreshReports">
                                    <i class="fas fa-sync-alt"></i> Làm mới dữ liệu
                                </button>
                                <button class="btn btn-success" id="exportAllBtn">
                                    <i class="fas fa-file-export"></i> Xuất báo cáo đầy đủ
                                </button>
                            </div>
                        </header>

                        <!-- KPI Cards -->
                        <div class="kpi-cards">
                            <div class="kpi-card kpi-revenue">
                                <div class="kpi-icon">
                                    <i class="fas fa-money-bill-wave"></i>
                                </div>
                                <div class="kpi-info">
                                    <h3>Doanh thu tháng</h3>
                                    <div class="kpi-value" id="kpiRevenue">
                                        <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencySymbol="₫"
                                            maxFractionDigits="0" />
                                    </div>
                                    <div class="kpi-change ${revenueChange >= 0 ? 'positive' : 'negative'}">
                                        <i class="fas fa-${revenueChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${revenueChange}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>

                            <div class="kpi-card kpi-bookings">
                                <div class="kpi-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="kpi-info">
                                    <h3>Tổng đơn đặt</h3>
                                    <div class="kpi-value" id="kpiBookings">${totalBookings}</div>
                                    <div class="kpi-change ${bookingChange >= 0 ? 'positive' : 'negative'}">
                                        <i class="fas fa-${bookingChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${bookingChange}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>

                            <div class="kpi-card kpi-vehicles">
                                <div class="kpi-icon">
                                    <i class="fas fa-car"></i>
                                </div>
                                <div class="kpi-info">
                                    <h3>Tỷ lệ sử dụng xe</h3>
                                    <div class="kpi-value" id="kpiUtilization">
                                        <fmt:formatNumber value="${vehicleUtilization}" pattern="0.0" />%
                                    </div>
                                    <div class="kpi-change ${utilizationChange <= 0 ? 'positive' : 'negative'}">
                                        <i class="fas fa-${utilizationChange <= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${utilizationChange}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>

                            <div class="kpi-card kpi-users">
                                <div class="kpi-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="kpi-info">
                                    <h3>Khách hàng mới</h3>
                                    <div class="kpi-value" id="kpiNewUsers">${newCustomers}</div>
                                    <div class="kpi-change ${customerChange >= 0 ? 'positive' : 'negative'}">
                                        <i class="fas fa-${customerChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${customerChange}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Report Filters -->
                        <section class="report-filters">
                            <div class="filters-header">
                                <h3><i class="fas fa-filter"></i> Tùy chỉnh báo cáo</h3>
                                <div style="display: flex; gap: 1rem; align-items: center;">
                                    <span style="font-size: 0.9rem; color: #666;">Dữ liệu tự động cập nhật</span>
                                    <div class="loading-spinner" id="filterLoading" style="display: none;">
                                        <div class="spinner"></div>
                                    </div>
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/admin/reports" method="GET"
                                id="reportFilterForm">
                                <div class="filter-grid">
                                    <div class="filter-group">
                                        <label for="reportPeriod">Kỳ báo cáo</label>
                                        <select id="reportPeriod" name="period">
                                            <option value="monthly" ${param.period eq 'monthly' ? 'selected' : '' }>Theo
                                                tháng</option>
                                            <option value="quarterly" ${param.period eq 'quarterly' ? 'selected' : '' }>
                                                Theo
                                                quý</option>
                                            <option value="yearly" ${param.period eq 'yearly' ? 'selected' : '' }>Theo
                                                năm
                                            </option>
                                            <option value="custom" ${param.period eq 'custom' ? 'selected' : '' }>Tùy
                                                chỉnh
                                            </option>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label for="reportDateRange">Khoảng thời gian</label>
                                        <input type="text" id="reportDateRange" name="dateRange"
                                            placeholder="Chọn khoảng thời gian..." value="${param.dateRange}">
                                    </div>

                                    <div class="filter-group">
                                        <label for="reportCategory">Phân loại</label>
                                        <select id="reportCategory" name="category">
                                            <option value="all" ${empty param.category or param.category eq 'all'
                                                ? 'selected' : '' }>Tất cả loại xe</option>
                                            <option value="motorcycle" ${param.category eq 'motorcycle' ? 'selected'
                                                : '' }>
                                                Xe máy</option>
                                            <option value="electric" ${param.category eq 'electric' ? 'selected' : '' }>
                                                Xe
                                                điện</option>
                                            <option value="car" ${param.category eq 'car' ? 'selected' : '' }>Ô tô
                                            </option>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label for="reportMetrics">Chỉ số chính</label>
                                        <select id="reportMetrics" name="metrics">
                                            <option value="revenue" ${param.metrics eq 'revenue' ? 'selected' : '' }>
                                                Doanh
                                                thu</option>
                                            <option value="bookings" ${param.metrics eq 'bookings' ? 'selected' : '' }>
                                                Số
                                                đơn đặt</option>
                                            <option value="utilization" ${param.metrics eq 'utilization' ? 'selected'
                                                : '' }>Tỷ lệ sử dụng</option>
                                            <option value="customers" ${param.metrics eq 'customers' ? 'selected' : ''
                                                }>
                                                Khách hàng</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="filter-actions">
                                    <button type="submit" class="btn btn-primary" id="generateReport">
                                        <i class="fas fa-chart-line"></i> Tạo báo cáo
                                    </button>
                                    <button type="button" class="btn btn-outline" id="resetFilters">
                                        <i class="fas fa-redo"></i> Đặt lại
                                    </button>
                                    <button type="button" class="btn btn-success" id="saveReportTemplate">
                                        <i class="fas fa-save"></i> Lưu mẫu báo cáo
                                    </button>
                                    <button type="button" class="btn btn-warning" id="scheduleReport">
                                        <i class="fas fa-clock"></i> Lên lịch báo cáo
                                    </button>
                                </div>
                            </form>
                        </section>

                        <!-- Charts Container -->
                        <div class="charts-container">
                            <!-- Revenue Chart -->
                            <div class="chart-card">
                                <div class="chart-header">
                                    <h3><i class="fas fa-money-bill-wave"></i> Doanh thu theo thời gian</h3>
                                    <div class="chart-actions">
                                        <button class="chart-btn active" data-chart="revenue-monthly">Tháng</button>
                                        <button class="chart-btn" data-chart="revenue-quarterly">Quý</button>
                                        <button class="chart-btn" data-chart="revenue-yearly">Năm</button>
                                    </div>
                                </div>
                                <div class="chart-wrapper">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>

                            <!-- Bookings Chart -->
                            <div class="chart-card">
                                <div class="chart-header">
                                    <h3><i class="fas fa-calendar-alt"></i> Phân tích đơn đặt</h3>
                                    <div class="chart-actions">
                                        <button class="chart-btn active" data-chart="bookings-status">Theo trạng
                                            thái</button>
                                        <button class="chart-btn" data-chart="bookings-category">Theo loại xe</button>
                                        <button class="chart-btn" data-chart="bookings-trend">Xu hướng</button>
                                    </div>
                                </div>
                                <div class="chart-wrapper">
                                    <canvas id="bookingsChart"></canvas>
                                </div>
                            </div>
                        </div>

                        <!-- Comparison Cards -->
                        <div class="comparison-cards">
                            <!-- Vehicle Performance -->
                            <div class="comparison-card">
                                <div class="comparison-header">
                                    <h3><i class="fas fa-car"></i> Hiệu suất xe</h3>
                                    <span style="font-size: 0.8rem; color: #666;">Top 5 xe được thuê nhiều nhất</span>
                                </div>

                                <div class="comparison-list" id="vehiclePerformanceList">
                                    <c:forEach var="vehicle" items="${topVehicles}">
                                        <div class="comparison-item">
                                            <div class="item-info">
                                                <div class="item-icon" style="background: #3498db;">
                                                    <i class="fas fa-car"></i>
                                                </div>
                                                <div class="item-details">
                                                    <h4>${vehicle.name}</h4>
                                                    <p>${vehicle.bookings} đơn •
                                                        <fmt:formatNumber value="${vehicle.utilization}"
                                                            pattern="0.0" />%
                                                        sử dụng
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="item-stats">
                                                <div class="item-value">
                                                    <fmt:formatNumber value="${vehicle.revenue}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </div>
                                                <div
                                                    class="item-change ${vehicle.change >= 0 ? 'positive' : 'negative'}">
                                                    <i
                                                        class="fas fa-${vehicle.change >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                                    <span>${Math.abs(vehicle.change)}%</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Customer Analysis -->
                            <div class="comparison-card">
                                <div class="comparison-header">
                                    <h3><i class="fas fa-users"></i> Phân tích khách hàng</h3>
                                    <span style="font-size: 0.8rem; color: #666;">Theo giá trị đơn hàng</span>
                                </div>

                                <div class="comparison-list" id="customerAnalysisList">
                                    <c:forEach var="customer" items="${topCustomers}">
                                        <div class="comparison-item">
                                            <div class="item-info">
                                                <div class="item-icon" style="background: #9b59b6;">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div class="item-details">
                                                    <h4>${customer.name}</h4>
                                                    <p>${customer.bookings} đơn •
                                                        <fmt:formatNumber value="${customer.avgSpent}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />/đơn
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="item-stats">
                                                <div class="item-value">
                                                    <fmt:formatNumber value="${customer.totalSpent}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </div>
                                                <div class="progress-bar" style="margin-top: 0.3rem;">
                                                    <c:set var="loyaltyClass" value="progress-success" />
                                                    <c:if test="${customer.loyalty < 85}">
                                                        <c:set var="loyaltyClass" value="progress-warning" />
                                                    </c:if>
                                                    <c:if test="${customer.loyalty < 70}">
                                                        <c:set var="loyaltyClass" value="progress-primary" />
                                                    </c:if>
                                                    <div class="progress-fill ${loyaltyClass}"
                                                        style="width: ${customer.loyalty}%"></div>
                                                </div>
                                                <div class="item-change"
                                                    style="font-size: 0.75rem; color: #666; margin-top: 0.2rem;">
                                                    Độ trung thành: ${customer.loyalty}%
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Report Tables -->
                        <div class="report-tables">
                            <!-- Monthly Revenue Table -->
                            <div class="table-card">
                                <div class="table-header">
                                    <h3><i class="fas fa-table"></i> Doanh thu chi tiết theo tháng</h3>
                                    <button class="btn btn-outline export-excel" data-type="revenue"
                                        style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                        <i class="fas fa-download"></i> Xuất Excel
                                    </button>
                                </div>
                                <div class="table-wrapper">
                                    <table id="revenueTable">
                                        <thead>
                                            <tr>
                                                <th>Tháng</th>
                                                <th>Doanh thu</th>
                                                <th>Tăng trưởng</th>
                                                <th>Số đơn</th>
                                                <th>Trung bình/đơn</th>
                                                <th>Tỷ lệ</th>
                                            </tr>
                                        </thead>
                                        <tbody id="revenueTableBody">
                                            <c:forEach var="item" items="${monthlyRevenueData}">
                                                <tr>
                                                    <td><strong>${item.month}</strong></td>
                                                    <td>
                                                        <fmt:formatNumber value="${item.revenue}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </td>
                                                    <td>
                                                        <span class="${item.growth >= 0 ? 'positive' : 'negative'}">
                                                            <i
                                                                class="fas fa-${item.growth >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                                            ${Math.abs(item.growth)}%
                                                        </span>
                                                    </td>
                                                    <td>${item.bookings}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${item.avgBooking}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </td>
                                                    <td>
                                                        <div class="progress-bar">
                                                            <div class="progress-fill progress-primary"
                                                                style="width: ${Math.min(100, item.growth + 20)}%">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Vehicle Category Analysis -->
                            <div class="table-card">
                                <div class="table-header">
                                    <h3><i class="fas fa-chart-pie"></i> Phân tích theo loại xe</h3>
                                    <button class="btn btn-outline export-excel" data-type="category"
                                        style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                        <i class="fas fa-download"></i> Xuất Excel
                                    </button>
                                </div>
                                <div class="table-wrapper">
                                    <table id="categoryTable">
                                        <thead>
                                            <tr>
                                                <th>Loại xe</th>
                                                <th>Doanh thu</th>
                                                <th>Tỷ lệ</th>
                                                <th>Số đơn</th>
                                                <th>Trung bình/ngày</th>
                                                <th>Tiến độ</th>
                                            </tr>
                                        </thead>
                                        <tbody id="categoryTableBody">
                                            <c:forEach var="category" items="${categoryData}">
                                                <tr>
                                                    <td><strong>${category.category}</strong></td>
                                                    <td>
                                                        <fmt:formatNumber value="${category.revenue}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${category.percentage}"
                                                            pattern="0.0" />%
                                                    </td>
                                                    <td>${category.bookings}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${category.avgDaily}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </td>
                                                    <td>
                                                        <div class="progress-bar">
                                                            <div class="progress-fill progress-success"
                                                                style="width: ${category.percentage}%"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Insights Section -->
                        <section class="insights-section">
                            <div class="insights-header">
                                <h3><i class="fas fa-lightbulb"></i> Insights & Đề xuất</h3>
                            </div>

                            <div class="insights-grid">
                                <div class="insight-card success">
                                    <div class="insight-header">
                                        <div class="insight-icon">
                                            <i class="fas fa-chart-line"></i>
                                        </div>
                                        <h4>Tăng trưởng tích cực</h4>
                                    </div>
                                    <div class="insight-content">
                                        <p>Doanh thu tháng ${currentMonth} tăng <strong>${revenueChange}%</strong> so
                                            với
                                            tháng trước.
                                            ${topVehicleName} đóng góp ${topVehicleContribution}% tổng doanh thu.</p>
                                        <div class="insight-actions">
                                            <button class="btn btn-outline"
                                                style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                                <i class="fas fa-chart-bar"></i> Xem chi tiết
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="insight-card warning">
                                    <div class="insight-header">
                                        <div class="insight-icon">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <h4>Cần chú ý</h4>
                                    </div>
                                    <div class="insight-content">
                                        <p>Tỷ lệ sử dụng xe điện giảm <strong>${electricDecrease}%</strong>.
                                            Xem xét điều chỉnh giá hoặc chương trình khuyến mãi.</p>
                                        <div class="insight-actions">
                                            <button class="btn btn-outline"
                                                style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                                <i class="fas fa-cog"></i> Điều chỉnh giá
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="insight-card">
                                    <div class="insight-header">
                                        <div class="insight-icon">
                                            <i class="fas fa-bullseye"></i>
                                        </div>
                                        <h4>Cơ hội kinh doanh</h4>
                                    </div>
                                    <div class="insight-content">
                                        <p><strong>${newCustomers} khách hàng mới</strong> trong tháng.
                                            Tỷ lệ giữ chân khách hàng cũ đạt ${retentionRate}%, cao hơn mục tiêu.</p>
                                        <div class="insight-actions">
                                            <button class="btn btn-outline"
                                                style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                                <i class="fas fa-gift"></i> Chương trình loyalty
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Export Section -->
                        <section class="export-section">
                            <div class="export-header">
                                <h3><i class="fas fa-file-export"></i> Xuất báo cáo</h3>
                                <p style="color: #666; margin-top: 0.5rem;">Chọn định dạng và xuất báo cáo chi tiết</p>
                            </div>

                            <div class="export-options">
                                <div class="export-option" data-format="pdf">
                                    <div class="export-icon" style="background: #e74c3c;">
                                        <i class="fas fa-file-pdf"></i>
                                    </div>
                                    <h4>PDF Report</h4>
                                    <p>Báo cáo chuyên nghiệp với biểu đồ và phân tích chi tiết</p>
                                </div>

                                <div class="export-option" data-format="excel">
                                    <div class="export-icon" style="background: #2ecc71;">
                                        <i class="fas fa-file-excel"></i>
                                    </div>
                                    <h4>Excel Data</h4>
                                    <p>Dữ liệu thô để phân tích sâu và xử lý thêm</p>
                                </div>

                                <div class="export-option" data-format="csv">
                                    <div class="export-icon" style="background: #3498db;">
                                        <i class="fas fa-file-csv"></i>
                                    </div>
                                    <h4>CSV Export</h4>
                                    <p>Định dạng đơn giản để nhập vào các hệ thống khác</p>
                                </div>

                                <div class="export-option" data-format="presentation">
                                    <div class="export-icon" style="background: #9b59b6;">
                                        <i class="fas fa-file-powerpoint"></i>
                                    </div>
                                    <h4>Presentation</h4>
                                    <p>Bản trình bày với slide đẹp mắt cho meetings</p>
                                </div>
                            </div>

                            <div class="filter-actions" style="margin-top: 2rem;">
                                <button class="btn btn-primary" id="generateCustomReport">
                                    <i class="fas fa-magic"></i> Tạo báo cáo tùy chỉnh
                                </button>
                                <button class="btn btn-outline" id="viewReportHistory">
                                    <i class="fas fa-history"></i> Lịch sử báo cáo
                                </button>
                                <button class="btn btn-success" id="scheduleAutoReport">
                                    <i class="fas fa-robot"></i> Lên lịch tự động
                                </button>
                            </div>
                        </section>

                        <!-- Loading Overlay -->
                        <div class="modal" id="loadingModal" style="background: rgba(255, 255, 255, 0.9);">
                            <div class="modal-content"
                                style="max-width: 400px; background: transparent; box-shadow: none;">
                                <div class="modal-body" style="text-align: center;">
                                    <div class="spinner"
                                        style="width: 60px; height: 60px; border-width: 6px; margin: 0 auto 1.5rem;">
                                    </div>
                                    <h3 style="color: var(--primary); margin-bottom: 0.5rem;">Đang xử lý dữ liệu...</h3>
                                    <p style="color: #666;">Vui lòng đợi trong giây lát</p>
                                    <div id="loadingProgress" style="margin-top: 1rem; font-size: 0.9rem; color: #666;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Custom Report Modal -->
                        <div class="modal" id="customReportModal">
                            <div class="modal-content" style="max-width: 700px;">
                                <div class="modal-header">
                                    <h3><i class="fas fa-magic"></i> Tạo báo cáo tùy chỉnh</h3>
                                    <button class="close-modal" id="closeCustomModal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <form id="customReportForm"
                                        action="${pageContext.request.contextPath}/admin/reports/export" method="POST">
                                        <div style="display: grid; gap: 1.5rem;">
                                            <div class="filter-group">
                                                <label>Tên báo cáo *</label>
                                                <input type="text" id="reportName" name="reportName"
                                                    placeholder="Nhập tên báo cáo..." style="width: 100%;" required>
                                            </div>

                                            <div class="filter-group">
                                                <label>Chọn chỉ số</label>
                                                <div
                                                    style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem;">
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="revenue" checked>
                                                        Doanh
                                                        thu
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="bookings" checked>
                                                        Số
                                                        đơn đặt
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="vehicles" checked>
                                                        Hiệu
                                                        suất xe
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="customers"> Khách
                                                        hàng
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="utilization"> Tỷ lệ
                                                        sử
                                                        dụng
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="metrics" value="profit"> Lợi nhuận
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="filter-group">
                                                <label>Định dạng xuất</label>
                                                <div style="display: flex; gap: 1rem;">
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="radio" name="format" value="pdf" checked> PDF
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="radio" name="format" value="excel"> Excel
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="radio" name="format" value="both"> Cả hai
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="filter-group">
                                                <label>Tùy chọn nâng cao</label>
                                                <div style="display: grid; gap: 0.5rem;">
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="includeCharts" id="includeCharts">
                                                        Bao
                                                        gồm biểu đồ
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="includeInsights"
                                                            id="includeInsights">
                                                        Bao gồm insights
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <input type="checkbox" name="scheduleReport"
                                                            id="scheduleReport">
                                                        Lên lịch gửi hàng tuần
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-outline" id="cancelCustomReport">Hủy</button>
                                    <button class="btn btn-primary" id="generateCustomReportBtn" type="submit"
                                        form="customReportForm">Tạo báo cáo</button>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
                    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
                    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/vn.js"></script>
                    <script>
                        // Chart instances
                        let revenueChart;
                        let bookingsChart;
                        let currentChartType = 'revenue-monthly';
                        let currentBookingsChartType = 'bookings-status';

                        // DOM Elements
                        const loadingModal = document.getElementById('loadingModal');
                        const customReportModal = document.getElementById('customReportModal');
                        let isGeneratingReport = false;

                        // Format currency (client-side fallback)
                        function formatCurrency(amount) {
                            if (amount >= 1000000) {
                                return (amount / 1000000).toFixed(1) + 'M ₫';
                            }
                            return new Intl.NumberFormat('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }).format(amount);
                        }

                        // Format percentage
                        function formatPercentage(value) {
                            return `\${value.toFixed(1)}%`;
                        }

                        // Show loading
                        function showLoading(message = 'Đang xử lý...') {
                            loadingModal.classList.add('active');
                            document.getElementById('loadingProgress').textContent = message;
                        }

                        // Hide loading
                        function hideLoading() {
                            loadingModal.classList.remove('active');
                        }

                        // Initialize revenue chart
                        function initRevenueChart(chartType = 'revenue-monthly') {
                            const ctx = document.getElementById('revenueChart').getContext('2d');

                            // Destroy existing chart
                            if (revenueChart) {
                                revenueChart.destroy();
                            }

                            // Get data from server (simplified version)
                            // In real application, you would fetch this via AJAX
                            let labels, data;

                            if (chartType === 'revenue-monthly') {
                                labels = ${ chartMonths };
                                data = ${ chartRevenue };
                            } else if (chartType === 'revenue-quarterly') {
                                labels = ['Q1', 'Q2', 'Q3', 'Q4'];
                                data = [106.4, 124.3, 142.1, 155.2];
                            } else {
                                labels = ['2019', '2020', '2021', '2022', '2023'];
                                data = [380.5, 410.2, 485.7, 520.3, 580.1];
                            }

                            revenueChart = new Chart(ctx, {
                                type: 'line',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        label: 'Doanh thu (triệu VNĐ)',
                                        data: data,
                                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                                        borderColor: '#3498db',
                                        borderWidth: 3,
                                        tension: 0.4,
                                        fill: true,
                                        pointBackgroundColor: '#3498db',
                                        pointBorderColor: '#ffffff',
                                        pointBorderWidth: 2,
                                        pointRadius: 6,
                                        pointHoverRadius: 8
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            display: true,
                                            position: 'top'
                                        },
                                        tooltip: {
                                            mode: 'index',
                                            intersect: false,
                                            callbacks: {
                                                label: function (context) {
                                                    return `Doanh thu: \${formatCurrency(context.parsed.y * 1000000)}`;
                                                }
                                            }
                                        }
                                    },
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            title: {
                                                display: true,
                                                text: 'Triệu VNĐ'
                                            },
                                            ticks: {
                                                callback: function (value) {
                                                    return value + 'M';
                                                }
                                            }
                                        },
                                        x: {
                                            grid: {
                                                display: false
                                            }
                                        }
                                    },
                                    interaction: {
                                        intersect: false,
                                        mode: 'index'
                                    }
                                }
                            });
                        }

                        // Initialize bookings chart
                        function initBookingsChart(chartType = 'bookings-status') {
                            const ctx = document.getElementById('bookingsChart').getContext('2d');

                            // Destroy existing chart
                            if (bookingsChart) {
                                bookingsChart.destroy();
                            }

                            let chartConfig;

                            if (chartType === 'bookings-status') {
                                const statusLabels = ['Chờ xác nhận', 'Đã xác nhận', 'Đang hoạt động', 'Đã hoàn thành', 'Đã hủy'];
                                const statusData = [12, 45, 8, 115, 7];
                                const statusColors = ['#f39c12', '#3498db', '#2ecc71', '#95a5a6', '#e74c3c'];

                                chartConfig = {
                                    type: 'doughnut',
                                    data: {
                                        labels: statusLabels,
                                        datasets: [{
                                            data: statusData,
                                            backgroundColor: statusColors,
                                            borderWidth: 2,
                                            borderColor: '#ffffff'
                                        }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {
                                                position: 'right'
                                            },
                                            tooltip: {
                                                callbacks: {
                                                    label: function (context) {
                                                        const total = statusData.reduce((a, b) => a + b, 0);
                                                        const percentage = Math.round((context.parsed / total) * 100);
                                                        return `${context.label}: ${context.parsed} đơn (${percentage}%)`;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                };
                            } else if (chartType === 'bookings-category') {
                                const categoryLabels = ['Xe máy', 'Xe điện', 'Ô tô'];
                                const categoryData = [185, 65, 255];
                                const categoryColors = ['#3498db', '#2ecc71', '#e74c3c'];

                                chartConfig = {
                                    type: 'bar',
                                    data: {
                                        labels: categoryLabels,
                                        datasets: [{
                                            label: 'Doanh thu (triệu VNĐ)',
                                            data: categoryData,
                                            backgroundColor: categoryColors,
                                            borderWidth: 1
                                        }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {
                                                display: false
                                            }
                                        },
                                        scales: {
                                            y: {
                                                beginAtZero: true,
                                                title: {
                                                    display: true,
                                                    text: 'Triệu VNĐ'
                                                },
                                                ticks: {
                                                    callback: function (value) {
                                                        return value + 'M';
                                                    }
                                                }
                                            }
                                        }
                                    }
                                };
                            } else {
                                const trendLabels = ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6',
                                    'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'];
                                const trendData = [145, 158, 168, 172, 175, 187,
                                    195, 192, 198, 205, 212, 220];

                                chartConfig = {
                                    type: 'line',
                                    data: {
                                        labels: trendLabels,
                                        datasets: [{
                                            label: 'Số đơn đặt',
                                            data: trendData,
                                            borderColor: '#9b59b6',
                                            backgroundColor: 'rgba(155, 89, 182, 0.1)',
                                            borderWidth: 3,
                                            tension: 0.4,
                                            fill: true
                                        }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {
                                                position: 'top'
                                            }
                                        },
                                        scales: {
                                            y: {
                                                beginAtZero: true,
                                                title: {
                                                    display: true,
                                                    text: 'Số đơn'
                                                }
                                            }
                                        }
                                    }
                                };
                            }

                            bookingsChart = new Chart(ctx, chartConfig);
                        }

                        // Initialize all charts
                        function initializeCharts() {
                            initRevenueChart(currentChartType);
                            initBookingsChart(currentBookingsChartType);
                        }

                        // Export report in different formats
                        function exportReport(format) {
                            const formats = {
                                pdf: { name: 'PDF', icon: 'file-pdf', color: '#e74c3c' },
                                excel: { name: 'Excel', icon: 'file-excel', color: '#2ecc71' },
                                csv: { name: 'CSV', icon: 'file-csv', color: '#3498db' },
                                presentation: { name: 'Presentation', icon: 'file-powerpoint', color: '#9b59b6' }
                            };

                            const formatInfo = formats[format];
                            if (!formatInfo) return;

                            showLoading(`Đang xuất báo cáo ${formatInfo.name}...`);

                            // Submit export request
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/reports/export';

                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'format';
                            input.value = format;
                            form.appendChild(input);

                            document.body.appendChild(form);
                            form.submit();
                        }

                        // Initialize
                        document.addEventListener('DOMContentLoaded', () => {
                            // Initialize charts
                            initializeCharts();

                            // Initialize DataTables
                            $('#revenueTable, #categoryTable').DataTable({
                                language: {
                                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json'
                                },
                                pageLength: 10,
                                responsive: true
                            });

                            // Initialize Flatpickr
                            flatpickr("#reportDateRange", {
                                mode: "range",
                                locale: "vn",
                                dateFormat: "d/m/Y",
                                placeholder: "Chọn khoảng thời gian..."
                            });

                            // Initialize Select2
                            $('#reportCategory, #reportMetrics').select2({
                                width: '100%',
                                placeholder: 'Chọn...'
                            });

                            // Chart type switchers
                            document.querySelectorAll('[data-chart]').forEach(btn => {
                                btn.addEventListener('click', function () {
                                    const chartType = this.dataset.chart;

                                    // Remove active class from all buttons
                                    this.parentElement.querySelectorAll('.chart-btn').forEach(b => b.classList.remove('active'));

                                    // Add active class to clicked button
                                    this.classList.add('active');

                                    // Update and reinitialize chart
                                    if (chartType.startsWith('revenue-')) {
                                        currentChartType = chartType;
                                        initRevenueChart(chartType);
                                    } else if (chartType.startsWith('bookings-')) {
                                        currentBookingsChartType = chartType;
                                        initBookingsChart(chartType);
                                    }
                                });
                            });

                            // Report period change
                            document.getElementById('reportPeriod').addEventListener('change', function () {
                                const period = this.value;
                                const dateRange = document.getElementById('reportDateRange');

                                if (period === 'custom') {
                                    dateRange.disabled = false;
                                    dateRange.style.opacity = '1';
                                } else {
                                    dateRange.disabled = true;
                                    dateRange.style.opacity = '0.6';
                                }
                            });

                            // Generate report button
                            document.getElementById('generateReport').addEventListener('click', function (e) {
                                showLoading('Đang phân tích dữ liệu...');
                                // Form will submit normally
                            });

                            // Refresh reports button
                            document.getElementById('refreshReports').addEventListener('click', async () => {
                                showLoading('Đang làm mới dữ liệu...');

                                // Reload the page to get fresh data
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1000);
                            });

                            // Export all button
                            document.getElementById('exportAllBtn').addEventListener('click', () => {
                                exportReport('pdf');
                            });

                            // Export options
                            document.querySelectorAll('.export-option').forEach(option => {
                                option.addEventListener('click', function () {
                                    const format = this.dataset.format;
                                    exportReport(format);
                                });
                            });

                            // Export Excel buttons
                            document.querySelectorAll('.export-excel').forEach(btn => {
                                btn.addEventListener('click', function () {
                                    const type = this.dataset.type;
                                    showLoading(`Đang xuất dữ liệu ${type}...`);

                                    const form = document.createElement('form');
                                    form.method = 'POST';
                                    form.action = '${pageContext.request.contextPath}/admin/reports/export-excel';

                                    const input = document.createElement('input');
                                    input.type = 'hidden';
                                    input.name = 'type';
                                    input.value = type;
                                    form.appendChild(input);

                                    document.body.appendChild(form);
                                    form.submit();
                                });
                            });

                            // Generate custom report button
                            document.getElementById('generateCustomReport').addEventListener('click', () => {
                                customReportModal.classList.add('active');
                            });

                            // Custom report modal buttons
                            document.getElementById('closeCustomModal').addEventListener('click', () => {
                                customReportModal.classList.remove('active');
                            });

                            document.getElementById('cancelCustomReport').addEventListener('click', () => {
                                customReportModal.classList.remove('active');
                            });

                            // Reset filters button
                            document.getElementById('resetFilters').addEventListener('click', () => {
                                // Reset form
                                document.getElementById('reportFilterForm').reset();
                                $('.select2').val(null).trigger('change');

                                // Reload page with default parameters
                                window.location.href = '${pageContext.request.contextPath}/admin/reports';
                            });

                            // Save report template
                            document.getElementById('saveReportTemplate').addEventListener('click', () => {
                                const templateName = prompt('Nhập tên cho mẫu báo cáo:');
                                if (templateName) {
                                    showLoading('Đang lưu mẫu báo cáo...');

                                    // Send AJAX request to save template
                                    fetch('${pageContext.request.contextPath}/admin/reports/save-template', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                        body: `name=${encodeURIComponent(templateName)}&period=${document.getElementById('reportPeriod').value}&category=${document.getElementById('reportCategory').value}&metrics=${document.getElementById('reportMetrics').value}`
                                    })
                                        .then(response => response.json())
                                        .then(data => {
                                            hideLoading();
                                            if (data.success) {
                                                alert(`Mẫu báo cáo "${templateName}" đã được lưu thành công!`);
                                            } else {
                                                alert('Có lỗi xảy ra khi lưu mẫu báo cáo.');
                                            }
                                        })
                                        .catch(error => {
                                            hideLoading();
                                            alert('Có lỗi xảy ra khi lưu mẫu báo cáo.');
                                        });
                                }
                            });

                            // Schedule report
                            document.getElementById('scheduleReport').addEventListener('click', () => {
                                alert('Tính năng lên lịch báo cáo đang được phát triển!');
                            });

                            // View report history
                            document.getElementById('viewReportHistory').addEventListener('click', () => {
                                window.location.href = '${pageContext.request.contextPath}/admin/reports/history';
                            });

                            // Schedule auto report
                            document.getElementById('scheduleAutoReport').addEventListener('click', () => {
                                alert('Tính năng lên lịch báo cáo tự động đang được phát triển!');
                            });

                            // Close modals when clicking outside
                            [loadingModal, customReportModal].forEach(modal => {
                                modal.addEventListener('click', (e) => {
                                    if (e.target === modal) {
                                        modal.classList.remove('active');
                                    }
                                });
                            });
                        });
                    </script>
                </body>

                </html>