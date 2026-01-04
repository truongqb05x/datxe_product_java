<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thuê Xe Máy - RentCar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/xemay.css">
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
                    <li><a href="${pageContext.request.contextPath}/xemay.jsp" class="active">Thuê Xe máy</a></li>
                    <li><a href="${pageContext.request.contextPath}/xeoto.jsp">Thuê Ô tô</a></li>
                    <li><a href="${pageContext.request.contextPath}/datxe.jsp">Đặt Xe</a></li>
                    <li><a href="${pageContext.request.contextPath}/timkiem.jsp">Tìm Kiếm</a></li>
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
                <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/xemay.jsp" class="active">Xe máy</a></li>
                <li><a href="${pageContext.request.contextPath}/xeoto.jsp">Ô tô</a></li>
                <li><a href="${pageContext.request.contextPath}/datxe.jsp">Đặt Xe</a></li>
                <li><a href="${pageContext.request.contextPath}/timkiem.jsp">Tìm Kiếm</a></li>
                <li><a href="${pageContext.request.contextPath}/yeuthich.jsp">Yêu Thích</a></li>
                <li>
                    <div class="auth-buttons-mobile" id="authButtonsMobile">
                        <button class="btn btn-outline" id="loginBtnMobile" style="width: 100%; margin-bottom: 0.5rem;">Đăng nhập</button>
                        <button class="btn btn-primary" id="registerBtnMobile" style="width: 100%;">Đăng ký</button>
                    </div>
                    <div class="user-avatar-mobile" id="userAvatarMobile" style="display: none;">
                        <div class="avatar-placeholder">U</div>
                        <div class="user-info">
                            <p>Xin chào, <span id="mobileUserName">Người dùng</span></p>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline" style="width: 100%; margin-top: 0.5rem;">Đăng xuất</a>
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
            <li>Xe máy</li>
        </ul>
    </div>

    <!-- Page Header -->
    <section class="page-header">
        <h1>Danh Mục Xe Máy</h1>
        <p>Khám phá bộ sưu tập xe máy đa dạng của chúng tôi, từ xe phổ thông đến cao cấp, phù hợp với mọi nhu cầu di chuyển của bạn.</p>
    </section>

    <!-- Filter & Sort Section -->
    <section class="filter-sort-section">
        <div class="filter-options">
            <div class="filter-group">
                <label for="brand-filter">Hãng xe</label>
                <select id="brand-filter">
                    <option value="">Tất cả hãng</option>
                    <option value="honda">Honda</option>
                    <option value="yamaha">Yamaha</option>
                    <option value="suzuki">Suzuki</option>
                    <option value="sym">SYM</option>
                    <option value="piaggio">Piaggio</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="type-filter">Loại xe</label>
                <select id="type-filter">
                    <option value="">Tất cả loại</option>
                    <option value="scooter">Xe tay ga</option>
                    <option value="sport">Xe thể thao</option>
                    <option value="underbone">Xe số</option>
                    <option value="cruiser">Xe cruiser</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="price-filter">Mức giá</label>
                <select id="price-filter">
                    <option value="">Tất cả giá</option>
                    <option value="0-100">Dưới 100.000đ</option>
                    <option value="100-150">100.000đ - 150.000đ</option>
                    <option value="150-200">150.000đ - 200.000đ</option>
                    <option value="200-250">200.000đ - 250.000đ</option>
                    <option value="250+">Trên 250.000đ</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="capacity-filter">Phân khối</label>
                <select id="capacity-filter">
                    <option value="">Tất cả</option>
                    <option value="50-110">50cc - 110cc</option>
                    <option value="110-150">110cc - 150cc</option>
                    <option value="150+">Trên 150cc</option>
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

    <!-- Motorcycles Grid -->
    <section class="motorcycles-section">
        <div class="motorcycles-grid">
            <!-- Honda Vision -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                    <div class="motorcycle-tag">Phổ biến</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Honda Vision</h3>
                    
                    <!-- Rating System -->
                    <div class="motorcycle-rating">
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
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Tự động</span>
                    </div>
                    <div class="motorcycle-price">150.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('honda-vision')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
                            <span>👥 15 người đang xem</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Yamaha Exciter -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                    <div class="motorcycle-tag">Thể thao</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Yamaha Exciter</h3>
                    
                    <div class="motorcycle-rating">
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
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Số sàn</span>
                    </div>
                    <div class="motorcycle-price">180.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('yamaha-exciter')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
            
            <!-- Honda SH -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda SH">
                    <div class="motorcycle-tag">Cao cấp</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Honda SH</h3>
                    
                    <div class="motorcycle-rating">
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
                        </div>
                    </div>
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Tự động</span>
                    </div>
                    <div class="motorcycle-price">250.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('honda-sh')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
                            <span>👥 8 người đang xem</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Yamaha Sirius -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Sirius">
                    <div class="motorcycle-tag">Tiết kiệm</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Yamaha Sirius</h3>
                    
                    <div class="motorcycle-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <span>4.0 (76 đánh giá)</span>
                        </div>
                        <div class="rating-badges">
                            <span class="badge eco-friendly">♻️ Tiết kiệm</span>
                        </div>
                    </div>
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Số sàn</span>
                    </div>
                    <div class="motorcycle-price">120.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('yamaha-sirius')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
            
            <!-- Honda Wave -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda Wave">
                    <div class="motorcycle-tag">Bền bỉ</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Honda Wave</h3>
                    
                    <div class="motorcycle-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span>4.5 (142 đánh giá)</span>
                        </div>
                        <div class="rating-badges">
                            <span class="badge eco-friendly">♻️ Bền bỉ</span>
                        </div>
                    </div>
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Số sàn</span>
                    </div>
                    <div class="motorcycle-price">100.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('honda-wave')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
            
            <!-- Piaggio Liberty -->
            <div class="motorcycle-card">
                <div class="motorcycle-img">
                    <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Piaggio Liberty">
                    <div class="motorcycle-tag">Phong cách</div>
                </div>
                <div class="motorcycle-content">
                    <h3>Piaggio Liberty</h3>
                    
                    <div class="motorcycle-rating">
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
                    
                    <div class="motorcycle-details">
                        <span><i class="fas fa-gas-pump"></i> Xăng</span>
                        <span><i class="fas fa-user"></i> 2 người</span>
                        <span><i class="fas fa-cog"></i> Tự động</span>
                    </div>
                    <div class="motorcycle-price">200.000đ <span>/ngày</span></div>
                    
                    <button class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;" onclick="openVehicleModal('piaggio-liberty')">Chi tiết xe</button>
                    <button class="btn btn-outline" style="width: 100%;" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
                    
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
                            <span>👥 7 người đang xem</span>
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
                <h2 id="modalVehicleName">Honda Vision 2023</h2>
                <div class="motorcycle-rating">
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
                                <span class="spec-label">Khóa thông minh:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Chống trộm:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Cốp rộng:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Đèn LED:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Phanh ABS:</span>
                                <span class="spec-value">✓ Có</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Hệ thống chống bó cứng phanh:</span>
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
                        <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/pages/datxe.jsp'">Thuê ngay</button>
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

        // Wrap all DOM-related code in DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function() {

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

        // Check if user is logged in (for demo purposes)
        let isLoggedIn = false;
        let currentUser = null;

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
            // Server-side validation will handle authentication
        });
        
        registerForm.addEventListener('submit', (e) => {
            // Let the form submit normally to the server
            // Server-side validation will handle registration
        });

        // Update UI after login
        function updateUIAfterLogin() {
            if (isLoggedIn && currentUser) {
                // Update avatar placeholder with first letter of name
                avatarPlaceholder.textContent = currentUser.name.charAt(0).toUpperCase();
                
                // Show user avatar, hide auth buttons
                userAvatar.style.display = 'block';
                authButtons.style.display = 'none';
                
                // Update mobile menu
                userAvatarMobile.style.display = 'block';
                authButtonsMobile.style.display = 'none';
                document.getElementById('mobileUserName').textContent = currentUser.name;
            }
        }

        // Logout functionality
        function logout() {
            // Redirect to logout servlet
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

        // Vehicle Modal Functions
        const vehicleModal = document.getElementById('vehicleModal');
        const closeModal = document.getElementById('closeModal');
        
        function openVehicleModal(vehicleId) {
            // Hiển thị loading trong modal
            vehicleModal.style.display = 'block';
            document.body.style.overflow = 'hidden';
            
            // Giả lập loading 2 giây
            setTimeout(() => {
                // Cập nhật thông tin xe dựa trên vehicleId
                updateModalContent(vehicleId);
            }, 2000);
        }
        
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
                'honda-sh': {
                    name: 'Honda SH 150i',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Tự động',
                    engine: '150cc',
                    color: 'Trắng, Đen, Xám',
                    basePrice: '250.000đ',
                    insuranceFee: '50.000đ',
                    serviceFee: '30.000đ',
                    totalPrice: '330.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
                'yamaha-sirius': {
                    name: 'Yamaha Sirius',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Số sàn',
                    engine: '115cc',
                    color: 'Đỏ, Xanh, Đen',
                    basePrice: '120.000đ',
                    insuranceFee: '25.000đ',
                    serviceFee: '15.000đ',
                    totalPrice: '160.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
                },
                'honda-wave': {
                    name: 'Honda Wave RSX',
                    type: 'Xe máy',
                    fuel: 'Xăng',
                    seats: '2 người',
                    gear: 'Số sàn',
                    engine: '110cc',
                    color: 'Đỏ, Xanh, Bạc',
                    basePrice: '100.000đ',
                    insuranceFee: '20.000đ',
                    serviceFee: '10.000đ',
                    totalPrice: '130.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
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
                    serviceFee: '25.000đ',
                    totalPrice: '265.000đ',
                    mainImage: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'
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
        }
        
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

        // Filter Functionality
        const brandFilter = document.getElementById('brand-filter');
        const typeFilter = document.getElementById('type-filter');
        const priceFilter = document.getElementById('price-filter');
        const capacityFilter = document.getElementById('capacity-filter');
        const sortBy = document.getElementById('sort-by');

        function applyFilters() {
            // Logic for filtering and sorting motorcycles
            console.log('Applying filters...');
            // In a real application, this would make an API call or filter the displayed items
        }

        brandFilter.addEventListener('change', applyFilters);
        typeFilter.addEventListener('change', applyFilters);
        priceFilter.addEventListener('change', applyFilters);
        capacityFilter.addEventListener('change', applyFilters);
        sortBy.addEventListener('change', applyFilters);

        // Pagination
        document.querySelectorAll('.pagination button').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.pagination button').forEach(btn => {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
                // In a real application, this would load the corresponding page
            });
        });

        // Share functionality
        document.querySelectorAll('.btn-share').forEach(button => {
            button.addEventListener('click', function() {
                if (navigator.share) {
                    navigator.share({
                        title: 'Thuê xe máy - RentCar',
                        text: 'Xem xe máy chất lượng cao tại RentCar',
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
        }); // End of DOMContentLoaded
    </script>
</body>
</html>