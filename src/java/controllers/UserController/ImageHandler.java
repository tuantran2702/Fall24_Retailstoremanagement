/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers.UserController;

/**
 *
 * @author ptrung
 */
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;


public class ImageHandler {

    public String luuAnh(Part filePart, String duongDanLuuAnh) {
        String duongDanAnh = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Lấy tên file
            String tenFile = getFileName(filePart);
            duongDanAnh = "img-anhthe/" + tenFile;

            // Tạo đường dẫn đầy đủ để lưu file
            File thuMucLuu = new File(duongDanLuuAnh + File.separator + tenFile);

            // Kiểm tra xem thư mục đã tồn tại chưa, nếu chưa thì tạo mới
            if (!thuMucLuu.getParentFile().exists()) {
                thuMucLuu.getParentFile().mkdirs();
            }

            // Ghi file vào đĩa
            try {
                filePart.write(thuMucLuu.getAbsolutePath());
            } catch (IOException e) {
                e.printStackTrace();  // Ghi log lỗi để kiểm tra
                // Xử lý lỗi khi ghi file
            }
        }
        return duongDanAnh; // Trả về đường dẫn ảnh đã lưu
    }

    private String getFileName(Part part) {
        // Lấy tên file từ header
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1);
            }
        }
        return null;
    }
}