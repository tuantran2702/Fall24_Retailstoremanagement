<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Warehouse List | Quản lý kho</title>
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
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>

            <hr>
            <ul class="app-menu">
               
                <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-tachometer'></i>Bảng điều khiển</a></li>
                           
               
                <li><a class="app-menu__item " href="${pageContext.request.contextPath}/inventory"><i class='app-menu__icon bx bx-task'></i>Quản lý tồn kho</a></li
                              
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách kho hàng</li>
                </ul>

                <form action="${pageContext.request.contextPath}/warehouse" method="get" style="float: right;">
                    <input type="text" name="search" placeholder="Tìm kiếm kho..." />
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>

                <a href="${pageContext.request.contextPath}/warehouse?action=create" class="btn btn-primary" style="float: right; margin-right: 10px;">
                    <i class="fa fa-plus"></i> Thêm kho hàng
                </a>
            </div>



            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách kho hàng</h3>
                        <div class="tile-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Warehouse ID</th>
                                        <th>Warehouse Name</th>
                                        <th>Location</th>
                                        <th>Manager Name</th>
                                        <th>Contact Number</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="w" items="${data}">
                                        <tr>
                                            <td>${w.getWarehouseID()}</td>
                                            <td>${w.getWarehouseName()}</td>
                                            <td>${w.getLocation()}</td>
                                            <td>${w.getManagerName()}</td>
                                            <td>${w.getContactNumber()}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/warehouse?action=edit&id=${w.getWarehouseID()}" title="Edit">
                                                    <i class='bx bx-edit'></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/warehouse?action=delete&id=${w.getWarehouseID()}" title="Delete">
                                                    <i class='bx bx-trash'></i>
                                                </a>
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
