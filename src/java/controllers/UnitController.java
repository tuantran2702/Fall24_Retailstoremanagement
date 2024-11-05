/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.UnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Unit;

/**
 *
 * @author admin
 */
public class UnitController extends HttpServlet {

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
            out.println("<title>Servlet UnitController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UnitController at " + request.getContextPath() + "</h1>");
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
        String keyword = request.getParameter("keyword");
        String unitIDStr = request.getParameter("unitID");
        Integer unitID = null;

        // Chuyển đổi unitID từ String sang Integer
        if (unitIDStr != null && !unitIDStr.isEmpty()) {
            try {
                unitID = Integer.parseInt(unitIDStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Xử lý lỗi nếu cần, có thể đặt unitID về null hoặc thông báo lỗi
            }
        }

        UnitDAO unitDAO = new UnitDAO();

        // Lấy danh sách đơn vị để hiển thị trong dropdown
        List<Unit> listUnit = unitDAO.getListunit();
        request.setAttribute("listUnit", listUnit);

        if (action == null) {
            // Hiển thị danh sách đơn vị với chức năng tìm kiếm
            List<Unit> units = unitDAO.searchUnits(keyword, unitID);
            request.setAttribute("data", units);
            request.getRequestDispatcher("/UnitManager/listUnit.jsp").forward(request, response);
        } else if (action.equals("update") && idStr != null) {
            // Chỉnh sửa đơn vị
            int id = Integer.parseInt(idStr);
            Unit u = unitDAO.getUnitById(id);
            request.setAttribute("unit", u);
            request.getRequestDispatcher("/UnitManager/updateUnit.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Tạo đơn vị mới
            request.getRequestDispatcher("/UnitManager/createUnit.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Xóa đơn vị
            int id = Integer.parseInt(request.getParameter("id"));
            unitDAO.deleteUnit(id);
            response.sendRedirect("unit");
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
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if (action.equals("create")) {
            String unitName = request.getParameter("unitName");
            
            UnitDAO unitDAO = new UnitDAO();
            // Kiểm tra xem tên đơn vị đã tồn tại chưa
        if (unitDAO.isUnitNameExists(unitName)) {
            request.setAttribute("errorMessage", "Tên đơn vị đã tồn tại. Vui lòng nhập tên khác.");
            request.getRequestDispatcher("/UnitManager/createUnit.jsp").forward(request, response);
            return;
        }

            Unit unit = new Unit(0, unitName);
            UnitDAO u = new UnitDAO();
            u.createUnit(unit);
            response.sendRedirect("unit");

        } else if (action.equals("update")) {

            int id = Integer.parseInt(request.getParameter("id"));
            String unitName = request.getParameter("unitName");

            Unit unit = new Unit(id, unitName);
            UnitDAO u = new UnitDAO();

            u.updateUnit(unit);
            response.sendRedirect("unit");

        } else if ("createUnitName".equals(action)) {
            // Lấy giá trị của categoryName từ form
            String unitName = request.getParameter("unitName");

            // Thực hiện thêm Category vào database (giả sử có một service hoặc DAO xử lý)
            UnitDAO unitDAO = new UnitDAO();
            unitDAO.addUnitName(new Unit(unitName));

            // Chuyển hướng sau khi thêm thành công
            response.sendRedirect("product?action=create");
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
