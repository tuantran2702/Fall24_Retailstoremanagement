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
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="product">Danh sách sản phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật sản phẩm</li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Cập nhật sản phẩm</h3>
                        <div class="tile-body">
                            <!-- Hiển thị thông báo lỗi nếu có -->
                            <form action="product" method="post" >
                                <input type="hidden" name="action" value="update">
                                <div class="row">
                                    <div class="row">
                                        <div class="form-group  col-md-12">
                                            <span class="thong-tin-thanh-toan">
                                                <h5>Chỉnh sửa thông tin sản phẩm cơ bản</h5>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <input type="hidden" name="id" value="${product.productID}">

                                        <div class="form-group col-md-6">
                                            <label class="control-label">Product Code</label>
                                            <input class="form-control" type="text" required name="productCode" value="${product.productCode}"><br>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Product Name</label>
                                            <input class="form-control" type="text" required name="productName" value="${product.productName}"><br>
                                        </div>
                                        <div class="form-group  col-md-6">
                                            <label class="control-label">Price</label>
                                            <input class="form-control" type="number" required name="price" value="${product.price}"><br>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="categorySelect" class="control-label">Category</label>
                                            <select class="form-control" id="categorySelect" name="categoryID" required>
                                                <c:forEach var="c" items="${listCategory}">
                                                    <option value="${c.categoryID}" 
                                                            <c:if test="${c.categoryID == product.categoryID}">
                                                                selected
                                                            </c:if>>
                                                        ${c.categoryName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <!--                                        <div class="form-group col-md-6 ">
                                                                                    <label for="exampleSelect1" class="control-label">Category</label>
                                            <input class="form-control" type="text" required name="categoryID" value="${product.categoryID}"><br>
                                        </div>-->
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Quantity</label>
                                            <input class="form-control" type="text" name="quantity" value="${product.quantity}"><br>
                                            <c:if test="${not empty error}">
    <div style="color: red;">
        ${error}
    </div>
</c:if>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Created Date</label>
                                            <input class="form-control" type="date" name="createdDate" value="${product.createdDate}"><br>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Expired Date</label>
                                            <input class="form-control" type="date" name="expiredDate" value="${product.expiredDate}"><br>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Update Date</label>
                                            <input class="form-control" type="date" name="updateDate" value="${product.updateDate}"><br>
                                        </div>
                                        <div class="form-group col-md-6">
                                            
                                                                                        <label for="userSelect" class="control-label">User</label>
                                            <select class="form-control" id="userSelect" name="userID" required>
                                                <c:forEach var="s" items="${listUser}">
                                                    <option value="${s.userID}" 
                                                            <c:if test="${s.userID == product.userID}">
                                                                selected
                                                            </c:if>>
                                                        ${s.firstName} ${s.lastName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            
                                        </div>
                                        <div class="form-group col-md-6">
                                            
                                                        <label for="unitSelect" class="control-label">Unit</label>
                                            <select class="form-control" id="unitSelect" name="unitID" required>
                                                <c:forEach var="u" items="${listUnit}">
                                                    <option value="${u.unitID}" 
                                                            <c:if test="${u.unitID == product.unitID}">
                                                                selected
                                                            </c:if>>
                                                        ${u.unitName} 
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-6">
                                            
                                                                                                    <label for="supplierSelect" class="control-label">Supplier</label>
                                            <select class="form-control" id="supplierSelect" name="supplierID" required>
                                                <c:forEach var="s" items="${listSupplier}">
                                                    <option value="${s.supplierID}" 
                                                            <c:if test="${s.supplierID == product.supplierID}">
                                                                selected
                                                            </c:if>>
                                                        ${s.supplierName} 
                                                    </option>
                                                </c:forEach>
                                            </select>

                                        </div>
                                        <div class="form-group col-md-12">
                                            <label class="control-label">Image</label>
                                            <div id="myfileupload">
                                                <!-- Input to upload a new image -->
                                                <input type="file" name="image" id="uploadfile" onchange="readURL(this);" value="${product.image}">
                                                <br>
                                            </div>

                                            <!-- Display the current image if available -->
                                            <div id="thumbbox">
                                                <c:if test="${not empty product.image}">
                                                    <img height="450" width="400" alt="Thumb image" id="thumbimage" src="${pageContext.request.contextPath}/img-sanpham/${product.image}" />
                                                </c:if>
                                                <a class="removeimg" href="javascript:void(0);"></a>
                                            </div>

                                            <div id="boxchoice">
                                                <a href="javascript:void(0);" class="Choicefile">
                                                    <i class="fas fa-cloud-upload-alt"></i> Chọn ảnh
                                                </a>
                                                <p style="clear:both"></p>
                                            </div>
                                        </div>

                                        <!--                                        <div class="form-group col-md-12">
                                                                                    <label class="control-label">Image</label>
                                                                                    <div id="myfileupload">
                                                                                         Input to upload a new image 
                                                                                        <input type="file" name="image" id="uploadfile" onchange="readURL(this);" value="${product.image}">
                                                                                        <br>
                                                                                    </div>
                                        
                                                                                     Display the current image if available 
                                                                                    <div id="thumbbox">
                                        <c:if test="${not empty product.image}">
                                            <img height="450" width="400" alt="Thumb image" id="thumbimage" src="${pageContext.request.contextPath}/img-sanpham/${product.image}" />
                                        </c:if>
                                        <a class="removeimg" href="javascript:void(0);"></a>
                                    </div>

                                    <div id="boxchoice">
                                        <a href="javascript:void(0);" class="Choicefile">
                                            <i class="fas fa-cloud-upload-alt"></i> Chọn ảnh
                                        </a>
                                        <p style="clear:both"></p>
                                    </div>
                                </div>-->

                                        <div class="form-group col-md-12">
                                            <label class="control-label">Description</label>
                                            <textarea class="form-control" name="description" id="description">${product.description}</textarea>
                                            <script>CKEDITOR.replace('description');</script>
                                        </div>
                                    </div>
                                    <br>
                                    <a href="#" style="float: right; font-weight: 600; color: #ea0000;">Chỉnh sửa sản phẩm nâng cao</a>
                                    <br><br>
                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    <a class="btn btn-cancel" href="${pageContext.request.contextPath}/product">Hủy bỏ</a>
                                    <br>
                                </div>
                            </form>

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
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        // Change the image src to the newly selected file
                        $('#thumbimage').attr('src', e.target.result);
                    };

                    reader.readAsDataURL(input.files[0]); // Read the file
                }
            }

            function deleteRow(r) {
                var i = r.parentNode.parentNode.rowIndex;
                document.getElementById("myTable").deleteRow(i);
            }
            jQuery(function () {
                jQuery(".trash").click(function () {
                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn là muốn xóa sản phẩm này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    swal("Đã xóa thành công.!", {

                                    });
                                }
                            });
                });
            });
            oTable = $('#sampleTable').dataTable();
            $('#all').click(function (e) {
                $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
                e.stopImmediatePropagation();
            });
        </script>
    </body>

</html>