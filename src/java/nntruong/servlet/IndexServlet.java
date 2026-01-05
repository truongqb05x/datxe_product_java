package nntruong.servlet;

import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Vehicle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý trang chủ (index)
 * URL mapping: /index hoặc / (sẽ cấu hình trong web.xml)
 * Method: GET
 */
public class IndexServlet extends HttpServlet {
    
    private VehicleDAO vehicleDAO;
    
    /**
     * Khởi tạo servlet - tạo instance của VehicleDAO
     */
    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo VehicleDAO để tương tác với database
        vehicleDAO = new VehicleDAO();
    }
    
    /**
     * Xử lý GET request - lấy danh sách xe nổi bật và hiển thị trang chủ
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy danh sách xe nổi bật từ database (tối đa 4 xe)
            List<Vehicle> featuredVehicles = vehicleDAO.getFeaturedVehicles(4);
            
            // Lưu danh sách xe vào request attribute để JSP có thể truy cập
            request.setAttribute("featuredVehicles", featuredVehicles);
            
            // Forward đến trang index.jsp
            request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Xử lý lỗi ngoại lệ (database connection error, etc.)
            System.err.println("Lỗi khi lấy danh sách xe nổi bật: " + e.getMessage());
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn forward đến trang index.jsp nhưng không có dữ liệu
            // Trang sẽ hiển thị thông báo hoặc không hiển thị phần xe nổi bật
            request.setAttribute("featuredVehicles", null);
            request.setAttribute("errorMessage", "Không thể tải danh sách xe nổi bật. Vui lòng thử lại sau.");
            
            request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý POST request - redirect về GET
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}




