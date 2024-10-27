/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers.UserController;

/**
 *
 * @author ptrung
 */
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ImageHandler {

    // Đường dẫn thư mục lưu ảnh trong thư mục gốc của dự án
    private static final String UPLOAD_DIRECTORY = "img-anhthe";

    public String luuAnh(Part filePart, ServletContext context) throws IOException {
        if (filePart == null || filePart.getSize() <= 0) {
            return "img-anhthe/default.png"; // Đường dẫn ảnh mặc định nếu không có file upload
        }

        // Lấy đường dẫn tuyệt đối của thư mục `webapp/img-anhthe`
        String uploadFilePath = context.getRealPath("/") + UPLOAD_DIRECTORY;

        createDirectoryIfNotExists(uploadFilePath);

        // Lấy tên file và tạo đường dẫn đầy đủ để lưu file
        String fileName = getFileName(filePart);
        Path filePath = Paths.get(uploadFilePath, fileName);

        // Ghi file vào đĩa
        // Sử dụng Files.copy để ghi file
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }

        // Trả về đường dẫn tương đối để lưu vào cơ sở dữ liệu hoặc hiển thị
        return UPLOAD_DIRECTORY + "\\" + fileName;
    }

    private String getFileName(Part part) {
        // Lấy tên file từ header
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1);
            }
        }
        return null;
    }

    private static void createDirectoryIfNotExists(String directoryPath) throws IOException {
        Path directory = Paths.get(directoryPath);
        if (Files.notExists(directory)) {
            Files.createDirectories(directory);
        }
    }

    public static void main(String[] args) {
        try {
            // Lấy thư mục gốc của dự án và tạo đường dẫn đầy đủ cho UPLOAD_DIRECTORY
            String projectRoot = System.getProperty("user.dir");  // Thư mục gốc của dự án
            String uploadFilePath = projectRoot + File.separator + UPLOAD_DIRECTORY;
            createDirectoryIfNotExists(uploadFilePath);

            // Đường dẫn đầy đủ của file txt kiểm tra
            Path testFilePath = Paths.get(uploadFilePath, "testFile.txt");

            // Kiểm tra và ghi nội dung vào file test
            try (FileWriter writer = new FileWriter(testFilePath.toFile())) {
                writer.write("Đây là file kiểm tra ghi thành công.");
                System.out.println("File đã được ghi thành công vào: " + testFilePath.toString());
            } catch (IOException e) {
                System.out.println("Lỗi khi ghi file: " + e.getMessage());
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
