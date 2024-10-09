/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Supplier;

/**
 *
 * @author admin
 */
public class SupplierController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SupplierController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SupplierController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if (action == null) {
            SupplierDAO supplier = new SupplierDAO();
            request.setAttribute("data", supplier.getListsupplier());
            request.getRequestDispatcher("/SupplierManager/listSupplier.jsp").forward(request, response);

        } else if (action.equals("create")) {
            SupplierDAO supplier = new SupplierDAO();
            request.getRequestDispatcher("/SupplierManager/createSupplier.jsp").forward(request, response);
        } else if (action.equals("update") && idStr != null) {
            int id = Integer.parseInt(idStr);
            
            SupplierDAO supplier = new SupplierDAO();
            Supplier s = supplier.getSupplierById(id);
            request.setAttribute("supplier", s);         
            request.getRequestDispatcher("/SupplierManager/updateSupplier.jsp").forward(request, response);
        }
         else if (action.equals("delete") && idStr != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            SupplierDAO supplier = new SupplierDAO();
            supplier.deletesupplier(id);
            response.sendRedirect("supplier");
        }
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
        String action = request.getParameter("action");
        if(action.equals("create")){
            String supplierName = request.getParameter("supplierName");
        String contactName = request.getParameter("contactName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        
        Supplier supplier =new Supplier(0, supplierName, contactName, phoneNumber, email, address);
        SupplierDAO s=new SupplierDAO();
        s.createSupplier(supplier);
        response.sendRedirect("supplier");
                
                
            
        }
        else if (action.equals("update")) {
            
            int id = Integer.parseInt(request.getParameter("id"));
            String supplierName = request.getParameter("supplierName");
            String contactName = request.getParameter("contactName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            
            Supplier supplier = new Supplier(id, supplierName, contactName, phoneNumber, email, address);
            SupplierDAO s = new SupplierDAO();

            s.updateSupplier(supplier);
            response.sendRedirect("supplier");
        
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
