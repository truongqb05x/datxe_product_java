package nntruong.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class để xử lý mã hóa và xác thực mật khẩu
 * Sử dụng SHA-256 với salt để mã hóa mật khẩu
 * Lưu ý: Trong production nên sử dụng BCrypt hoặc Argon2 thay vì SHA-256
 */
public class PasswordUtil {
    
    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16; // Độ dài salt 16 bytes
    
    /**
     * Tạo salt ngẫu nhiên để thêm vào mật khẩu trước khi hash
     * @return Salt dạng Base64 string
     */
    public static String generateSalt() {
        try {
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[SALT_LENGTH];
            random.nextBytes(salt);
            // Chuyển salt thành Base64 string để lưu vào database
            return Base64.getEncoder().encodeToString(salt);
        } catch (Exception e) {
            System.err.println("Lỗi khi tạo salt: " + e.getMessage());
            throw new RuntimeException("Không thể tạo salt", e);
        }
    }
    
    /**
     * Hash mật khẩu với salt
     * @param password Mật khẩu gốc (plain text)
     * @param salt Salt string (Base64)
     * @return Password hash dạng Base64 string
     */
    public static String hashPassword(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            
            // Kết hợp password và salt
            md.update(salt.getBytes());
            byte[] hashedPassword = md.digest(password.getBytes("UTF-8"));
            
            // Chuyển hash thành Base64 string để lưu vào database
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (Exception e) {
            System.err.println("Lỗi khi hash password: " + e.getMessage());
            throw new RuntimeException("Không thể hash password", e);
        }
    }
    
    /**
     * Hash mật khẩu và tự động tạo salt
     * @param password Mật khẩu gốc
     * @return Mảng String[2] với [0] là salt, [1] là hash
     */
    public static String[] hashPasswordWithSalt(String password) {
        String salt = generateSalt();
        String hash = hashPassword(password, salt);
        return new String[]{salt, hash};
    }
    
    /**
     * Xác thực mật khẩu bằng cách so sánh hash
     * @param password Mật khẩu người dùng nhập vào
     * @param salt Salt đã lưu trong database
     * @param storedHash Hash đã lưu trong database
     * @return true nếu mật khẩu khớp, false nếu không khớp
     */
    public static boolean verifyPassword(String password, String salt, String storedHash) {
        try {
            // Hash mật khẩu nhập vào với salt đã lưu
            String computedHash = hashPassword(password, salt);
            
            // So sánh hash đã tính với hash đã lưu (constant-time comparison)
            return constantTimeEquals(computedHash, storedHash);
        } catch (Exception e) {
            System.err.println("Lỗi khi xác thực password: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * So sánh hai string với thời gian cố định để tránh timing attack
     * @param a String thứ nhất
     * @param b String thứ hai
     * @return true nếu bằng nhau, false nếu khác
     */
    private static boolean constantTimeEquals(String a, String b) {
        if (a == null || b == null) {
            return a == b;
        }
        if (a.length() != b.length()) {
            return false;
        }
        
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }
}
