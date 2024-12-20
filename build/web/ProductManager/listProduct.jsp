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
    <jsp:include page="/menu.jsp" />
    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb side">
                <li class="breadcrumb-item active"><a href="#"><b>Danh sách sản phẩm</b></a></li>  
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
                                    Thêm sản phẩm</a>
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
                                <a href="${pageContext.request.contextPath}/reportInventory" class="btn btn-delete btn-sm print-file js-textareacopybtn" type="button" title="Sao chép"><i class="fas fa-chart-line"></i>
                                    Báo cáo Tồn kho</a>
                            </div>

                            <div class="col-sm-2">
                                <a class="btn btn-excel btn-sm" href="${pageContext.request.contextPath}/exportExcel" title="Xuất Excel">
                                    <i class="fas fa-file-excel"></i> Xuất Excel
                                </a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <form action="${pageContext.request.contextPath}/product" method="GET">
                                    <div class="form-group">
                                        <label for="productName">Product Name:</label>
                                        <input type="text" id="productName" name="productName" class="form-control" placeholder="Nhập tên sản phẩm">
                                    </div>

                                    <div class="form-group">
                                        <label for="categoryID">Category:</label>
                                        <select id="categoryID" name="categoryID" class="form-control">
                                            <option value="">-- Chọn danh mục --</option>
                                            <c:forEach var="category" items="${listCategory}">
                                                <option value="${category.categoryID}">${category.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="minPrice">Min Price:</label>
                                        <input type="number" id="minPrice" name="minPrice" class="form-control" placeholder="Nhập giá tối thiểu">
                                    </div>

                                    <div class="form-group">
                                        <label for="maxPrice">Max Price:</label>
                                        <input type="number" id="maxPrice" name="maxPrice" class="form-control" placeholder="Nhập giá tối đa">
                                    </div>

                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                </form>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="widget-small primary coloured-icon">
                                    <i class='icon bx bxs-user-account fa-3x'></i>
                                    <div class="info">
                                        <h4>Tổng mặt hàng</h4>
                                        <p><b>${totalItems} mặt hàng</b></p>
                                        <p class="info-tong">Tổng số mặt hàng được quản lý.</p>
                                    </div>
                                </div>
                            </div>
                            <!-- col-6 -->
                            <div class="col-md-6">
                                <div class="widget-small info coloured-icon">
                                    <i class='icon bx bxs-data fa-3x'></i>
                                    <div class="info">
                                        <h4>Tổng số lượng</h4>
                                        <p><b>${totalQuantity} sản phẩm</b></p>
                                        <p class="info-tong">Tổng số sản phẩm đang quản lý</p>
                                    </div>
                                </div>
                            </div>
                            <!-- col-6 -->
                            <div class="col-md-6">
                                <div class="widget-small warning coloured-icon">
                                    <i class='icon bx bxs-shopping-bags fa-3x'></i>
                                    <div class="info">
                                        <h4>Tổng giá trị</h4>
                                        <p><b>${totalValue} VND</b></p>
                                        <p class="info-tong">Tổng giá trị hàng đang quản lý.</p>
                                    </div>
                                </div>
                            </div>
                            <!-- col-6 -->
                            <div class="col-md-6">
                                <div class="widget-small danger coloured-icon">
                                    <i class='icon bx bxs-error-alt fa-3x'></i>
                                    <div class="info">
                                        <h4>Sản phẩm cảnh báo hết hàng</h4>
                                        <p><b>${lowStockCount} sản phẩm</b></p>
                                        <p class="info-tong">Số sản phẩm cảnh báo hết cần nhập thêm.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>Mã sản phẩm</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Hình ảnh</th>
                                    <th>Danh mục</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Sự miêu tả</th>
                                    <th>Hoạt động</th>
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
                                            <a href="${pageContext.request.contextPath}/product?action=delete&id=${p.getProductID()}" onclick="if (confirm('Are you sure you want to delete product with Name: ${p.getProductName()}?')) {
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
    <!--    <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>-->
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
</body>

</html>