/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ptrung
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MaHoa {
    public String md5Hash(String input) {
        try {
            // Tạo instance của MessageDigest với MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            // Cập nhật chuỗi input và tính toán mã băm
            byte[] messageDigest = md.digest(input.getBytes());
            
            // Chuyển đổi byte thành định dạng hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    
    
}
