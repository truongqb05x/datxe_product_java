package nntruong.servlet;

import nntruong.data.dao.UserDAO;
import nntruong.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng ký tài khoản mới
 * URL mapping: /register (đã cấu hình trong web.xml)
 * Method: POST
 */
public class RegisterServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    /**
     * Khởi tạo servlet - tạo instance của UserDAO
     */
    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo UserDAO để tương tác với database
        userDAO = new UserDAO();
    }
    
    /**
     * Xử lý GET request - redirect về trang chủ (không cho phép đăng ký qua GET)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect về trang chủ nếu truy cập bằng GET
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    /**
     * Xử lý POST request - xử lý đăng ký tài khoản mới
     * Lấy thông tin từ form, validate, kiểm tra email đã tồn tại chưa, tạo user mới
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy tham số từ form đăng ký (từ index.jsp)
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Biến để lưu thông báo lỗi (nếu có)
        String errorMessage = null;
        String successMessage = null;
        
        // Validation: Kiểm tra các trường bắt buộc
        if (fullName == null || fullName.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập họ và tên";
        } else if (phone == null || phone.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập số điện thoại";
        } else if (email == null || email.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập email";
        } else if (!isValidEmail(email.trim())) {
            errorMessage = "Email không hợp lệ";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập mật khẩu";
        } else if (password.length() < 6) {
            errorMessage = "Mật khẩu phải có ít nhất 6 ký tự";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Mật khẩu xác nhận không khớp";
        } else {
            try {
                // Kiểm tra email đã tồn tại chưa
                if (userDAO.emailExists(email.trim())) {
                    errorMessage = "Email này đã được sử dụng. Vui lòng chọn email khác.";
                } else {
                    // Tạo User object mới
                    User newUser = new User();
                    newUser.setEmail(email.trim());
                    newUser.setFullName(fullName.trim());
                    newUser.setPhoneNumber(phone.trim());
                    newUser.setVerified(false); // Mặc định chưa xác thực
                    newUser.setActive(true);    // Mặc định tài khoản hoạt động
                    
                    // Thêm user vào database (UserDAO sẽ tự động hash password)
                    boolean success = userDAO.insert(newUser, password);
                    
                    if (success) {
                        // Đăng ký thành công
                        successMessage = "Đăng ký thành công! Vui lòng đăng nhập.";
                        
                        // Tự động đăng nhập sau khi đăng ký thành công
                        User registeredUser = userDAO.findByEmailAndPassword(email.trim(), password);
                        if (registeredUser != null) {
                            // Tạo session và lưu thông tin user
                            HttpSession session = request.getSession(true);
                            session.setAttribute("user", registeredUser);
                            session.setAttribute("userId", registeredUser.getUserId());
                            session.setAttribute("userEmail", registeredUser.getEmail());
                            session.setAttribute("userName", registeredUser.getFullName());
                            session.setAttribute("isLoggedIn", true);
                            session.setMaxInactiveInterval(30 * 60); // 30 phút
                        }
                        
                        // Redirect về trang chủ với thông báo thành công
                        request.setAttribute("registerSuccess", successMessage);
                        response.sendRedirect(request.getContextPath() + "/");
                        return;
                        
                    } else {
                        // Đăng ký thất bại (lỗi database)
                        errorMessage = "Đăng ký thất bại. Vui lòng thử lại sau.";
                    }
                }
                
            } catch (Exception e) {
                // Xử lý lỗi ngoại lệ
                System.err.println("Lỗi khi đăng ký: " + e.getMessage());
                e.printStackTrace();
                errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
            }
        }
        
        // Nếu có lỗi, quay lại trang đăng ký với thông báo lỗi
        // Lưu errorMessage và các giá trị đã nhập vào request attribute
        request.setAttribute("registerError", errorMessage);
        request.setAttribute("registerFullName", fullName);
        request.setAttribute("registerPhone", phone);
        request.setAttribute("registerEmail", email);
        
        // Forward về trang chủ (modal đăng ký sẽ hiển thị với thông báo lỗi)
        request.getRequestDispatcher("/").forward(request, response);
    }
    
    /**
     * Kiểm tra định dạng email có hợp lệ không (validation đơn giản)
     * @param email Email cần kiểm tra
     * @return true nếu email hợp lệ, false nếu không hợp lệ
     */
    private boolean isValidEmail(String email) {
        // Regex pattern để kiểm tra email
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email != null && email.matches(emailRegex);
    }
}
