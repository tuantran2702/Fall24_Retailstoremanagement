<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${empty inventory ? 'Create' : 'Update'} Inventory | Quản lý kho</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
    <!-- Navbar -->
    <header class="app-header">
        <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
        <ul class="app-nav">
            <li><a class="app-nav__item" href="${pageContext.request.contextPath}/index.html"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/warehouse">Danh sách kho hàng</a></li>
                <li class="breadcrumb-item active">${empty inventory ? 'Tạo mới' : 'Cập nhật'} kho hàng</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">${empty inventory ? 'Tạo mới' : 'Cập nhật'} kho hàng</h3>
                    <div class="tile-body">
                        <form action="${pageContext.request.contextPath}/inventory" method="post">
                            <input type="hidden" name="action" value="${empty inventory ? 'create' : 'update'}" />
                            <c:if test="${!empty inventory}">
                                <input type="hidden" name="id" value="${inventory.inventoryID}" />
                            </c:if>
                            <div class="form-group">
                                <label for="ProductName">Tên sản phẩm:</label>
                                <input type="text" class="form-control" id="ProductName" name="ProductName" value="${empty inventory ? '' : inventory.productName}" required />
                            </div>
                            <div class="form-group">
                                <label for="WarehouseName">Tên kho:</label>
                                <input type="text" class="form-control" id="WarehouseName" name="WarehouseName" value="${empty inventory ? '' : inventory.warehouseName}" required />
                            </div>
                            <div class="form-group">
                                <label for="Quantity">Số lượng:</label>
                                <input type="number" class="form-control" id="Quantity" name="Quantity" value="${empty inventory ? '' : inventory.quantity}" required />
                            </div>
                            <button type="submit" class="btn btn-primary">${empty inventory ? 'Tạo mới' : 'Cập nhật'}</button>
                        </form>
                        <a href="${pageContext.request.contextPath}/inventory" class="btn btn-secondary">Trở lại danh sách</a>
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
