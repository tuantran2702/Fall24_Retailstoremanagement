<%-- 
    Document   : ProductAdd
    Created on : 18-Sep-2024, 09:08:13
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Thêm sản phẩm | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script>

            function readURL(input, thumbimage) {
                if (input.files && input.files[0]) { //Sử dụng  cho Firefox - chrome
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#thumbimage").attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                } else { // Sử dụng cho IE
                    $("#thumbimage").attr('src', input.value);

                }
                $("#thumbimage").show();
                $('.filename').text($("#uploadfile").val());
                $('.Choicefile').css('background', '#14142B');
                $('.Choicefile').css('cursor', 'default');
                $(".removeimg").show();
                $(".Choicefile").unbind('click');

            }
            $(document).ready(function () {
                $(".Choicefile").bind('click', function () {
                    $("#uploadfile").click();

                });
                $(".removeimg").click(function () {
                    $("#thumbimage").attr('src', '').hide();
                    $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
                    $(".removeimg").hide();
                    $(".Choicefile").bind('click', function () {
                        $("#uploadfile").click();
                    });
                    $('.Choicefile').css('background', '#14142B');
                    $('.Choicefile').css('cursor', 'pointer');
                    $(".filename").text("");
                });
            })
        </script>
    </head>

    <body class="app sidebar-mini rtl">
        <style>
            .Choicefile {
                display: block;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
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
                    <li class="breadcrumb-item"><a href="#">Thêm sản phẩm</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tạo mới sản phẩm</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#exampleModalCenter"><i
                                            class="fas fa-folder-plus"></i> Thêm supplier</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc"><i
                                            class="fas fa-folder-plus"></i> Thêm Category</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#addtinhtrang"><i
                                            class="fas fa-folder-plus"></i> Thêm Unit</a>
                                </div>
                            </div>
                            <c:if test="${not empty error}">
                                <div style="color: red;">
                                    ${error}
                                </div>
                            </c:if>
                            <form action="product" method="post" class="row" onsubmit="return validateForm();">
                                <input type="hidden" name="action" value="create">
                                <div class="form-group col-md-3">
                                    <label class="control-label">Product Code</label>
                                    <input class="form-control" type="text" name="productCode" id="productCode" required oninput="validateForm();">
                                    <small id="error-message-code" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Product Name</label>
                                    <input class="form-control" type="text" name="productName" id="productName" required oninput="validateForm();">
                                    <small id="error-message-name" style="color: red;"></small>
                                </div>



                                <div class="form-group col-md-3 ">
                                    <label for="exampleSelect1" class="control-label">Category </label>
                                    <select class="form-control" id="exampleSelect1" name="categoryID">
                                        <c:forEach var="c" items="${listCategory}">
                                            <option value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="form-group col-md-3">
                                    <label class="control-label">Price</label>
                                    <input class="form-control" type="number" name="price" id="price" required oninput="validateForm();">
                                    <small id="error-message-price" style="color: red;"></small> <!-- Thêm thông báo lỗi cho giá -->
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Quantity</label>
                                    <input class="form-control" type="number" name="quantity" id="quantity" required oninput="validateForm();">
                                    <small id="error-message-quantity" style="color: red;"></small> <!-- Thay đổi ID thông báo lỗi -->
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Created Date</label>
                                    <input class="form-control" type="date" required name="createdDate">
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Expired Date</label>
                                    <input class="form-control" type="date" required name="expiredDate">
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Update Date</label>
                                    <input class="form-control" type="date" required name="updateDate">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="exampleSelect1" class="control-label">User </label>
                                    <select class="form-control" id="exampleSelect1" name="userID">
                                        <c:forEach var="u" items="${listUser}">
                                            <option value="${u.getUserID()}">${u.getFirstName()} ${u.getLastName()}</option>
                                        </c:forEach>



                                    </select>
                                </div>
                                <div class="form-group col-md-3 ">
                                    <label for="exampleSelect1" class="control-label">Unit </label>
                                    <select class="form-control" id="exampleSelect1" name="unitID">
                                        <c:forEach var="c" items="${listUnit}">
                                            <option value="${c.getUnitID()}">${c.getUnitName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-3 ">
                                    <label for="exampleSelect1" class="control-label">Supplier </label>
                                    <select class="form-control" id="exampleSelect1" name="supplierID">
                                        <c:forEach var="s" items="${listSupplier}">
                                            <option value="${s.getSupplierID()}">${s.getSupplierName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="form-group col-md-12">
                                    <label class="control-label">Image</label>
                                    <div id="myfileupload">
                                        <input type="file" name="image" id="uploadfile" accept="image/*" onchange="readURL(this);" />
                                        <small id="error-message-image" style="color: red;"></small> <!-- Thêm thông báo lỗi cho hình ảnh -->
                                    </div>
                                    <div id="thumbbox">
                                        <img height="450" width="400" alt="Thumb image" id="thumbimage" style="display: none" />
                                        <a class="removeimg" href="javascript:;" onclick="removeImage();">Remove Image</a> <!-- Thêm sự kiện để xóa ảnh -->
                                    </div>
                                    <div id="boxchoice">
                                        <a href="javascript:;" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                        <p style="clear:both"></p>
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Description</label>
                                    <textarea class="form-control" name="description" id="description"></textarea>
                                    <script>CKEDITOR.replace('description');</script>
                                </div>


                        </div>
                        <button class="btn btn-save" type="submit">Lưu lại</button>
                        <a class="btn btn-cancel" href="${pageContext.request.contextPath}/product">Hủy bỏ</a>
                        </form>

                    </div>
                    </main>


                    <!--
                    MODAL supplier 
                    -->
                    <form action="supplier" method="post" id="addSupplierForm">
                        <input type="hidden" name="action" value="createSupplierName">

                        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                             data-backdrop="static" data-keyboard="false">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group  col-md-12">
                                                <span class="thong-tin-thanh-toan">
                                                    <h5>Thêm mới nhà cung cấp</h5>
                                                </span>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Nhập tên Supplier</label>
                                                <input class="form-control" type="text" name="supplierName" required>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Danh mục Supplier hiện đang có</label>
                                                <ul style="padding-left: 20px;">
                                                    <!-- Lặp qua danh sách category -->
                                                    <c:forEach var="supplier" items="${listSupplier}">
                                                        <li>${supplier.supplierName}</li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                        <BR>
                                        <button class="btn btn-save" type="submit">Lưu lại</button>
                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                        <BR>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <!--
                  MODAL
                    -->



                    <!--
                    MODAL category
                    -->
                    <form action="category" method="post" id="addCategoryForm">
                        <input type="hidden" name="action" value="createCategoryName">
                        <div class="modal fade" id="adddanhmuc" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                             data-backdrop="static" data-keyboard="false">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group  col-md-12">
                                                <span class="thong-tin-thanh-toan">
                                                    <h5>Thêm mới danh mục </h5>
                                                </span>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Nhập tên Category</label>
                                                <input class="form-control" type="text" name="categoryName" required>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Danh mục sản phẩm hiện đang có</label>
                                                <ul style="padding-left: 20px;">
                                                    <!-- Lặp qua danh sách category -->
                                                    <c:forEach var="category" items="${listCategory}">
                                                        <li>${category.categoryName}</li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                        <BR>
                                        <button class="btn btn-save" type="submit">Lưu lại</button>
                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                        <BR>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <!--
                  MODAL
                    -->




                    <!--
                    MODAL TÌNH TRẠNG
                    -->
                    <form action="unit" method="post" id="addUnitForm">
                        <input type="hidden" name="action" value="createUnitName">
                        <div class="modal fade" id="addtinhtrang" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                             data-backdrop="static" data-keyboard="false">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group  col-md-12">
                                                <span class="thong-tin-thanh-toan">
                                                    <h5>Thêm mới đơn vị </h5>
                                                </span>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Nhập tên Unit</label>
                                                <input class="form-control" type="text" name="unitName" required>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Danh mục Unit hiện đang có</label>
                                                <ul style="padding-left: 20px;">
                                                    <!-- Lặp qua danh sách category -->
                                                    <c:forEach var="unit" items="${listUnit}">
                                                        <li>${unit.unitName}</li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                        <BR>
                                        <button class="btn btn-save" type="submit">Lưu lại</button>
                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                        <BR>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <!--
                  MODAL
                    -->



                    <script src="js/jquery-3.2.1.min.js"></script>
                    <script src="js/popper.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/main.js"></script>
                    <script src="js/plugins/pace.min.js"></script>
                    
                    
                    <script>
    function validateForm() {
        let isValid = true;

        // Kiểm tra từng trường
        const productCodeInput = document.getElementById('productCode');
        const productNameInput = document.getElementById('productName');
        const priceInput = document.getElementById('price');
        const quantityInput = document.getElementById('quantity');

        // Kiểm tra mã sản phẩm
        const regexCode = /^[A-Z0-9]{3,10}$/;
        if (!regexCode.test(productCodeInput.value)) {
            document.getElementById('error-message-code').textContent = 'Please enter a valid product code (3-10 uppercase letters and numbers).';
            isValid = false;
        } else {
            document.getElementById('error-message-code').textContent = '';
        }

        // Kiểm tra tên sản phẩm
        if (productNameInput.value.trim().length < 3 || productNameInput.value.trim().length > 50) {
            document.getElementById('error-message-name').textContent = 'Please enter a valid product name (3-50 characters).';
            isValid = false;
        } else {
            document.getElementById('error-message-name').textContent = '';
        }

        // Kiểm tra giá
        if (priceInput.value <= 0) {
            document.getElementById('error-message-price').textContent = 'Please enter a valid price (greater than 0).';
            isValid = false;
        } else {
            document.getElementById('error-message-price').textContent = '';
        }

        // Kiểm tra số lượng
        if (quantityInput.value < 1) {
            document.getElementById('error-message-quantity').textContent = 'Please enter a valid quantity (1 or more).';
            isValid = false;
        } else {
            document.getElementById('error-message-quantity').textContent = '';
        }

        return isValid; // Nếu tất cả đều hợp lệ, cho phép gửi form
    }
</script>


<!--                    <script>
                                        function validateProductCode() {
                                            const productCodeInput = document.getElementById('productCode');
                                            const errorMessageCode = document.getElementById('error-message-code');
                                            const productCodeValue = productCodeInput.value;

                                            const regex = /^[A-Z0-9]{3,10}$/;

                                            if (!regex.test(productCodeValue)) {
                                                errorMessageCode.textContent = 'Please enter a valid product code (3-10 uppercase letters and numbers).';
                                            } else {
                                                errorMessageCode.textContent = '';
                                            }
                                        }

                                        function validateProductName() {
                                            const productNameInput = document.getElementById('productName');
                                            const errorMessageName = document.getElementById('error-message-name');
                                            const productNameValue = productNameInput.value.trim();

                                            if (productNameValue.length < 3 || productNameValue.length > 50) {
                                                errorMessageName.textContent = 'Please enter a valid product name (3-50 characters).';
                                            } else if (!/^[a-zA-Z0-9\s]+$/.test(productNameValue)) {
                                                errorMessageName.textContent = 'Product name can only contain letters, numbers, and spaces.';
                                            } else {
                                                errorMessageName.textContent = '';
                                            }
                                        }

                                        function validatePrice() {
                                            const priceInput = document.getElementById('price');
                                            const errorMessagePrice = document.getElementById('error-message-price');
                                            const priceValue = priceInput.value;

                                            if (priceValue <= 0) {
                                                errorMessagePrice.textContent = 'Please enter a valid price (greater than 0).';
                                            } else {
                                                errorMessagePrice.textContent = '';
                                            }
                                        }

                                        function validateQuantity() {
                                            const quantityInput = document.getElementById('quantity');
                                            const errorMessageQuantity = document.getElementById('error-message-quantity');
                                            const quantityValue = quantityInput.value;

                                            if (quantityValue < 1) {
                                                errorMessageQuantity.textContent = 'Please enter a valid quantity (1 or more).';
                                            } else {
                                                errorMessageQuantity.textContent = '';
                                            }
                                        }
                                        function readURL(input) {
                                            const errorMessageImage = document.getElementById('error-message-image');
                                            const thumbImage = document.getElementById('thumbimage');

                                            // Kiểm tra nếu có tệp được chọn
                                            if (input.files && input.files[0]) {
                                                const file = input.files[0];
                                                const fileType = file.type;
                                                const validImageTypes = ["image/jpeg", "image/png", "image/gif", "image/webp"]; // Các định dạng hình ảnh hợp lệ

                                                // Kiểm tra loại tệp
                                                if (!validImageTypes.includes(fileType)) {
                                                    errorMessageImage.textContent = 'Please select a valid image file (JPEG, PNG, GIF, WEBP).';
                                                    thumbImage.style.display = 'none'; // Ẩn ảnh thumbnail
                                                    return;
                                                } else {
                                                    errorMessageImage.textContent = ''; // Xóa thông báo lỗi nếu hợp lệ
                                                }

                                                // Hiển thị ảnh thumbnail
                                                const reader = new FileReader();
                                                reader.onload = function (e) {
                                                    thumbImage.src = e.target.result;
                                                    thumbImage.style.display = 'block'; // Hiển thị ảnh thumbnail
                                                };
                                                reader.readAsDataURL(file);
                                            }
                                        }

                                        function removeImage() {
                                            const thumbImage = document.getElementById('thumbimage');
                                            const uploadfile = document.getElementById('uploadfile');
                                            const errorMessageImage = document.getElementById('error-message-image');

                                            uploadfile.value = ''; // Đặt lại giá trị của input file
                                            thumbImage.src = ''; // Đặt lại src của ảnh thumbnail
                                            thumbImage.style.display = 'none'; // Ẩn ảnh thumbnail
                                            errorMessageImage.textContent = ''; // Xóa thông báo lỗi
                                        }





                    </script>-->

                    </body>

                    </html>