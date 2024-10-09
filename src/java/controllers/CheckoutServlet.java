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
import model.*;

/**
 *
 * @author Admin
 */
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        OrderDAO dao = new OrderDAO();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        String customerId_raw = request.getParameter("customerId");
        int customerId = 0;
        boolean isValidCustomerId = false; // Flag to track if the customer ID is valid
        try {
            if (customerId_raw != null && !customerId_raw.isEmpty()) {
                customerId = Integer.parseInt(customerId_raw);
                // Check if the customerId is greater than zero
                if (customerId > 0) {
                    isValidCustomerId = true; // Valid customer ID
                } else {
                    throw new NumberFormatException("Customer ID must be greater than zero");
                }
            } else {
                throw new NumberFormatException("Customer ID is empty");
            }

        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        int paymentMethodId = 0;

        String paymentMethodStr = request.getParameter("paymentMethod");

        try {
            if (paymentMethodStr != null && !paymentMethodStr.isEmpty()) {
                paymentMethodId = Integer.parseInt(paymentMethodStr);
            } else {
                throw new NumberFormatException("Payment Method ID is empty");
            }

        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }
        String totalAmount_raw = request.getParameter("total");
        double totalAmount = 0;
        try {
            totalAmount = Double.parseDouble(totalAmount_raw);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        
        if (isValidCustomerId) {
            dao.addOrder(customerId, cart, totalAmount, paymentMethodId);
        } else {
            dao.addOrder(cart, totalAmount, paymentMethodId);
        }
        for (Item item : cart.getItems()) {
            int productId = item.getProduct().getProductID();
            int quantityOrdered = item.getQuantity();
            dao.updateProductQuantity(productId, quantityOrdered);
        }
        session.removeAttribute("cart");
        session.setAttribute("size", 0);

        response.sendRedirect("order");
    }

}
