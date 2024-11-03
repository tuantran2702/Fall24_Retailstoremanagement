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
                    <li class="breadcrumb-item">Danh sách sản phẩm</li>
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
                                            class="fas fa-folder-plus"></i> Thêm nhà cung cấp</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc"><i
                                            class="fas fa-folder-plus"></i> Thêm danh mục</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#addtinhtrang"><i
                                            class="fas fa-folder-plus"></i> Thêm tình trạng</a>
                                </div>
                            </div>
                            <form action="supplier" method="post" class="row">
                                <input type="hidden" name="action" value="create">

                                <div class="form-group col-md-3">
                                    <label class="control-label">Supplier Name</label>
                                    <input class="form-control" type="text" name="supplierName" id="supplierName" oninput="validateSupplierName();">
                                    <small id="error-message-supplier" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Contact Name</label>
                                    <input class="form-control" type="text" name="contactName" id="contactName" oninput="validateContactName();">
                                    <small id="error-message-contact" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Phone Number</label>
                                    <input class="form-control" type="number" name="phoneNumber" id="phoneNumber" oninput="validatePhoneNumber();">
                                    <small id="error-message-phone" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" type="email" name="email" id="email" oninput="validateEmail();">
                                    <small id="error-message-email" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-3">
                                    <label class="control-label">Address</label>
                                    <input class="form-control" type="text" name="address" id="address" oninput="validateAddress();">
                                    <small id="error-message-address" style="color: red;"></small>
                                </div>

                        </div>
                        <button class="btn btn-save" type="submit">Lưu lại</button>
                        <a class="btn btn-cancel" href="table-data-product.html">Hủy bỏ</a>
                        </form>


                    </div>
                    </main>


                    <!--
                    MODAL CHỨC VỤ 
                    -->
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
                                            <label class="control-label">Nhập tên chức vụ mới</label>
                                            <input class="form-control" type="text" required>
                                        </div>
                                    </div>
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



                    <script src="js/jquery-3.2.1.min.js"></script>
                    <script src="js/popper.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/main.js"></script>
                    <script src="js/plugins/pace.min.js"></script>
                    <script>
            function validateSupplierName() {
                const supplierNameInput = document.getElementById('supplierName');
                const errorMessageSupplier = document.getElementById('error-message-supplier');
                const supplierNameValue = supplierNameInput.value.trim();

                if (supplierNameValue.length < 3 || supplierNameValue.length > 50) {
                    errorMessageSupplier.textContent = 'Supplier name must be between 3 and 50 characters.';
                } else {
                    errorMessageSupplier.textContent = '';
                }
            }

            function validateContactName() {
                const contactNameInput = document.getElementById('contactName');
                const errorMessageContact = document.getElementById('error-message-contact');
                const contactNameValue = contactNameInput.value.trim();

                if (contactNameValue.length < 3 || contactNameValue.length > 50) {
                    errorMessageContact.textContent = 'Contact name must be between 3 and 50 characters.';
                } else {
                    errorMessageContact.textContent = '';
                }
            }

            function validatePhoneNumber() {
                const phoneNumberInput = document.getElementById('phoneNumber');
                const errorMessagePhone = document.getElementById('error-message-phone');
                const phoneNumberValue = phoneNumberInput.value;

                const phoneRegex = /^[0-9]{10,15}$/; // Validates a range of 10-15 digits

                if (!phoneRegex.test(phoneNumberValue)) {
                    errorMessagePhone.textContent = 'Please enter a valid phone number (10-15 digits).';
                } else {
                    errorMessagePhone.textContent = '';
                }
            }

            function validateEmail() {
                const emailInput = document.getElementById('email');
                const errorMessageEmail = document.getElementById('error-message-email');
                const emailValue = emailInput.value.trim();

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Basic email format validation

                if (!emailRegex.test(emailValue)) {
                    errorMessageEmail.textContent = 'Please enter a valid email address.';
                } else {
                    errorMessageEmail.textContent = '';
                }
            }

            function validateAddress() {
                const addressInput = document.getElementById('address');
                const errorMessageAddress = document.getElementById('error-message-address');
                const addressValue = addressInput.value.trim();

                if (addressValue.length < 5 || addressValue.length > 100) {
                    errorMessageAddress.textContent = 'Address must be between 5 and 100 characters.';
                } else {
                    errorMessageAddress.textContent = '';
                }
            }


                    </script>
                    <script>
                        const inpFile = document.getElementById("inpFile");
                        const loadFile = document.getElementById("loadFile");
                        const previewContainer = document.getElementById("imagePreview");
                        const previewContainer = document.getElementById("imagePreview");
                        const previewImage = previewContainer.querySelector(".image-preview__image");
                        const previewDefaultText = previewContainer.querySelector(".image-preview__default-text");
                        inpFile.addEventListener("change", function () {
                            const file = this.files[0];
                            if (file) {
                                const reader = new FileReader();
                                previewDefaultText.style.display = "none";
                                previewImage.style.display = "block";
                                reader.addEventListener("load", function () {
                                    previewImage.setAttribute("src", this.result);
                                });
                                reader.readAsDataURL(file);
                            }
                        });

                    </script>
                    </body>

                    </html>