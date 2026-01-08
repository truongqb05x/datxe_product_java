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
    /**
     * Lấy danh sách tất cả vehicles (dùng cho admin)
     */
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT v.*, b.brand_name, c.category_name, " +
                         "(SELECT image_url FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND image_type = 'main' ORDER BY display_order LIMIT 1) as main_image_url " +
                         "FROM vehicles v " +
                         "LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id " +
                         "LEFT JOIN vehicle_categories c ON v.category_id = c.category_id " +
                         "ORDER BY v.created_at DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return vehicles;
    }
    /**
     * Search vehicles with filters and pagination
     */
    public List<Vehicle> searchVehicles(String keyword, String categoryId, String brandId, String status, int offset, int limit) {
        List<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            StringBuilder sql = new StringBuilder("SELECT v.*, b.brand_name, c.category_name, " +
                                                "(SELECT image_url FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND image_type = 'main' ORDER BY display_order LIMIT 1) as main_image_url " +
                                                "FROM vehicles v " +
                                                "LEFT JOIN vehicle_brands b ON v.brand_id = b.brand_id " +
                                                "LEFT JOIN vehicle_categories c ON v.category_id = c.category_id " +
                                                "WHERE 1=1 ");
            List<Object> params = new ArrayList<>();
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (v.license_plate LIKE ? OR v.model_name LIKE ?) ");
                String likeKey = "%" + keyword + "%";
                params.add(likeKey);
                params.add(likeKey);
            }
            if (categoryId != null && !categoryId.isEmpty()) {
                sql.append("AND v.category_id = ? ");
                params.add(Integer.parseInt(categoryId));
            }
            if (brandId != null && !brandId.isEmpty()) {
                sql.append("AND v.brand_id = ? ");
                params.add(Integer.parseInt(brandId));
            }
            if (status != null && !status.isEmpty()) {
                if ("available".equals(status)) {
                    sql.append("AND v.is_available = TRUE ");
                } else if ("rented".equals(status)) {
                    // Logic for rented might be complex (booking active), for now assuming is_available=FALSE means rented or maintenance
                    // Simplified: just check is_available or adding status column if exists. 
                    // The model has is_available. Let's assume unavailable means rented for now or we need a status column.
                    // Checking existing code: v.is_available boolean.
                    // User requirements imply status: available, rented, maintenance, unavailable.
                    // Database likely only has is_available. we might need to rely on bookings to know if rented.
                    // For now, let's map: available -> is_available=1. unavailable -> is_available=0.
                    sql.append("AND v.is_available = FALSE ");
                }
            }
            
            sql.append("ORDER BY v.created_at DESC LIMIT ? OFFSET ?");
            params.add(limit);
            params.add(offset);
            
            stmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return vehicles;
    }

    public int countVehicles(String keyword, String categoryId, String brandId, String status) {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM vehicles v WHERE 1=1 ");
            List<Object> params = new ArrayList<>();
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (v.license_plate LIKE ? OR v.model_name LIKE ?) ");
                String likeKey = "%" + keyword + "%";
                params.add(likeKey);
                params.add(likeKey);
            }
            if (categoryId != null && !categoryId.isEmpty()) {
                sql.append("AND v.category_id = ? ");
                params.add(Integer.parseInt(categoryId));
            }
            if (brandId != null && !brandId.isEmpty()) {
                sql.append("AND v.brand_id = ? ");
                params.add(Integer.parseInt(brandId));
            }
            if (status != null && !status.isEmpty()) {
                 if ("available".equals(status)) {
                    sql.append("AND v.is_available = TRUE ");
                } else if ("rented".equals(status) || "unavailable".equals(status)) {
                    sql.append("AND v.is_available = FALSE ");
                }
            }
            
            stmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            rs = stmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return count;
    }
    
    public java.util.Map<String, Integer> getVehicleStats() {
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            stmt = conn.createStatement();
            
            // Total
            rs = stmt.executeQuery("SELECT COUNT(*) FROM vehicles");
            if (rs.next()) stats.put("totalVehicles", rs.getInt(1));
            rs.close();
            
            // Available
            rs = stmt.executeQuery("SELECT COUNT(*) FROM vehicles WHERE is_available = TRUE");
            if (rs.next()) stats.put("availableVehicles", rs.getInt(1));
            rs.close();
            
            // Rented/Unavailable (Approximation)
            rs = stmt.executeQuery("SELECT COUNT(*) FROM vehicles WHERE is_available = FALSE");
            if (rs.next()) stats.put("rentedVehicles", rs.getInt(1));
            // Maintenance (Assuming no specific column yet, using 0)
            stats.put("maintenanceVehicles", 0);
            
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        return stats;
    }
    
    public java.util.Map<Integer, String> getAllBrands() {
        java.util.Map<Integer, String> brands = new java.util.HashMap<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM vehicle_brands ORDER BY brand_name");
            while (rs.next()) {
                brands.put(rs.getInt("brand_id"), rs.getString("brand_name"));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return brands;
    }
    
    public java.util.Map<Integer, String> getAllCategories() {
        java.util.Map<Integer, String> cats = new java.util.HashMap<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM vehicle_categories ORDER BY category_name");
            while (rs.next()) {
                cats.put(rs.getInt("category_id"), rs.getString("category_name"));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return cats;
    }
    
    public boolean deleteVehicle(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbConnection.getConnection();
            // Delete related images first (if cascade not set)
            stmt = conn.prepareStatement("DELETE FROM vehicle_images WHERE vehicle_id = ?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            
            // Delete vehicle
            stmt = conn.prepareStatement("DELETE FROM vehicles WHERE vehicle_id = ?");
            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            conn.commit();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
}




