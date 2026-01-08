package nntruong.data.model;

import java.math.BigDecimal;

/**
 * Model class để chứa các thông số thống kê cho dashboard
 */
public class DashboardStats {
    private BigDecimal monthlyRevenue;
    private double revenueChange;
    private int totalBookings;
    private double bookingChange;
    private int activeVehicles;
    private int maintenanceVehicles;
    private int newUsers;
    private double userChange;

    public DashboardStats() {
        this.monthlyRevenue = BigDecimal.ZERO;
    }

    public BigDecimal getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(BigDecimal monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public double getRevenueChange() {
        return revenueChange;
    }

    public void setRevenueChange(double revenueChange) {
        this.revenueChange = revenueChange;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public double getBookingChange() {
        return bookingChange;
    }

    public void setBookingChange(double bookingChange) {
        this.bookingChange = bookingChange;
    }

    public int getActiveVehicles() {
        return activeVehicles;
    }

    public void setActiveVehicles(int activeVehicles) {
        this.activeVehicles = activeVehicles;
    }

    public int getMaintenanceVehicles() {
        return maintenanceVehicles;
    }

    public void setMaintenanceVehicles(int maintenanceVehicles) {
        this.maintenanceVehicles = maintenanceVehicles;
    }

    public int getNewUsers() {
        return newUsers;
    }

    public void setNewUsers(int newUsers) {
        this.newUsers = newUsers;
    }

    public double getUserChange() {
        return userChange;
    }

    public void setUserChange(double userChange) {
        this.userChange = userChange;
    }
}
