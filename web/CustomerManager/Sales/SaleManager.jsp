<%@ page import="model.Sales" %>
<%@ page import="model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>     <script src=http://127.0.0.1:59490/E57></script>
        <title>Sale List | Quản lý bán hàng</title>
        <meta charset="utf-8">

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
            <div class="app-sidebar__user">
                <img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>


            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-home'></i>
                        <span class="app-menu__label">Trang chủ</span></a></li>                            

                <li><a class="app-menu__item " href="customer"><i class='app-menu__icon bx bx-user'></i> <span
                            class="app-menu__label">Danh sách khách hàng</span></a></li>            
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách bán hàng</li>
                </ul>
                <a href="${pageContext.request.contextPath}/sales?action=create" class="btn btn-primary" style="float: right;">
                    <i class="fa fa-plus"></i> Thêm bán hàng
                </a>
            </div>

            <!-- Bộ lọc tìm kiếm -->
            <div class="row">
                <div class="col-md-12">
                    <form action="${pageContext.request.contextPath}/sales" method="GET">
                        <div class="form-group">
                            <label for="customerName">Tên khách hàng:</label>
                            <input type="text" id="customerName" name="customerName" class="form-control" placeholder="Nhập tên khách hàng">
                        </div>

                        <div class="form-group">
                            <label for="saleDate">Ngày bán hàng:</label>
                            <input type="date" id="saleDate" name="saleDate" class="form-control">
                        </div>

                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách bán hàng</h3>
                        <div class="tile-body">
                            <table>
                                <thead>
                                    <tr>

                                        <th>Sale ID</th>
                                        <th>Tên khách hàng</th>
                                        <th>Ngày bán hàng</th>
                                        <th>Tổng tiền</th>

                                        <!--                                    <th>Actions</th>-->
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sale" items="${salesList}">
                                        <tr>

                                            <td>${sale.saleID}</td>
                                            <td>${sale.customerFullName}</td>
                                            <td>${sale.saleDate}</td>
                                            <td>${sale.totalAmount}</td>

                                            <!--                                        <td>
                                                                                        <a href="${pageContext.request.contextPath}/sales?action=edit&id=${sale.saleID}">Edit</a>
                                                                                        <a href="${pageContext.request.contextPath}/sales?action=delete&id=${sale.saleID}">Delete</a>
                                                                                    </td>-->
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