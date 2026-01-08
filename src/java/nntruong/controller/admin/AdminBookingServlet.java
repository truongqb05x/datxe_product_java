package nntruong.controller.admin;

import nntruong.data.dao.BookingDAO;
import nntruong.data.dao.UserDAO;
import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Booking; // Ensure Booking is imported
import nntruong.data.model.User;
import nntruong.data.model.Vehicle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet; // Optional if web.xml is used, but good practice
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Servlet for managing bookings in Admin Dashboard
 */
@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private UserDAO userDAO;
    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        bookingDAO = new BookingDAO();
        userDAO = new UserDAO();
        vehicleDAO = new VehicleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Get Parameters
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String customerIdStr = request.getParameter("customerId");
        String vehicleIdStr = request.getParameter("vehicleId");
        String paymentStatus = request.getParameter("paymentStatus");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String pageStr = request.getParameter("page");
        
        // 2. Parse Parameters
        Integer customerId = null;
        if (customerIdStr != null && !customerIdStr.isEmpty()) {
            try { customerId = Integer.parseInt(customerIdStr); } catch (NumberFormatException e) {}
        }
        
        Integer vehicleId = null;
        if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
            try { vehicleId = Integer.parseInt(vehicleIdStr); } catch (NumberFormatException e) {}
        }
        
        Date startDate = null;
        Date endDate = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) startDate = sdf.parse(startDateStr);
            if (endDateStr != null && !endDateStr.isEmpty()) endDate = sdf.parse(endDateStr);
        } catch (Exception e) {}
        
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try { page = Integer.parseInt(pageStr); } catch (NumberFormatException e) {}
        }
        int limit = 10;
        int offset = (page - 1) * limit;

        // 3. Fetch Data
        java.sql.Date sqlStartDate = (startDate != null) ? new java.sql.Date(startDate.getTime()) : null;
        java.sql.Date sqlEndDate = (endDate != null) ? new java.sql.Date(endDate.getTime()) : null;
        
        List<Booking> bookings = bookingDAO.searchBookings(keyword, status, customerId, vehicleId, paymentStatus, sqlStartDate, sqlEndDate, offset, limit);
        int totalBookings = bookingDAO.countBookings(keyword, status, customerId, vehicleId, paymentStatus, sqlStartDate, sqlEndDate);
        int totalPages = (int) Math.ceil((double) totalBookings / limit);
        
        Map<String, Integer> stats = bookingDAO.getBookingStats();
        
        List<User> customers = userDAO.getAllUsers();
        List<Vehicle> vehicles = vehicleDAO.getAllVehicles();

        // 4. Set Attributes
        request.setAttribute("bookings", bookings);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalBookings", totalBookings); // Available as result count
        request.setAttribute("stats", stats);
        request.setAttribute("customers", customers); // For dropdown
        request.setAttribute("vehicles", vehicles);   // For dropdown
        
        // Keep filter values
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("customerId", customerId);
        request.setAttribute("vehicleId", vehicleId);
        request.setAttribute("paymentStatus", paymentStatus);
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);

        // 5. Forward
        request.getRequestDispatcher("/WEB-INF/jsp/dondatxe.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action"); // e.g., "updateStatus", "delete"
        
        if ("updateStatus".equals(action)) {
            String bookingIdStr = request.getParameter("bookingId");
            String newStatus = request.getParameter("status");
             try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = bookingDAO.updateStatus(bookingId, newStatus);
                 if (success) {
                      response.sendRedirect(request.getContextPath() + "/admin/bookings?message=StatusUpdated");
                 } else {
                      response.sendRedirect(request.getContextPath() + "/admin/bookings?error=UpdateFailed");
                 }
            } catch (NumberFormatException e) {
                 response.sendRedirect(request.getContextPath() + "/admin/bookings?error=InvalidId");
            }
        } else if ("delete".equals(action)) {
             String bookingIdStr = request.getParameter("bookingId");
             try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = bookingDAO.delete(bookingId);
                 if (success) {
                      response.sendRedirect(request.getContextPath() + "/admin/bookings?message=Deleted");
                 } else {
                      response.sendRedirect(request.getContextPath() + "/admin/bookings?error=DeleteFailed");
                 }
            } catch (NumberFormatException e) {
                 response.sendRedirect(request.getContextPath() + "/admin/bookings?error=InvalidId");
            }
        } else {
            // Handle other posts or re-direct
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }
}
