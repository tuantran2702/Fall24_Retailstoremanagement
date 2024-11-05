<%@ page import="dao.ImportDAO" %> 
<%@ page import="model.Product" %>
<%@ page import="model.Supplier" %>
<%@ page import="model.Inventory" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    ImportDAO importDAO = new ImportDAO();
    List<Product> products = importDAO.getAllProducts();
    List<Supplier> suppliers = importDAO.getAllSuppliers();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Create Import | Quản lý nhập hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon CSS -->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
<body class="app sidebar-mini rtl">
    <!-- Navbar -->
    <header class="app-header">
        <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
        <ul class="app-nav">
            <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>

    <!-- Sidebar menu -->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <jsp:include page="/menu.jsp" />

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="import">Danh sách nhập hàng</a></li>
                    <li class="breadcrumb-item active">Tạo đơn nhập hàng</li>

                </ul>
                <div style="display: flex; justify-content: space-between; align-items: center;">
    <div>
         
        <a href="${pageContext.request.contextPath}/warehouse" class="btn btn-secondary" style="margin-right: 10px;">
            <i class="fa fa-warehouse"></i> Danh Mục Kho
        </a>
      
        <a href="${pageContext.request.contextPath}/import" class="btn btn-secondary" style="margin-right: 10px;">
            <i class="fa fa-upload"></i> Lịch sử nhập hàng 
        </a>
        <a href="${pageContext.request.contextPath}/import?action=create" class="btn btn-secondary" style="margin-right: 10px;">
            <i class="fa fa-upload"></i> Nhập Hàng
        </a>
    </div>
    <a href="${pageContext.request.contextPath}/inventory?action=create" class="btn btn-primary">
        <i class="fa fa-plus"></i> Thêm mới tồn kho
    </a>
</div> 
                
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tạo đơn nhập hàng</h3>
                        <div class="tile-body">
                            <% if (request.getAttribute("error") != null) { %>
                            <p style="color: red;"><%= request.getAttribute("error") %></p>
                            <% } %>
                            <% if (request.getAttribute("success") != null) { %>
                            <p style="color: green;"><%= request.getAttribute("success") %></p>
                            <% } %>
                            <form action="${pageContext.request.contextPath}/import" method="post" class="row">
                                <input type="hidden" name="action" value="create">

                                <div class="form-group col-md-4">
                                    <label for="productID">Sản phẩm:</label>
                                    <select class="form-control" name="productID" id="productID" required>
                                        <option value="">Chọn sản phẩm</option>
                                        <% for (Product product : products) { %>
                                        <option value="<%= product.getProductID() %>"><%= product.getProductName() %></option>
                                        <% } %>
                                    </select>
                                    <span id="productName" class="form-text text-muted"></span>
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="inventoryID">Kho chứa sản phẩm:</label>
                                    <select class="form-control" name="inventoryID" id="inventoryID" required disabled>
                                        <option value="">Vui lòng chọn sản phẩm trước</option>
                                    </select>
                                    <span id="inventoryStatus" class="form-text"></span>
                                </div>

                              
                                <div class="form-group col-md-4">
                                    <label for="importDate">Ngày nhập:</label>
                                    <input type="date" class="form-control" name="importDate" id="importDate" required>
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="unitCost">Đơn giá:</label>
                                    <input type="number" step="0.01" class="form-control" name="unitCost" id="unitCost" required>
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="quantity">Số lượng:</label>
                                    <input type="number" class="form-control" name="quantity" id="quantity" required>
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="supplierName">Nhà cung cấp:</label>
                                    <select class="form-control" name="supplierName" id="supplierName" required>
                                        <option value="">Chọn nhà cung cấp</option>
                                        <% for (Supplier supplier : suppliers) { %>
                                        <option value="<%= supplier.getSupplierName() %>"><%= supplier.getSupplierName() %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="form-group col-md-12">
                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    <a class="btn btn-cancel" href="import">Hủy bỏ</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Essential javascripts for application to work -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>

        <script>
            $(document).ready(function () {
                $('#productID').change(function () {
                    var productId = $(this).val();
                    var productName = $("#productID option:selected").text();
                    $('#productName').text('Sản phẩm đã chọn: ' + productName);

                    // Reset và disable inventory select nếu không có sản phẩm được chọn
                    if (!productId) {
                        $('#inventoryID').prop('disabled', true)
                                .html('<option value="">Vui lòng chọn sản phẩm trước</option>');
                        return;
                    }

                    // Lấy danh sách kho chứa sản phẩm
                    $.ajax({
                        url: '${pageContext.request.contextPath}/getInventories',
                        method: 'GET',
                        data: {productId: productId},
                        success: function (inventories) {
                            var options = '<option value="">Chọn kho chứa sản phẩm</option>';
                            inventories.forEach(function (inventory) {
                                options += '<option value="' + inventory.inventoryID + '">' +
                                        ' ' + inventory.warehouseName +
                                        '  ' +   '</option>';
                            });

                            $('#inventoryID').html(options)
                                    .prop('disabled', false);

                            if (inventories.length === 0) {
                                $('#inventoryStatus').text('Không có kho nào chứa sản phẩm này')
                                        .css('color', 'red');
                            } else {
                                $('#inventoryStatus').text('Có ' + inventories.length + ' kho chứa sản phẩm này')
                                        .css('color', 'green');
                            }
                        },
                        error: function () {
                            $('#inventoryStatus').text('Lỗi khi lấy danh sách kho')
                                    .css('color', 'red');
                        }
                    });
                });
            });
        </script>
    </body>
</html>