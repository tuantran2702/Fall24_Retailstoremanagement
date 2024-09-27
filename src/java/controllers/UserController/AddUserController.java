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
import jakarta.servlet.http.Part;
import java.io.File;
import model.User;

/**
 *
 * @author ptrung
 */
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
    private static final String SAVE_DIR = "img-sanpham";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        // Kiểm tra giá trị của role
        int roleID = 0; // giá trị mặc định
        String errorMessage = null;

        // Validate dữ liệu nhập vào
        if (firstName == null || firstName.isEmpty()) {
            errorMessage = "First name is required.";
        } else if (lastName == null || lastName.isEmpty()) {
            errorMessage = "Last name is required.";
        } else if (email == null || email.isEmpty()) {
            errorMessage = "Email is required.";
        } else if (password == null || password.isEmpty()) {
            errorMessage = "Password is required.";
        } else if (roleParam == null || roleParam.isEmpty()) {
            errorMessage = "Please select a valid role.";
        } else {
            try {
                roleID = Integer.parseInt(roleParam);
            } catch (NumberFormatException e) {
                errorMessage = "Invalid role ID.";
            }
        }

        // Nếu có lỗi, chuyển lại về form với thông báo lỗi
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            response.sendRedirect("addUser");
            // request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return;
        }

        // Xử lý file upload
        String imagePath = uploadImage(request);

        // Khởi tạo đối tượng User
        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phone);
        newUser.setAddress(address);
        newUser.setPassword(password);
        newUser.setRoleID(roleID);
        newUser.setImg(imagePath);

        // Gọi phương thức addUser để thêm nhân viên vào database
        UserDAO userDAO = new UserDAO();
        userDAO.addUser(newUser);

        // Chuyển hướng về trang quản lý người dùng
        response.sendRedirect("userManage");
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        // Lấy đường dẫn thực tế để lưu file
        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + SAVE_DIR;

        // Tạo thư mục lưu ảnh nếu chưa tồn tại
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        // Lấy file upload từ form
        Part filePart = request.getPart("ImageUpload");
        String fileName = extractFileName(filePart);
        String filePath = savePath + File.separator + fileName;

        // Ghi file vào thư mục lưu trữ
        filePart.write(filePath);

        // Trả về đường dẫn tương đối của file để lưu vào DB
        return SAVE_DIR + File.separator + fileName;
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
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
