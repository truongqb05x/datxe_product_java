package nntruong.servlet;

import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Vehicle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet xử lý trang đặt xe (datxe.jsp)
 * Lấy thông tin xe từ database và forward đến JSP
 * URL mapping: /datxe.jsp (đã cấu hình trong web.xml qua JspForwardServlet)
 */
public class DatXeServlet extends HttpServlet {
    
    private VehicleDAO vehicleDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        vehicleDAO = new VehicleDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy vehicleId từ URL parameter
        String vehicleIdStr = request.getParameter("vehicleId");
        Vehicle vehicle = null;
        
        if (vehicleIdStr != null && !vehicleIdStr.trim().isEmpty()) {
            try {
                int vehicleId = Integer.parseInt(vehicleIdStr);
                // Lấy thông tin xe từ database
                vehicle = vehicleDAO.findById(vehicleId);
            } catch (NumberFormatException e) {
                System.err.println("Invalid vehicleId: " + vehicleIdStr);
            }
        }
        
        // Nếu không tìm thấy xe, lấy xe đầu tiên hoặc để null
        if (vehicle == null && vehicleIdStr != null) {
            System.out.println("Vehicle not found with ID: " + vehicleIdStr);
        }
        
        // Set vehicle vào request attribute để JSP sử dụng
        request.setAttribute("selectedVehicle", vehicle);
        
        // Forward đến JSP
        request.getRequestDispatcher("/WEB-INF/jsp/datxe.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST request cũng xử lý giống GET (cho trường hợp redirect từ servlet khác)
        doGet(request, response);
    }
}
