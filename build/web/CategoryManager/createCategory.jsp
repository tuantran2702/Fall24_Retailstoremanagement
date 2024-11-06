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
                    <li class="breadcrumb-item"><a href="category">Danh sách Danh mục</a></li>
                    <li class="breadcrumb-item"><a href="#">Thêm Danh mục</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tạo mới Danh mục</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                            </div>
                            <c:if test="${not empty errorMessage}">
                                <div style="color: red;">${errorMessage}</div>
                            </c:if>
                            <form action="category" method="post" class="row" onsubmit="return validateForm();">
                                <input type="hidden" name="action" value="create">

                                <div class="form-group col-md-3">
                                    <label class="control-label">Tên Danh Mục</label>
                                    <input class="form-control" type="text" name="categoryName" id="categoryName" required oninput="validateCategoryName();">
                                    <small id="error-message-category" style="color: red;"></small>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Mô Tả</label>
                                    <textarea class="form-control" name="description" id="description" required oninput="validateDescription();"></textarea>
                                    <small id="error-message-description" style="color: red;"></small>
                                    <script>CKEDITOR.replace('description');</script>
                                </div>

                                <button class="btn btn-save" type="submit">Lưu lại</button>
                                <a class="btn btn-cancel" href="${pageContext.request.contextPath}/category">Hủy bỏ</a>
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
                                        // Biểu thức chính quy
                                        const regexCategoryName = /^[A-Za-zÀ-ỹ\s]{3,50}$/; // Chữ cái có dấu và từ 3-50 ký tự
                                        const regexDescription = /^.{10,500}$/;            // Mô tả từ 10-500 ký tự

                                        function validateCategoryName() {
                                            const categoryName = document.getElementById('categoryName');
                                            const errorMessageCategory = document.getElementById('error-message-category');

                                            if (!regexCategoryName.test(categoryName.value.trim())) {
                                                errorMessageCategory.textContent = 'Tên danh mục phải là chữ cái (có dấu) và từ 3-50 ký tự.';
                                                return false;
                                            } else {
                                                errorMessageCategory.textContent = '';
                                                return true;
                                            }
                                        }

                                        function validateDescription() {
                                            const description = CKEDITOR.instances.description.getData(); // Lấy nội dung từ CKEditor
                                            const errorMessageDescription = document.getElementById('error-message-description');

                                            if (!regexDescription.test(description.trim())) {
                                                errorMessageDescription.textContent = 'Mô tả phải từ 10-500 ký tự.';
                                                return false;
                                            } else {
                                                errorMessageDescription.textContent = '';
                                                return true;
                                            }
                                        }

                                        function validateForm() {
                                            // Kiểm tra tất cả các trường
                                            return validateCategoryName() && validateDescription();
                                        }

                                        // Sự kiện 'change' cho CKEditor để hiển thị lỗi ngay khi người dùng chỉnh sửa
                                        CKEDITOR.instances.description.on('change', validateDescription);
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