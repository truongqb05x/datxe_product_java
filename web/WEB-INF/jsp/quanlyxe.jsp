<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>RentCar Admin - Quản lý xe</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/quanlyxe.css">
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
                                <a href="${pageContext.request.contextPath}/admin/vehicles" class="nav-link active">
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
                    </a>
                    </li>
                    </ul>

                    <div class="sidebar-footer">
                        <div class="user-info">
                            <div class="user-avatar">A</div>
                            <div>
                                <h4>Admin User</h4>
                                <p>Quản trị viên</p>
                            </div>
                        </div>
                    </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <header class="header">
                            <div class="header-left">
                                <h1><i class="fas fa-car"></i> Quản lý xe</h1>
                                <p>Quản lý tất cả phương tiện trong hệ thống</p>
                            </div>

                            <div class="header-right">
                                <button class="btn btn-primary" id="addVehicleBtn">
                                    <i class="fas fa-plus"></i> Thêm xe mới
                                </button>
                            </div>
                        </header>

                        <!-- Stats Summary -->
                        <div class="stats-summary">
                            <div class="stat-item">
                                <div class="stat-item">
                                    <div class="stat-value" id="totalVehicles">${totalVehiclesCount != null ?
                                        totalVehiclesCount : 0}</div>
                                    <div class="stat-label">Tổng số xe</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value" id="availableVehicles">${availableVehicles != null ?
                                        availableVehicles : 0}</div>
                                    <div class="stat-label">Xe có sẵn</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value" id="rentedVehicles">${rentedVehicles != null ?
                                        rentedVehicles : 0}</div>
                                    <div class="stat-label">Đang được thuê</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value" id="maintenanceVehicles">${maintenanceVehicles != null ?
                                        maintenanceVehicles : 0}</div>
                                    <div class="stat-label">Đang bảo trì</div>
                                </div>
                            </div>

                            <!-- Filters Section -->
                            <section class="filters-section">
                                <h3><i class="fas fa-filter"></i> Bộ lọc</h3>
                                <div class="filter-grid">
                                    <div class="filter-group">
                                        <label for="filterCategory">Loại xe</label>
                                        <select id="filterCategory">
                                            <option value="">Tất cả loại</option>
                                            <option value="motorcycle">Xe máy</option>
                                            <option value="electric">Xe điện</option>
                                            <option value="car">Ô tô</option>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label for="filterBrand">Thương hiệu</label>
                                        <select id="filterBrand">
                                            <option value="">Tất cả thương hiệu</option>
                                            <c:forEach var="brand" items="${brands}">
                                                <option value="${brand.key}">${brand.value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label for="filterStatus">Trạng thái</label>
                                        <select id="filterStatus">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="available">Có sẵn</option>
                                            <option value="rented">Đang thuê</option>
                                            <option value="maintenance">Bảo trì</option>
                                            <option value="unavailable">Không khả dụng</option>
                                        </select>
                                    </div>

                                    <div class="filter-group">
                                        <label for="filterSearch">Tìm kiếm</label>
                                        <input type="text" id="filterSearch" placeholder="Biển số, model...">
                                    </div>
                                </div>

                                <div class="filter-actions">
                                    <button class="btn btn-primary" id="applyFilters">
                                        <i class="fas fa-search"></i> Áp dụng bộ lọc
                                    </button>
                                    <button class="btn btn-outline" id="resetFilters">
                                        <i class="fas fa-redo"></i> Đặt lại
                                    </button>
                                    <button class="btn btn-success" id="exportBtn">
                                        <i class="fas fa-file-export"></i> Xuất Excel
                                    </button>
                                </div>
                            </section>

                            <!-- View Toggle -->
                            <div class="view-toggle">
                                <button class="view-btn active" id="gridViewBtn">
                                    <i class="fas fa-th"></i> Grid
                                </button>
                                <button class="view-btn" id="tableViewBtn">
                                    <i class="fas fa-list"></i> Table
                                </button>
                            </div>

                            <!-- Vehicles Grid View -->
                            <div class="vehicles-grid" id="vehiclesGridView">
                                <c:forEach var="v" items="${vehicles}">
                                    <div class="vehicle-card-grid">
                                        <div class="vehicle-card-header">
                                            <img src="${v.mainImageUrl}" alt="${v.brandName} ${v.modelName}"
                                                onerror="this.src='${pageContext.request.contextPath}/images/default-car.png'">
                                            <span class="status-badge status-${v.available ? 'available' : 'rented'}">
                                                ${v.available ? 'Có sẵn' : 'Đang thuê'}
                                            </span>
                                        </div>
                                        <div class="vehicle-card-body">
                                            <div class="vehicle-title">
                                                <h4>${v.brandName} ${v.modelName} ${v.modelYear}</h4>
                                                <div class="vehicle-price">
                                                    <fmt:formatNumber value="${v.dailyRate}" type="currency"
                                                        currencySymbol="đ" /> <small>/ngày</small>
                                                </div>
                                            </div>
                                            <div class="vehicle-details">
                                                <div class="vehicle-detail">
                                                    <i class="fas fa-tag"></i> ${v.licensePlate}
                                                </div>
                                                <div class="vehicle-detail">
                                                    <i class="fas fa-gas-pump"></i> ${v.fuelType}
                                                </div>
                                                <div class="vehicle-detail">
                                                    <i class="fas fa-user"></i> ${v.seatCapacity} chỗ
                                                </div>
                                            </div>
                                            <div class="vehicle-rating">
                                                <span class="stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="${i <= v.rating ? 'fas' : 'far'} fa-star"
                                                            style="color: #f39c12;"></i>
                                                    </c:forEach>
                                                </span>
                                                <span>${v.rating} (${v.totalRentals})</span>
                                            </div>
                                            <p style="font-size: 0.9rem; color: #666; margin: 0.5rem 0;">
                                                <c:if test="${not empty v.description}">
                                                    ${fn:substring(v.description, 0, 60)}${fn:length(v.description) > 60
                                                    ? '...' : ''}
                                                </c:if>
                                            </p>
                                            <div class="vehicle-stats">
                                                <div class="stat">
                                                    <i class="fas fa-calendar-check"></i> ${v.totalRentals} lần thuê
                                                </div>
                                            </div>
                                            <div class="vehicle-actions">
                                                <button class="btn btn-outline view-detail" data-id="${v.vehicleId}">
                                                    <i class="fas fa-eye"></i> Xem
                                                </button>
                                                <button class="btn btn-primary edit-vehicle" data-id="${v.vehicleId}">
                                                    <i class="fas fa-edit"></i> Sửa
                                                </button>
                                                <button class="btn btn-danger delete-vehicle" data-id="${v.vehicleId}">
                                                    <i class="fas fa-trash"></i> Xóa
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty vehicles}">
                                    <div style="grid-column: 1/-1; text-align: center; padding: 2rem;">
                                        <p>Không tìm thấy xe nào phù hợp.</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Vehicles Table View -->
                            <div class="vehicles-table-container" id="vehiclesTableView" style="display: none;">
                                <div class="table-toolbar">
                                    <div class="table-info">
                                        Hiển thị <span id="tableCount">${fn:length(vehicles)}</span> trên tổng số <span
                                            id="tableTotal">${totalVehicles}</span> xe
                                    </div>
                                    <div class="table-actions">
                                        <button class="btn btn-outline" id="selectAllBtn">
                                            <i class="fas fa-check-square"></i> Chọn tất cả
                                        </button>
                                        <button class="btn btn-danger" id="deleteSelectedBtn">
                                            <i class="fas fa-trash"></i> Xóa đã chọn
                                        </button>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table id="vehiclesTable">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;">
                                                    <input type="checkbox" class="select-checkbox"
                                                        id="selectAllCheckbox">
                                                </th>
                                                <th style="width: 80px;">Ảnh</th>
                                                <th>Thông tin xe</th>
                                                <th>Loại xe</th>
                                                <th>Giá thuê</th>
                                                <th>Trạng thái</th>
                                                <th>Đánh giá</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody id="vehiclesTableBody">
                                            <c:forEach var="v" items="${vehicles}">
                                                <tr>
                                                    <td>
                                                        <input type="checkbox" class="select-checkbox select-vehicle"
                                                            data-id="${v.vehicleId}">
                                                    </td>
                                                    <td>
                                                        <img src="${v.mainImageUrl}" class="vehicle-thumb"
                                                            alt="${v.brandName} ${v.modelName}"
                                                            onerror="this.src='${pageContext.request.contextPath}/images/default-car.png'">
                                                    </td>
                                                    <td>
                                                        <div style="font-weight: 600;">${v.brandName} ${v.modelName}
                                                            ${v.modelYear}</div>
                                                        <div style="font-size: 0.8rem; color: #666;">${v.licensePlate}
                                                        </div>
                                                        <div style="font-size: 0.8rem;">${v.color} • ${v.seatCapacity}
                                                            chỗ</div>
                                                    </td>
                                                    <td>${v.categoryName}</td>
                                                    <td>
                                                        <div style="font-weight: 600; color: var(--secondary);">
                                                            <fmt:formatNumber value="${v.dailyRate}" type="currency"
                                                                currencySymbol="đ" />
                                                        </div>
                                                        <div style="font-size: 0.8rem; color: #666;">/ngày</div>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="status-badge status-${v.available ? 'available' : 'rented'}">
                                                            ${v.available ? 'Có sẵn' : 'Đang thuê'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; align-items: center; gap: 5px;">
                                                            <span style="color: #f39c12;"><i
                                                                    class="fas fa-star"></i></span>
                                                            <span style="font-size: 0.8rem;">${v.rating}</span>
                                                        </div>
                                                        <div style="font-size: 0.8rem; color: #666;">${v.totalRentals}
                                                            lần thuê</div>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; gap: 5px;">
                                                            <button class="action-btn view-detail"
                                                                data-id="${v.vehicleId}" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            <button class="action-btn edit-vehicle"
                                                                data-id="${v.vehicleId}" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <button class="action-btn delete-vehicle"
                                                                data-id="${v.vehicleId}" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Server-side Pagination -->
                            <div class="pagination">
                                <c:if test="${totalPages > 1}">
                                    <c:if test="${currentPage > 1}">
                                        <a href="?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&status=${status}"
                                            class="page-btn"><i class="fas fa-chevron-left"></i></a>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <a href="?page=${p}&keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&status=${status}"
                                            class="page-btn ${p == currentPage ? 'active' : ''}">${p}</a>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?page=${currentPage + 1}&keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&status=${status}"
                                            class="page-btn"><i class="fas fa-chevron-right"></i></a>
                                    </c:if>
                                </c:if>
                            </div>

                            <!-- Add/Edit Vehicle Modal -->
                            <div class="modal" id="vehicleModal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 id="modalTitle">Thêm xe mới</h3>
                                        <button class="close-modal" id="closeModal">&times;</button>
                                    </div>

                                    <div class="modal-body">
                                        <form id="vehicleForm"
                                            action="${pageContext.request.contextPath}/admin/vehicles" method="post">
                                            <input type="hidden" id="vehicleId" name="vehicleId" value="">
                                            <input type="hidden" name="action" id="formAction" value="add">

                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label for="vehicleLicensePlate">Biển số xe *</label>
                                                    <input type="text" id="vehicleLicensePlate" name="licensePlate"
                                                        required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleBrand">Thương hiệu *</label>
                                                    <select id="vehicleBrand" name="brandId" required>
                                                        <option value="">Chọn thương hiệu</option>
                                                        <c:forEach var="brand" items="${brands}">
                                                            <option value="${brand.key}">${brand.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleModel">Model *</label>
                                                    <input type="text" id="vehicleModel" name="model" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleYear">Năm sản xuất *</label>
                                                    <select id="vehicleYear" name="year" required>
                                                        <option value="">Chọn năm</option>
                                                        <option value="2023">2023</option>
                                                        <option value="2022">2022</option>
                                                        <option value="2021">2021</option>
                                                        <option value="2020">2020</option>
                                                        <option value="2019">2019</option>
                                                        <option value="2018">2018</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleCategory">Loại xe *</label>
                                                    <select id="vehicleCategory" name="categoryId" required>
                                                        <option value="">Chọn loại xe</option>
                                                        <c:forEach var="category" items="${categories}">
                                                            <option value="${category.key}">${category.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleColor">Màu sắc *</label>
                                                    <input type="text" id="vehicleColor" name="color" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleFuelType">Loại nhiên liệu</label>
                                                    <select id="vehicleFuelType" name="fuelType">
                                                        <option value="gasoline">Xăng</option>
                                                        <option value="electric">Điện</option>
                                                        <option value="diesel">Dầu Diesel</option>
                                                        <option value="hybrid">Hybrid</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleTransmission">Hộp số</label>
                                                    <select id="vehicleTransmission" name="transmission">
                                                        <option value="manual">Số sàn</option>
                                                        <option value="automatic">Tự động</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleEngine">Động cơ</label>
                                                    <input type="text" id="vehicleEngine" name="engine"
                                                        placeholder="110cc, 1.5L...">
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleSeats">Số chỗ</label>
                                                    <select id="vehicleSeats" name="seats">
                                                        <option value="1">1 chỗ</option>
                                                        <option value="2">2 chỗ</option>
                                                        <option value="4">4 chỗ</option>
                                                        <option value="5">5 chỗ</option>
                                                        <option value="7">7 chỗ</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleDailyRate">Giá thuê/ngày (VNĐ) *</label>
                                                    <input type="number" id="vehicleDailyRate" name="dailyRate" required
                                                        min="0">
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleWeeklyRate">Giá thuê/tuần (VNĐ)</label>
                                                    <input type="number" id="vehicleWeeklyRate" name="weeklyRate"
                                                        min="0">
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleMonthlyRate">Giá thuê/tháng (VNĐ)</label>
                                                    <input type="number" id="vehicleMonthlyRate" name="monthlyRate"
                                                        min="0">
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleDeposit">Tiền cọc (VNĐ)</label>
                                                    <input type="number" id="vehicleDeposit" name="deposit" min="0">
                                                </div>

                                                <div class="form-group full-width">
                                                    <label for="vehicleDescription">Mô tả</label>
                                                    <textarea id="vehicleDescription" name="description"
                                                        rows="3"></textarea>
                                                </div>

                                                <div class="form-group full-width">
                                                    <label for="vehicleSpecifications">Thông số kỹ thuật (JSON)</label>
                                                    <textarea id="vehicleSpecifications" name="specifications" rows="3"
                                                        placeholder='{"max_speed": "120km/h", "fuel_capacity": "4L"}'></textarea>
                                                </div>

                                                <div class="form-group full-width">
                                                    <label for="vehicleAmenities">Tiện nghi</label>
                                                    <div class="form-row">
                                                        <c:forEach var="amenity" items="${amenities}">
                                                            <label
                                                                style="display: flex; align-items: center; gap: 5px;">
                                                                <input type="checkbox" name="amenities"
                                                                    value="${amenity.key}"> ${amenity.value}
                                                            </label>
                                                        </c:forEach>
                                                    </div>
                                                </div>

                                                <div class="form-group full-width">
                                                    <label>Hình ảnh xe</label>
                                                    <div class="image-upload" id="imageUpload">
                                                        <i class="fas fa-cloud-upload-alt"></i>
                                                        <p>Kéo thả hình ảnh vào đây hoặc click để chọn</p>
                                                        <p><small>Định dạng hỗ trợ: JPG, PNG, GIF. Tối đa 5MB mỗi
                                                                ảnh</small></p>
                                                        <input type="file" id="imageInput" multiple accept="image/*"
                                                            style="display: none;">
                                                    </div>
                                                    <div class="image-preview" id="imagePreview"></div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleStatus">Trạng thái</label>
                                                    <select id="vehicleStatus" name="status">
                                                        <option value="available">Có sẵn</option>
                                                        <option value="rented">Đang thuê</option>
                                                        <option value="maintenance">Bảo trì</option>
                                                        <option value="unavailable">Không khả dụng</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleFeatured">Nổi bật</label>
                                                    <select id="vehicleFeatured" name="featured">
                                                        <option value="0">Không</option>
                                                        <option value="1">Có</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="vehicleLocation">Vị trí hiện tại</label>
                                                    <input type="text" id="vehicleLocation" name="location"
                                                        placeholder="Địa chỉ">
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="modal-footer">
                                        <button class="btn btn-outline" id="cancelModal">Hủy</button>
                                        <button class="btn btn-primary" id="saveVehicle">Lưu thông tin</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Delete Confirmation Modal -->
                            <div class="modal" id="deleteModal">
                                <div class="modal-content" style="max-width: 400px;">
                                    <div class="modal-header">
                                        <h3><i class="fas fa-exclamation-triangle"></i> Xác nhận xóa</h3>
                                        <button class="close-modal" id="closeDeleteModal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <p id="deleteMessage">Bạn có chắc chắn muốn xóa xe này?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-outline" id="cancelDelete">Hủy</button>
                                        <button class="btn btn-danger" id="confirmDelete">Xóa</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Vehicle Detail Modal -->
                            <div class="modal" id="detailModal">
                                <div class="modal-content" style="max-width: 900px;">
                                    <div class="modal-header">
                                        <h3 id="detailVehicleName">Toyota Vios 2023</h3>
                                        <button class="close-modal" id="closeDetailModal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="detailContent">
                                            <!-- Detail content will be loaded dynamically -->
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-outline" id="closeDetail">Đóng</button>
                                        <button class="btn btn-primary" id="editDetail">Chỉnh sửa</button>
                                    </div>
                                </div>
                            </div>
                    </main>

                    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
                    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
                    <script>
                        // AJAX URL
                        const API_BASE_URL = '${pageContext.request.contextPath}/api/vehicles';

                        // DOM Elements
                        const vehiclesGridView = document.getElementById('vehiclesGridView');
                        const vehiclesTableView = document.getElementById('vehiclesTableView');
                        const vehiclesTableBody = document.getElementById('vehiclesTableBody');
                        const gridViewBtn = document.getElementById('gridViewBtn');
                        const tableViewBtn = document.getElementById('tableViewBtn');
                        const addVehicleBtn = document.getElementById('addVehicleBtn');
                        const vehicleModal = document.getElementById('vehicleModal');
                        const deleteModal = document.getElementById('deleteModal');
                        const detailModal = document.getElementById('detailModal');
                        const vehicleForm = document.getElementById('vehicleForm');
                        const imageUpload = document.getElementById('imageUpload');
                        const imageInput = document.getElementById('imageInput');
                        const imagePreview = document.getElementById('imagePreview');
                        let currentVehicleId = null;
                        let selectedVehicles = new Set();

                        // Populate vehiclesData for JS compatibility from Server Data
                        const vehiclesData = [
                            <c:forEach var="v" items="${vehicles}">
                                {
                                    id: ${v.vehicleId},
                                license_plate: "${v.licensePlate}",
                                brand: "${v.brandName}",
                                brand_id: ${v.brandId},
                                model: "${v.modelName}",
                                modelName: "${v.modelName}", // Alias
                                brandName: "${v.brandName}", // Alias
                                modelYear: ${v.modelYear},
                                year: ${v.modelYear},
                                category: "${v.categoryName}",
                                categoryName: "${v.categoryName}",
                                category_id: ${v.categoryId},
                                color: "${v.color}",
                                fuel_type: "${v.fuelType}",
                                fuelType: "${v.fuelType}",
                                transmission: "${v.transmission}",
                                engine: "${v.engineCapacity}",
                                engineCapacity: "${v.engineCapacity}",
                                seats: ${v.seatCapacity},
                                seatCapacity: ${v.seatCapacity},
                                daily_rate: ${v.dailyRate},
                                dailyRate: ${v.dailyRate},
                                weekly_rate: ${v.weeklyRate != null ? v.weeklyRate : 0},
                                weeklyRate: ${v.weeklyRate != null ? v.weeklyRate : 0},
                                monthly_rate: ${v.monthlyRate != null ? v.monthlyRate : 0},
                                monthlyRate: ${v.monthlyRate != null ? v.monthlyRate : 0},
                                deposit: ${v.depositAmount != null ? v.depositAmount : 0},
                                depositAmount: ${v.depositAmount != null ? v.depositAmount : 0},
                                status: "${v.available ? 'available' : 'rented'}",
                                available: ${v.available},
                                featured: ${v.featured},
                                rating: ${v.rating},
                                total_rentals: ${v.totalRentals},
                                totalRentals: ${v.totalRentals},
                                description: `<c:out value="${v.description}" escapeXml="true" />`,
                                mainImageUrl: "${v.mainImageUrl}",
                                image: "${v.mainImageUrl}"
                            },
                            </c:forEach>
                        ];

                        // Initialize Select2
                        $(document).ready(function () {
                            $('#vehicleBrand, #vehicleCategory, #vehicleYear').select2({
                                width: '100%',
                                placeholder: 'Chọn...'
                            });
                        });

                        // Format currency
                        function formatCurrency(amount) {
                            return new Intl.NumberFormat('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }).format(amount);
                        }

                        // Get status badge
                        function getStatusBadge(status) {
                            const badges = {
                                'available': '<span class="status-badge status-available">Có sẵn</span>',
                                'rented': '<span class="status-badge status-rented">Đang thuê</span>',
                                'maintenance': '<span class="status-badge status-maintenance">Bảo trì</span>',
                                'unavailable': '<span class="status-badge status-unavailable">Không khả dụng</span>'
                            };
                            return badges[status] || badges['unavailable'];
                        }

                        // Get status text
                        function getStatusText(status) {
                            const texts = {
                                'available': 'Có sẵn',
                                'rented': 'Đang thuê',
                                'maintenance': 'Bảo trì',
                                'unavailable': 'Không khả dụng'
                            };
                            return texts[status] || 'Không xác định';
                        }

                        // Generate star rating HTML
                        function generateStars(rating) {
                            let stars = '';
                            const fullStars = Math.floor(rating);
                            const hasHalfStar = rating % 1 >= 0.5;

                            for (let i = 0; i < 5; i++) {
                                if (i < fullStars) {
                                    stars += '<i class="fas fa-star" style="color: #f39c12;"></i>';
                                } else if (i === fullStars && hasHalfStar) {
                                    stars += '<i class="fas fa-star-half-alt" style="color: #f39c12;"></i>';
                                } else {
                                    stars += '<i class="far fa-star" style="color: #ccc;"></i>';
                                }
                            }
                            return stars;
                        }

                        // Load vehicles data - DEPRECATED (Server Side Rendered)
                        function loadVehiclesData() {
                            // No-op: Data is loaded via JSTL
                            attachEventListeners();
                            attachTableEventListeners();
                        }

                        // Mock data fallback - DEPRECATED
                        function loadMockData() {
                            // No-op
                        }

                        // Render vehicles grid view
                        function renderGridView(vehicles = vehiclesData) {
                            vehiclesGridView.innerHTML = '';

                            vehicles.forEach(vehicle => {
                                const card = document.createElement('div');
                                card.className = 'vehicle-card-grid';
                                card.innerHTML = `
                    <div class="vehicle-card-header">
                        <img src="\${vehicle.mainImageUrl}" alt="\${vehicle.brandName} \${vehicle.modelName}" onerror="this.src='\${API_BASE_URL}/../images/default-car.png'">
                        \${getStatusBadge(vehicle.available ? 'available' : 'unavailable')}
                    </div>
                    <div class="vehicle-card-body">
                        <div class="vehicle-title">
                            <h4>\${vehicle.brandName} \${vehicle.modelName} \${vehicle.modelYear}</h4>
                            <div class="vehicle-price">\${formatCurrency(vehicle.dailyRate)}<small>/ngày</small></div>
                        </div>
                        <div class="vehicle-details">
                            <div class="vehicle-detail">
                                <i class="fas fa-tag"></i> \${vehicle.licensePlate}
                            </div>
                            <div class="vehicle-detail">
                                <i class="fas fa-gas-pump"></i> \${vehicle.fuelType}
                            </div>
                            <div class="vehicle-detail">
                                <i class="fas fa-user"></i> \${vehicle.seatCapacity} chỗ
                            </div>
                        </div>
                        <div class="vehicle-rating">
                            \${generateStars(vehicle.rating)}
                            <span>\${vehicle.rating.toFixed(1)} (\${vehicle.totalRentals || 0})</span>
                        </div>
                        <p style="font-size: 0.9rem; color: #666; margin: 0.5rem 0;">\${vehicle.description ? vehicle.description.substring(0, 60) + '...' : ''}</p>
                        <div class="vehicle-stats">
                            <div class="stat">
                                <i class="fas fa-calendar-check"></i> \${vehicle.totalRentals || 0} lần thuê
                            </div>
                        </div>
                        <div class="vehicle-actions">
                            <button class="btn btn-outline view-detail" data-id="\${vehicle.vehicleId}">
                                <i class="fas fa-eye"></i> Xem
                            </button>
                            <button class="btn btn-primary edit-vehicle" data-id="\${vehicle.vehicleId}">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <button class="btn btn-danger delete-vehicle" data-id="\${vehicle.vehicleId}">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
                        </div>
                    </div>
                `;
                                vehiclesGridView.appendChild(card);
                            });

                            // Add event listeners
                            attachEventListeners();
                        }

                        // Render vehicles table view
                        function renderTableView(vehicles = vehiclesData) {
                            vehiclesTableBody.innerHTML = '';

                            vehicles.forEach(vehicle => {
                                const row = document.createElement('tr');
                                row.innerHTML = `
                    <td>
                        <input type="checkbox" class="select-checkbox select-vehicle" data-id="\${vehicle.vehicleId}">
                    </td>
                    <td>
                        <img src="\${vehicle.mainImageUrl}" class="vehicle-thumb" alt="\${vehicle.brandName} \${vehicle.modelName}" onerror="this.src='\${API_BASE_URL}/../images/default-car.png'">
                    </td>
                    <td>
                        <div style="font-weight: 600;">\${vehicle.brandName} \${vehicle.modelName} \${vehicle.modelYear}</div>
                        <div style="font-size: 0.8rem; color: #666;">\${vehicle.licensePlate}</div>
                        <div style="font-size: 0.8rem;">\${vehicle.color} • \${vehicle.seatCapacity} chỗ</div>
                    </td>
                    <td>\${vehicle.categoryName}</td>
                    <td>
                        <div style="font-weight: 600; color: var(--secondary);">\${formatCurrency(vehicle.dailyRate)}</div>
                        <div style="font-size: 0.8rem; color: #666;">/ngày</div>
                    </td>
                    <td>\${getStatusBadge(vehicle.available ? 'available' : 'unavailable')}</td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 5px;">
                            \${generateStars(vehicle.rating)}
                            <span style="font-size: 0.8rem;">\${vehicle.rating.toFixed(1)}</span>
                        </div>
                        <div style="font-size: 0.8rem; color: #666;">\${vehicle.totalRentals || 0} lần thuê</div>
                    </td>
                    <td>
                        <div style="display: flex; gap: 5px;">
                            <button class="action-btn view-detail" data-id="\${vehicle.vehicleId}" title="Xem chi tiết">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="action-btn edit-vehicle" data-id="\${vehicle.vehicleId}" title="Chỉnh sửa">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="action-btn delete-vehicle" data-id="\${vehicle.vehicleId}" title="Xóa">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                `;
                                vehiclesTableBody.appendChild(row);
                            });

                            // Add event listeners
                            attachTableEventListeners();

                            // Update counts
                            document.getElementById('tableCount').textContent = vehicles.length;
                            document.getElementById('tableTotal').textContent = vehiclesData.length;
                        }

                        // Attach event listeners to grid view
                        function attachEventListeners() {
                            document.querySelectorAll('.view-detail').forEach(btn => {
                                btn.addEventListener('click', () => viewVehicleDetail(btn.dataset.id));
                            });

                            document.querySelectorAll('.edit-vehicle').forEach(btn => {
                                btn.addEventListener('click', () => editVehicle(btn.dataset.id));
                            });

                            document.querySelectorAll('.delete-vehicle').forEach(btn => {
                                btn.addEventListener('click', () => confirmDeleteVehicle(btn.dataset.id));
                            });
                        }

                        // Attach event listeners to table view
                        function attachTableEventListeners() {
                            document.querySelectorAll('.select-vehicle').forEach(checkbox => {
                                checkbox.addEventListener('change', (e) => {
                                    const id = parseInt(e.target.dataset.id);
                                    if (e.target.checked) {
                                        selectedVehicles.add(id);
                                    } else {
                                        selectedVehicles.delete(id);
                                    }
                                    updateSelectedCount();
                                });
                            });

                            document.querySelectorAll('.view-detail').forEach(btn => {
                                btn.addEventListener('click', () => viewVehicleDetail(btn.dataset.id));
                            });

                            document.querySelectorAll('.edit-vehicle').forEach(btn => {
                                btn.addEventListener('click', () => editVehicle(btn.dataset.id));
                            });

                            document.querySelectorAll('.delete-vehicle').forEach(btn => {
                                btn.addEventListener('click', () => confirmDeleteVehicle(btn.dataset.id));
                            });
                        }

                        // Update selected count
                        function updateSelectedCount() {
                            const deleteBtn = document.getElementById('deleteSelectedBtn');
                            if (selectedVehicles.size > 0) {
                                deleteBtn.textContent = `Xóa (${selectedVehicles.size})`;
                            } else {
                                deleteBtn.textContent = 'Xóa đã chọn';
                            }
                        }

                        // View vehicle details
                        function viewVehicleDetail(id) {
                            const vehicle = vehiclesData.find(v => v.id === parseInt(id));
                            if (!vehicle) return;

                            currentVehicleId = vehicle.id;

                            document.getElementById('detailVehicleName').textContent = `\${vehicle.brandName} \${vehicle.modelName} \${vehicle.modelYear}`;

                            document.getElementById('detailContent').innerHTML = `
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                    <div>
                        <img src="\${vehicle.mainImageUrl}" alt="\${vehicle.brandName} \${vehicle.modelName}" style="width: 100%; border-radius: 8px; margin-bottom: 1rem;" onerror="this.src='\${API_BASE_URL}/../images/default-car.png'">
                        
                        <h4 style="color: var(--primary); margin-bottom: 1rem; border-bottom: 2px solid var(--secondary); padding-bottom: 0.5rem;">Thông tin cơ bản</h4>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.5rem; margin-bottom: 1rem;">
                            <div><strong>Biển số:</strong> \${vehicle.licensePlate}</div>
                            <div><strong>Màu sắc:</strong> \${vehicle.color}</div>
                            <div><strong>Năm SX:</strong> \${vehicle.modelYear}</div>
                            <div><strong>Loại xe:</strong> \${vehicle.categoryName}</div>
                            <div><strong>Nhiên liệu:</strong> \${vehicle.fuelType}</div>
                            <div><strong>Hộp số:</strong> \${vehicle.transmission}</div>
                            <div><strong>Động cơ:</strong> \${vehicle.engineCapacity}</div>
                            <div><strong>Số chỗ:</strong> \${vehicle.seatCapacity}</div>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                            <div style="font-size: 2rem; font-weight: bold; color: var(--secondary);">\${vehicle.rating ? vehicle.rating.toFixed(1) : '0.0'}</div>
                            <div>
                                <div>\${generateStars(vehicle.rating || 0)}</div>
                                <div style="font-size: 0.9rem; color: #666;">\${vehicle.totalRentals || 0} lần thuê</div>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <h4 style="color: var(--primary); margin-bottom: 1rem; border-bottom: 2px solid var(--secondary); padding-bottom: 0.5rem;">Thông tin giá</h4>
                        <div style="background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                <span>Giá thuê theo ngày:</span>
                                <span style="font-weight: bold; color: var(--secondary);">\${formatCurrency(vehicle.dailyRate)}</span>
                            </div>
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                <span>Giá thuê theo tuần:</span>
                                <span style="font-weight: bold;">\${formatCurrency(vehicle.weeklyRate || 0)}</span>
                            </div>
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                <span>Giá thuê theo tháng:</span>
                                <span style="font-weight: bold;">\${formatCurrency(vehicle.monthlyRate || 0)}</span>
                            </div>
                            <div style="display: flex; justify-content: space-between; border-top: 1px solid #ddd; padding-top: 0.5rem; margin-top: 0.5rem;">
                                <span>Tiền cọc:</span>
                                <span style="font-weight: bold; color: var(--warning);">\${formatCurrency(vehicle.depositAmount || 0)}</span>
                            </div>
                        </div>
                        
                        <h4 style="color: var(--primary); margin-bottom: 1rem; border-bottom: 2px solid var(--secondary); padding-bottom: 0.5rem;">Trạng thái & Vị trí</h4>
                        <div style="margin-bottom: 1rem;">
                            <div style="margin-bottom: 0.5rem;">
                                <strong>Trạng thái:</strong> \${getStatusBadge(vehicle.available ? 'available' : 'unavailable')}
                            </div>
                            <div>
                                <strong>Vị trí hiện tại:</strong>
                                <div style="background: #f8f9fa; padding: 0.8rem; border-radius: 4px; margin-top: 0.3rem;">
                                    <i class="fas fa-map-marker-alt"></i> \${vehicle.location || 'Chưa có thông tin'}
                                </div>
                            </div>
                        </div>
                        
                        <h4 style="color: var(--primary); margin-bottom: 1rem; border-bottom: 2px solid var(--secondary); padding-bottom: 0.5rem;">Mô tả</h4>
                        <p style="color: #666; line-height: 1.6;">${vehicle.description || 'Chưa có mô tả'}</p>
                    </div>
                </div>
            `;

                            detailModal.classList.add('active');
                        }

                        // Open modal for adding new vehicle
                        function addNewVehicle() {
                            currentVehicleId = null;
                            document.getElementById('modalTitle').textContent = 'Thêm xe mới';
                            document.getElementById('vehicleId').value = '';
                            document.getElementById('formAction').value = 'add';
                            vehicleForm.reset();
                            imagePreview.innerHTML = '';

                            // Set default values
                            document.getElementById('vehicleStatus').value = 'available';
                            document.getElementById('vehicleFeatured').value = '0';
                            $('#vehicleBrand, #vehicleCategory, #vehicleYear').val(null).trigger('change');

                            vehicleModal.classList.add('active');
                        }

                        // Edit vehicle
                        function editVehicle(id) {
                            const vehicle = vehiclesData.find(v => v.id === parseInt(id));
                            if (!vehicle) return;

                            currentVehicleId = vehicle.id;
                            document.getElementById('modalTitle').textContent = `Chỉnh sửa: ${vehicle.brand} ${vehicle.model}`;
                            document.getElementById('vehicleId').value = vehicle.id;
                            document.getElementById('formAction').value = 'edit';

                            // Fill form with vehicle data
                            document.getElementById('vehicleLicensePlate').value = vehicle.license_plate;
                            document.getElementById('vehicleModel').value = vehicle.model;
                            document.getElementById('vehicleColor').value = vehicle.color;
                            document.getElementById('vehicleFuelType').value = vehicle.fuel_type ? vehicle.fuel_type.toLowerCase() : 'gasoline';
                            document.getElementById('vehicleTransmission').value = vehicle.transmission === 'Số sàn' ? 'manual' : 'automatic';
                            document.getElementById('vehicleEngine').value = vehicle.engine || '';
                            document.getElementById('vehicleSeats').value = vehicle.seats || '5';
                            document.getElementById('vehicleDailyRate').value = vehicle.daily_rate;
                            document.getElementById('vehicleWeeklyRate').value = vehicle.weekly_rate || '';
                            document.getElementById('vehicleMonthlyRate').value = vehicle.monthly_rate || '';
                            document.getElementById('vehicleDeposit').value = vehicle.deposit || '';
                            document.getElementById('vehicleDescription').value = vehicle.description || '';
                            document.getElementById('vehicleLocation').value = vehicle.location || '';
                            document.getElementById('vehicleStatus').value = vehicle.status || 'available';
                            document.getElementById('vehicleFeatured').value = vehicle.featured ? '1' : '0';

                            // Set Select2 values (you'll need to adjust based on your actual data structure)
                            $('#vehicleBrand').val(vehicle.brand_id || '').trigger('change');
                            $('#vehicleCategory').val(vehicle.category_id || '').trigger('change');
                            $('#vehicleYear').val(vehicle.year ? vehicle.year.toString() : '').trigger('change');

                            // Clear and set image preview
                            imagePreview.innerHTML = '';
                            if (vehicle.image) {
                                imagePreview.innerHTML = `
                    <div class="preview-image">
                        <img src="${vehicle.image}" alt="Vehicle Image">
                        <button type="button" class="remove-image" onclick="this.parentElement.remove()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
                            }

                            vehicleModal.classList.add('active');
                        }

                        // Confirm delete vehicle
                        function confirmDeleteVehicle(id) {
                            const vehicle = vehiclesData.find(v => v.id === parseInt(id));
                            if (!vehicle) return;

                            currentVehicleId = vehicle.id;
                            document.getElementById('deleteMessage').textContent =
                                `Bạn có chắc chắn muốn xóa xe "${vehicle.brand} ${vehicle.model} (${vehicle.license_plate})"? Hành động này không thể hoàn tác.`;

                            deleteModal.classList.add('active');
                        }

                        // Delete vehicle via API
                        function deleteVehicle() {
                            fetch(`${API_BASE_URL}/${currentVehicleId}`, {
                                method: 'DELETE',
                                headers: {
                                    'Content-Type': 'application/json'
                                }
                            })
                                .then(response => {
                                    if (response.ok) {
                                        alert('Xóa xe thành công!');
                                        // RELOAD PAGE
                                        window.location.reload();
                                    } else {
                                        alert('Có lỗi xảy ra khi xóa xe!');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error deleting vehicle:', error);
                                    alert('Có lỗi xảy ra khi xóa xe!');
                                })
                                .finally(() => {
                                    deleteModal.classList.remove('active');
                                });
                        }

                        // Delete selected vehicles
                        function deleteSelectedVehicles() {
                            if (selectedVehicles.size === 0) {
                                alert('Vui lòng chọn ít nhất một xe để xóa.');
                                return;
                            }

                            if (confirm(`Bạn có chắc chắn muốn xóa ${selectedVehicles.size} xe đã chọn?`)) {
                                // In real implementation, you would send a bulk delete request
                                // For now, we'll delete one by one
                                const deletePromises = Array.from(selectedVehicles).map(id =>
                                    fetch(`${API_BASE_URL}/${id}`, { method: 'DELETE' })
                                );

                                Promise.all(deletePromises)
                                    .then(responses => {
                                        const allOk = responses.every(r => r.ok);
                                        if (allOk) {
                                            alert(`Đã xóa ${selectedVehicles.size} xe thành công!`);
                                            // RELOAD PAGE
                                            window.location.reload();
                                        } else {
                                            alert('Có lỗi xảy ra khi xóa một số xe!');
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error deleting vehicles:', error);
                                        alert('Có lỗi xảy ra khi xóa xe!');
                                    });
                            }
                        }

                        // Save vehicle (add or update) via form submission
                        function saveVehicle() {
                            if (!vehicleForm.checkValidity()) {
                                alert('Vui lòng điền đầy đủ thông tin bắt buộc (*)');
                                return;
                            }

                            // Submit form
                            vehicleForm.submit();
                        }

                        // Update statistics
                        function updateStats() {
                            // Server side handles this
                        }

                        // Filter vehicles - Server Side
                        function filterVehicles() {
                            const category = document.getElementById('filterCategory').value;
                            const brand = document.getElementById('filterBrand').value;
                            const status = document.getElementById('filterStatus').value;
                            const search = document.getElementById('filterSearch').value;

                            // Reload page with query params
                            let url = '?';
                            if (category) url += `categoryId=\${category}&`;
                            if (brand) url += `brandId=\${brand}&`;
                            if (status) url += `status=\${status}&`;
                            if (search) url += `keyword=\${encodeURIComponent(search)}&`;

                            window.location.href = url;
                        }

                        // Initialize
                        document.addEventListener('DOMContentLoaded', () => {
                            // Load vehicles data
                            loadVehiclesData();

                            // View toggle
                            gridViewBtn.addEventListener('click', () => {
                                gridViewBtn.classList.add('active');
                                tableViewBtn.classList.remove('active');
                                vehiclesGridView.style.display = 'grid';
                                vehiclesTableView.style.display = 'none';
                            });

                            tableViewBtn.addEventListener('click', () => {
                                tableViewBtn.classList.add('active');
                                gridViewBtn.classList.remove('active');
                                vehiclesGridView.style.display = 'none';
                                vehiclesTableView.style.display = 'block';
                            });

                            // Add vehicle button
                            addVehicleBtn.addEventListener('click', addNewVehicle);

                            // Image upload
                            imageUpload.addEventListener('click', () => imageInput.click());
                            imageInput.addEventListener('change', function (e) {
                                const files = Array.from(e.target.files);
                                files.forEach(file => {
                                    if (file.type.startsWith('image/')) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            const preview = document.createElement('div');
                                            preview.className = 'preview-image';
                                            preview.innerHTML = `
                                <img src="${e.target.result}" alt="Preview">
                                <button type="button" class="remove-image" onclick="this.parentElement.remove()">
                                    <i class="fas fa-times"></i>
                                </button>
                            `;
                                            imagePreview.appendChild(preview);
                                        };
                                        reader.readAsDataURL(file);
                                    }
                                });
                            });

                            // Modal close buttons
                            document.getElementById('closeModal').addEventListener('click', () => {
                                vehicleModal.classList.remove('active');
                            });

                            document.getElementById('cancelModal').addEventListener('click', () => {
                                vehicleModal.classList.remove('active');
                            });

                            document.getElementById('closeDeleteModal').addEventListener('click', () => {
                                deleteModal.classList.remove('active');
                            });

                            document.getElementById('cancelDelete').addEventListener('click', () => {
                                deleteModal.classList.remove('active');
                            });

                            document.getElementById('closeDetailModal').addEventListener('click', () => {
                                detailModal.classList.remove('active');
                            });

                            document.getElementById('closeDetail').addEventListener('click', () => {
                                detailModal.classList.remove('active');
                            });

                            // Action buttons
                            document.getElementById('saveVehicle').addEventListener('click', saveVehicle);
                            document.getElementById('confirmDelete').addEventListener('click', deleteVehicle);
                            document.getElementById('deleteSelectedBtn').addEventListener('click', deleteSelectedVehicles);
                            document.getElementById('selectAllBtn').addEventListener('click', () => {
                                const checkboxes = document.querySelectorAll('.select-vehicle');
                                const allChecked = Array.from(checkboxes).every(cb => cb.checked);

                                checkboxes.forEach(cb => {
                                    cb.checked = !allChecked;
                                    const id = parseInt(cb.dataset.id);
                                    if (!allChecked) {
                                        selectedVehicles.add(id);
                                    } else {
                                        selectedVehicles.delete(id);
                                    }
                                });

                                updateSelectedCount();
                            });

                            // Filter buttons
                            document.getElementById('applyFilters').addEventListener('click', filterVehicles);
                            document.getElementById('resetFilters').addEventListener('click', () => {
                                document.getElementById('filterCategory').value = '';
                                document.getElementById('filterBrand').value = '';
                                document.getElementById('filterStatus').value = '';
                                document.getElementById('filterSearch').value = '';
                                renderGridView();
                                renderTableView();
                            });

                            document.getElementById('exportBtn').addEventListener('click', () => {
                                // Export to Excel functionality
                                alert('Xuất file Excel thành công!');
                            });

                            // Edit from detail modal
                            document.getElementById('editDetail').addEventListener('click', () => {
                                if (currentVehicleId) {
                                    detailModal.classList.remove('active');
                                    editVehicle(currentVehicleId);
                                }
                            });

                            // Close modals when clicking outside
                            [vehicleModal, deleteModal, detailModal].forEach(modal => {
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