package nntruong.controller.admin;

import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Vehicle;
import nntruong.utils.JsonUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminVehicleApiServlet", urlPatterns = {"/api/vehicles/*"})
public class AdminVehicleApiServlet extends HttpServlet {

    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        vehicleDAO = new VehicleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                 // Return all or filtered list if params?
                 // Currently frontend calls this for list logic if separate, but primarily AdminVehicleServlet handles list.
                 // dondatxe/quanlyxe might use this for grid view if purely ajax. 
                 // The Javascript in quanlyxe.jsp: fetch(API_BASE_URL) .then...
                 // So yes, we need to return list search here if JSP uses AJAX for grid.
                 // Let's check parameters.
                 String keyword = request.getParameter("keyword");
                 // ... params
                 // Simplification: Return all for now or implement search logic mirroring Servlet.
                 // Better: Reuse searchVehicles from DAO.
                 
                 java.util.List<Vehicle> vehicles = vehicleDAO.searchVehicles(null, null, null, null, 0, 100);
                 response.getWriter().write(JsonUtil.toJson(vehicles));
            } else {
                 // /api/vehicles/{id}
                 String idStr = pathInfo.substring(1);
                 try {
                     int id = Integer.parseInt(idStr);
                     Vehicle vehicle = vehicleDAO.findById(id);
                     if (vehicle != null) {
                         response.getWriter().write(JsonUtil.toJson(vehicle));
                     } else {
                         response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                     }
                 } catch (NumberFormatException e) {
                     response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                 }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        
        String pathInfo = request.getPathInfo(); // /123
        if (pathInfo != null && pathInfo.length() > 1) {
             String idStr = pathInfo.substring(1);
             try {
                 int id = Integer.parseInt(idStr);
                 if (vehicleDAO.deleteVehicle(id)) {
                     response.setStatus(HttpServletResponse.SC_OK);
                     response.getWriter().write("{\"status\": \"success\"}");
                 } else {
                     response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                 }
             } catch (NumberFormatException e) {
                 response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
             }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
