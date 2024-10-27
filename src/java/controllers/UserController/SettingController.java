/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.UserController;

import dao.MaHoa;
import dao.PermissionsDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ptrung
 */
public class SettingController extends HttpServlet {

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
            out.println("<title>Servlet SettingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SettingController at " + request.getContextPath() + "</h1>");
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
        
        //Xử lí Phân Quyền
        String END_POINT = "SETTING";
        if (request.getSession().getAttribute("User") != null) {
            PermissionsDAO pd = new PermissionsDAO();
            User u = (User) request.getSession().getAttribute("User");
            if (!pd.isAccess(u, END_POINT)) {
                response.sendRedirect("404.jsp");
                return;
            }
        } else {
            response.sendRedirect("404.jsp");
            return;
        }
        
        request.getRequestDispatcher("User/Setting.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String oldPassword = request.getParameter("oldPassword").trim();
        String newPassword = request.getParameter("newPassword").trim();
        String confirmNewPassword = request.getParameter("confirmNewPassword").trim();

        HttpSession session = request.getSession();
        MaHoa mh = new MaHoa();
        UserDAO ud = new UserDAO();
        
        User u = (User) session.getAttribute("User"); // Giả sử password hiện tại lưu trong session
        User user = ud.getUserById(u.getUserID());
        
        if(user == null){
            // Chuyển hướng người dùng sau khi thay đổi mật khẩu khong thành công
            request.setAttribute("errorMessage", "Khong tim thay User");
            request.getRequestDispatcher("User/Setting.jsp").forward(request, response);
        }
        
        // Kiểm tra mật khẩu hiện tại và các điều kiện của mật khẩu mới
        String errorMessage = null;

        if (!mh.md5Hash(oldPassword).equals(user.getPassword())) {
            errorMessage = "Mật khẩu cũ không đúng!";
        } else if (!newPassword.equals(confirmNewPassword)) {
            errorMessage = "Mật khẩu mới không khớp!";
        } else if (newPassword.equals(oldPassword)) {
            errorMessage = "Mật khẩu mới phải khác mật khẩu cũ!";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("User/Setting.jsp").forward(request, response);
        } else {
            // Lưu mật khẩu mới (cập nhật vào cơ sở dữ liệu hoặc session)
            boolean flag = ud.updatePassword(u, mh.md5Hash(newPassword));
            if(flag){
                // Chuyển hướng người dùng sau khi thay đổi mật khẩu thành công
            request.setAttribute("errorMessage", "Cap nhat Mat Khau Thanh Cong");
            request.getRequestDispatcher("User/Setting.jsp").forward(request, response);
            }else{
                // Chuyển hướng người dùng sau khi thay đổi mật khẩu khong thành công
            request.setAttribute("errorMessage", "Cap nhat Mat Khau Khong Thanh Cong");
            request.getRequestDispatcher("User/Setting.jsp").forward(request, response);
            }

            
            
        }
    }

    // Giả định có phương thức cập nhật mật khẩu trong cơ sở dữ liệu
    // private void updatePasswordInDatabase(String userId, String newPassword) {
    //     // Cập nhật mật khẩu trong database
    // }
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