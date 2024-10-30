/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;
import model.Pagination;

/**
 *
 * @author Admin
 */
public class ViewOrderHistoryServlet extends HttpServlet {

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
            out.println("<title>Servlet ViewOrderHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewOrderHistoryServlet at " + request.getContextPath() + "</h1>");
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
        OrderDAO d = new OrderDAO();
        HttpSession session = request.getSession();
        int cp = 1;
        if (request.getParameter("cp") != null) {
            cp = Integer.parseInt(request.getParameter("cp"));
        }
        List<Order> list = d.getAllOrder();
        Pagination page = new Pagination(list.size(), 5, cp);
        session.setAttribute("page", page);
        List<Order> orderhistory = d.getOrderByPage(page.getCurrentPage(), 5, list);
        request.setAttribute("orderList", orderhistory);
        request.getRequestDispatcher("vieworder.jsp").forward(request, response);
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
        String orderId_raw = request.getParameter("orderId");
        String status = request.getParameter("status");
        int orderId = -1;
        try {
            orderId = Integer.parseInt(orderId_raw);
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.updateOrderStatus(orderId, status);
        int cp = 1;
        if (request.getParameter("cp") != null) {
            cp = Integer.parseInt(request.getParameter("cp"));
        }
        response.sendRedirect("vieworderhistory?cp=" + cp);
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
