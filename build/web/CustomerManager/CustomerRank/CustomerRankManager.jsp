<%@ page import="model.CustomerRank" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>     <script src=http://127.0.0.1:59490/S81></script>
        <title>Customer Rank List | Quản lý cấp bậc khách hàng</title>
        <meta charset="utf-8">

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
                    <li class="breadcrumb-item">Danh sách cấp bậc khách hàng</li>
                </ul>
                <a href="${pageContext.request.contextPath}/customerRank?action=create" class="btn btn-primary" style="float: right;">
                    <i class="fa fa-plus"></i> Thêm cấp bậc
                </a>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <form action="${pageContext.request.contextPath}/customerRank" method="GET">
                        <div class="form-group">
                            <label for="rankName">Tên hạng:</label>
                            <input type="text" id="rankName" name="rankName" class="form-control" placeholder="Nhập tên hạng">
                        </div>

                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách cấp bậc khách hàng</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/customerRank?action=create" title="Thêm">
                                        <i class="fas fa-user-plus"></i> Tạo mới thứ bậc
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-warning btn-sm nhap-tu-file" type="button" title="Nhập" href="customer">
                                        <i class="fas fa-users"></i> Quản lý khách hàng
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-info btn-sm print-file" type="button" title="In" href="sales">
                                        <i class="fas fa-chart-line"></i> Sales
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
                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="/Fall24_Retailstoremanagement/customerRank?action=exportExcel" title="In"><i class="fas fa-file-excel"></i> Xuất Excel</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm pdf-file" type="button" title="In" onclick="myFunction(this)"><i
                                            class="fas fa-file-pdf"></i> Xuất PDF</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm" type="button" title="Xóa" onclick="confirmDeleteAll()">
                                        <i class="fas fa-trash-alt"></i> Xóa tất cả
                                    </a>
                                </div>

                                <script>
                                    function confirmDeleteAll() {
                                        if (confirm("Bạn có chắc chắn muốn xóa tất cả customer ranks không?")) {
                                            // Nếu người dùng xác nhận, chuyển hướng đến URL xóa tất cả
                                            window.location.href = "customerRank?action=deleteAll";
                                        }
                                    }
                                </script>
                            </div>

                            <table>
                                <thead>
                                    <tr>
                                        <th>Rank ID</th>
                                        <th>Rank Name</th>
                                        <th>Minimum Spent</th>
                                        <th>Description</th>
                                        <th>Discount Percent</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="rank" items="${data}">
                                        <tr>
                                            <td>${rank.rankID}</td>
                                            <td>${rank.rankName}</td>
                                            <td>${rank.minimumSpent}</td>
                                            <td>${rank.description}</td>
                                            <td>${rank.discountPercent}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/customerRank?action=edit&id=${rank.rankID}" class="btn btn-primary btn-sm edit" title="Sửa"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/customerRank?action=delete&id=${rank.rankID}" class="btn btn-primary btn-sm trash" title="Xóa"><i class="fas fa-trash-alt"></i></a>
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