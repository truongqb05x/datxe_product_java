package nntruong.controller;

import nntruong.data.dao.VehicleDAO;
import nntruong.data.model.Vehicle;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Spring Controller để xử lý root path "/" và lấy danh sách xe nổi bật
 */
public class IndexController implements Controller {
    
    private VehicleDAO vehicleDAO;
    
    public IndexController() {
        this.vehicleDAO = new VehicleDAO();
    }
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            // Lấy danh sách xe nổi bật từ database (tối đa 4 xe)
            List<Vehicle> featuredVehicles = vehicleDAO.getFeaturedVehicles(4);
            
            // Tạo ModelAndView và set dữ liệu
            ModelAndView modelAndView = new ModelAndView("index");
            modelAndView.addObject("featuredVehicles", featuredVehicles);
            
            return modelAndView;
            
        } catch (Exception e) {
            // Xử lý lỗi ngoại lệ
            System.err.println("Lỗi khi lấy danh sách xe nổi bật: " + e.getMessage());
            e.printStackTrace();
            
            // Vẫn trả về view nhưng không có dữ liệu
            ModelAndView modelAndView = new ModelAndView("index");
            modelAndView.addObject("featuredVehicles", null);
            modelAndView.addObject("errorMessage", "Không thể tải danh sách xe nổi bật. Vui lòng thử lại sau.");
            
            return modelAndView;
        }
    }
}

