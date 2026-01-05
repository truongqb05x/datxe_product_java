package nntruong.servlet;

import nntruong.data.dao.BookingDAO;
import nntruong.data.model.Booking;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Servlet xử lý đặt xe (booking)
 * URL mapping: /booking (đã cấu hình trong web.xml)
 * Method: POST
 */
public class BookingServlet extends HttpServlet {
    
    private BookingDAO bookingDAO;
    
    /**
     * Khởi tạo servlet - tạo instance của BookingDAO
     */
    @Override
    public void init() throws ServletException {
        super.init();
        bookingDAO = new BookingDAO();
    }
    
    /**
     * Xử lý GET request - redirect về trang đặt xe
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/datxe.jsp");
    }
    
    /**
     * Xử lý POST request - xử lý đặt xe
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("[BookingServlet] POST request received");
        
        // Kiểm tra user đã đăng nhập chưa
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("[BookingServlet] User not logged in");
            // Chưa đăng nhập, redirect về trang chủ với thông báo
            request.setAttribute("loginError", "Vui lòng đăng nhập để đặt xe");
            request.getRequestDispatcher("/index").forward(request, response);
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("[BookingServlet] User ID: " + userId);
        String errorMessage = null;
        
        try {
            // Lấy các tham số từ form
            String vehicleIdStr = request.getParameter("vehicleId");
            String pickupDateStr = request.getParameter("pickupDate");
            String returnDateStr = request.getParameter("returnDate");
            String pickupLocationStr = request.getParameter("pickupLocation");
            String returnLocationStr = request.getParameter("returnLocation");
            String paymentMethod = request.getParameter("paymentMethod");
            String notes = request.getParameter("notes");
            
            System.out.println("[BookingServlet] Form parameters:");
            System.out.println("  vehicleId: " + vehicleIdStr);
            System.out.println("  pickupDate: " + pickupDateStr);
            System.out.println("  returnDate: " + returnDateStr);
            System.out.println("  pickupLocation: " + pickupLocationStr);
            System.out.println("  returnLocation: " + returnLocationStr);
            System.out.println("  paymentMethod: " + paymentMethod);
            
            // Validation
            if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {
                errorMessage = "Vui lòng chọn xe cần thuê";
            } else if (pickupDateStr == null || pickupDateStr.trim().isEmpty()) {
                errorMessage = "Vui lòng chọn ngày nhận xe";
            } else if (returnDateStr == null || returnDateStr.trim().isEmpty()) {
                errorMessage = "Vui lòng chọn ngày trả xe";
            } else if (pickupLocationStr == null || pickupLocationStr.trim().isEmpty()) {
                errorMessage = "Vui lòng chọn địa điểm nhận xe";
            } else if (returnLocationStr == null || returnLocationStr.trim().isEmpty()) {
                errorMessage = "Vui lòng chọn địa điểm trả xe";
            } else {
                try {
                    // Parse các giá trị
                    Integer vehicleId = Integer.parseInt(vehicleIdStr);
                    Integer pickupLocationId = parseLocationId(pickupLocationStr);
                    Integer returnLocationId = parseLocationId(returnLocationStr);
                    
                    // Parse dates
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date pickupDate = dateFormat.parse(pickupDateStr);
                    Date returnDate = dateFormat.parse(returnDateStr);
                    
                    System.out.println("[BookingServlet] Parsed dates - Pickup: " + pickupDate + ", Return: " + returnDate);
                    
                    // Validate dates - use Calendar to properly set time to midnight
                    java.util.Calendar cal = java.util.Calendar.getInstance();
                    cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                    cal.set(java.util.Calendar.MINUTE, 0);
                    cal.set(java.util.Calendar.SECOND, 0);
                    cal.set(java.util.Calendar.MILLISECOND, 0);
                    Date today = cal.getTime();
                    
                    System.out.println("[BookingServlet] Today (midnight): " + today);
                    System.out.println("[BookingServlet] Validating dates...");
                    
                    if (pickupDate.before(today)) {
                        System.out.println("[BookingServlet] Validation failed: pickup date is in the past");
                        errorMessage = "Ngày nhận xe không được là ngày trong quá khứ";
                    } else if (returnDate.before(pickupDate) || returnDate.equals(pickupDate)) {
                        System.out.println("[BookingServlet] Validation failed: return date must be after pickup date");
                        errorMessage = "Ngày trả xe phải sau ngày nhận xe";
                    } else {
                        // Tạo booking object
                        Booking booking = new Booking();
                        booking.setUserId(userId);
                        booking.setVehicleId(vehicleId);
                        booking.setPickupLocationId(pickupLocationId);
                        booking.setReturnLocationId(returnLocationId);
                        booking.setPickupDate(new Timestamp(pickupDate.getTime()));
                        booking.setReturnDate(new Timestamp(returnDate.getTime()));
                        
                        // Set payment method nếu có
                        if (paymentMethod != null && !paymentMethod.trim().isEmpty()) {
                            booking.setPaymentMethod(paymentMethod);
                        }
                        
                        // Set notes nếu có
                        if (notes != null && !notes.trim().isEmpty()) {
                            booking.setNotes(notes);
                        }
                        
                        // Lưu vào database
                        System.out.println("[BookingServlet] Calling bookingDAO.insert()");
                        Integer bookingId = bookingDAO.insert(booking);
                        System.out.println("[BookingServlet] Booking ID returned: " + bookingId);
                        
                        if (bookingId != null) {
                            // Đặt xe thành công
                            System.out.println("[BookingServlet] Booking successful! Code: " + booking.getBookingCode());
                            // Lưu booking vào session để hiển thị ở trang success
                            session.setAttribute("lastBooking", booking);
                            
                            // Redirect về trang đặt xe với thông báo thành công
                            String redirectUrl = request.getContextPath() + "/datxe.jsp?success=true&bookingCode=" + booking.getBookingCode();
                            System.out.println("[BookingServlet] Redirecting to: " + redirectUrl);
                            response.sendRedirect(redirectUrl);
                            return;
                        } else {
                            System.out.println("[BookingServlet] Booking failed - bookingId is null");
                            errorMessage = "Đã xảy ra lỗi khi đặt xe. Vui lòng thử lại.";
                        }
                    }
                    
                } catch (NumberFormatException e) {
                    errorMessage = "Dữ liệu không hợp lệ";
                } catch (ParseException e) {
                    errorMessage = "Định dạng ngày không hợp lệ";
                }
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi xử lý booking: " + e.getMessage());
            e.printStackTrace();
            errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
        }
        
        // Nếu có lỗi, quay lại trang đặt xe với thông báo lỗi
        request.setAttribute("bookingError", errorMessage);
        request.getRequestDispatcher("/datxe.jsp").forward(request, response);
    }
    
    /**
     * Parse location ID từ string
     * Mapping: hq -> 1, branch1 -> 2, branch2 -> 3
     * @param locationStr Location string từ form
     * @return Location ID
     */
    private Integer parseLocationId(String locationStr) {
        switch (locationStr.toLowerCase()) {
            case "hq":
                return 1;
            case "branch1":
                return 2;
            case "branch2":
                return 3;
            default:
                // Nếu là số, parse trực tiếp
                try {
                    return Integer.parseInt(locationStr);
                } catch (NumberFormatException e) {
                    return 1; // Default to HQ
                }
        }
    }
}
