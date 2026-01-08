package nntruong.controller.admin;

import nntruong.data.dao.ReportDAO;
import nntruong.data.model.ReportDTO;
import nntruong.utils.JsonUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ReportServlet", urlPatterns = {"/admin/reports"})
public class ReportServlet extends HttpServlet {

    private ReportDAO reportDAO;

    @Override
    public void init() throws ServletException {
        reportDAO = new ReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Fetch Data
        List<ReportDTO.RevenueStat> revenueStats = reportDAO.getMonthlyRevenueStats();
        List<ReportDTO.VehiclePerformance> topVehicles = reportDAO.getTopVehicles(5);
        List<ReportDTO.CustomerStat> topCustomers = reportDAO.getTopCustomers(5);
        List<ReportDTO.CategoryStat> categoryStats = reportDAO.getCategoryStats();

        // Calculate KPIs (Simulated from latest month)
        if (!revenueStats.isEmpty()) {
            ReportDTO.RevenueStat current = revenueStats.get(0); // Latest month
            request.setAttribute("monthlyRevenue", current.getRevenue());
            request.setAttribute("revenueChange", Math.round(current.getGrowth() * 10.0) / 10.0);
            request.setAttribute("totalBookings", current.getBookings());
            // Mock changes for other stats
            request.setAttribute("bookingChange", 12.5);
            request.setAttribute("currentMonth", current.getMonth());
        } else {
             request.setAttribute("monthlyRevenue", BigDecimal.ZERO);
             request.setAttribute("revenueChange", 0.0);
             request.setAttribute("totalBookings", 0);
             request.setAttribute("bookingChange", 0.0);
             request.setAttribute("currentMonth", LocalDate.now().getMonthValue());
        }
        
        // Mock other KPIs not directly in main query
        request.setAttribute("vehicleUtilization", 78.5);
        request.setAttribute("utilizationChange", 2.4);
        request.setAttribute("newCustomers", 45);
        request.setAttribute("customerChange", 15.0);
        request.setAttribute("retentionRate", 85);
        // Top vehicle for insights
        if (!topVehicles.isEmpty()) {
            request.setAttribute("topVehicleName", topVehicles.get(0).getName());
            request.setAttribute("topVehicleContribution", 18);
        }

        // Set Lists for Tables
        request.setAttribute("monthlyRevenueData", revenueStats);
        request.setAttribute("topVehicles", topVehicles);
        request.setAttribute("topCustomers", topCustomers);
        request.setAttribute("categoryData", categoryStats);
        
        // Prepare Chart Data (JSON)
        // Reverse for chart (oldest to newest)
        List<String> months = revenueStats.stream()
                .sorted((a, b) -> 0) // Keep order if query returns desc and we want desc? Chart usually needs asc. 
                 // SQL was (ORDER BY year DESC, month DESC), so list is Newest -> Oldest.
                 // We need Oldest -> Newest for chart.
                .map(ReportDTO.RevenueStat::getMonth)
                .collect(Collectors.toList());
        java.util.Collections.reverse(months);
        
        List<BigDecimal> revenues = revenueStats.stream()
                .map(ReportDTO.RevenueStat::getRevenue)
                .collect(Collectors.toList());
        java.util.Collections.reverse(revenues);

        // Simple implementation - manual JSON construction or use JsonUtil if it supports lists
        // Note: JsonUtil might need updates for List<String> or BigDecimal. 
        // Let's rely on string building for simple arrays to be safe and fast.
        request.setAttribute("chartMonths", toJsArray(months));
        request.setAttribute("chartRevenue", toJsNumericArray(revenues));
        
        // Forward
        request.getRequestDispatcher("/WEB-INF/jsp/baocaothongke.jsp").forward(request, response);
    }
    
    private String toJsArray(List<String> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append("'").append(list.get(i)).append("'");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsNumericArray(List<?> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i).toString());
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
