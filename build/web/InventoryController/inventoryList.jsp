<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Inventory List | Quản lý tồn kho</title>
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
            <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>

    <!-- Sidebar menu -->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
       <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px"
        alt="User Image">
      <div>
        <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
        <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
      </div>
    </div>
        <hr>
                   <ul class="app-menu">
                 <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>POS Bán Hàng</a></li>
                <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-tachometer'></i>Bảng điều khiển</a></li>

                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/employee"><i class='app-menu__icon bx bx-id-card'></i>Quản lý nhân viên</a></li>
               
              
                <li><a class="app-menu__item " href="${pageContext.request.contextPath}/category"><i class='app-menu__icon bx bx-category'></i>Quản lý danh mục</a></li>
                <li><a class="app-menu__item " href="${pageContext.request.contextPath}/warehouse"><i class='app-menu__icon bx bx-task'></i>Quản lý kho</a></li>
                 <li><a class="app-menu__item active " href="${pageContext.request.contextPath}/inventory"><i class='app-menu__icon bx bx-task'></i>Quản lý tồn  kho</a></li>
                  <li><a class="app-menu__item " href="${pageContext.request.contextPath}/import"><i class='app-menu__icon bx bx-task'></i>Quản lý nhập hàng </a></li

                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/warehouseList.jsp"><i class='app-menu__icon bx bx-run'></i>Quản lý nội bộ</a></li>
                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/table-data-money.html"><i class='app-menu__icon bx bx-dollar'></i>Bảng kê lương</a></li>
                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/quan-ly-bao-cao.html"><i class='app-menu__icon bx bx-pie-chart-alt-2'></i>Báo cáo doanh thu</a></li>
                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/page-calendar.html"><i class='app-menu__icon bx bx-calendar-check'></i>Lịch công tác</a></li>
                <li><a class="app-menu__item" href="${pageContext.request.contextPath}/#"><i class='app-menu__icon bx bx-cog'></i>Cài đặt hệ thống</a></li>
            </ul>
    </aside>

    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item">Danh sách tồn kho</li>
            </ul>
            
              <form action="${pageContext.request.contextPath}/inventory" method="get" style="float: right;">
                    <input type="text" name="search" placeholder="Tìm kiếm " />
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
            <a href="${pageContext.request.contextPath}/inventory?action=create" class="btn btn-primary" style="float: right;">
                <i class="fa fa-plus"></i> Thêm tồn kho
            </a>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Danh sách tồn kho</h3>
                    <div class="tile-body">
                        <table>
                            <thead>
                                <tr>
                                    <th>InventoryID</th>
                                    <th>ProductName</th>
                                    <th>WarehouseName</th>
                                    <th>Quantity</th>
                                    <th>LastUpdated</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${data}">
                                    <tr>
                                        <td>${item.inventoryID}</td>
                                        <td>${item.productName}</td>
                                        <td>${item.warehouseName}</td>
                                        <td>${item.quantity}</td>
                                        <td>${item.lastUpdated}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/inventory?action=edit&id=${item.inventoryID}">Edit</a>
                                            <a href="${pageContext.request.contextPath}/inventory?action=delete&id=${item.inventoryID}">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
