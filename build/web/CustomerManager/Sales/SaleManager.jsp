<%@ page import="model.Sales" %>
<%@ page import="model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Sale list | Quản trị ban hang</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <!--        <link rel="stylesheet" type="text/css" href="css/main.css">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

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
        <jsp:include page="/menu.jsp" />

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
                            <div class="row element-button">
<!--                                <div class="col-sm-2">
                                    <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/customer?action=create" title="Thêm">
                                        <i class="fas fa-user-plus"></i> Tạo mới thứ bậc
                                    </a>
                                </div>-->
                                <div class="col-sm-2">
                                    <a class="btn btn-warning btn-sm nhap-tu-file" type="button" title="Nhập" href="customer">
                                        <i class="fas fa-users"></i> Quản lý khách hàng
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-warning btn-sm nhap-tu-file" type="button" title="Nhập" href="customerRank">
                                        <i class="fas fa-trophy"></i> Quản lý thứ bậc
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-success btn-sm print-file js-textareacopybtn" type="button" href="loyalty">
                                        <i class="fas fa-gift"></i> Quản lý điểm thưởng
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-danger btn-sm print-file js-textareacopybtn" type="button" href="order">
                                        <i class="fas fa-shopping-cart"></i> Order
                                    </a>
                                </div>
                            </div>
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