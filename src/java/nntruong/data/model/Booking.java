package nntruong.data.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.Locale;
import nntruong.data.model.Vehicle;

/**
 * Model class đại diện cho bảng bookings trong database
 * Chứa thông tin về đơn đặt xe của khách hàng
 */
public class Booking {
    
    // Primary key
    private Integer bookingId;
    
    // Mã đơn đặt (RENT20260001)
    private String bookingCode;
    
    // Foreign keys
    private Integer userId;
    private Integer vehicleId;
    private Integer pickupLocationId;
    private Integer returnLocationId;
    
    // Linked object
    private Vehicle vehicle;
    private User customer;
    
    // Thông tin thời gian
    private Timestamp pickupDate;
    private Timestamp returnDate;
    private Integer totalDays;
    
    // Thông tin giá cả
    private BigDecimal dailyRate;
    private BigDecimal baseAmount;
    private BigDecimal insuranceFee;
    private BigDecimal serviceFee;
    private BigDecimal discountAmount;
    private BigDecimal totalAmount;
    private BigDecimal depositAmount;
    
    // Trạng thái
    private String status; // pending, confirmed, paid, active, completed, cancelled
    private String paymentStatus; // unpaid, partially_paid, paid, refunded
    private String paymentMethod;
    
    // Ghi chú và lý do hủy
    private String notes;
    private String cancellationReason;
    private Timestamp cancelledAt;
    
    // Timestamps
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    /**
     * Constructor mặc định
     */
    public Booking() {
        // Khởi tạo giá trị mặc định
        this.status = "pending";
        this.paymentStatus = "unpaid";
        this.discountAmount = BigDecimal.ZERO;
    }
    
    /**
     * Constructor với các tham số cơ bản
     */
    public Booking(Integer userId, Integer vehicleId, Integer pickupLocationId, 
                   Integer returnLocationId, Timestamp pickupDate, Timestamp returnDate) {
        this();
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.pickupLocationId = pickupLocationId;
        this.returnLocationId = returnLocationId;
        this.pickupDate = pickupDate;
        this.returnDate = returnDate;
    }
    
    // Getters and Setters
    
    public Integer getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(Integer bookingId) {
        this.bookingId = bookingId;
    }

    public Integer getId() {
        return bookingId;
    }
    
    public String getBookingCode() {
        return bookingCode;
    }
    
    public void setBookingCode(String bookingCode) {
        this.bookingCode = bookingCode;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public Integer getVehicleId() {
        return vehicleId;
    }
    
    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }
    
    public Integer getPickupLocationId() {
        return pickupLocationId;
    }
    
    public void setPickupLocationId(Integer pickupLocationId) {
        this.pickupLocationId = pickupLocationId;
    }
    
    public Integer getReturnLocationId() {
        return returnLocationId;
    }
    
    public void setReturnLocationId(Integer returnLocationId) {
        this.returnLocationId = returnLocationId;
    }
    
    public Timestamp getPickupDate() {
        return pickupDate;
    }
    
    public void setPickupDate(Timestamp pickupDate) {
        this.pickupDate = pickupDate;
    }
    
    public Timestamp getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(Timestamp returnDate) {
        this.returnDate = returnDate;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }
    
    public Integer getTotalDays() {
        return totalDays;
    }
    
    public void setTotalDays(Integer totalDays) {
        this.totalDays = totalDays;
    }

    public long getTotalHours() {
        if (pickupDate == null || returnDate == null) {
            return 0;
        }
        long diffInMillis = returnDate.getTime() - pickupDate.getTime();
        return java.util.concurrent.TimeUnit.MILLISECONDS.toHours(diffInMillis);
    }
    
    public BigDecimal getDailyRate() {
        return dailyRate;
    }
    
    public void setDailyRate(BigDecimal dailyRate) {
        this.dailyRate = dailyRate;
    }
    
    public BigDecimal getBaseAmount() {
        return baseAmount;
    }
    
    public void setBaseAmount(BigDecimal baseAmount) {
        this.baseAmount = baseAmount;
    }
    
    public BigDecimal getInsuranceFee() {
        return insuranceFee;
    }
    
    public void setInsuranceFee(BigDecimal insuranceFee) {
        this.insuranceFee = insuranceFee;
    }
    
    public BigDecimal getServiceFee() {
        return serviceFee;
    }
    
    public void setServiceFee(BigDecimal serviceFee) {
        this.serviceFee = serviceFee;
    }
    
    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }
    
    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public BigDecimal getDepositAmount() {
        return depositAmount;
    }
    
    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getCancellationReason() {
        return cancellationReason;
    }
    
    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }
    
    public Timestamp getCancelledAt() {
        return cancelledAt;
    }
    
    public void setCancelledAt(Timestamp cancelledAt) {
        this.cancelledAt = cancelledAt;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    /**
     * Tính toán tổng số tiền
     * totalAmount = baseAmount + insuranceFee + serviceFee - discountAmount
     */
    public void calculateTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        
        if (baseAmount != null) {
            total = total.add(baseAmount);
        }
        if (insuranceFee != null) {
            total = total.add(insuranceFee);
        }
        if (serviceFee != null) {
            total = total.add(serviceFee);
        }
        if (discountAmount != null) {
            total = total.subtract(discountAmount);
        }
        
        this.totalAmount = total;
    }
    
    /**
     * Format tổng tiền theo định dạng VNĐ
     * @return Chuỗi định dạng tiền tệ (VD: 600.000đ)
     */
    public String getFormattedTotalAmount() {
        if (totalAmount == null) {
            return "0đ";
        }
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(totalAmount) + "đ";
    }
    
    /**
     * Format base amount theo định dạng VNĐ
     * @return Chuỗi định dạng tiền tệ
     */
    public String getFormattedBaseAmount() {
        if (baseAmount == null) {
            return "0đ";
        }
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(baseAmount) + "đ";
    }
    
    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", bookingCode='" + bookingCode + '\'' +
                ", userId=" + userId +
                ", vehicleId=" + vehicleId +
                ", pickupDate=" + pickupDate +
                ", returnDate=" + returnDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }
}
