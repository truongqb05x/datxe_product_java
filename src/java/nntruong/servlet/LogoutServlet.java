package nntruong.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng xuất người dùng
 * URL mapping: /logout (đã cấu hình trong web.xml)
 * Method: GET hoặc POST
 */
public class LogoutServlet extends HttpServlet {
    
    /**
     * Xử lý GET request - xử lý đăng xuất
     * Hủy session và redirect về trang chủ
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy session hiện tại (nếu có)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Xóa tất cả các attribute trong session
            session.removeAttribute("user");
            session.removeAttribute("userId");
            session.removeAttribute("userEmail");
            session.removeAttribute("userName");
            session.removeAttribute("isLoggedIn");
            
            // Hoặc có thể xóa toàn bộ session bằng cách invalidate
            // session.invalidate() sẽ xóa toàn bộ session và không thể sử dụng session object sau đó
            
            // Invalidate session (hủy session)
            session.invalidate();
        }
        
        // Redirect về trang chủ sau khi đăng xuất
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    /**
     * Xử lý POST request - tương tự GET
     * Cho phép gọi logout từ form POST nếu cần
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Gọi doGet để xử lý (DRY principle - Don't Repeat Yourself)
        doGet(request, response);
    }
}
