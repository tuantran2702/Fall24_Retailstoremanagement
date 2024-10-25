/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.UserController;

import static controllers.UserController.ImageHandler.getAbsolutePath;
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
        User user = new User(); // Khởi tạo một đối tượng User mới
        request.setAttribute("user", user);
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
    private static final String UPLOAD_DIRECTORY = "web/img-anhthe";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect form data
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();

        SendEmail se = new SendEmail();
        String password = se.generateRandomCode(6);
        

        // Xử lý ảnh tải lên
        ImageHandler ih = new ImageHandler();
        String uploadFilePath = getServletContext().getRealPath("/") + "img-anhthe";
        String imgPath = "img-anhthe\\default.png"; // Đường dẫn mặc định nếu không có file upload

        // Lấy phần file tải lên từ request
        Part filePart = request.getPart("ImageUpload");

        if (filePart != null && filePart.getSize() > 0) {
            // Lưu ảnh vào thư mục upload và lấy đường dẫn ảnh
            imgPath = ih.luuAnh(filePart, uploadFilePath);
        }
        

        //Tao 1 User de kiem tra
        User addedUser = new User();

        addedUser.setFirstName(firstName);

        addedUser.setLastName(lastName);

        addedUser.setEmail(email);

        addedUser.setPassword(password); // Password will be hashed in the DAO layer

        addedUser.setPhoneNumber(phone);

        addedUser.setAddress(address);

        addedUser.setImg(imgPath); // Set the image path

        //Kiem tra Role
        int roleId;

        try {
            roleId = Integer.parseInt(request.getParameter("role"));
            addedUser.setRoleID(roleId);
        } catch (Exception e) {
            // Gửi thông báo lỗi khi người dùng không chọn chức vụ hợp lệ
            request.setAttribute("errorMessage", "Vui lòng chọn chức vụ.");

            request.setAttribute("user", addedUser);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return; // Dừng việc xử lý thêm người dùng
        }

        //Kiem Tra Email
        UserDAO ud = new UserDAO();
        User checkEmail = ud.getUserByEmail(addedUser.getEmail());
        if (checkEmail
                != null) {
            request.setAttribute("errorMessage", "Email already exists");

            addedUser.setEmail("");
            request.setAttribute("user", addedUser);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return;  // Dừng xử lý tiếp
        }

        // Kiểm tra số điện thoại có hợp lệ hay không (10 số và bắt đầu bằng 0)
        String phonePattern = "^0\\d{9}$";

        if (!phone.matches(phonePattern)) {
            // Nếu số điện thoại không hợp lệ, thiết lập thông báo lỗi
            request.setAttribute("errorMessage", "Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại 10 số bắt đầu bằng 0.");

            request.setAttribute("user", addedUser);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return;  // Dừng xử lý tiếp
        }
      
        // Create a user object
        User user = new User();

        user.setFirstName(addedUser.getFirstName());
        user.setLastName(addedUser.getLastName());
        user.setEmail(addedUser.getEmail());
        user.setPassword(addedUser.getPassword()); // Password will be hashed in the DAO layer
        user.setPhoneNumber(addedUser.getPhoneNumber());
        user.setAddress(addedUser.getAddress());
        user.setRoleID(addedUser.getRoleID());
        user.setImg(addedUser.getImg()); // Set the image path

        // Insert user into the database
        ;
        try {
            ud.addUser(user);
            se.sendEmailWelcome(email, password);
            response.sendRedirect("userManage"); // Redirect on success

        } catch (Exception e) {
            // Set error message in the request
            request.setAttribute("errorMessage", "An error occurred while adding the user. Please try again.");
            // Forward request back to the form page
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
        }

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
