<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thuê Xe - RentCar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../../static/css/pages/datxe.css">
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
                    <li><a href="xemay.html">Thuê Xe máy</a></li>
                    <li><a href="#">Thuê Ô tô</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <button class="btn btn-outline">Đăng nhập</button>
                <button class="btn btn-primary">Đăng ký</button>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <ul>
            <li><a href="index.html">Trang chủ</a></li>
            <li><a href="xemay.html">Xe máy</a></li>
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
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Họ và tên *</label>
                            <input type="text" id="fullName" placeholder="Nhập họ và tên" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại *</label>
                            <input type="tel" id="phone" placeholder="Nhập số điện thoại" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" placeholder="Nhập email" required>
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
                                <option value="hq">Trụ sở chính - 123 ABC, Quận 1, TP.HCM</option>
                                <option value="branch1">Chi nhánh 1 - 456 XYZ, Quận 3, TP.HCM</option>
                                <option value="branch2">Chi nhánh 2 - 789 DEF, Quận 5, TP.HCM</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="returnLocation">Địa điểm trả xe *</label>
                            <select id="returnLocation" required>
                                <option value="">Chọn địa điểm trả xe</option>
                                <option value="hq">Trụ sở chính - 123 ABC, Quận 1, TP.HCM</option>
                                <option value="branch1">Chi nhánh 1 - 456 XYZ, Quận 3, TP.HCM</option>
                                <option value="branch2">Chi nhánh 2 - 789 DEF, Quận 5, TP.HCM</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="specialRequest">Yêu cầu đặc biệt (nếu có)</label>
                        <textarea id="specialRequest" rows="3" placeholder="Nhập yêu cầu đặc biệt của bạn..."></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button class="btn btn-outline" disabled>Quay lại</button>
                        <button class="btn btn-primary" onclick="nextStep(2)">Tiếp tục</button>
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
                            <p>1. Khách hàng phải có bằng lái xe hợp lệ và đủ điều kiện theo quy định của pháp luật.</p>
                            <p>2. Khách hàng chịu trách nhiệm về mọi vi phạm giao thông trong thời gian thuê xe.</p>
                            <p>3. Xe phải được trả đúng giờ và địa điểm đã thỏa thuận. Trễ hẹn sẽ bị phụ thu.</p>
                            <p>4. Khách hàng chịu trách nhiệm bồi thường thiệt hại nếu xảy ra tai nạn do lỗi của mình.</p>
                            <p>5. Phí bảo hiểm đã bao gồm trong giá thuê, tuy nhiên khách hàng vẫn phải chịu một phần chi phí khấu trừ trong trường hợp xảy ra sự cố.</p>
                            <p>6. Không sử dụng xe cho mục đích bất hợp pháp, đua xe trái phép hoặc các hoạt động vi phạm pháp luật.</p>
                            <p>7. Khách hàng đồng ý cho RentCar kiểm tra lịch sử lái xe và thông tin cá nhân khi cần thiết.</p>
                        </div>
                        <div class="agree-terms">
                            <input type="checkbox" id="agreeTerms" required>
                            <label for="agreeTerms">Tôi đã đọc và đồng ý với các điều khoản và điều kiện trên</label>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button class="btn btn-outline" onclick="prevStep(2)">Quay lại</button>
                        <button class="btn btn-primary" onclick="completeBooking()">Hoàn tất đặt xe</button>
                    </div>
                </div>
                
                <!-- Step 4: Hoàn tất -->
                <div class="form-section" id="section4">
                    <div class="success-message">
                        <div class="success-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h2>Đặt xe thành công!</h2>
                        <p>Cảm ơn bạn đã sử dụng dịch vụ của RentCar. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận đơn đặt xe.</p>
                        
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
                            <button class="btn btn-outline" onclick="printBooking()">In hóa đơn</button>
                            <button class="btn btn-primary" onclick="goHome()">Về trang chủ</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Summary -->
            <div class="booking-summary">
                <h2 class="section-title">Thông tin xe</h2>
                
                <div class="vehicle-summary">
                    <div class="vehicle-image">
                        <img src="https://images.unsplash.com/photo-1609630875171-b1321377ee65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Honda Vision">
                    </div>
                    <div class="vehicle-info">
                        <h3>Honda Vision 2023</h3>
                        <div class="vehicle-details">
                            <div>Xăng • Tự động • 2 người</div>
                            <div>110cc • Màu: Đen</div>
                        </div>
                    </div>
                </div>
                
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
        // Current step
        let currentStep = 1;
        
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
            const agreeTerms = document.getElementById('agreeTerms');
            
            if (!agreeTerms.checked) {
                alert('Vui lòng đồng ý với điều khoản và điều kiện để tiếp tục.');
                return;
            }
            
            // In a real application, you would submit the form data here
            // For demo purposes, we'll just proceed to the next step
            nextStep(4);
        }
        
        // Print booking
        function printBooking() {
            window.print();
        }
        
        // Go to home page
        function goHome() {
            window.location.href = 'index.html';
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
        
        // Initialize file upload areas
        document.addEventListener('DOMContentLoaded', () => {
            setupFileUpload('idCardUpload', 'idCardFiles');
            setupFileUpload('licenseUpload', 'licenseFiles');
            
            // Set default dates
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const pickupDate = document.getElementById('pickupDate');
            const returnDate = document.getElementById('returnDate');
            
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
        });
    </script>
</body>
</html>