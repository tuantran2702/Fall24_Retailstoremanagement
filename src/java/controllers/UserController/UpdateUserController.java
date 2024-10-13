/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.UserController;

import dao.RoleDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author ptrung
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UpdateUserController extends HttpServlet {

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
            out.println("<title>Servlet UpdateUserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserController at " + request.getContextPath() + "</h1>");
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
        // Get the userID from the request
        String userID = request.getParameter("userID");

        // Fetch the user details from the database
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(Integer.parseInt(userID));

        RoleDAO rd = new RoleDAO();
        List<Role> roles = rd.getAllRole();

        // Set the user as an attribute in the request
        request.setAttribute("user", user);
        request.setAttribute("roles", roles);

        // Forward to the edit page (JSP)
        request.getRequestDispatcher("User/EditEmployee.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserDAO ud = new UserDAO();
        ImageHandler ih = new ImageHandler();
        
        // Collect updated user data from the form
        int userID = Integer.parseInt(request.getParameter("userID"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int roleID = Integer.parseInt(request.getParameter("role"));
        
        
        String uploadFilePath = "E:\\Fall24\\SWP391\\Clone-Git\\Fall24_Retailstoremanagement-Clone\\web\\img-anhthe";
        String imgPath = null;

        // Lấy phần file tải lên
        Part filePart = request.getPart("ImageUpload");
        
        User u = ud.getUserById(userID);  // Lấy thông tin người dùng từ DB

        // Hàm lưu ảnh
        imgPath = ih.luuAnh(filePart, uploadFilePath);

        // Nếu không có file được tải lên, giữ nguyên đường dẫn ảnh hiện tại
        if (imgPath == null) {
            imgPath = u.getImg();
        }
        
        
        //Kiem tra Email
        User checkedUser = ud.getUserByEmail(email);
        if(checkedUser != null){
            request.setAttribute("errorMessage", "Email already exits");

            
            request.setAttribute("user", u);
            

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/EditEmployee.jsp").forward(request, response);
            return;  // Dừng xử lý tiếp
        }
        
        //Kiem tra Role
        int roleId;
        try {
            roleId = Integer.parseInt(request.getParameter("role"));
        } catch (Exception e) {
            // Gửi thông báo lỗi khi người dùng không chọn chức vụ hợp lệ
            request.setAttribute("errorMessage", "Vui lòng chọn chức vụ.");

            request.setAttribute("user", u);

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

            u.setPhoneNumber("");
            request.setAttribute("user", u);

            // Truy vấn dữ liệu từ database
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getAllRole();

            // Lưu danh sách roles vào request attribute
            request.setAttribute("roles", roles);
            // Chuyển tiếp yêu cầu về lại trang thêm người dùng
            request.getRequestDispatcher("User/AddEmployee.jsp").forward(request, response);
            return;  // Dừng xử lý tiếp
        }

        
        

// Proceed with further logic (e.g., update user data with imgPath)
        // Update user object
        User user = new User();
        user.setUserID(userID);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhoneNumber(phone);
        user.setAddress(address);
        user.setRoleID(roleID);
        user.setImg(imgPath); // Set updated image path if provided

        // Update user in the database
        UserDAO userDAO = new UserDAO();
        userDAO.updateUser(user);

        // Redirect back to the user management page
        response.sendRedirect("userManage");
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
