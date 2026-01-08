package nntruong.data.dao;

import nntruong.data.model.Vehicle;
import nntruong.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class để xử lý các thao tác với bảng vehicles trong database
 */
public class VehicleDAO {
    
    private DatabaseConnection dbConnection;
    
    /**
     * Constructor - khởi tạo DatabaseConnection
     */
    public VehicleDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }
    
    /**
     * Lấy danh sách xe nổi bật (is_featured = true và is_available = true)
     * @param limit Số lượng xe tối đa cần lấy (mặc định 4)
     * @return List các Vehicle nổi bật
     */
    public List<Vehicle> getFeaturedVehicles(int limit) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vehicle> vehicles = new ArrayList<>();
        
        try {
            conn = dbConnection.getConnection();
            
            // Query lấy xe nổi bật với thông tin brand, category và ảnh chính
            String sql = "SELECT v.vehicle_id, v.license_plate, v.brand_id, v.model_name, " +
                        "v.model_year, v.category_id, v.fuel_type, v.transmission, " +
                        "v.engine_capacity, v.seat_capacity, v.color, v.daily_rate, " +
                        "v.weekly_rate, v.monthly_rate, v.deposit_amount, v.is_available, " +
                        "v.is_featured, v.description, v.specifications, v.amenities, " +
                        "v.rating, v.total_rentals, v.created_at, v.updated_at, " +
                        "b.brand_name, c.category_name, " +
                        "(SELECT image_url FROM vehicle_images WHERE vehicle_id = v.vehicle_id " +
                        "AND image_type = 'main' ORDER BY display_order LIMIT 1) as main_image_url " +
                        "FROM vehicles v " +
                        "LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id " +
                        "LEFT JOIN vehicle_categories c ON v.category_id = c.category_id " +
                        "WHERE v.is_featured = TRUE AND v.is_available = TRUE " +
                        "ORDER BY v.rating DESC, v.total_rentals DESC " +
                        "LIMIT ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Vehicle vehicle = mapResultSetToVehicle(rs);
                vehicles.add(vehicle);
            }
            
            conn.commit();
            return vehicles;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách xe nổi bật: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return vehicles; // Trả về list rỗng nếu có lỗi
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Lấy danh sách xe nổi bật (mặc định 4 xe)
     */
    public List<Vehicle> getFeaturedVehicles() {
        return getFeaturedVehicles(4);
    }
    
    /**
     * Lấy thông tin chi tiết một xe theo vehicle_id
     * @param vehicleId ID của xe
     * @return Vehicle object nếu tìm thấy, null nếu không tìm thấy
     */
    public Vehicle findById(int vehicleId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT v.vehicle_id, v.license_plate, v.brand_id, v.model_name, " +
                        "v.model_year, v.category_id, v.fuel_type, v.transmission, " +
                        "v.engine_capacity, v.seat_capacity, v.color, v.daily_rate, " +
                        "v.weekly_rate, v.monthly_rate, v.deposit_amount, v.is_available, " +
                        "v.is_featured, v.description, v.specifications, v.amenities, " +
                        "v.rating, v.total_rentals, v.created_at, v.updated_at, " +
                        "b.brand_name, c.category_name, " +
                        "(SELECT image_url FROM vehicle_images WHERE vehicle_id = v.vehicle_id " +
                        "AND image_type = 'main' ORDER BY display_order LIMIT 1) as main_image_url " +
                        "FROM vehicles v " +
                        "LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id " +
                        "LEFT JOIN vehicle_categories c ON v.category_id = c.category_id " +
                        "WHERE v.vehicle_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, vehicleId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Vehicle vehicle = mapResultSetToVehicle(rs);
                conn.commit();
                return vehicle;
            }
            
            conn.commit();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm xe theo ID: " + e.getMessage());
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
     * Helper method: Map ResultSet sang Vehicle object
     */
    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
        Vehicle vehicle = new Vehicle();
        
        vehicle.setVehicleId(rs.getInt("vehicle_id"));
        vehicle.setLicensePlate(rs.getString("license_plate"));
        vehicle.setBrandId(rs.getInt("brand_id"));
        vehicle.setBrandName(rs.getString("brand_name"));
        vehicle.setModelName(rs.getString("model_name"));
        
        int modelYear = rs.getInt("model_year");
        if (!rs.wasNull()) {
            vehicle.setModelYear(modelYear);
        }
        
        vehicle.setCategoryId(rs.getInt("category_id"));
        vehicle.setCategoryName(rs.getString("category_name"));
        vehicle.setFuelType(rs.getString("fuel_type"));
        vehicle.setTransmission(rs.getString("transmission"));
        vehicle.setEngineCapacity(rs.getString("engine_capacity"));
        
        int seatCapacity = rs.getInt("seat_capacity");
        if (!rs.wasNull()) {
            vehicle.setSeatCapacity(seatCapacity);
        }
        
        vehicle.setColor(rs.getString("color"));
        
        BigDecimal dailyRate = rs.getBigDecimal("daily_rate");
        vehicle.setDailyRate(dailyRate);
        
        BigDecimal weeklyRate = rs.getBigDecimal("weekly_rate");
        if (weeklyRate != null) {
            vehicle.setWeeklyRate(weeklyRate);
        }
        
        BigDecimal monthlyRate = rs.getBigDecimal("monthly_rate");
        if (monthlyRate != null) {
            vehicle.setMonthlyRate(monthlyRate);
        }
        
        BigDecimal depositAmount = rs.getBigDecimal("deposit_amount");
        if (depositAmount != null) {
            vehicle.setDepositAmount(depositAmount);
        }
        
        vehicle.setAvailable(rs.getBoolean("is_available"));
        vehicle.setFeatured(rs.getBoolean("is_featured"));
        vehicle.setDescription(rs.getString("description"));
        vehicle.setSpecifications(rs.getString("specifications"));
        vehicle.setAmenities(rs.getString("amenities"));
        
        BigDecimal rating = rs.getBigDecimal("rating");
        if (rating != null) {
            vehicle.setRating(rating);
        } else {
            vehicle.setRating(BigDecimal.ZERO);
        }
        
        vehicle.setTotalRentals(rs.getInt("total_rentals"));
        vehicle.setMainImageUrl(rs.getString("main_image_url"));
        
        Date createdAt = rs.getDate("created_at");
        if (createdAt != null) {
            vehicle.setCreatedAt(createdAt);
        }
        
        Date updatedAt = rs.getDate("updated_at");
        if (updatedAt != null) {
            vehicle.setUpdatedAt(updatedAt);
        }
        
        return vehicle;
    }
    
    /**
     * Helper method: Đóng các resource (Connection, Statement, ResultSet)
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
     * Lấy danh sách xe phổ biến nhất (dựa trên view popular_vehicles)
     * @param limit Số lượng xe
     * @return List xe (có populating rating, rentals info)
     */
    public List<Vehicle> getPopularVehicles(int limit) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vehicle> vehicles = new ArrayList<>();
        
        try {
            conn = dbConnection.getConnection();
            
            // Sử dụng view popular_vehicles
            String sql = "SELECT * FROM popular_vehicles LIMIT ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(rs.getInt("vehicle_id"));
                vehicle.setLicensePlate(rs.getString("license_plate"));
                vehicle.setModelName(rs.getString("model_name"));
                vehicle.setBrandName(rs.getString("brand_name"));
                // View has wishlist_count, review_count, avg_rating
                vehicle.setRating(rs.getBigDecimal("avg_rating"));
                vehicle.setReviewCount(rs.getInt("review_count"));
                // Map wishlist_count to totalRentals for now as requested by user visualization or just simplistic mapping
                // Or better, set it to 0 if we don't have rental count, but sort order implies popularity.
                vehicle.setTotalRentals(rs.getInt("wishlist_count")); 
                
                vehicles.add(vehicle);
            }
            
            conn.commit();
            return vehicles;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return vehicles;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
}




