<%@ page import="model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Danh sách khách hàng | Quản trị Admin</title>
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

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>

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
                    <li class="breadcrumb-item">Danh sách khách hàng</li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <form action="${pageContext.request.contextPath}/customer" method="GET">
<!--                        <div class="form-group">
                            <label for="firstName">Họ:</label>
                            <input type="text" id="firstName" name="firstName" class="form-control" placeholder="Nhập firstName">
                        </div>-->

                        <div class="form-group">
                            <label for="lastName">Tên khách hàng:</label>
                            <input type="text" id="lastName" name="lastName" class="form-control" placeholder="Tên khách hàng:">
                        </div>

                        <div class="form-group">
                            <label for="rankID">Thứ hạng:</label>
                            <select id="rankID" name="rankID" class="form-control">
                                <option value="">Tất cả thứ hạng</option>
                                <c:forEach var="rank" items="${ranks}">
                                    <option value="${rank.rankID}">${rank.rankName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách khách hàng</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/customer?action=create" title="Thêm">
                                        <i class="fas fa-user-plus"></i> Tạo mới khách hàng
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-warning btn-sm nhap-tu-file" type="button" title="Nhập" href="customerRank">
                                        <i class="fas fa-trophy"></i> Quản lý thứ bậc
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
                                    <a class="btn btn-info btn-sm print-file" type="button" href="customerReport">
                                        <i class="fas fa-chart-line"></i> Báo cáo
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="/Fall24_Retailstoremanagement/customer?action=exportExcel" title="In"><i class="fas fa-file-excel"></i> Xuất Excel</a>
                                </div>
                                <!--                                <div class="col-sm-2">
                                                                    <a class="btn btn-delete btn-sm pdf-file" type="button" title="In" onclick="myFunction(this)"><i
                                                                            class="fas fa-file-pdf"></i> Xuất PDF</a>
                                                                </div>-->
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm" type="button" title="Xóa tất cả" onclick="confirmDeleteAll()">
                                        <i class="fas fa-trash-alt"></i> Xóa tất cả
                                    </a>
                                </div>

                                <script>
                                    function confirmDeleteAll() {
                                        if (confirm("Bạn có chắc chắn muốn xóa tất cả khách hàng không?")) {
                                            // Nếu người dùng xác nhận, chuyển hướng đến URL xóa tất cả
                                            window.location.href = "customer?action=deleteAll";
                                        }
                                    }
                                </script>
                            </div>

                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
<!--                                        <th>Customer ID</th>-->
                                        <th>Tên đầy đủ</th>
<!--                                        <th>Last Name</th>-->
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Tổng chi tiêu</th>
                                        <th>Địa chỉ</th>
                                        <th>Thứ hạng</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="customer" items="${data}">
                                        <tr>
<!--                                            <td>${customer.customerID}</td>-->
                                            <td>${customer.firstName} ${customer.lastName}</td>
<!--                                            <td>${customer.lastName}</td>-->
                                            <td>${customer.email}</td>
                                            <td>${customer.phoneNumber}</td>
                                            <td>${customer.totalSpent}</td>
                                            <td>${customer.address}</td>
                                            <td>${customer.rankName}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/customer?action=edit&id=${customer.customerID}" class="btn btn-primary btn-sm edit" title="Sửa"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/customer?action=delete&id=${customer.customerID}" class="btn btn-primary btn-sm trash" title="Xóa"><i class="fas fa-trash-alt"></i></a>


                                            </td>
                                            <!--                                        <td>
                                                                                            <a href="${pageContext.request.contextPath}/product?action=update&id=${p.getProductID()}"  class="btn btn-primary btn-sm edit" title="Sửa">
                                                                                                <i class="fas fa-edit"></i></a>
                                                                                            <a href="${pageContext.request.contextPath}/product?action=delete&id=${p.getProductID()}" onclick="if (confirm('Are you sure you want to delete product with Name: ${p.getProductName()}?')) {
                                                                                                            doDelete('${p.getProductID()}');
                                                                                                            return true;
                                                                                                        } else {
                                                                                                            return false;
                                                                                                        }" class="btn btn-primary btn-sm trash" title="Xóa">
                                                                                                <i class="fas fa-trash-alt"></i>
                                                                                            </a>
                                            
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
        <script type="text/javascript">
            $('#sampleTable').DataTable();
            //Thời Gian
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Chủ Nhật";
                weekday[1] = "Thứ Hai";
                weekday[2] = "Thứ Ba";
                weekday[3] = "Thứ Tư";
                weekday[4] = "Thứ Năm";
                weekday[5] = "Thứ Sáu";
                weekday[6] = "Thứ Bảy";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                nowTime = h + " giờ " + m + " phút " + s + " giây";
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");

                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="src/jquery.table2excel.js"></script>
        <script src="js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
    </body>
</html>