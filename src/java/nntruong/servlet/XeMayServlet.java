package nntruong.servlet;

import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Vehicle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class XeMayServlet extends HttpServlet {
    
    private VehicleDAO vehicleDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        vehicleDAO = new VehicleDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Category ID 1 is for motorcycles (Xe máy)
        List<Vehicle> motorcycles = vehicleDAO.getVehiclesByCategoryId(1);
        
        // Pass data to JSP
        request.setAttribute("motorcycles", motorcycles);
        
        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/jsp/xemay.jsp").forward(request, response);
    }
}
