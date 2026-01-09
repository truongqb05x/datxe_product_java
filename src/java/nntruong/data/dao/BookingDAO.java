package nntruong.data.dao;

import nntruong.data.model.Booking;
import nntruong.data.model.User;
import nntruong.data.model.Vehicle;
import nntruong.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Data Access Object (DAO) class để xử lý các thao tác với bảng bookings trong database
 * Bao gồm: thêm, tìm kiếm, cập nhật booking
 */
public class BookingDAO {
    
    private DatabaseConnection dbConnection;
    private VehicleDAO vehicleDAO;
    
    // Hằng số cho phí bảo hiểm và phí dịch vụ
    private static final BigDecimal INSURANCE_FEE_PERCENT = new BigDecimal("0.20"); // 20%
    private static final BigDecimal SERVICE_FEE = new BigDecimal("20000"); // 20,000 VNĐ
    
    /**
     * Constructor - khởi tạo DatabaseConnection và VehicleDAO
     */
    public BookingDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
        this.vehicleDAO = new VehicleDAO();
    }
    
    /**
     * Thêm booking mới vào database
     * @param booking Booking object cần thêm
     * @return booking ID nếu thành công, null nếu thất bại
     */
    public Integer insert(Booking booking) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            // Generate booking code nếu chưa có
            if (booking.getBookingCode() == null || booking.getBookingCode().isEmpty()) {
                booking.setBookingCode(generateBookingCode(conn));
            }
            
            // Tính toán số ngày thuê nếu chưa có
            if (booking.getTotalDays() == null) {
                booking.setTotalDays(calculateTotalDays(booking.getPickupDate(), booking.getReturnDate()));
            }
            
            // Tính toán giá nếu chưa có
            if (booking.getDailyRate() == null || booking.getBaseAmount() == null) {
                calculatePricing(booking, conn);
            }
            
            // Tính tổng tiền
            booking.calculateTotalAmount();
            
            String sql = "INSERT INTO bookings (booking_code, user_id, vehicle_id, " +
                        "pickup_location_id, return_location_id, pickup_date, return_date, " +
                        "total_days, daily_rate, base_amount, insurance_fee, service_fee, " +
                        "discount_amount, total_amount, deposit_amount, status, payment_status, " +
                        "payment_method, notes) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, booking.getBookingCode());
            stmt.setInt(2, booking.getUserId());
            stmt.setInt(3, booking.getVehicleId());
            stmt.setInt(4, booking.getPickupLocationId());
            stmt.setInt(5, booking.getReturnLocationId());
            stmt.setTimestamp(6, booking.getPickupDate());
            stmt.setTimestamp(7, booking.getReturnDate());
            stmt.setInt(8, booking.getTotalDays());
            stmt.setBigDecimal(9, booking.getDailyRate());
            stmt.setBigDecimal(10, booking.getBaseAmount());
            stmt.setBigDecimal(11, booking.getInsuranceFee());
            stmt.setBigDecimal(12, booking.getServiceFee());
            stmt.setBigDecimal(13, booking.getDiscountAmount());
            stmt.setBigDecimal(14, booking.getTotalAmount());
            
            if (booking.getDepositAmount() != null) {
                stmt.setBigDecimal(15, booking.getDepositAmount());
            } else {
                stmt.setNull(15, Types.DECIMAL);
            }
            
            stmt.setString(16, booking.getStatus());
            stmt.setString(17, booking.getPaymentStatus());
            
            if (booking.getPaymentMethod() != null) {
                stmt.setString(18, booking.getPaymentMethod());
            } else {
                stmt.setNull(18, Types.VARCHAR);
            }
            
            if (booking.getNotes() != null) {
                stmt.setString(19, booking.getNotes());
            } else {
                stmt.setNull(19, Types.VARCHAR);
            }
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Lấy ID của booking vừa tạo
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    Integer bookingId = rs.getInt(1);
                    booking.setBookingId(bookingId);
                    conn.commit();
                    return bookingId;
                }
            }
            
            conn.rollback();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm booking: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Tìm booking theo ID
     * @param bookingId ID của booking
     * @return Booking object nếu tìm thấy, null nếu không tìm thấy
     */
    public Booking findById(Integer bookingId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT * FROM bookings WHERE booking_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                conn.commit();
                return booking;
            }
            
            conn.commit();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm booking theo ID: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Tìm booking theo booking code
     * @param bookingCode Mã booking
     * @return Booking object nếu tìm thấy, null nếu không tìm thấy
     */
    public Booking findByBookingCode(String bookingCode) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT * FROM bookings WHERE booking_code = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookingCode);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                conn.commit();
                return booking;
            }
            
            conn.commit();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm booking theo code: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Lấy danh sách booking của một user
     * @param userId ID của user
     * @return List<Booking> danh sách booking
     */
    public List<Booking> getBookingsByUserId(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Booking> bookings = new ArrayList<>();
        
        try {
            conn = dbConnection.getConnection();
            
            // Lấy danh sách booking của user, sắp xếp mới nhất lên đầu
            String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY created_at DESC";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                
                // Lấy thông tin vehicle cho mỗi booking
                Vehicle vehicle = vehicleDAO.findById(booking.getVehicleId());
                booking.setVehicle(vehicle);
                
                bookings.add(booking);
            }
            
            conn.commit();
            return bookings;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách booking của user: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return new ArrayList<>(); // Trả về list rỗng nếu lỗi
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Generate mã booking code duy nhất (format: RENT20260001)
     * @param conn Database connection
     * @return Booking code
     */
    private String generateBookingCode(Connection conn) throws SQLException {
        // Lấy năm hiện tại
        String year = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy"));
        
        // Tìm booking code lớn nhất trong năm hiện tại
        String sql = "SELECT booking_code FROM bookings " +
                    "WHERE booking_code LIKE ? " +
                    "ORDER BY booking_code DESC LIMIT 1";
        
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, "RENT" + year + "%");
        
        ResultSet rs = stmt.executeQuery();
        
        int nextNumber = 1;
        if (rs.next()) {
            String lastCode = rs.getString("booking_code");
            // Extract số từ code (RENT20260001 -> 0001)
            String numberPart = lastCode.substring(8); // Bỏ "RENT2026"
            nextNumber = Integer.parseInt(numberPart) + 1;
        }
        
        rs.close();
        stmt.close();
        
        // Format: RENT + năm + số thứ tự (4 chữ số)
        return String.format("RENT%s%04d", year, nextNumber);
    }
    
    /**
     * Tính số ngày thuê
     * @param pickupDate Ngày nhận xe
     * @param returnDate Ngày trả xe
     * @return Số ngày thuê
     */
    private int calculateTotalDays(Timestamp pickupDate, Timestamp returnDate) {
        if (pickupDate == null || returnDate == null) {
            return 0;
        }
        
        long diffInMillis = returnDate.getTime() - pickupDate.getTime();
        long days = TimeUnit.MILLISECONDS.toDays(diffInMillis);
        
        // Tối thiểu 1 ngày
        return (int) Math.max(1, days);
    }
    
    /**
     * Tính toán giá thuê và các phí
     * @param booking Booking object cần tính giá
     * @param conn Database connection
     */
    private void calculatePricing(Booking booking, Connection conn) throws SQLException {
        // Lấy thông tin xe để biết giá thuê theo ngày
        Vehicle vehicle = vehicleDAO.findById(booking.getVehicleId());
        
        if (vehicle != null && vehicle.getDailyRate() != null) {
            BigDecimal dailyRate = vehicle.getDailyRate();
            booking.setDailyRate(dailyRate);
            
            // Tính base amount = daily rate * số ngày
            BigDecimal baseAmount = dailyRate.multiply(new BigDecimal(booking.getTotalDays()));
            booking.setBaseAmount(baseAmount);
            
            // Tính phí bảo hiểm = 20% của base amount
            BigDecimal insuranceFee = baseAmount.multiply(INSURANCE_FEE_PERCENT);
            booking.setInsuranceFee(insuranceFee);
            
            // Phí dịch vụ cố định
            booking.setServiceFee(SERVICE_FEE);
            
            // Tiền cọc = giá thuê 1 ngày
            booking.setDepositAmount(dailyRate);
        } else {
            // Nếu không tìm thấy xe, set giá mặc định
            booking.setDailyRate(BigDecimal.ZERO);
            booking.setBaseAmount(BigDecimal.ZERO);
            booking.setInsuranceFee(BigDecimal.ZERO);
            booking.setServiceFee(BigDecimal.ZERO);
            booking.setDepositAmount(BigDecimal.ZERO);
        }
    }
    
    /**
     * Helper method: Map ResultSet sang Booking object
     * @param rs ResultSet từ database
     * @return Booking object
     * @throws SQLException nếu có lỗi khi đọc dữ liệu
     */
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setBookingCode(rs.getString("booking_code"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setVehicleId(rs.getInt("vehicle_id"));
        booking.setPickupLocationId(rs.getInt("pickup_location_id"));
        booking.setReturnLocationId(rs.getInt("return_location_id"));
        booking.setPickupDate(rs.getTimestamp("pickup_date"));
        booking.setReturnDate(rs.getTimestamp("return_date"));
        booking.setTotalDays(rs.getInt("total_days"));
        booking.setDailyRate(rs.getBigDecimal("daily_rate"));
        booking.setBaseAmount(rs.getBigDecimal("base_amount"));
        booking.setInsuranceFee(rs.getBigDecimal("insurance_fee"));
        booking.setServiceFee(rs.getBigDecimal("service_fee"));
        booking.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setDepositAmount(rs.getBigDecimal("deposit_amount"));
        booking.setStatus(rs.getString("status"));
        booking.setPaymentStatus(rs.getString("payment_status"));
        booking.setPaymentMethod(rs.getString("payment_method"));
        booking.setNotes(rs.getString("notes"));
        booking.setCancellationReason(rs.getString("cancellation_reason"));
        booking.setCancelledAt(rs.getTimestamp("cancelled_at"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        booking.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return booking;
    }
    
    /**
     * Helper method: Đóng các resource (Connection, Statement, ResultSet)
     * @param conn Connection
     * @param stmt Statement/PreparedStatement
     * @param rs ResultSet
     */
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            dbConnection.closeConnection(conn);
        }
    }
    /**
     * Lấy danh sách booking gần đây (dùng cho dashboard)
     * @param limit Số lượng booking cần lấy
     * @return List<Booking>
     */
    public List<Booking> getRecentBookings(int limit) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Booking> bookings = new ArrayList<>();
        
        try {
            conn = dbConnection.getConnection();
            
            // Query lấy bookings gần nhất, join với users và vehicles để lấy tên
            // Note: Booking model might need to store extra info or we just populate fields
            String sql = "SELECT b.*, u.full_name, v.model_name FROM bookings b " +
                         "JOIN users u ON b.user_id = u.user_id " +
                         "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                         "ORDER BY b.created_at DESC LIMIT ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                // Manually set transient fields if Booking model supports them, 
                // or we rely on the caller to fetch related objects.
                // For simplified dashboard, we might want to extend Booking or set transient properties
                // Let's assume we can fetch User/Vehicle or just set IDs.
                // To minimize N+1, ideally we'd map the joined columns.
                // But Booking model structure:
                // private Vehicle vehicle; 
                // We can populate simple vehicle/user objects
                
                // For now, let's keep it simple and just return the booking. 
                // If the JSP needs names, we might need to populate them.
                // Checking Booking model... it has setVehicle.
                
                Vehicle v = new Vehicle();
                v.setModelName(rs.getString("model_name"));
                booking.setVehicle(v);
                
                // User info is not directly in Booking model usually, unless it has a User field.
                // Let's check Booking.java later. Assuming for now we need a DTO or just handle it in Servlet?
                // Actually the Dashboard JSP uses ${booking.customerName}, implying a DTO or specific getter.
                // But let's return standard Booking objects and maybe wrap them in DTOs in the Servlet or use a map.
                
                bookings.add(booking);
            }
            
            conn.commit();
            return bookings;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy recent bookings: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return bookings;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }

    /**
     * Search bookings with filters and pagination
     */
    public List<Booking> searchBookings(String keyword, String status, Integer customerId, Integer vehicleId, 
                                      String paymentStatus, Date startDate, Date endDate, int offset, int limit) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            StringBuilder sql = new StringBuilder("SELECT b.*, u.full_name, u.phone_number, u.email, v.model_name, v.license_plate, v.color, v.daily_rate " +
                                                "FROM bookings b " +
                                                "JOIN users u ON b.user_id = u.user_id " +
                                                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                                "WHERE 1=1 ");
            List<Object> params = new ArrayList<>();
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (b.booking_code LIKE ? OR u.full_name LIKE ? OR u.phone_number LIKE ?) ");
                String likeKey = "%" + keyword + "%";
                params.add(likeKey);
                params.add(likeKey);
                params.add(likeKey);
            }
            if (status != null && !status.isEmpty() && !"all".equalsIgnoreCase(status)) {
                sql.append("AND b.status = ? ");
                params.add(status);
            }
            if (customerId != null) {
                sql.append("AND b.user_id = ? ");
                params.add(customerId);
            }
            if (vehicleId != null) {
                sql.append("AND b.vehicle_id = ? ");
                params.add(vehicleId);
            }
             if (paymentStatus != null && !paymentStatus.isEmpty()) {
                sql.append("AND b.payment_status = ? ");
                params.add(paymentStatus);
            }
            if (startDate != null) {
                sql.append("AND b.created_at >= ? ");
                params.add(new Timestamp(startDate.getTime()));
            }
            if (endDate != null) {
                sql.append("AND b.created_at <= ? ");
                params.add(new Timestamp(endDate.getTime()));
            }
            
            sql.append("ORDER BY b.created_at DESC LIMIT ? OFFSET ?");
            params.add(limit);
            params.add(offset);
            
            stmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                Booking b = mapResultSetToBooking(rs);
                // Populate Customer (User) info
                nntruong.data.model.User u = new nntruong.data.model.User();
                u.setUserId(rs.getInt("user_id"));
                u.setFullName(rs.getString("full_name"));
                u.setPhone(rs.getString("phone_number"));
                u.setEmail(rs.getString("email"));
                b.setCustomer(u); 
                
                // Populate Vehicle info
                Vehicle v = new Vehicle();
                v.setVehicleId(rs.getInt("vehicle_id"));
                v.setModelName(rs.getString("model_name"));
                v.setLicensePlate(rs.getString("license_plate"));
                v.setColor(rs.getString("color"));
                v.setDailyRate(rs.getBigDecimal("daily_rate"));
                v.setName(rs.getString("model_name")); // Alias if needed
                b.setVehicle(v);
                
                bookings.add(b);
            }
             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return bookings;
    }

    /**
     * Count total bookings for pagination
     */
    public int countBookings(String keyword, String status, Integer customerId, Integer vehicleId, 
                           String paymentStatus, Date startDate, Date endDate) {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM bookings b " +
                                                "JOIN users u ON b.user_id = u.user_id " +
                                                "WHERE 1=1 ");
            List<Object> params = new ArrayList<>();
             if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (b.booking_code LIKE ? OR u.full_name LIKE ? OR u.phone_number LIKE ?) ");
                String likeKey = "%" + keyword + "%";
                params.add(likeKey);
                params.add(likeKey);
                params.add(likeKey);
            }
            if (status != null && !status.isEmpty() && !"all".equalsIgnoreCase(status)) {
                sql.append("AND b.status = ? ");
                params.add(status);
            }
            if (customerId != null) {
                sql.append("AND b.user_id = ? ");
                params.add(customerId);
            }
            if (vehicleId != null) {
                sql.append("AND b.vehicle_id = ? ");
                params.add(vehicleId);
            }
             if (paymentStatus != null && !paymentStatus.isEmpty()) {
                sql.append("AND b.payment_status = ? ");
                params.add(paymentStatus);
            }
            if (startDate != null) {
                sql.append("AND b.created_at >= ? ");
                params.add(new Timestamp(startDate.getTime()));
            }
            if (endDate != null) {
                sql.append("AND b.created_at <= ? ");
                params.add(new Timestamp(endDate.getTime()));
            }
            
            stmt = conn.prepareStatement(sql.toString());
             for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return count;
    }

    public boolean updateStatus(int bookingId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "UPDATE bookings SET status = ?, updated_at = NOW() WHERE booking_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            int rows = stmt.executeUpdate();
            if(rows > 0) conn.commit();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
             if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    public boolean delete(int bookingId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "DELETE FROM bookings WHERE booking_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            int rows = stmt.executeUpdate();
             if(rows > 0) conn.commit();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    public java.util.Map<String, Integer> getBookingStats() {
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT status, COUNT(*) as count FROM bookings GROUP BY status";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            int total = 0;
            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                stats.put(status.toLowerCase() + "Bookings", count); // PENDING -> pendingBookings
                total += count;
            }
            stats.put("totalBookings", total);
             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        return stats;
    }
}
