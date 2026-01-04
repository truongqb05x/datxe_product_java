package nntruong.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet để forward các request đến các trang JSP trong WEB-INF/jsp/
 * Xử lý các URL như /xemay.jsp, /xeoto.jsp, /datxe.jsp, etc.
 */
public class JspForwardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy tên file JSP từ request path
        String requestPath = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        // Loại bỏ context path và lấy tên file
        String jspFileName = requestPath.substring(contextPath.length());
        
        // Loại bỏ dấu "/" ở đầu và extension .jsp nếu có
        if (jspFileName.startsWith("/")) {
            jspFileName = jspFileName.substring(1);
        }
        if (jspFileName.endsWith(".jsp")) {
            jspFileName = jspFileName.substring(0, jspFileName.length() - 4);
        }
        
        // Forward đến JSP tương ứng trong WEB-INF/jsp/
        String jspPath = "/WEB-INF/jsp/" + jspFileName + ".jsp";
        request.getRequestDispatcher(jspPath).forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

