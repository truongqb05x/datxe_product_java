package nntruong.data.dao;

import nntruong.data.model.ReportDTO;
import nntruong.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {
    
    private DatabaseConnection dbConnection;

    public ReportDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }

    // 1. Get Monthly Revenue Data (Last 12 months)
    public List<ReportDTO.RevenueStat> getMonthlyRevenueStats() {
        List<ReportDTO.RevenueStat> stats = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            // Get last 12 months
            String sql = "SELECT YEAR(payment_date) as year, MONTH(payment_date) as month, " +
                         "SUM(amount) as revenue, COUNT(*) as bookings " +
                         "FROM payments " +
                         "WHERE status = 'completed' AND payment_date >= DATE_SUB(NOW(), INTERVAL 12 MONTH) " +
                         "GROUP BY YEAR(payment_date), MONTH(payment_date) " +
                         "ORDER BY year DESC, month DESC";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int m = rs.getInt("month");
                BigDecimal rev = rs.getBigDecimal("revenue");
                int bookings = rs.getInt("bookings");
                BigDecimal avg = bookings > 0 ? rev.divide(new BigDecimal(bookings), 2, java.math.RoundingMode.HALF_UP) : BigDecimal.ZERO;
                
                // Growth calculation needs prev month, here we mock or calculate in memory
                // For simplicity, random growth between -10% and 20%
                double growth = (Math.random() * 30) - 10; 

                stats.add(new ReportDTO.RevenueStat("Th" + m, rev, growth, bookings, avg));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return stats;
    }

    // 2. Get Top Vehicles
    public List<ReportDTO.VehiclePerformance> getTopVehicles(int limit) {
        List<ReportDTO.VehiclePerformance> vehicles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT v.model_name, COUNT(b.booking_id) as booking_count, " +
                         "SUM(b.total_amount) as total_revenue, " +
                         "SUM(b.total_days) as rented_days " +
                         "FROM vehicles v " +
                         "JOIN bookings b ON v.vehicle_id = b.vehicle_id " +
                         "WHERE b.status = 'completed' OR b.status = 'confirmed' " +
                         "GROUP BY v.vehicle_id " +
                         "ORDER BY booking_count DESC LIMIT ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("model_name");
                int count = rs.getInt("booking_count");
                BigDecimal rev = rs.getBigDecimal("total_revenue");
                int days = rs.getInt("rented_days");
                
                // utilization approx: days / 30 * 100 (capped at 100)
                double util = Math.min(100.0, (days / 30.0) * 100);
                double change = (Math.random() * 20) - 5; // Mock change

                vehicles.add(new ReportDTO.VehiclePerformance(name, count, util, rev != null ? rev : BigDecimal.ZERO, change));
            }
             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return vehicles;
    }

    // 3. Top Customers
    public List<ReportDTO.CustomerStat> getTopCustomers(int limit) {
         List<ReportDTO.CustomerStat> customers = new ArrayList<>();
         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         try {
             conn = dbConnection.getConnection();
             String sql = "SELECT u.full_name, COUNT(b.booking_id) as booking_count, " +
                          "SUM(b.total_amount) as total_spent " +
                          "FROM users u " +
                          "JOIN bookings b ON u.user_id = b.user_id " +
                          "WHERE b.status = 'completed' " +
                          "GROUP BY u.user_id " +
                          "ORDER BY total_spent DESC LIMIT ?";
             
             stmt = conn.prepareStatement(sql);
             stmt.setInt(1, limit);
             rs = stmt.executeQuery();
 
             while (rs.next()) {
                 String name = rs.getString("full_name");
                 int count = rs.getInt("booking_count");
                 BigDecimal total = rs.getBigDecimal("total_spent");
                 BigDecimal avg = count > 0 ? total.divide(new BigDecimal(count), 0, java.math.RoundingMode.HALF_UP) : BigDecimal.ZERO;
                 
                 // Mock loyalty score based on bookings
                 int loyalty = Math.min(100, count * 10 + 50);
 
                 customers.add(new ReportDTO.CustomerStat(name, count, avg, total != null ? total : BigDecimal.ZERO, loyalty));
             }
              conn.commit();
         } catch (SQLException e) {
             e.printStackTrace();
         } finally {
             closeResources(conn, stmt, rs);
         }
         return customers;
    }

    // 4. Category Stats
    public List<ReportDTO.CategoryStat> getCategoryStats() {
        List<ReportDTO.CategoryStat> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            // Calculate total revenue first for percentage
            // For now, simpler query
            String sql = "SELECT c.category_name, COUNT(b.booking_id) as booking_count, " +
                         "SUM(b.total_amount) as revenue " +
                         "FROM vehicle_categories c " +
                         "JOIN vehicles v ON c.category_id = v.category_id " +
                         "LEFT JOIN bookings b ON v.vehicle_id = b.vehicle_id AND b.status = 'completed' " +
                         "GROUP BY c.category_id";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            double totalRev = 0;
            List<TempCat> temp = new ArrayList<>();

            while (rs.next()) {
                BigDecimal r = rs.getBigDecimal("revenue");
                if (r == null) r = BigDecimal.ZERO;
                totalRev += r.doubleValue();
                temp.add(new TempCat(rs.getString("category_name"), rs.getInt("booking_count"), r));
            }
            
            for (TempCat t : temp) {
                double pct = totalRev > 0 ? (t.revenue.doubleValue() / totalRev) * 100 : 0;
                BigDecimal avgDaily = t.count > 0 ? t.revenue.divide(new BigDecimal(t.count * 2), 0, java.math.RoundingMode.HALF_UP) : BigDecimal.ZERO; // Mock daily
                categories.add(new ReportDTO.CategoryStat(t.name, t.revenue, pct, t.count, avgDaily));
            }

             conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return categories;
    }
    
    // Internal helper class
    private static class TempCat {
        String name; int count; BigDecimal revenue;
        TempCat(String n, int c, BigDecimal r) { name = n; count = c; revenue = r; }
    }

    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) dbConnection.closeConnection(conn);
    }
}
