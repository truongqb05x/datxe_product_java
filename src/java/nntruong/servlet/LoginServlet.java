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
 * Servlet xử lý đăng nhập người dùng
 * URL mapping: /login (đã cấu hình trong web.xml)
 * Method: POST
 */
public class LoginServlet extends HttpServlet {
    
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
     * Xử lý GET request - redirect về trang chủ (không cho phép đăng nhập qua GET)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect về trang chủ nếu truy cập bằng GET
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    /**
     * Xử lý POST request - xử lý đăng nhập
     * Lấy email và password từ form, kiểm tra với database, tạo session nếu thành công
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy tham số từ form (từ index.jsp)
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe"); // Checkbox "Ghi nhớ đăng nhập"
        
        // Biến để lưu thông báo lỗi (nếu có)
        String errorMessage = null;
        
        // Validation: Kiểm tra email và password có được nhập không
        if (email == null || email.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập email";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập mật khẩu";
        } else if (!isValidEmail(email.trim())) {
            errorMessage = "Email không hợp lệ";
        } else if (password.length() < 6) {
            errorMessage = "Mật khẩu phải có ít nhất 6 ký tự";
        } else {
            try {
                // Tìm user trong database theo email và password
                // UserDAO sẽ tự động hash password và so sánh với hash trong database
                User user = userDAO.findByEmailAndPassword(email.trim(), password);
                
                if (user != null) {
                    // Đăng nhập thành công
                    // Tạo session và lưu thông tin user vào session
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", user); // Lưu user object vào session
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userEmail", user.getEmail());
                    session.setAttribute("userName", user.getFullName());
                    
                    // Nếu user chọn "Ghi nhớ đăng nhập", set session timeout dài hơn
                    if (rememberMe != null && rememberMe.equals("on")) {
                        // Set session timeout 30 ngày (2592000 giây)
                        session.setMaxInactiveInterval(30 * 24 * 60 * 60);
                    } else {
                        // Session timeout mặc định 30 phút (đã cấu hình trong web.xml)
                        session.setMaxInactiveInterval(30 * 60);
                    }
                    
                    // Set session attribute để biết user đã đăng nhập
                    session.setAttribute("isLoggedIn", true);
                    
                    // Đảm bảo response chưa được commit
                    if (!response.isCommitted()) {
                        // Redirect về trang chủ sau khi đăng nhập thành công
                        // Sử dụng redirect để URL thay đổi thành "/" thay vì "/login"
                        response.sendRedirect(request.getContextPath() + "/");
                        return;
                    }
                    
                } else {
                    // Đăng nhập thất bại - email hoặc password không đúng
                    errorMessage = "Email hoặc mật khẩu không đúng";
                }
                
            } catch (Exception e) {
                // Xử lý lỗi ngoại lệ (database connection error, etc.)
                System.err.println("Lỗi khi đăng nhập: " + e.getMessage());
                e.printStackTrace();
                errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
            }
        }
        
        // Nếu có lỗi, quay lại trang đăng nhập với thông báo lỗi
        // Lưu errorMessage vào request attribute để hiển thị trên JSP
        request.setAttribute("loginError", errorMessage);
        request.setAttribute("loginEmail", email); // Giữ lại email đã nhập
        
        // Forward về trang chủ (hoặc trang login nếu có)
        // Trang index.jsp sẽ hiển thị modal đăng nhập với thông báo lỗi
        // Sử dụng IndexServlet để xử lý và hiển thị trang chủ
        request.getRequestDispatcher("/index").forward(request, response);
    }
    
    /**
     * Kiểm tra định dạng email có hợp lệ không
     * @param email Email cần kiểm tra
     * @return true nếu email hợp lệ, false nếu không
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email != null && email.matches(emailRegex);
    }
}
