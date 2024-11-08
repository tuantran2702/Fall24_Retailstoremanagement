<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Inventory" %>
<%@ page import="model.Product" %>
<%@ page import="model.Warehouse" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Inventory | Quản lý tồn kho</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- Font-icon CSS -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Custom CSS for Update Inventory -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/update-inventory-styles.css">
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
                <li class="breadcrumb-item"><a href="inventory">Danh sách tồn kho</a></li>
                <li class="breadcrumb-item active">Cập nhật tồn kho</li>
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
                    <h3 class="tile-title">Cập nhật tồn kho</h3>
                    <div class="tile-body">
                        <% 
                            Inventory inventory = (Inventory) request.getAttribute("inventory");
                            List<Product> products = (List<Product>) request.getAttribute("products");
                            List<Warehouse> warehouses = (List<Warehouse>) request.getAttribute("warehouses");
                        %>
                        <form action="inventory" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="inventoryID" value="<%= inventory.getInventoryID() %>">
                            <div class="form-group">
                                <label for="productID">Sản phẩm:</label>
                                <select class="form-control" id="productID" name="productID">
                                    <c:forEach items="${products}" var="product">
                                        <option value="${product.productID}" ${product.productID == inventory.getProductID() ? 'selected' : ''}>${product.productName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="warehouseID">Kho:</label>
                                <select class="form-control" id="warehouseID" name="warehouseID">
                                    <c:forEach items="${warehouses}" var="warehouse">
                                        <option value="${warehouse.warehouseID}" ${warehouse.warehouseID == inventory.getWarehouseID() ? 'selected' : ''}>${warehouse.warehouseName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                            <a href="inventory" class="btn btn-secondary">Hủy</a>
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
</body>
</html>