<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Inventory" %>
<%@ page import="model.Warehouse" %>
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
            <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>
    <!-- Sidebar menu -->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
        <div class="app-sidebar__user">
            <img class="app-sidebar__user-avatar" src="${pageContext.request.contextPath}/doc/images/hay.jpg" width="50px" alt="User Image">
            <div>
                <p class="app-sidebar__user-name"><b>Võ Trường</b></p>
                <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
            </div>
        </div>
        <hr>
        <ul class="app-menu">
            <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>POS Bán Hàng</a></li>
            <li><a class="app-menu__item active" href="${pageContext.request.contextPath}/inventory"><i class='app-menu__icon bx bx-task'></i>Quản lý tồn kho</a></li>
        </ul>
    </aside>
    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item"><a href="inventory">Danh sách tồn kho</a></li>
                <li class="breadcrumb-item active">Cập nhật tồn kho</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Cập nhật tồn kho</h3>
                    <div class="tile-body">
                        <% 
                            Inventory inventory = (Inventory) request.getAttribute("inventory");
                        %>
                        <form action="inventory" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="inventoryID" value="<%= inventory.getInventoryID() %>">
                            <input type="hidden" name="productID" value="<%= inventory.getProductID() %>">
                            <input type="hidden" name="warehouseID" value="<%= inventory.getWarehouseID() %>">
                            <div class="form-group">
                                <label for="quantity">Số lượng:</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" value="<%= inventory.getQuantity() %>" required>
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