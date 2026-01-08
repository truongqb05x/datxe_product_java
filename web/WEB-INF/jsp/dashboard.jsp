<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>RentCar Admin - Dashboard</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/dashboard.css">
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
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
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
                                <button class="mobile-menu-btn" id="mobileMenuBtn">
                                    <i class="fas fa-bars"></i>
                                </button>
                                <h1>Dashboard</h1>
                                <p>Xin chào ${sessionScope.user.fullName}, đây là tổng quan hệ thống</p>
                            </div>


                        </header>

                        <!-- Stats Cards -->
                        <div class="stats-cards">
                            <div class="stat-card">
                                <div class="stat-icon icon-revenue">
                                    <i class="fas fa-money-bill-wave"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>DOANH THU THÁNG</h3>
                                    <div class="stat-value">
                                        <fmt:formatNumber value="${dashboardStats.monthlyRevenue}" type="currency"
                                            currencySymbol="₫" maxFractionDigits="0" />
                                    </div>
                                    <div
                                        class="stat-change ${dashboardStats.revenueChange >= 0 ? 'positive' : 'negative'}">
                                        <i
                                            class="fas fa-${dashboardStats.revenueChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${Math.abs(dashboardStats.revenueChange)}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon icon-bookings">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>ĐƠN ĐẶT XE</h3>
                                    <div class="stat-value">${dashboardStats.totalBookings}</div>
                                    <div
                                        class="stat-change ${dashboardStats.bookingChange >= 0 ? 'positive' : 'negative'}">
                                        <i
                                            class="fas fa-${dashboardStats.bookingChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${Math.abs(dashboardStats.bookingChange)}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon icon-vehicles">
                                    <i class="fas fa-car"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>XE ĐANG HOẠT ĐỘNG</h3>
                                    <div class="stat-value">${dashboardStats.activeVehicles}</div>
                                    <div
                                        class="stat-change ${dashboardStats.maintenanceVehicles > 0 ? 'negative' : 'positive'}">
                                        <i
                                            class="fas fa-${dashboardStats.maintenanceVehicles > 0 ? 'arrow-down' : 'arrow-up'}"></i>
                                        <span>${dashboardStats.maintenanceVehicles} xe đang bảo trì</span>
                                    </div>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon icon-users">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>NGƯỜI DÙNG MỚI</h3>
                                    <div class="stat-value">${dashboardStats.newUsers}</div>
                                    <div
                                        class="stat-change ${dashboardStats.userChange >= 0 ? 'positive' : 'negative'}">
                                        <i
                                            class="fas fa-${dashboardStats.userChange >= 0 ? 'arrow-up' : 'arrow-down'}"></i>
                                        <span>${Math.abs(dashboardStats.userChange)}% so với tháng trước</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Charts and Recent Activities -->
                        <div class="charts-row">
                            <div class="chart-container">
                                <div class="chart-header">
                                    <h3>DOANH THU THEO THÁNG</h3>
                                    <div class="chart-actions">
                                        <button class="chart-btn active" data-chart="monthly">Tháng</button>
                                        <button class="chart-btn" data-chart="quarterly">Quý</button>
                                        <button class="chart-btn" data-chart="yearly">Năm</button>
                                    </div>
                                </div>
                                <div class="chart-wrapper">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>

                            <div class="recent-container">
                                <div class="recent-header">
                                    <h3>HOẠT ĐỘNG GẦN ĐÂY</h3>
                                    <button class="btn-refresh" id="refreshActivities">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                                <ul class="recent-list" id="recentActivitiesList">
                                    <c:forEach var="activity" items="${recentActivities}">
                                        <li class="recent-item">
                                            <div class="recent-icon icon-${activity.type}">
                                                <i class="fas fa-${activity.icon}"></i>
                                            </div>
                                            <div class="recent-info">
                                                <h4>${activity.title}</h4>
                                                <p>${activity.details}</p>
                                            </div>
                                            <div class="recent-time">${activity.time}</div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>

                        <!-- Tables -->
                        <div class="tables-row">
                            <div class="table-container">
                                <div class="table-header">
                                    <h3>ĐƠN ĐẶT XE GẦN ĐÂY</h3>
                                    <a href="${pageContext.request.contextPath}/admin/bookings" class="btn-view-all">Xem
                                        tất
                                        cả <i class="fas fa-arrow-right"></i></a>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Mã đơn</th>
                                            <th>Khách hàng</th>
                                            <th>Xe</th>
                                            <th>Ngày thuê</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="recentBookingsTable">
                                        <c:forEach var="booking" items="${recentBookings}">
                                            <tr>
                                                <td>${booking.code}</td>
                                                <td>${booking.customerName}</td>
                                                <td>${booking.vehicleName}</td>
                                                <td>${booking.rentalPeriod}</td>
                                                <td>
                                                    <fmt:formatNumber value="${booking.totalAmount}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                                            <span class="status-badge status-confirmed">Đã xác
                                                                nhận</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'PENDING'}">
                                                            <span class="status-badge status-pending">Chờ xác
                                                                nhận</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'COMPLETED'}">
                                                            <span class="status-badge status-completed">Hoàn
                                                                thành</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'CANCELLED'}">
                                                            <span class="status-badge status-cancelled">Đã hủy</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'ACTIVE'}">
                                                            <span class="status-badge status-active">Đang hoạt
                                                                động</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/bookings/${booking.id}"
                                                        class="btn-view">Xem</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="table-container">
                                <div class="table-header">
                                    <h3>XE ĐƯỢC THUÊ NHIỀU NHẤT</h3>
                                    <a href="${pageContext.request.contextPath}/admin/vehicles" class="btn-view-all">Xem
                                        tất
                                        cả <i class="fas fa-arrow-right"></i></a>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Xe</th>
                                            <th>Số lần thuê</th>
                                            <th>Doanh thu</th>
                                            <th>Đánh giá</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody id="popularVehiclesTable">
                                        <c:forEach var="vehicle" items="${popularVehicles}">
                                            <tr>
                                                <td>
                                                    <strong>${vehicle.name}</strong><br>
                                                    <small>Biển số: ${vehicle.licensePlate}</small>
                                                </td>
                                                <td>${vehicle.rentalCount}</td>
                                                <td>
                                                    <fmt:formatNumber value="${vehicle.revenue}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </td>
                                                <td>⭐ ${vehicle.rating} (${vehicle.reviewCount})</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${vehicle.status == 'AVAILABLE'}">
                                                            <span class="status-badge status-confirmed">Đang hoạt
                                                                động</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'MAINTENANCE'}">
                                                            <span class="status-badge status-pending">Bảo trì</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'RENTED'}">
                                                            <span class="status-badge status-active">Đang thuê</span>
                                                        </c:when>
                                                        <c:when test="${vehicle.status == 'UNAVAILABLE'}">
                                                            <span class="status-badge status-cancelled">Không khả
                                                                dụng</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="footer">
                            <p>© 2023 RentCar Admin Dashboard. Phiên bản ${appVersion} | <span
                                    id="currentDateTime"></span>
                            </p>
                        </footer>
                    </main>



                    <script>
                        // Initialize data from server
                        const dashboardData = {
                            monthlyRevenue: ${ monthlyRevenueData },
                            quarterlyRevenue: ${ quarterlyRevenueData },
                            yearlyRevenue: ${ yearlyRevenueData }
        };

                        // DOM Elements
                        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
                        const sidebar = document.getElementById('sidebar');
                        const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
                        const chartBtns = document.querySelectorAll('.chart-btn');
                        const currentDateTime = document.getElementById('currentDateTime');

                        const refreshActivitiesBtn = document.getElementById('refreshActivities');

                        // Mobile menu toggle
                        mobileMenuBtn.addEventListener('click', () => {
                            sidebar.classList.toggle('active');
                        });

                        // Dropdown toggle for sidebar
                        dropdownToggles.forEach(toggle => {
                            toggle.addEventListener('click', (e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                const targetId = toggle.getAttribute('data-target');
                                const dropdown = document.getElementById(targetId);

                                // Close other dropdowns
                                document.querySelectorAll('.nav-dropdown.show').forEach(d => {
                                    if (d.id !== targetId) {
                                        d.classList.remove('show');
                                        d.previousElementSibling.classList.remove('collapsed');
                                    }
                                });

                                toggle.classList.toggle('collapsed');
                                dropdown.classList.toggle('show');
                            });
                        });



                        // Close dropdowns when clicking outside
                        document.addEventListener('click', (e) => {
                            // Close sidebar on mobile
                            if (window.innerWidth <= 992) {
                                if (!sidebar.contains(e.target) && !mobileMenuBtn.contains(e.target)) {
                                    sidebar.classList.remove('active');
                                }
                            }



                            // Close sidebar dropdowns
                            if (!e.target.closest('.nav-item')) {
                                document.querySelectorAll('.nav-dropdown.show').forEach(dropdown => {
                                    dropdown.classList.remove('show');
                                    dropdown.previousElementSibling.classList.remove('collapsed');
                                });
                            }
                        });

                        // Chart initialization
                        let revenueChart;

                        function initChart(chartType = 'monthly') {
                            const ctx = document.getElementById('revenueChart').getContext('2d');

                            // Destroy existing chart
                            if (revenueChart) {
                                revenueChart.destroy();
                            }

                            let labels, data, label;

                            switch (chartType) {
                                case 'monthly':
                                    labels = ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'];
                                    data = dashboardData.monthlyRevenue;
                                    label = 'Doanh thu theo tháng (triệu VNĐ)';
                                    break;
                                case 'quarterly':
                                    labels = ['Q1', 'Q2', 'Q3', 'Q4'];
                                    data = dashboardData.quarterlyRevenue;
                                    label = 'Doanh thu theo quý (triệu VNĐ)';
                                    break;
                                case 'yearly':
                                    labels = Object.keys(dashboardData.yearlyRevenue);
                                    data = Object.values(dashboardData.yearlyRevenue);
                                    label = 'Doanh thu theo năm (triệu VNĐ)';
                                    break;
                            }

                            revenueChart = new Chart(ctx, {
                                type: 'line',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        label: label,
                                        data: data,
                                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                                        borderColor: '#3498db',
                                        borderWidth: 2,
                                        tension: 0.4,
                                        fill: true,
                                        pointBackgroundColor: '#3498db',
                                        pointBorderColor: '#ffffff',
                                        pointBorderWidth: 2,
                                        pointRadius: 4,
                                        pointHoverRadius: 6
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            display: true,
                                            position: 'top',
                                            labels: {
                                                usePointStyle: true,
                                                padding: 20
                                            }
                                        },
                                        tooltip: {
                                            mode: 'index',
                                            intersect: false,
                                            callbacks: {
                                                label: function (context) {
                                                    return `\${context.dataset.label}: \${context.parsed.y.toLocaleString('vi-VN')} triệu VNĐ`;
                                                }
                                            }
                                        }
                                    },
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                callback: function (value) {
                                                    return value.toLocaleString('vi-VN') + 'M';
                                                }
                                            },
                                            grid: {
                                                drawBorder: false
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

                        // Chart type switcher
                        chartBtns.forEach(btn => {
                            btn.addEventListener('click', () => {
                                chartBtns.forEach(b => b.classList.remove('active'));
                                btn.classList.add('active');
                                initChart(btn.getAttribute('data-chart'));
                            });
                        });

                        // Update current date and time
                        function updateDateTime() {
                            const now = new Date();
                            const options = {
                                weekday: 'long',
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit',
                                hour12: false
                            };
                            currentDateTime.textContent = now.toLocaleDateString('vi-VN', options);
                        }



                        // Search functionality
                        searchInput.addEventListener('keypress', (e) => {
                            if (e.key === 'Enter') {
                                const query = searchInput.value.trim();
                                if (query) {
                                    window.location.href = `${pageContext.request.contextPath}/admin/search?q=\${encodeURIComponent(query)}`;
                                }

                            }
                        });

                        // Refresh activities
                        refreshActivitiesBtn.addEventListener('click', () => {
                            refreshActivitiesBtn.classList.add('rotating');

                            fetch('${pageContext.request.contextPath}/admin/api/recent-activities')
                                .then(response => response.json())
                                .then(data => {
                                    const activitiesList = document.getElementById('recentActivitiesList');
                                    activitiesList.innerHTML = '';

                                    data.forEach(activity => {
                                        const li = document.createElement('li');
                                        li.className = 'recent-item';
                                        li.innerHTML = `
                            <div class="recent-icon icon-\${activity.type}">
                                <i class="fas fa-\${activity.icon}"></i>
                            </div>
                            <div class="recent-info">
                                <h4>\${activity.title}</h4>
                                <p>\${activity.details}</p>
                            </div>
                            <div class="recent-time">\${activity.time}</div>
                        `;
                                        activitiesList.appendChild(li);
                                    });
                                })
                                .catch(error => {
                                    console.error('Error refreshing activities:', error);
                                })
                                .finally(() => {
                                    setTimeout(() => {
                                        refreshActivitiesBtn.classList.remove('rotating');
                                    }, 500);
                                });
                        });

                        // Real-time updates (WebSocket simulation)
                        function connectWebSocket() {
                            // In a real application, you would use WebSocket
                            // Here we simulate with polling
                            setInterval(() => {


                                // Update stats occasionally
                                if (Math.random() > 0.8) { // 20% chance
                                    fetch('${pageContext.request.contextPath}/admin/api/dashboard-stats')
                                        .then(response => response.json())
                                        .then(stats => {
                                            // Update booking count
                                            const bookingStat = document.querySelector('.stat-card:nth-child(2) .stat-value');
                                            if (bookingStat) {
                                                bookingStat.textContent = stats.totalBookings;
                                            }
                                        });
                                }
                            }, 30000); // Update every 30 seconds
                        }

                        // Initialize dashboard
                        document.addEventListener('DOMContentLoaded', () => {
                            // Initialize chart
                            initChart();

                            // Update date/time
                            updateDateTime();
                            setInterval(updateDateTime, 1000);

                            // Load notifications


                            // Connect to real-time updates
                            connectWebSocket();



                            // Close modal when clicking outside


                            // Add animation to stat cards on load
                            document.querySelectorAll('.stat-card').forEach((card, index) => {
                                setTimeout(() => {
                                    card.classList.add('animate-in');
                                }, index * 100);
                            });

                            // Add hover effect to table rows
                            document.querySelectorAll('tbody tr').forEach(row => {
                                row.addEventListener('mouseenter', () => {
                                    row.style.backgroundColor = '#f8f9fa';
                                });
                                row.addEventListener('mouseleave', () => {
                                    row.style.backgroundColor = '';
                                });
                            });

                            // Initialize tooltips
                            document.querySelectorAll('[title]').forEach(element => {
                                element.addEventListener('mouseenter', (e) => {
                                    const title = e.target.getAttribute('title');
                                    if (title) {
                                        const tooltip = document.createElement('div');
                                        tooltip.className = 'custom-tooltip';
                                        tooltip.textContent = title;
                                        document.body.appendChild(tooltip);

                                        const rect = e.target.getBoundingClientRect();
                                        tooltip.style.left = `${rect.left + rect.width / 2 - tooltip.offsetWidth / 2}px`;
                                        tooltip.style.top = `${rect.top - tooltip.offsetHeight - 10}px`;

                                        e.target.setAttribute('data-tooltip', title);
                                        e.target.removeAttribute('title');
                                    }
                                });

                                element.addEventListener('mouseleave', (e) => {
                                    const tooltip = document.querySelector('.custom-tooltip');
                                    if (tooltip) {
                                        tooltip.remove();
                                    }
                                    const title = e.target.getAttribute('data-tooltip');
                                    if (title) {
                                        e.target.setAttribute('title', title);
                                        e.target.removeAttribute('data-tooltip');
                                    }
                                });
                            });
                        });

                        // Handle window resize
                        window.addEventListener('resize', () => {
                            if (window.innerWidth > 992) {
                                sidebar.classList.remove('active');
                            }
                            if (revenueChart) {
                                revenueChart.resize();
                            }
                        });
                    </script>
                </body>

                </html>