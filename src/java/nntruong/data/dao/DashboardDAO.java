package nntruong.data.dao;

import nntruong.data.model.DashboardStats;
import nntruong.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DAO xử lý các query thống kê cho Dashboard
 */
public class DashboardDAO {
    
    private DatabaseConnection dbConnection;

    public DashboardDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }

    /**
     * Lấy các chỉ số thống kê tổng quan (Dashboard Stats)
     */
    public DashboardStats getDashboardStats() {
        DashboardStats stats = new DashboardStats();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();

            // 1. Calculate Monthly Revenue (Current Month)
            String sqlRevenue = "SELECT SUM(amount) as total FROM payments WHERE status = 'completed' AND MONTH(payment_date) = MONTH(CURRENT_DATE()) AND YEAR(payment_date) = YEAR(CURRENT_DATE())";
            stmt = conn.prepareStatement(sqlRevenue);
            rs = stmt.executeQuery();
            if (rs.next()) {
                BigDecimal revenue = rs.getBigDecimal("total");
                stats.setMonthlyRevenue(revenue != null ? revenue : BigDecimal.ZERO);
            }
            rs.close();
            stmt.close();

            // 2. Calculate Total Bookings (Current Month)
            String sqlBookings = "SELECT COUNT(*) as total FROM bookings WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
            stmt = conn.prepareStatement(sqlBookings);
            rs = stmt.executeQuery();
            if (rs.next()) {
                stats.setTotalBookings(rs.getInt("total"));
            }
            rs.close();
            stmt.close();

            // 3. Count Active Vehicles
            String sqlActiveVehicles = "SELECT COUNT(*) as total FROM vehicles WHERE is_available = TRUE";
            stmt = conn.prepareStatement(sqlActiveVehicles);
            rs = stmt.executeQuery();
            if (rs.next()) {
                stats.setActiveVehicles(rs.getInt("total"));
            }
            rs.close();
            stmt.close();
            
            // 4. Count Maintenance Vehicles (Not available but active)
             String sqlMaintenanceVehicles = "SELECT COUNT(*) as total FROM vehicles WHERE is_available = FALSE";
            stmt = conn.prepareStatement(sqlMaintenanceVehicles);
            rs = stmt.executeQuery();
            if (rs.next()) {
                stats.setMaintenanceVehicles(rs.getInt("total"));
            }
            rs.close();
            stmt.close();


            // 5. New Users (Current Month)
            String sqlNewUsers = "SELECT COUNT(*) as total FROM users WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
            stmt = conn.prepareStatement(sqlNewUsers);
            rs = stmt.executeQuery();
            if (rs.next()) {
                stats.setNewUsers(rs.getInt("total"));
            }
            rs.close();
            stmt.close();
            
            // Note: Calculation for changes (%) requires previous month data. 
            // For now, I'll set dummy values for changes or implement real comparison if needed.
            // Let's implement a simple comparison for revenue
            
            // Previous Month Revenue
             String sqlPrevRevenue = "SELECT SUM(amount) as total FROM payments WHERE status = 'completed' AND MONTH(payment_date) = MONTH(CURRENT_DATE() - INTERVAL 1 MONTH) AND YEAR(payment_date) = YEAR(CURRENT_DATE() - INTERVAL 1 MONTH)";
            stmt = conn.prepareStatement(sqlPrevRevenue);
            rs = stmt.executeQuery();
            BigDecimal prevRevenue = BigDecimal.ZERO;
            if (rs.next()) {
                 BigDecimal val = rs.getBigDecimal("total");
                 if(val != null) prevRevenue = val;
            }
            
            if (prevRevenue.compareTo(BigDecimal.ZERO) > 0) {
                double change = stats.getMonthlyRevenue().subtract(prevRevenue)
                        .divide(prevRevenue, 4, java.math.RoundingMode.HALF_UP)
                        .multiply(new BigDecimal(100)).doubleValue();
                stats.setRevenueChange(change);
            } else {
                 stats.setRevenueChange(100.0); // Assuming 100% growth if prev was 0
            }


            conn.commit();
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            closeResources(conn, stmt, rs);
        }

        return stats;
    }

    /**
     * Lấy dữ liệu doanh thu theo tháng cho biểu đồ (12 tháng)
     */
    public List<BigDecimal> getMonthlyRevenueData() {
        List<BigDecimal> data = new ArrayList<>();
        // Initialize with 0 for 12 months
        for (int i = 0; i < 12; i++) data.add(BigDecimal.ZERO);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT MONTH(payment_date) as month, SUM(amount) as total " +
                         "FROM payments " +
                         "WHERE status = 'completed' AND YEAR(payment_date) = YEAR(CURRENT_DATE()) " +
                         "GROUP BY MONTH(payment_date)";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int month = rs.getInt("month"); // 1-12
                if (month >= 1 && month <= 12) {
                    data.set(month - 1, rs.getBigDecimal("total"));
                }
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return data;
    }
    
    /**
     * Lấy dữ liệu doanh thu theo quý cho biểu đồ
     */
    public List<BigDecimal> getQuarterlyRevenueData() {
        List<BigDecimal> data = new ArrayList<>();
        // Initialize 4 quarters
        for (int i = 0; i < 4; i++) data.add(BigDecimal.ZERO);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT QUARTER(payment_date) as quarter, SUM(amount) as total " +
                         "FROM payments " +
                         "WHERE status = 'completed' AND YEAR(payment_date) = YEAR(CURRENT_DATE()) " +
                         "GROUP BY QUARTER(payment_date)";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int quarter = rs.getInt("quarter"); // 1-4
                if (quarter >= 1 && quarter <= 4) {
                    data.set(quarter - 1, rs.getBigDecimal("total"));
                }
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return data;
    }

    /**
     * Lấy dữ liệu doanh thu theo năm (5 năm gần nhất)
     */
    public Map<Integer, BigDecimal> getYearlyRevenueData() {
        Map<Integer, BigDecimal> data = new HashMap<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            // Get last 5 years
            String sql = "SELECT YEAR(payment_date) as year, SUM(amount) as total " +
                         "FROM payments " +
                         "WHERE status = 'completed' AND YEAR(payment_date) >= YEAR(CURRENT_DATE()) - 4 " +
                         "GROUP BY YEAR(payment_date) ORDER BY year ASC";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                data.put(rs.getInt("year"), rs.getBigDecimal("total"));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return data;
    }

     /**
     * Gets a list of recent activities (Bookings + New Users)
     */
    public List<Map<String, String>> getRecentActivities() {
        List<Map<String, String>> activities = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
             conn = dbConnection.getConnection();
             // UNION query for Bookings and Users
             // Type 1: Booking, Type 2: User registration
             String sql = "(SELECT 'booking' as type, 'fa-calendar-check' as icon, " +
                          "CONCAT('Đơn đặt xe: ', b.booking_code) as title, " +
                          "CONCAT('Khách hàng: ', u.full_name) as details, " +
                          "b.created_at as time_sort, " +
                          "DATE_FORMAT(b.created_at, '%H:%i %d/%m') as time_display " +
                          "FROM bookings b JOIN users u ON b.user_id = u.user_id " +
                          "WHERE b.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)) " +
                          "UNION ALL " +
                          "(SELECT 'user' as type, 'fa-user-plus' as icon, " +
                          "'Người dùng mới' as title, " +
                          "full_name as details, " +
                          "created_at as time_sort, " +
                          "DATE_FORMAT(created_at, '%H:%i %d/%m') as time_display " +
                          "FROM users " +
                          "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)) " +
                          "ORDER BY time_sort DESC LIMIT 10";
             
             stmt = conn.prepareStatement(sql);
             rs = stmt.executeQuery();
             while(rs.next()) {
                 Map<String, String> activity = new HashMap<>();
                 activity.put("type", rs.getString("type"));
                 
                 // Remove fa- prefix if the JSP adds it, JSP says: <i class="fas fa-${activity.icon}"></i>
                 // My query returns 'fa-calendar-check'.
                 // If JSp does `fa-${activity.icon}`, then I should return `calendar-check`.
                 String icon = rs.getString("icon");
                 if (icon.startsWith("fa-")) icon = icon.substring(3);
                 
                 activity.put("icon", icon);
                 activity.put("title", rs.getString("title"));
                 activity.put("details", rs.getString("details"));
                 activity.put("time", rs.getString("time_display"));
                 activities.add(activity);
             }
             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
             closeResources(conn, stmt, rs);
        }
        
        return activities;
    }

    /**
     * Get recent notifications (simulated or from specific table)
     */
    public List<Map<String, Object>> getNotifications() {
        List<Map<String, Object>> notifications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            
            // Simulation: 
            // 1. New Bookings (Pending)
            String sqlBookings = "SELECT booking_code, created_at FROM bookings WHERE status = 'pending' ORDER BY created_at DESC LIMIT 3";
            stmt = conn.prepareStatement(sqlBookings);
            rs = stmt.executeQuery();
            while(rs.next()) {
                Map<String, Object> notif = new HashMap<>();
                notif.put("id", "b-" + rs.getString("booking_code"));
                notif.put("title", "Đơn đặt xe mới");
                notif.put("message", "Mã đơn: " + rs.getString("booking_code") + " cần xác nhận.");
                notif.put("icon", "calendar-plus");
                notif.put("time", getTimeAgo(rs.getTimestamp("created_at")));
                notif.put("unread", true);
                notifications.add(notif);
            }
            rs.close();
            stmt.close();

            // 2. Vehicles needing maintenance (Active but unavailable maybe?)
            // Or just mock some system alerts
            
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return notifications;
    }

    private String getTimeAgo(Timestamp time) {
        if (time == null) return "Vừa xong";
        long diff = System.currentTimeMillis() - time.getTime();
        long minutes = diff / (60 * 1000);
        
        if (minutes < 1) return "Vừa xong";
        if (minutes < 60) return minutes + " phút trước";
        long hours = minutes / 60;
        if (hours < 24) return hours + " giờ trước";
        long days = hours / 24;
        return days + " ngày trước";
    }

    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) dbConnection.closeConnection(conn);
    }
}
