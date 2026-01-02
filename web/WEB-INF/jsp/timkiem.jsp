<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Tìm Kiếm - RentCar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="stylesheet" href="../../static/css/pages/timkiem.css">
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
                    <li><a href="index.html">Trang chủ</a></li>
                    <li><a href="#" class="active">Kết quả tìm kiếm</a></li>
                    <li><a href="#">Thuê Xe máy</a></li>
                    <li><a href="#">Thuê Ô tô</a></li>
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
                        <li><a href="#"><i class="fas fa-user"></i> Thông tin tài khoản</a></li>
                        <li><a href="#"><i class="fas fa-history"></i> Lịch sử thuê xe</a></li>
                        <li><a href="#"><i class="fas fa-heart"></i> Xe yêu thích</a></li>
                        <li class="divider"></li>
                        <li><a href="#" id="logoutBtn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
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
                <li><a href="index.html">Trang chủ</a></li>
                <li><a href="#" class="active">Kết quả tìm kiếm</a></li>
                <li><a href="#">Xe máy</a></li>
                <li><a href="#">Xe điện</a></li>
                <li><a href="#">Ô tô</a></li>
                <li>
                    <div class="auth-buttons-mobile" id="authButtonsMobile">
                        <button class="btn btn-outline" id="loginBtnMobile" style="width: 100%; margin-bottom: 0.5rem;">Đăng nhập</button>
                        <button class="btn btn-primary" id="registerBtnMobile" style="width: 100%;">Đăng ký</button>
                    </div>
                    <div class="user-avatar-mobile" id="userAvatarMobile" style="display: none;">
                        <div class="avatar-placeholder">U</div>
                        <div class="user-info">
                            <p>Xin chào, <span id="mobileUserName">Người dùng</span></p>
                            <a href="#" class="btn btn-outline" style="width: 100%; margin-top: 0.5rem;" id="logoutBtnMobile">Đăng xuất</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </header>

    <!-- Search Results Header -->
    <section class="search-results-header">
        <div class="search-results-container">
            <div class="search-results-title">
                <h1>Kết Quả Tìm Kiếm</h1>
                <p>Tìm thấy các phương tiện phù hợp với yêu cầu của bạn</p>
            </div>
            
            <div class="search-criteria">
                <h3>Tiêu chí tìm kiếm của bạn:</h3>
                <div class="criteria-list">
                    <div class="criteria-item">Loại xe: Xe máy</div>
                    <div class="criteria-item">Ngày nhận: 15/11/2023</div>
                    <div class="criteria-item">Ngày trả: 20/11/2023</div>
                    <div class="criteria-item">Địa điểm: Hồ Chí Minh</div>
                </div>
            </div>
            
            <div class="modify-search">
                <button class="btn btn-outline">
                    <i class="fas fa-edit"></i> Sửa tìm kiếm
                </button>
            </div>
        </div>
    </section>

    <!-- Search Results Content -->
    <section class="search-results-content">
        <div class="results-header">
            <div class="results-count">
                Tìm thấy <span>12</span> kết quả phù hợp
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
        </div>
        
        <div class="results-layout">
            <!-- Filters Sidebar -->
            <div class="filters-sidebar">
                <div class="filter-section">
                    <h3>Bộ lọc <button class="btn-reset">Đặt lại</button></h3>
                </div>
                
                <div class="filter-section">
                    <h3>Loại xe</h3>
                    <div class="filter-options">
                        <div class="filter-option">
                            <input type="checkbox" id="type-motorcycle" checked>
                            <label for="type-motorcycle">Xe máy</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="type-electric">
                            <label for="type-electric">Xe điện</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="type-car">
                            <label for="type-car">Ô tô</label>
                        </div>
                    </div>
                </div>
                
                <div class="filter-section">
                    <h3>Giá thuê / ngày</h3>
                    <div class="price-range">
                        <div class="price-inputs">
                            <input type="number" placeholder="Từ" value="100000">
                            <input type="number" placeholder="Đến" value="300000">
                        </div>
                    </div>
                </div>
                
                <div class="filter-section">
                    <h3>Hãng xe</h3>
                    <div class="filter-options">
                        <div class="filter-option">
                            <input type="checkbox" id="brand-honda" checked>
                            <label for="brand-honda">Honda</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="brand-yamaha" checked>
                            <label for="brand-yamaha">Yamaha</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="brand-suzuki">
                            <label for="brand-suzuki">Suzuki</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="brand-vespa">
                            <label for="brand-vespa">Vespa</label>
                        </div>
                    </div>
                </div>
                
                <div class="filter-section">
                    <h3>Truyền động</h3>
                    <div class="filter-options">
                        <div class="filter-option">
                            <input type="checkbox" id="trans-auto" checked>
                            <label for="trans-auto">Tự động</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="trans-manual">
                            <label for="trans-manual">Số sàn</label>
                        </div>
                    </div>
                </div>
                
                <div class="filter-section">
                    <h3>Nhiên liệu</h3>
                    <div class="filter-options">
                        <div class="filter-option">
                            <input type="checkbox" id="fuel-petrol" checked>
                            <label for="fuel-petrol">Xăng</label>
                        </div>
                        <div class="filter-option">
                            <input type="checkbox" id="fuel-electric">
                            <label for="fuel-electric">Điện</label>
                        </div>
                    </div>
                </div>
                
                <button class="btn btn-primary apply-filters">Áp dụng bộ lọc</button>
            </div>
            
            <!-- Results Grid -->
            <div class="results-grid">
                <!-- Result Card 1 -->
                <div class="result-card">
                    <div class="result-image">
                        <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                    </div>
                    <div class="result-content">
                        <div class="result-header">
                            <div class="result-title">
                                <h3>Honda Vision 2023</h3>
                                <div class="result-rating">
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
                            <div class="result-tag">Phổ biến</div>
                        </div>
                        
                        <div class="result-details">
                            <div class="detail-item">
                                <i class="fas fa-gas-pump"></i>
                                <span>Xăng</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-user"></i>
                                <span>2 người</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-cog"></i>
                                <span>Tự động</span>
                            </div>
                        </div>
                        
                        <div class="result-price">
                            150.000đ <span>/ngày</span>
                        </div>
                        
                        <div class="result-actions">
                            <button class="btn btn-outline">Xem chi tiết</button>
                            <button class="btn btn-primary">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Result Card 2 -->
                <div class="result-card">
                    <div class="result-image">
                        <img src="https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Yamaha Exciter">
                    </div>
                    <div class="result-content">
                        <div class="result-header">
                            <div class="result-title">
                                <h3>Yamaha Exciter 150</h3>
                                <div class="result-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span>4.5 (167 đánh giá)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="result-tag">Thể thao</div>
                        </div>
                        
                        <div class="result-details">
                            <div class="detail-item">
                                <i class="fas fa-gas-pump"></i>
                                <span>Xăng</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-user"></i>
                                <span>2 người</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-cog"></i>
                                <span>Số sàn</span>
                            </div>
                        </div>
                        
                        <div class="result-price">
                            180.000đ <span>/ngày</span>
                        </div>
                        
                        <div class="result-actions">
                            <button class="btn btn-outline">Xem chi tiết</button>
                            <button class="btn btn-primary">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Result Card 3 -->
                <div class="result-card">
                    <div class="result-image">
                        <img src="https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Honda Air Blade">
                    </div>
                    <div class="result-content">
                        <div class="result-header">
                            <div class="result-title">
                                <h3>Honda Air Blade 150</h3>
                                <div class="result-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <span>4.0 (98 đánh giá)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="result-tag">Tiết kiệm</div>
                        </div>
                        
                        <div class="result-details">
                            <div class="detail-item">
                                <i class="fas fa-gas-pump"></i>
                                <span>Xăng</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-user"></i>
                                <span>2 người</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-cog"></i>
                                <span>Tự động</span>
                            </div>
                        </div>
                        
                        <div class="result-price">
                            160.000đ <span>/ngày</span>
                        </div>
                        
                        <div class="result-actions">
                            <button class="btn btn-outline">Xem chi tiết</button>
                            <button class="btn btn-primary">Thuê ngay</button>
                        </div>
                    </div>
                </div>
                
                <!-- Add more result cards as needed -->
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="pagination">
            <button class="active">1</button>
            <button>2</button>
            <button>3</button>
            <button>4</button>
            <button>Tiếp theo</button>
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
                    <li><a href="index.html">Trang chủ</a></li>
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

    <script>
        // Mobile Menu
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');
        
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('active');
        });

        // Auth Modal Functionality (giữ nguyên từ trang index)
        const loginBtn = document.getElementById('loginBtn');
        const registerBtn = document.getElementById('registerBtn');
        const loginBtnMobile = document.getElementById('loginBtnMobile');
        const registerBtnMobile = document.getElementById('registerBtnMobile');
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
            isLoggedIn = false;
            currentUser = null;
            
            // Show auth buttons, hide user avatar
            userAvatar.style.display = 'none';
            authButtons.style.display = 'flex';
            
            // Update mobile menu
            userAvatarMobile.style.display = 'none';
            authButtonsMobile.style.display = 'block';
            
            alert('Đã đăng xuất thành công!');
        }

        // For demo purposes, simulate a logged in user
        // Comment out the following lines to start with logged out state
        /*
        currentUser = {
            name: 'Người dùng',
            email: 'user@example.com'
        };
        isLoggedIn = true;
        updateUIAfterLogin();
        */

        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            logout();
        });

        logoutBtnMobile.addEventListener('click', (e) => {
            e.preventDefault();
            logout();
        });

        // Filter functionality
        const applyFiltersBtn = document.querySelector('.apply-filters');
        const resetFiltersBtn = document.querySelector('.btn-reset');
        
        applyFiltersBtn.addEventListener('click', () => {
            // In a real application, this would update the search results
            alert('Bộ lọc đã được áp dụng!');
        });
        
        resetFiltersBtn.addEventListener('click', () => {
            // Reset all checkboxes
            document.querySelectorAll('.filter-option input[type="checkbox"]').forEach(checkbox => {
                checkbox.checked = false;
            });
            
            // Reset price inputs
            document.querySelectorAll('.price-inputs input').forEach((input, index) => {
                input.value = index === 0 ? '100000' : '300000';
            });
            
            alert('Bộ lọc đã được đặt lại!');
        });

        // Sort functionality
        const sortSelect = document.getElementById('sort-by');
        
        sortSelect.addEventListener('change', () => {
            // In a real application, this would re-sort the search results
            alert(`Đã sắp xếp theo: ${sortSelect.options[sortSelect.selectedIndex].text}`);
        });

        // Pagination functionality
        document.querySelectorAll('.pagination button').forEach(button => {
            button.addEventListener('click', function() {
                if (this.textContent !== 'Tiếp theo') {
                    document.querySelector('.pagination button.active').classList.remove('active');
                    this.classList.add('active');
                }
                // In a real application, this would load the corresponding page
                alert(`Đang tải trang ${this.textContent}`);
            });
        });
    </script>
</body>
</html>