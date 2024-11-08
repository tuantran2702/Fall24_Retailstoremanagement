package controllers;

import dao.LoyaltyPointsDAO;
import dao.PermissionsDAO;
import model.LoyaltyPoints;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.User;

@WebServlet(name = "LoyaltyPointsController", urlPatterns = {"/loyalty"})
public class LoyaltyPointsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method can be removed if not used
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
            //Xử lí Phân Quyền
        String END_POINT = "CUSTOMER-MANAGE";
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
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        LoyaltyPointsDAO loyaltyPointsDAO = new LoyaltyPointsDAO();

        if (action == null) {
            // Display list of loyalty points
            request.setAttribute("data", loyaltyPointsDAO.getListLoyaltyPoints());
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/LoyaltyPointsManager.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit loyalty points entry
            int id = Integer.parseInt(idStr);
            LoyaltyPoints loyaltyPoints = loyaltyPointsDAO.getLoyaltyPointsById(id);
            request.setAttribute("loyaltyPoints", loyaltyPoints);
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/updateLoyaltyPoints.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new loyalty points entry
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/createLoyaltyPoints.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete loyalty points confirmation
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/deleteLoyaltyPoints.jsp").forward(request, response);
        } else if (action.equals("exportExcel")) {
            // Export loyalty points to Excel
            List<LoyaltyPoints> loyaltyPointsList = loyaltyPointsDAO.getListLoyaltyPoints();
            exportExcel(response, loyaltyPointsList);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        LoyaltyPointsDAO loyaltyPointsDAO = new LoyaltyPointsDAO();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            if (action.equals("create")) {
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                int pointsEarned = Integer.parseInt(request.getParameter("pointsEarned"));
                int pointsRedeemed = Integer.parseInt(request.getParameter("pointsRedeemed"));
                Date transactionDate = dateFormat.parse(request.getParameter("transactionDate"));
                String description = request.getParameter("description");

                LoyaltyPoints lp = new LoyaltyPoints(0, customerID, pointsEarned, pointsRedeemed, transactionDate, description);
                loyaltyPointsDAO.createLoyaltyPoints(lp);
                response.sendRedirect(request.getContextPath() + "/loyalty");
            } else if (action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                int pointsEarned = Integer.parseInt(request.getParameter("pointsEarned"));
                int pointsRedeemed = Integer.parseInt(request.getParameter("pointsRedeemed"));
                Date transactionDate = dateFormat.parse(request.getParameter("transactionDate"));
                String description = request.getParameter("description");

                LoyaltyPoints lp = new LoyaltyPoints(id, customerID, pointsEarned, pointsRedeemed, transactionDate, description);
                loyaltyPointsDAO.updateLoyaltyPoints(lp);
                response.sendRedirect(request.getContextPath() + "/loyalty");
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                loyaltyPointsDAO.deleteLoyaltyPoints(id);
                response.sendRedirect(request.getContextPath() + "/loyalty");
 }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    private void exportExcel(HttpServletResponse response, List<LoyaltyPoints> loyaltyPointsList) throws IOException {
        // Set the content type and header for the response
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=loyalty_points.xlsx");

        // Create a workbook and a sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Loyalty Points");

        // Create header row
        Row headerRow = sheet.createRow(0);
        String[] columnHeaders = {"Loyalty Point ID", "Customer ID", "Customer Name", "Points Earned", "Points Redeemed", "Transaction Date", "Description"};
        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
        }

        // Populate the sheet with loyalty points data
        int rowNum = 1;
        for (LoyaltyPoints lp : loyaltyPointsList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(lp.getLoyaltyPointID());
            row.createCell(1).setCellValue(lp.getCustomerID());
            row.createCell(2).setCellValue(lp.getCustomerName());
            row.createCell(3).setCellValue(lp.getPointsEarned());
            row.createCell(4).setCellValue(lp.getPointsRedeemed());
            row.createCell(5).setCellValue(lp.getTransactionDate().toString());
            row.createCell(6).setCellValue(lp.getDescription());
        }

        // Write the workbook to the output stream
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        } finally {
            workbook.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "LoyaltyPointsController handles CRUD operations for Loyalty Points entities.";
    }
}