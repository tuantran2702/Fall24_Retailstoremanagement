/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.UserController;

import dao.MaHoa;
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
 * @author trant
 */
public class Login extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet Login</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

 @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("User/login.jsp").forward(request, response);
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
        MaHoa mh = new MaHoa();
        // Lấy thông tin đăng nhập từ biểu mẫu
        String email = request.getParameter("username");
        String password = request.getParameter("current-password");
        String pw = mh.md5Hash(password);
        UserDAO ud = new UserDAO();
        // Thực hiện xác thực thông tin đăng nhập
        User u = ud.checkLogin(email, pw);

        if (u != null) {
            // Tạo một phiên người dùng
            HttpSession session = request.getSession();
            session.setAttribute("User", u); // Lưu thông tin người dùng trong phiên

            // Kiểm tra roleID để phân quyền
            if (u.getRoleID() == 1) {
                // Chuyển hướng đến trang quản trị (nếu vai trò là admin)
                response.sendRedirect("homepage");
            } else {
                // Chuyển hướng đến trang chính (nếu vai trò là người dùng thường)
                response.sendRedirect("banhang");
            }

        } else {
            // Nếu xác thực thất bại, chuyển hướng trở lại trang đăng nhập với thông báo lỗi
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("User/login.jsp").forward(request, response);
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