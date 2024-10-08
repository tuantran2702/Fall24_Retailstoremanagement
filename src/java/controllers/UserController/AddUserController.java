/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.UserController;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;
import dao.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.User;
import java.sql.SQLException;

/**
 *
 * @author ptrung
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddUserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddUserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RoleDAO rd = new RoleDAO();
        List<Role> roles = rd.getAllRole();
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIRECTORY = "img-anhthe";  // Folder where images will be stored

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        //Kiem tra Role
        int roleId;
        try {
            roleId = Integer.parseInt(request.getParameter("role"));
        } catch (Exception e) {
            // Gửi thông báo lỗi khi người dùng không chọn chức vụ hợp lệ
            request.setAttribute("errorMessage", "Vui lòng chọn chức vụ.");

            request.setAttribute("firstname", firstName);
            request.setAttribute("lastname", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("pass", password);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return; // Dừng việc xử lý thêm người dùng
        }

        // Kiểm tra số điện thoại có hợp lệ hay không (10 số và bắt đầu bằng 0)
        String phonePattern = "^0\\d{9}$";
        if (!phone.matches(phonePattern)) {
            // Nếu số điện thoại không hợp lệ, thiết lập thông báo lỗi
            request.setAttribute("errorMessage", "Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại 10 số bắt đầu bằng 0.");

            request.setAttribute("firstname", firstName);
            request.setAttribute("lastname", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("pass", password);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return;  // Dừng xử lý tiếp
        }
        
        ImageHandler ih = new ImageHandler();
        String uploadFilePath = getServletContext().getRealPath("") + File.separator + "img-anhthe";
        String imgPath = null;

        // Lấy phần file tải lên
        Part filePart = request.getPart("ImageUpload");
        UserDAO ud = new UserDAO();
        

        // Hàm lưu ảnh
        imgPath = ih.luuAnh(filePart, uploadFilePath);

        // Nếu không có file được tải lên, giữ nguyên đường dẫn ảnh hiện tại
        if (imgPath == null) {
            imgPath = "img-anhthe\\default.png";
        }
        

//        // Handling image upload
//        String imgPath = null;
//        Part filePart = request.getPart("ImageUpload"); // "ImageUpload" is the name attribute in the form
//        if (filePart != null && filePart.getSize() > 0) {
//            String applicationPath = request.getServletContext().getRealPath("");
//            String uploadFilePath = applicationPath + File.separator + "img-anhthe"; // Directory to store the uploaded image
//
//            // Create directory if it doesn't exist
//            File uploadDir = new File(uploadFilePath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs();
//            }
//
//            // Extract file name and save the file
//            String fileName = getFileName(filePart);
//            String fullFilePath = uploadFilePath + File.separator + fileName;
//            filePart.write(fullFilePath);
//
//            // Set the image path to store in the database (optional: relative path)
//            imgPath = "img-anhthe/" + fileName;
//        }else imgPath = "img-anhthe\\default.png";



        // Create a user object
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password); // Password will be hashed in the DAO layer
        user.setPhoneNumber(phone);
        user.setAddress(address);
        user.setRoleID(roleId);
        user.setImg(imgPath); // Set the image path

        // Insert user into the database
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.addUser(user);
            response.sendRedirect("userManage"); // Redirect on success

        } catch (Exception e) {
            // Set error message in the request
            request.setAttribute("errorMessage", "An error occurred while adding the user. Please try again.");
            // Forward request back to the form page
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
        }

    }
// Helper method to get file name

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}