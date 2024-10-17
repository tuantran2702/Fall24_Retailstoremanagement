<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Warehouse" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Warehouse | Quản lý kho</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">

    <!-- Font-icon CSS -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
           <li><a class="app-menu__item active" href="${pageContext.request.contextPath}/warehouse"><i class='app-menu__icon bx bx-task'></i>Quản lý kho</a></li>

        </ul>
    </aside>

    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item"><a href="warehouse">Danh sách kho hàng</a></li>
                <li class="breadcrumb-item active">Cập nhật kho hàng</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Cập nhật kho hàng</h3>
                    <div class="tile-body">
                        <form action="warehouse" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${warehouse.getWarehouseID()}">
                            <div class="form-group">
                                <label for="name">Tên kho hàng:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${warehouse.getWarehouseName()}" required>
                            </div>
                            <div class="form-group">
                                <label for="location">Vị trí:</label>
                                <input type="text" class="form-control" id="location" name="location" value="${warehouse.getLocation()}" required>
                            </div>
                            <div class="form-group">
                                <label for="manager">Tên quản lý:</label>
                                <input type="text" class="form-control" id="manager" name="manager" value="${warehouse.getManagerName()}" required>
                            </div>
                            <div class="form-group">
                                <label for="contact">Số liên lạc:</label>
                                <input type="text" class="form-control" id="contact" name="contact" value="${warehouse.getContactNumber()}" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
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
