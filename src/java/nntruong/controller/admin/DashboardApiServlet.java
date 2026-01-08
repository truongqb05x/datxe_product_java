package nntruong.controller.admin;

import nntruong.utils.JsonUtil;
import nntruong.data.dao.DashboardDAO;
import nntruong.data.model.DashboardStats;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DashboardApiServlet", urlPatterns = {"/admin/api/*"})
public class DashboardApiServlet extends HttpServlet {

    private DashboardDAO dashboardDAO;

    @Override
    public void init() throws ServletException {
        dashboardDAO = new DashboardDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo(); // /notifications, /recent-activities, /dashboard-stats
        // Gson gson = new Gson(); // Removed

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            if (pathInfo.equals("/notifications")) {
                List<Map<String, Object>> notifications = dashboardDAO.getNotifications();
                response.getWriter().write(JsonUtil.toJson(notifications));
                
            } else if (pathInfo.equals("/recent-activities")) {
                List<Map<String, String>> activities = dashboardDAO.getRecentActivities();
                response.getWriter().write(JsonUtil.toJson(activities));
                
            } else if (pathInfo.equals("/dashboard-stats")) {
                DashboardStats stats = dashboardDAO.getDashboardStats();
                response.getWriter().write(JsonUtil.toJson(stats));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
         if (pathInfo != null && pathInfo.equals("/notifications/mark-read")) {
             // Mock implementation
             response.setStatus(HttpServletResponse.SC_OK);
         } else {
             response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
         }
    }
}
