package nntruong.data.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * Model class đại diện cho bảng vehicles trong database
 * Chứa tất cả các thuộc tính tương ứng với các cột trong bảng vehicles
 */
public class Vehicle {
    
    private int vehicleId;                    // vehicle_id - ID phương tiện
    private String licensePlate;              // license_plate - Biển số xe
    private int brandId;                      // brand_id - ID nhãn hiệu
    private String brandName;                 // brand_name - Tên nhãn hiệu (join từ vehicle_brands)
    private String modelName;                 // model_name - Tên model
    private Integer modelYear;                // model_year - Năm sản xuất
    private int categoryId;                   // category_id - ID loại phương tiện
    private String categoryName;              // category_name - Tên loại (join từ vehicle_categories)
    private String fuelType;                  // fuel_type - Loại nhiên liệu
    private String transmission;             // transmission - Hộp số
    private String engineCapacity;           // engine_capacity - Dung tích xy-lanh
    private Integer seatCapacity;            // seat_capacity - Số chỗ ngồi
    private String color;                     // color - Màu sắc
    private BigDecimal dailyRate;           // daily_rate - Giá thuê theo ngày
    private BigDecimal weeklyRate;           // weekly_rate - Giá thuê theo tuần
    private BigDecimal monthlyRate;           // monthly_rate - Giá thuê theo tháng
    private BigDecimal depositAmount;         // deposit_amount - Tiền cọc
    private boolean isAvailable;              // is_available - Có sẵn để thuê không
    private boolean isFeatured;              // is_featured - Có nổi bật không
    private String description;               // description - Mô tả chi tiết
    private String specifications;            // specifications - Thông số kỹ thuật (JSON)
    private String amenities;                 // amenities - Tiện nghi (JSON)
    private BigDecimal rating;                // rating - Đánh giá trung bình
    private int totalRentals;                 // total_rentals - Tổng số lần thuê
    private String mainImageUrl;              // image_url - URL ảnh chính (join từ vehicle_images)
    private Date createdAt;                   // created_at
    private Date updatedAt;                   // updated_at
    
    // Constructor mặc định
    public Vehicle() {
    }
    
    // Constructor với các tham số cơ bản
    public Vehicle(String licensePlate, int brandId, String modelName, int categoryId, BigDecimal dailyRate) {
        this.licensePlate = licensePlate;
        this.brandId = brandId;
        this.modelName = modelName;
        this.categoryId = categoryId;
        this.dailyRate = dailyRate;
        this.isAvailable = true;
        this.isFeatured = false;
        this.rating = BigDecimal.ZERO;
        this.totalRentals = 0;
    }
    
    // Getter và Setter
    
    public int getVehicleId() {
        return vehicleId;
    }
    
    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }
    
    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    public int getBrandId() {
        return brandId;
    }
    
    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }
    
    public String getBrandName() {
        return brandName;
    }
    
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
    
    public String getModelName() {
        return modelName;
    }
    
    public void setModelName(String modelName) {
        this.modelName = modelName;
    }
    
    public Integer getModelYear() {
        return modelYear;
    }
    
    public void setModelYear(Integer modelYear) {
        this.modelYear = modelYear;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public String getFuelType() {
        return fuelType;
    }
    
    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }
    
    public String getTransmission() {
        return transmission;
    }
    
    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }
    
    public String getEngineCapacity() {
        return engineCapacity;
    }
    
    public void setEngineCapacity(String engineCapacity) {
        this.engineCapacity = engineCapacity;
    }
    
    public Integer getSeatCapacity() {
        return seatCapacity;
    }
    
    public void setSeatCapacity(Integer seatCapacity) {
        this.seatCapacity = seatCapacity;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color;
    }
    
    public BigDecimal getDailyRate() {
        return dailyRate;
    }
    
    public void setDailyRate(BigDecimal dailyRate) {
        this.dailyRate = dailyRate;
    }
    
    public BigDecimal getWeeklyRate() {
        return weeklyRate;
    }
    
    public void setWeeklyRate(BigDecimal weeklyRate) {
        this.weeklyRate = weeklyRate;
    }
    
    public BigDecimal getMonthlyRate() {
        return monthlyRate;
    }
    
    public void setMonthlyRate(BigDecimal monthlyRate) {
        this.monthlyRate = monthlyRate;
    }
    
    public BigDecimal getDepositAmount() {
        return depositAmount;
    }
    
    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean available) {
        isAvailable = available;
    }
    
    public boolean isFeatured() {
        return isFeatured;
    }
    
    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getSpecifications() {
        return specifications;
    }
    
    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }
    
    public String getAmenities() {
        return amenities;
    }
    
    public void setAmenities(String amenities) {
        this.amenities = amenities;
    }
    
    public BigDecimal getRating() {
        return rating;
    }
    
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }
    
    public int getTotalRentals() {
        return totalRentals;
    }
    
    public void setTotalRentals(int totalRentals) {
        this.totalRentals = totalRentals;
    }
    
    public String getMainImageUrl() {
        return mainImageUrl;
    }
    
    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    private int reviewCount; // review_count - Số lượng đánh giá (transient)
    private BigDecimal revenue; // revenue - Doanh thu (transient)

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }

    // Existing updateAt methods
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    /**
     * Alias for getModelName or getFullName - used in BookingDAO and JSP
     */
    public String getName() {
        return getFullName();
    }

    public void setName(String name) {
        // Since this is often used for model name alias in display
        this.modelName = name;
    }

    /**
     * Lấy tên đầy đủ của xe (Brand + Model)
     */
    public String getFullName() {
        if (brandName != null && modelName != null) {
            return brandName + " " + modelName;
        } else if (modelName != null) {
            return modelName;
        }
        return "";
    }
    
    /**
     * Format giá tiền theo định dạng VNĐ
     */
    public String getFormattedDailyRate() {
        if (dailyRate == null) {
            return "0đ";
        }
        return String.format("%,.0fđ", dailyRate.doubleValue());
    }
    
    @Override
    public String toString() {
        return "Vehicle{" +
                "vehicleId=" + vehicleId +
                ", licensePlate='" + licensePlate + '\'' +
                ", brandName='" + brandName + '\'' +
                ", modelName='" + modelName + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", dailyRate=" + dailyRate +
                ", isFeatured=" + isFeatured +
                '}';
    }
}




