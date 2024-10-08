<%@ page import="model.CustomerRank" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Rank List | Quản lý cấp bậc khách hàng</title>
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
            <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                    <span class="app-menu__label">Trang chủ</span></a></li>                            

            <li><a class="app-menu__item " href="customer"><i class='app-menu__icon bx bx-id-card'></i> <span
                        class="app-menu__label">Danh sách khách hàng</span></a></li>            


        </ul>
    </aside>

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
                <div class="tile">
                    <h3 class="tile-title">Danh sách cấp bậc khách hàng</h3>
                    <div class="tile-body">
                        <table>
                            <thead>
                                <tr>
                                    <th>Rank ID</th>
                                    <th>Rank Name</th>
                                    <th>Minimum Spent</th>
                                    <th>Description</th>
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
