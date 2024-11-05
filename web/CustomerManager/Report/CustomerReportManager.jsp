<%@ page import="model.CustomerReport" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Danh sách báo cáo khách hàng | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
</head>

<body onload="time()" class="app sidebar-mini rtl">
    <!-- Navbar-->
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
                <li class="breadcrumb-item">Danh sách báo cáo khách hàng</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form action="${pageContext.request.contextPath}/customerReport" method="GET">
                    <div class="form-group">
                        <label for="customerID">Customer ID:</label>
                        <input type="text" id="customerID" name="customerID" class="form-control" placeholder="Nhập Customer ID">
                    </div>

                    <div class="form-group">
                        <label for="reportDate">Ngày báo cáo:</label>
                        <input type="date" id="reportDate" name="reportDate" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Danh sách báo cáo khách hàng</h3>
                    <div class="tile-body">
                        <div class="row element-button">
                            <div class="col-sm-2">
                                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/customerReport?action=create" title="Thêm">
                                    <i class="fas fa-plus"></i> Tạo mới báo cáo
                                </a>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-danger btn-sm" type="button" title="Xóa tất cả" onclick="confirmDeleteAll()">
                                    <i class="fas fa-trash-alt"></i> Xóa tất cả
                                </a>
                            </div>
                            <script>
                                function confirmDeleteAll() {
                                    if (confirm("Bạn có chắc chắn muốn xóa tất cả báo cáo không?")) {
                                        window.location.href = "${pageContext.request.contextPath}/customerReport?action=deleteAll";
                                    }
                                }
                            </script>
                        </div>

                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>Report ID</th>
                                    <th>Customer Name</th> 
                                    <th>Ngày báo cáo</th>
                                    <th>Tổng đơn hàng</th>
                                    <th>Tổng chi tiêu</th>
                                    <th>Điểm thưởng tích lũy</th>
                                    <th>Điểm thưởng đã sử dụng</th>
                                    <th>Sản phẩm mua nhiều nhất</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="report" items="${data}">
                                    <tr>
                                        <td>${report.reportID}</td>
                                        <td>${report.customerName}</td>
                                        <td>${report.reportDate}</td>
                                        <td>${report.totalOrders}</td>
                                        <td>${report.totalSpent}</td>
                                        <td>${report.loyaltyPointsEarned}</td>
                                        <td>${report.loyaltyPointsRedeemed}</td>
                                        <td>${report.mostPurchasedProduct}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/customerReport?action=edit&id=${report.reportID}" class="btn btn-primary btn-sm edit" title="Sửa"><i class="fas fa-edit"></i></a>
                                            <a href="${pageContext.request.contextPath}/customerReport?action=delete&id=${report.reportID}" class="btn btn-danger btn-sm trash" title="Xóa"><i class="fas fa-trash-alt"></i></a>
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
    <script type="text/javascript">
        $('#sampleTable').DataTable();
        function time() {
            var today = new Date();
            var weekday = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"];
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
            if (dd < 10) { dd = '0' + dd }
            if (mm < 10) { mm = '0' + mm }
            today = day + ', ' + dd + '/' + mm + '/' + yyyy;
            tmp = '<span class="date"> ' + today + ' - ' + nowTime + '</span>';
            document.getElementById("clock").innerHTML = tmp;
            setTimeout(time, 1000);
        }
        function checkTime(i) {
            return (i < 10) ? "0" + i : i;
        }
    </script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
</body>
</html>