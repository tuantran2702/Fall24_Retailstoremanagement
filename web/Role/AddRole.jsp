<%-- 
    Document   : AddEmployee
    Created on : 25 Sep 2024, 8:02:23 am
    Author     : ptrung
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Thêm nhân viên | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    </head>

    <body class="app sidebar-mini rtl">
        <style>
            
            /* Căn chỉnh form container */
            .form-container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            /* Style cho các tiêu đề label */
            .control-label {
                font-weight: bold;
                margin-bottom: 10px;
                display: block;
                color: #333;
            }

            /* Style cho các input */
            .form-control {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            /* Checkbox group - Căn chỉnh checkbox */
            .checkbox-group {
                display: flex;
                flex-wrap: wrap;
                gap: 10px; /* Khoảng cách giữa các checkbox */
            }

            .checkbox-group label {
                display: flex;
                align-items: center; /* Căn giữa checkbox với văn bản */
                width: 45%; /* Chia mỗi cột chiếm 45% không gian */
                margin-bottom: 10px; /* Khoảng cách giữa các dòng */
            }


            .checkbox-group input[type="checkbox"] {
                margin-right: 10px; /* Khoảng cách giữa checkbox và văn bản */
                transform: scale(1.2); /* Tăng kích thước của checkbox (tùy chọn) */
            }

            /* Nút lưu lại và hủy bỏ */
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-save {
                background-color: #28a745;
                color: white;
                margin-right: 10px;
            }

            .btn-save:hover {
                background-color: #218838;
            }

            .btn-cancel {
                background-color: #dc3545;
                color: white;
            }

            .btn-cancel:hover {
                background-color: #c82333;
            }

            /* Đảm bảo responsive */
            @media (max-width: 768px) {
                .form-container {
                    width: 100%;
                    padding: 15px;
                }

                .checkbox-group {
                    gap: 10px;
                }

                .btn {
                    width: 100%;
                    margin-bottom: 10px;
                }
            }

        </style>
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
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
                <li><a class="app-menu__item haha" href="banhang"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="index.html"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item active" href="userManage"><i class='app-menu__icon bx bx-id-card'></i>
                        <span class="app-menu__label">Quản lý nhân viên</span></a></li>
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Quản lý khách hàng</span></a></li>
                <li><a class="app-menu__item" href="table-data-product.html"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="table-data-oder.html"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý đơn hàng</span></a></li>
                <li><a class="app-menu__item" href="table-data-banned.html"><i class='app-menu__icon bx bx-run'></i><span
                            class="app-menu__label">Quản lý nội bộ
                        </span></a></li>
                <li><a class="app-menu__item" href="table-data-money.html"><i class='app-menu__icon bx bx-dollar'></i><span
                            class="app-menu__label">Bảng kê lương</span></a></li>
                <li><a class="app-menu__item" href="quan-ly-bao-cao.html"><i
                            class='app-menu__icon bx bx-pie-chart-alt-2'></i><span class="app-menu__label">Báo cáo doanh thu</span></a>
                </li>
                <li><a class="app-menu__item" href="page-calendar.html"><i class='app-menu__icon bx bx-calendar-check'></i><span
                            class="app-menu__label">Lịch công tác </span></a></li>
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-cog'></i><span class="app-menu__label">Cài
                            đặt hệ thống</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="roles">List Role</a></li>
                    <li class="breadcrumb-item"><a href="#">Add New Role</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="tile">

                        <h3 class="tile-title">Add New Role</h3>
                        <div class="tile-body">
                            <c:if test="${not empty errorMessage}">
                                <p style="color:red">${errorMessage}</p>
                            </c:if>
                            <form class="form-container row" action="addRole" method="POST">
                                <div class="form-group col-md-12">
                                    <label class="control-label">Role Name</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("roleName") != null ? request.getAttribute("roleName") : "" %>" name="roleName" required>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Description</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("description") != null ? request.getAttribute("description") : "" %>" name="description" required>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Permissions</label>
                                    <div class="checkbox-group">
                                        <c:forEach var="permission" items="${permissions}">
                                            <label>
                                                <!-- Hiển thị checkbox với value là permissionID và tên quyền hạn -->
                                                <input type="checkbox" name="permissions" value="${permission.id}"> ${permission.permissionName}
                                            </label><br>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    <a class="btn btn-cancel" href="roles">Hủy bỏ</a>
                                </div>
                            </form>


                        </div>
                    </div>

                    </main>





                    <!-- Essential javascripts for application to work-->
                    <script src="js/jquery-3.2.1.min.js"></script>
                    <script src="js/popper.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/main.js"></script>
                    <!-- The javascript plugin to display page loading on top-->
                    <script src="js/plugins/pace.min.js"></script>




                    </body>

                    </html>
