package nntruong.data.model;

import java.sql.Date;

/**
 * Model class đại diện cho bảng users trong database
 * Chứa tất cả các thuộc tính tương ứng với các cột trong bảng users
 */
public class User {
    
    private int userId;                     // user_id - ID người dùng
    private String email;                   // email - Email đăng nhập
    private String passwordHash;            // password_hash - Mật khẩu đã mã hóa
    private String fullName;                // full_name - Họ và tên
    private String phoneNumber;             // phone_number - Số điện thoại
    private String avatarUrl;               // avatar_url - URL ảnh đại diện
    private Date dateOfBirth;               // date_of_birth - Ngày sinh
    private String identityCard;            // identity_card - Số CMND/CCCD
    private String driverLicenseNumber;     // driver_license_number - Số bằng lái xe
    private String driverLicenseType;       // driver_license_type - Loại bằng lái (A1, A2, B1, B2, C...)
    private String address;                 // address - Địa chỉ
    private boolean isVerified;             // is_verified - Đã xác thực tài khoản chưa
    private boolean isActive;               // is_active - Tài khoản có đang hoạt động không
    private Date createdAt;                 // created_at - Ngày tạo tài khoản
    private Date updatedAt;                 // updated_at - Ngày cập nhật
    
    // Constructor mặc định (không tham số)
    public User() {
    }
    
    // Constructor với các tham số cơ bản cho đăng ký
    public User(String email, String passwordHash, String fullName, String phoneNumber) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.isVerified = false;  // Mặc định chưa xác thực
        this.isActive = true;     // Mặc định tài khoản hoạt động
    }
    
    // Getter và Setter cho tất cả các thuộc tính
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public void setId(int userId) {
        this.userId = userId;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhone() {
        return phoneNumber;
    }

    public void setPhone(String phone) {
        this.phoneNumber = phone;
    }
    
    public String getAvatarUrl() {
        return avatarUrl;
    }
    
    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public String getIdentityCard() {
        return identityCard;
    }
    
    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard;
    }
    
    public String getDriverLicenseNumber() {
        return driverLicenseNumber;
    }
    
    public void setDriverLicenseNumber(String driverLicenseNumber) {
        this.driverLicenseNumber = driverLicenseNumber;
    }
    
    public String getDriverLicenseType() {
        return driverLicenseType;
    }
    
    public void setDriverLicenseType(String driverLicenseType) {
        this.driverLicenseType = driverLicenseType;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public boolean isVerified() {
        return isVerified;
    }
    
    public void setVerified(boolean verified) {
        isVerified = verified;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", isVerified=" + isVerified +
                ", isActive=" + isActive +
                '}';
    }
}
