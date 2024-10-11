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
import java.util.Random;
import model.User;

/**
 *
 * @author ptrung
 */
public class ForgotPassController extends HttpServlet {

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
            out.println("<title>Servlet ForgotPassController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("User/ForgotPass.jsp").forward(request, response);
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
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO ud = new UserDAO();
        MaHoa mh = new MaHoa();

        String email = request.getParameter("emailInput");
        User u = ud.getUserByEmail(email);
        if(u == null){
            request.setAttribute("error", "Không tồn tại Email này"); // Thêm thông báo lỗi
            request.getRequestDispatcher("User/ForgotPass.jsp").forward(request, response); // Chuyển tiếp đến trang thông báo
        }
        SendEmail se = new SendEmail();
        String randomCode = se.generateRandomCode(6);
        boolean result = se.sendEmailForgot(email, randomCode);
        if (result) {
            request.setAttribute("message", "Email đã được gửi thành công."); // Thêm thông báo thành công

            ud.updatePassword(u, mh.md5Hash(randomCode));
        } else {
            request.setAttribute("error", "Gửi email không thành công."); // Thêm thông báo lỗi
        }

        request.getRequestDispatcher("User/ForgotPass.jsp").forward(request, response); // Chuyển tiếp đến trang thông báo
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