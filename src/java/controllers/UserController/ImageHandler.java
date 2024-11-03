/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers.UserController;

/**
 *
 * @author ptrung
 */
import java.io.File;
import java.io.IOException;
import jakarta.servlet.http.Part;

public class ImageHandler {
    public static final String UPLOAD_DIRECTORY = "img-anhthe";

    public String luuAnh(Part filePart, String rootDirectory) {
        String duongDanAnh = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Lấy tên file
            String tenFile = getFileName(filePart);
            duongDanAnh = UPLOAD_DIRECTORY + File.separator + tenFile;

            // Tạo đường dẫn đầy đủ để lưu file
            File thuMucLuu = new File(rootDirectory + File.separator + duongDanAnh);

            // Kiểm tra xem thư mục đã tồn tại chưa, nếu chưa thì tạo mới
            if (!thuMucLuu.getParentFile().exists()) {
                thuMucLuu.getParentFile().mkdirs();
            }

            // Ghi file vào đĩa
            try {
                filePart.write(thuMucLuu.getAbsolutePath());
            } catch (IOException e) {
                e.printStackTrace();  // Ghi log lỗi để kiểm tra
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

    public static String getAbsolutePath(String relativePath) {
        File file = new File(relativePath);
        return file.getAbsolutePath();
    }
}
