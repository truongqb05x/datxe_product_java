package nntruong.data.dao;

import nntruong.data.model.User;
import nntruong.utils.DatabaseConnection;
import nntruong.utils.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class để xử lý các thao tác với bảng users trong database
 * Bao gồm: thêm, sửa, xóa, tìm kiếm user
 */
public class UserDAO {
    
    private DatabaseConnection dbConnection;
    
    /**
     * Constructor - khởi tạo DatabaseConnection
     */
    public UserDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }
    
    /**
     * Tìm user theo email và password (dùng cho đăng nhập)
     * @param email Email của user
     * @param password Mật khẩu (plain text)
     * @return User object nếu tìm thấy và mật khẩu đúng, null nếu không tìm thấy hoặc mật khẩu sai
     */
    public User findByEmailAndPassword(String email, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Lấy connection từ DatabaseConnection
            conn = dbConnection.getConnection();
            
            // Câu SQL để tìm user theo email
            String sql = "SELECT user_id, email, password_hash, full_name, phone_number, " +
                        "avatar_url, date_of_birth, identity_card, driver_license_number, " +
                        "driver_license_type, address, is_verified, is_active, created_at, updated_at " +
                        "FROM users WHERE email = ? AND is_active = TRUE";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            
            rs = stmt.executeQuery();
            
            // Nếu tìm thấy user
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setAvatarUrl(rs.getString("avatar_url"));
                user.setDateOfBirth(rs.getDate("date_of_birth"));
                user.setIdentityCard(rs.getString("identity_card"));
                user.setDriverLicenseNumber(rs.getString("driver_license_number"));
                user.setDriverLicenseType(rs.getString("driver_license_type"));
                user.setAddress(rs.getString("address"));
                user.setVerified(rs.getBoolean("is_verified"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedAt(rs.getDate("created_at"));
                user.setUpdatedAt(rs.getDate("updated_at"));
                
                // Xác thực mật khẩu
                // Lưu ý: Nếu dùng SHA-256 với salt, cần lưu salt riêng trong database
                // Ở đây giả sử password_hash chứa cả salt và hash (format: salt:hash)
                String passwordHash = user.getPasswordHash();
                if (passwordHash != null && passwordHash.contains(":")) {
                    String[] parts = passwordHash.split(":");
                    String salt = parts[0];
                    String storedHash = parts[1];
                    
                    // Kiểm tra mật khẩu
                    if (PasswordUtil.verifyPassword(password, salt, storedHash)) {
                        conn.commit(); // Commit transaction
                        return user;
                    }
                } else {
                    // Nếu format cũ không có salt, so sánh trực tiếp (không an toàn, chỉ để tương thích)
                    if (passwordHash != null && passwordHash.equals(password)) {
                        conn.commit();
                        return user;
                    }
                }
            }
            
            // Không tìm thấy hoặc mật khẩu sai
            conn.rollback();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm user theo email và password: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            // Đóng các resource
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Tìm user theo email (không cần password)
     * @param email Email của user
     * @return User object nếu tìm thấy, null nếu không tìm thấy
     */
    public User findByEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT user_id, email, password_hash, full_name, phone_number, " +
                        "avatar_url, date_of_birth, identity_card, driver_license_number, " +
                        "driver_license_type, address, is_verified, is_active, created_at, updated_at " +
                        "FROM users WHERE email = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = mapResultSetToUser(rs);
                conn.commit();
                return user;
            }
            
            conn.commit();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm user theo email: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Tìm user theo user_id
     * @param userId ID của user
     * @return User object nếu tìm thấy, null nếu không tìm thấy
     */
    public User findById(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT user_id, email, password_hash, full_name, phone_number, " +
                        "avatar_url, date_of_birth, identity_card, driver_license_number, " +
                        "driver_license_type, address, is_verified, is_active, created_at, updated_at " +
                        "FROM users WHERE user_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = mapResultSetToUser(rs);
                conn.commit();
                return user;
            }
            
            conn.commit();
            return null;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm user theo ID: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return null;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Thêm user mới vào database (dùng cho đăng ký)
     * @param user User object cần thêm
     * @param password Mật khẩu plain text (sẽ được hash trước khi lưu)
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean insert(User user, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = dbConnection.getConnection();
            
            // Hash mật khẩu với salt
            String[] hashResult = PasswordUtil.hashPasswordWithSalt(password);
            String salt = hashResult[0];
            String hash = hashResult[1];
            // Lưu format: salt:hash
            String passwordHash = salt + ":" + hash;
            
            String sql = "INSERT INTO users (email, password_hash, full_name, phone_number, " +
                        "is_verified, is_active) VALUES (?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, passwordHash);
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setBoolean(5, user.isVerified());
            stmt.setBoolean(6, user.isActive());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                conn.commit(); // Commit transaction
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm user: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Cập nhật thông tin user
     * @param user User object cần cập nhật
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean update(User user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "UPDATE users SET email = ?, full_name = ?, phone_number = ?, " +
                        "avatar_url = ?, date_of_birth = ?, identity_card = ?, " +
                        "driver_license_number = ?, driver_license_type = ?, address = ?, " +
                        "is_verified = ?, is_active = ? WHERE user_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setString(4, user.getAvatarUrl());
            
            if (user.getDateOfBirth() != null) {
                stmt.setDate(5, user.getDateOfBirth());
            } else {
                stmt.setNull(5, Types.DATE);
            }
            
            stmt.setString(6, user.getIdentityCard());
            stmt.setString(7, user.getDriverLicenseNumber());
            stmt.setString(8, user.getDriverLicenseType());
            stmt.setString(9, user.getAddress());
            stmt.setBoolean(10, user.isVerified());
            stmt.setBoolean(11, user.isActive());
            stmt.setInt(12, user.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật user: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Xóa user (soft delete - chỉ set is_active = false)
     * @param userId ID của user cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     */
    public boolean delete(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = dbConnection.getConnection();
            
            // Soft delete - chỉ set is_active = false
            String sql = "UPDATE users SET is_active = FALSE WHERE user_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa user: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa (dùng khi đăng ký)
     * @param email Email cần kiểm tra
     * @return true nếu email đã tồn tại, false nếu chưa tồn tại
     */
    public boolean emailExists(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbConnection.getConnection();
            
            String sql = "SELECT COUNT(*) as count FROM users WHERE email = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("count");
                conn.commit();
                return count > 0;
            }
            
            conn.commit();
            return false;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra email: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Helper method: Map ResultSet sang User object
     * @param rs ResultSet từ database
     * @return User object
     * @throws SQLException nếu có lỗi khi đọc dữ liệu
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setPhoneNumber(rs.getString("phone_number"));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setDateOfBirth(rs.getDate("date_of_birth"));
        user.setIdentityCard(rs.getString("identity_card"));
        user.setDriverLicenseNumber(rs.getString("driver_license_number"));
        user.setDriverLicenseType(rs.getString("driver_license_type"));
        user.setAddress(rs.getString("address"));
        user.setVerified(rs.getBoolean("is_verified"));
        user.setActive(rs.getBoolean("is_active"));
        user.setCreatedAt(rs.getDate("created_at"));
        user.setUpdatedAt(rs.getDate("updated_at"));
        return user;
    }
    
    /**
     * Helper method: Đóng các resource (Connection, Statement, ResultSet)
     * @param conn Connection
     * @param stmt Statement/PreparedStatement
     * @param rs ResultSet
     */
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            dbConnection.closeConnection(conn);
        }
    }
    /**
     * Lấy danh sách tất cả users (dùng cho admin)
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return users;
    }
}
