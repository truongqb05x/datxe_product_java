package nntruong.data.model;

import java.math.BigDecimal;

public class ReportDTO {
    
    // For Monthly Revenue Table/Chart
    public static class RevenueStat {
        private String month;
        private BigDecimal revenue;
        private double growth;
        private int bookings;
        private BigDecimal avgBooking;

        public RevenueStat(String month, BigDecimal revenue, double growth, int bookings, BigDecimal avgBooking) {
            this.month = month;
            this.revenue = revenue;
            this.growth = growth;
            this.bookings = bookings;
            this.avgBooking = avgBooking;
        }

        public String getMonth() { return month; }
        public BigDecimal getRevenue() { return revenue; }
        public double getGrowth() { return growth; }
        public int getBookings() { return bookings; }
        public BigDecimal getAvgBooking() { return avgBooking; }
    }

    // For Top Vehicles
    public static class VehiclePerformance {
        private String name;
        private int bookings;
        private double utilization;
        private BigDecimal revenue;
        private double change; // growth compared to prev period

        public VehiclePerformance(String name, int bookings, double utilization, BigDecimal revenue, double change) {
            this.name = name;
            this.bookings = bookings;
            this.utilization = utilization;
            this.revenue = revenue;
            this.change = change;
        }
        
        public String getName() { return name; }
        public int getBookings() { return bookings; }
        public double getUtilization() { return utilization; }
        public BigDecimal getRevenue() { return revenue; }
        public double getChange() { return change; }
    }

    // For Top Customers
    public static class CustomerStat {
        private String name;
        private int bookings;
        private BigDecimal avgSpent;
        private BigDecimal totalSpent;
        private int loyalty; // 0-100 score

        public CustomerStat(String name, int bookings, BigDecimal avgSpent, BigDecimal totalSpent, int loyalty) {
            this.name = name;
            this.bookings = bookings;
            this.avgSpent = avgSpent;
            this.totalSpent = totalSpent;
            this.loyalty = loyalty;
        }
        
        public String getName() { return name; }
        public int getBookings() { return bookings; }
        public BigDecimal getAvgSpent() { return avgSpent; }
        public BigDecimal getTotalSpent() { return totalSpent; }
        public int getLoyalty() { return loyalty; }
    }

    // For Category Analysis
    public static class CategoryStat {
        private String category;
        private BigDecimal revenue;
        private double percentage;
        private int bookings;
        private BigDecimal avgDaily;

        public CategoryStat(String category, BigDecimal revenue, double percentage, int bookings, BigDecimal avgDaily) {
            this.category = category;
            this.revenue = revenue;
            this.percentage = percentage;
            this.bookings = bookings;
            this.avgDaily = avgDaily;
        }
        
        public String getCategory() { return category; }
        public BigDecimal getRevenue() { return revenue; }
        public double getPercentage() { return percentage; }
        public int getBookings() { return bookings; }
        public BigDecimal getAvgDaily() { return avgDaily; }
    }
}
