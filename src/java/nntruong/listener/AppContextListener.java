package nntruong.listener;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

/**
 * Application Context Listener để xử lý lifecycle của web application
 * Đảm bảo proper cleanup của resources khi application shutdown
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    /**
     * Gọi khi web application khởi động
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("================================");
        System.out.println("Web Application Started: " + sce.getServletContext().getContextPath());
        System.out.println("================================");
    }

    /**
     * Gọi khi web application bị shutdown
     * Xử lý cleanup resources
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("================================");
        System.out.println("Web Application Shutting Down...");
        System.out.println("================================");
        
        try {
            // Shutdown MySQL abandoned connection cleanup thread
            AbandonedConnectionCleanupThread.uncheckedShutdown();
            System.out.println("MySQL cleanup thread shutdown successfully");
        } catch (Exception e) {
            System.err.println("Error shutting down MySQL cleanup thread: " + e.getMessage());
        }
        
        try {
            // Deregister JDBC drivers
            Enumeration<Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                Driver driver = drivers.nextElement();
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistered JDBC driver: " + driver.getClass().getName());
            }
        } catch (SQLException e) {
            System.err.println("Error deregistering JDBC drivers: " + e.getMessage());
        }
        
        System.out.println("================================");
        System.out.println("Web Application Shutdown Complete");
        System.out.println("================================");
    }
}
