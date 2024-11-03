/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import model.Product;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author admin
 */
public class ExportExcel extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

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
            out.println("<title>Servlet ExportExcel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportExcel at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=products.xlsx");

        // Lấy dữ liệu từ cơ sở dữ liệu
        List<Product> products = productDAO.getAllProducts();

        // Tạo workbook Excel
        XSSFWorkbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Products");

        // Tạo CellStyle cho định dạng ngày tháng
        CreationHelper creationHelper = workbook.getCreationHelper();
        CellStyle dateCellStyle = workbook.createCellStyle();
        dateCellStyle.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd")); // Định dạng ngày tháng (yyyy-MM-dd)

        // Tạo tiêu đề cho các cột
        String[] headers = {"Product ID", "Product Code", "Product Name", "Category", "Price", "Quantity", "Description", "CreatedDate", "ExpiredDate", "UpdateDate", "Image"};
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // Ghi dữ liệu sản phẩm vào các dòng tiếp theo
        int rowNum = 1;
        for (Product product : products) {
            Row row = sheet.createRow(rowNum++);
            // Đặt độ rộng cột và chiều cao dòng
            sheet.setColumnWidth(10, 5000); // Đặt độ rộng cột
            row.setHeightInPoints(100); // Đặt chiều cao dòng

            row.createCell(0).setCellValue(product.getProductID());
            row.createCell(1).setCellValue(product.getProductCode());
            row.createCell(2).setCellValue(product.getProductName());
            row.createCell(3).setCellValue(product.getCategoryName());
            row.createCell(4).setCellValue(product.getPrice());
            row.createCell(5).setCellValue(product.getQuantity());
            row.createCell(6).setCellValue(product.getDescription());
            if (product.getCreatedDate() != null) {
                Cell createdDateCell = row.createCell(7);
                createdDateCell.setCellValue(product.getCreatedDate()); // Ghi giá trị ngày tháng
                createdDateCell.setCellStyle(dateCellStyle);            // Áp dụng định dạng ngày tháng
            }

            if (product.getExpiredDate() != null) {
                Cell expiredDateCell = row.createCell(8);
                expiredDateCell.setCellValue(product.getExpiredDate()); // Ghi giá trị ngày tháng
                expiredDateCell.setCellStyle(dateCellStyle);            // Áp dụng định dạng ngày tháng
            }

            if (product.getUpdateDate() != null) {
                Cell updateDateCell = row.createCell(9);
                updateDateCell.setCellValue(product.getUpdateDate()); // Ghi giá trị ngày tháng
                updateDateCell.setCellStyle(dateCellStyle);            // Áp dụng định dạng ngày tháng
            }
            // Chèn hình ảnh vào cột thứ 10 (chỉ số cột 9)
            String imagePath = getServletContext().getRealPath("/img-sanpham/" + product.getImage()); // Đường dẫn tới thư mục img-sanpham // Đường dẫn đến file ảnh của sản phẩm
            try ( InputStream inputStream = new FileInputStream(imagePath)) {
                // Đọc tệp ảnh thành byte[]
                byte[] imageBytes = IOUtils.toByteArray(inputStream);

                // Thêm hình ảnh vào Workbook
                int pictureIdx = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_PNG); // Hoặc PICTURE_TYPE_JPEG nếu là file JPG

                // Tạo Drawing để vẽ ảnh
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Đặt vị trí ảnh trong Excel
                ClientAnchor anchor = creationHelper.createClientAnchor();
                anchor.setCol1(10); // Cột bắt đầu (cột 10)
                anchor.setRow1(rowNum - 1); // Dòng bắt đầu
                anchor.setCol2(11); // Cột kết thúc (cột 11)
                anchor.setRow2(rowNum); // Dòng kết thúc

                Picture picture = drawing.createPicture(anchor, pictureIdx);
                picture.resize(1); // Tự động điều chỉnh kích thước ảnh
            } catch (Exception e) {
                e.printStackTrace(); // Xử lý ngoại lệ nếu ảnh không tìm thấy hoặc không đọc được
            }

//            row.createCell(10).setCellValue(product.getImage());
//            row.createCell(11).setCellValue(product.getSupplierID());
        }

        // Xuất file Excel
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();

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
        processRequest(request, response);
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
