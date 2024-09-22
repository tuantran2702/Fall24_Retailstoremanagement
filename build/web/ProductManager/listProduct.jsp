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
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>Võ Trường</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="phan-mem-ban-hang.html"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="index.html"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item " href="table-data-table.html"><i class='app-menu__icon bx bx-id-card'></i>
                        <span class="app-menu__label">Quản lý nhân viên</span></a></li>
                <li><a class="app-menu__item " href="#"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Quản lý khách hàng</span></a></li>
                <li><a class="app-menu__item active" href="table-data-product.html"><i
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
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Product</b></a></li>  
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a href="${pageContext.request.contextPath}/product?action=create" class="btn btn-add btn-sm"  title="Thêm"><i class="fas fa-plus"></i>
                                        Create new product</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm nhap-tu-file" type="button" title="Nhập" onclick="myFunction(this)"><i
                                            class="fas fa-file-upload"></i> Tải từ file</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> In dữ liệu</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file js-textareacopybtn" type="button" title="Sao chép"><i
                                            class="fas fa-copy"></i> Sao chép</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất Excel</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm pdf-file" type="button" title="In" onclick="myFunction(this)"><i
                                            class="fas fa-file-pdf"></i> Xuất PDF</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm" type="button" title="Xóa" onclick="myFunction(this)"><i
                                            class="fas fa-trash-alt"></i> Xóa tất cả </a>
                                </div>
                            </div>
                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Product Code</th>
                                        <th>Product Name</th>
                                        <th>Image</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Description</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${data}">
                                        <tr>
                                            <td>${p.getProductCode()}</td>
                                            <td>${p.getProductName()}</td>
                                            <td><img src="<%= request.getContextPath() %>/img-sanpham/${p.getImage()}" alt="" width="100px;"></td>
                                            <td><span class="badge bg-success">${p.getCategoryName()}</span></td>
                                            <td>${p.getPrice()}</td>
                                            <td>${p.getQuantity()}</td>
                                            <td>${p.getDescription()}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/product?action=update&id=${p.getProductID()}" class="btn btn-primary btn-sm edit" title="Sửa">
                                                    <i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/product?action=delete&id=${p.getProductID()}" onclick="if (confirm('Are you sure you want to delete product with ID ${p.getProductID()}?')) {
                                                                doDelete('${p.getProductID()}');
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

        <!--
          MODAL
        -->
        <div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
             data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group  col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Chỉnh sửa thông tin sản phẩm cơ bản</h5>
                                </span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label class="control-label">Product Code </label>
                                <input class="form-control" type="number" value="${getProductById.getProductCode()}">
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Product Name</label>
                                <input class="form-control" type="text" required value="Bàn ăn gỗ Theresa">
                            </div>
                            <div class="form-group  col-md-6">
                                <label class="control-label">Price </label>
                                <input class="form-control" type="number" required value="20">
                            </div>
                            <div class="form-group col-md-6 ">
                                <label for="exampleSelect1" class="control-label">Category</label>
                                <select class="form-control" id="exampleSelect1">
                                    <option>Còn hàng</option>
                                    <option>Hết hàng</option>
                                    <option>Đang nhập hàng</option>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Quantity</label>
                                <input class="form-control" type="text" value="5.600.000">
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Created Date</label>
                                <input class="form-control" type="date" value="5.600.000">
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Expired Date</label>
                                <input class="form-control" type="date" value="5.600.000">
                            </div>
                            <div class="form-group col-md-6">
                                <label class="control-label">Update Date</label>
                                <input class="form-control" type="date" value="5.600.000">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="exampleSelect1" class="control-label">User</label>
                                <select class="form-control" id="exampleSelect1">
                                    <c:forEach var="u" items="${listUser}">
                                        <option value="${u.getUserID()}">${u.getFirstName()} ${u.getLastName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="exampleSelect1" class="control-label">Unit</label>
                                <select class="form-control" id="exampleSelect1">
                                    <c:forEach var="c" items="${listUnit}">
                                        <option value="${c.getUnitID()}">${c.getUnitName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="exampleSelect1" class="control-label">Supplier</label>
                                <select class="form-control" id="exampleSelect1">
                                    <c:forEach var="s" items="${listSupplier}">
                                        <option value="${s.getSupplierID()}">${s.getSupplierName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Image</label>
                                <div id="myfileupload">
                                    <input type="file" name="image" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                                </div>
                                <div id="thumbbox">
                                    <img height="450" width="400" alt="Thumb image" id="thumbimage" style="display: none" />
                                    <a class="removeimg" href="javascript:"></a>
                                </div>
                                <div id="boxchoice">
                                    <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                    <p style="clear:both"></p>
                                </div>

                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Description</label>
                                <textarea class="form-control" name="description" id="description"></textarea>
                                <script>CKEDITOR.replace('description');</script>
                            </div>
                        </div>
                        <BR>
                        <a href="#" style="    float: right;
                           font-weight: 600;
                           color: #ea0000;">Chỉnh sửa sản phẩm nâng cao</a>
                        <BR>
                        <BR>
                        <button class="btn btn-save" type="button">Lưu lại</button>
                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                        <BR>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <!--
        MODAL
        -->

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
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
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
