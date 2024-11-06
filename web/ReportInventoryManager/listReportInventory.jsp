<%-- 
    Document   : ProductList
    Created on : 18-Sep-2024, 07:50:09
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Product"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách nhân viên | Quản trị Admin</title>
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
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px"
                                                alt="User Image">      <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getFirstName()} ${sessionScope.User.getLastName()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>

            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item " href="order"><i class='app-menu__icon bx bx-task'></i>Order</a></li>

                <li><a class="app-menu__item " href="userManage"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý nhân viên</span></a></li>


                <li><a class="app-menu__item active" href="product"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>

                <li><a class="app-menu__item " href="customer"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý khách hàng </span></a></li>











                <li><a class="app-menu__item" href="inventory"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý   kho</span></a></li>

                <li><a class="app-menu__item" href="settingController"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Thay đổi mật khẩu </span></a></li>




            </ul>


        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách Báo cáo Tồn kho</b></a></li>  
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <form action="${pageContext.request.contextPath}/reportInventory" method="GET">
                        <div class="form-group">
                            <label for="keyword">Từ Khóa:</label>
                            <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Nhập từ khóa tìm kiếm">
                        </div>

                        <div class="form-group">
                            <label for="startDate">Ngày bắt đầu:</label>
                            <input type="date" id="startDate" name="startDate" class="form-control">
                        </div>

                        <div class="form-group">
                            <label for="endDate">Ngày kết thúc:</label>
                            <input type="date" id="endDate" name="endDate" class="form-control">
                        </div>

                        <div class="form-group">
                            <label for="productID">Tên sản phẩm:</label>
                            <select id="productID" name="productID" class="form-control">
                                <option value="">-- Chọn sản phẩm --</option>
                                <c:forEach var="product" items="${data}">
                                    <option value="${product.productID}">${product.productName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="warehouseID">Tên kho:</label>
                            <select id="warehouseID" name="warehouseID" class="form-control">
                                <option value="">-- Chọn kho --</option>
                                <c:forEach var="warehouse" items="${data}">
                                    <option value="${warehouse.warehouseID}">${warehouse.warehouseName}</option>
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
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a href="${pageContext.request.contextPath}/reportInventory?action=create" class="btn btn-add btn-sm" title="Thêm">
                                        <i class="fas fa-plus"></i> Tạo Báo Cáo Tồn Kho Mới
                                    </a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm pdf-file" type="button" href="${pageContext.request.contextPath}/product"><i
                                            class="fas fa-file-pdf"></i> Sản Phẩm</a>
                                </div>
                                <div class="col-sm-2">
                                    <a href="${pageContext.request.contextPath}/supplier" class="btn btn-delete btn-sm nhap-tu-file" type="button" title="Nhập" onclick="myFunction(this)"><i
                                            class="fas fa-file-upload"></i> Nhà cung cấp</a>
                                </div>

                                <div class="col-sm-2">
                                    <a href="${pageContext.request.contextPath}/category" class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> Danh mục</a>
                                </div>
                                <div class="col-sm-2">
                                    <a href="${pageContext.request.contextPath}/unit" class="btn btn-delete btn-sm print-file js-textareacopybtn" type="button" title="Sao chép"><i
                                            class="fas fa-copy"></i> Đơn vị</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="${pageContext.request.contextPath}/exportReportInventory" title="Xuất Excel">
                                        <i class="fas fa-file-excel"></i> Xuất Excel
                                    </a>
                                </div>
                            </div>
                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Ngày báo cáo</th>
                                        <th>Sản phẩm</th>
                                        <th>Kho</th>
                                        <th>Tổng số lượng</th>
                                        <th>Tổng giá trị tồn kho</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${data}">
                                        <tr>
                                            <td>${s.getReportDate()}</td>
                                            <td>${s.getProductName()}</td>
                                            <td><span class="badge bg-success">${s.getWarehouseName()}</span></td>
                                            <td>${s.getTotalQuantity()}</td>
                                            <td>${s.getTotalStockValue()}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/reportInventory?action=update&id=${s.getReportID()}" class="btn btn-primary btn-sm edit" title="Sửa">
                                                    <i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/reportInventory?action=delete&id=${s.getReportID()}" onclick="if (confirm('Are you sure you want to delete product with Name: ${s.getReportID()}?')) {
                                                            doDelete('${s.getReportID()}');
                                                            return true;
                                                        } else {
                                                            return false;
                                                        }" class="btn btn-primary btn-sm trash" title="Xóa">
                                                    <i class="fas fa-trash-alt"></i>
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

        <!-- Essential javascripts for application to work-->
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
        <!--        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>-->
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
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
        <script>
//            function deleteRow(r) {
//                var i = r.parentNode.parentNode.rowIndex;
//                document.getElementById("myTable").deleteRow(i);
//            }
//            jQuery(function () {
//                jQuery(".trash").click(function () {
//                    swal({
//                        title: "Cảnh báo",
//                        text: "Bạn có chắc chắn là muốn xóa sản phẩm này?",
//                        buttons: ["Hủy bỏ", "Đồng ý"],
//                    })
//                            .then((willDelete) => {
//                                if (willDelete) {
//                                    swal("Đã xóa thành công.!", {
//
//                                    });
//                                }
//                            });
//                });
//            });
//            oTable = $('#sampleTable').dataTable();
//            $('#all').click(function (e) {
//                $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
//                e.stopImmediatePropagation();
//            });
        </script>
    </body>

</html>
