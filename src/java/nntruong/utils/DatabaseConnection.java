package nntruong.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class để quản lý kết nối đến cơ sở dữ liệu MySQL
 * Sử dụng Singleton pattern để đảm bảo chỉ có một connection pool
 */
public class DatabaseConnection {
    
    // Thông tin kết nối database - nên được lưu trong file config
    private static final String DB_URL = "jdbc:mysql://localhost:3306/datxe?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Instance duy nhất của class
    private static DatabaseConnection instance;
    
    /**
     * Constructor private để ngăn việc tạo instance từ bên ngoài (Singleton pattern)
     */
    private DatabaseConnection() {
        try {
            // Load MySQL JDBC driver
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("Lỗi: Không tìm thấy MySQL JDBC Driver");
            e.printStackTrace();
        }
    }
    
    /**
     * Lấy instance duy nhất của DatabaseConnection (Singleton pattern)
     * @return DatabaseConnection instance
     */
    public static DatabaseConnection getInstance() {
        // Double-check locking pattern để đảm bảo thread-safe
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }
    
    /**
     * Tạo và trả về một Connection mới đến database
     * Mỗi lần gọi sẽ tạo connection mới (có thể cải thiện bằng Connection Pool sau)
     * @return Connection object
     * @throws SQLException nếu có lỗi khi kết nối
     */
    public Connection getConnection() throws SQLException {
        try {
            // Tạo connection mới
            Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            
            // Đặt auto-commit thành false để có thể rollback nếu cần
            connection.setAutoCommit(false);
            
            return connection;
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối database: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Đóng connection
     * @param connection Connection cần đóng
     */
    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Kiểm tra connection có còn sống không
     * @param connection Connection cần kiểm tra
     * @return true nếu connection còn sống, false nếu không
     */
    public boolean isConnectionValid(Connection connection) {
        if (connection == null) {
            return false;
        }
        try {
            // Kiểm tra connection có còn valid không (timeout 5 giây)
            return connection.isValid(5);
        } catch (SQLException e) {
            return false;
        }
    }
}
