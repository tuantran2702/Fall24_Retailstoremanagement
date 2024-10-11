<%-- 
    Document   : QuanLyNhanVien
    Created on : 19 Sep 2024, 11:13:20 am
    Author     : ptrung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách nhân viên | Quản trị Admin</title>
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
                <li><a class="app-menu__item haha" href="phan-mem-ban-hang.html"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
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
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-cog'></i><span class="app-menu__label">Cài
                            đặt hệ thống</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách Phân Quyền</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addRole" title="Thêm"><i class="fas fa-plus"></i>
                                        Tạo mới Phân Quyền</a>
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
                                    <a class="btn btn-delete btn-sm" type="button" title="Xóa" onclick="myFunction(this)"><i
                                            class="fas fa-trash-alt"></i> Xóa tất cả </a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="10">RoleID</th>
                                        <th width="180">Role Name</th>
                                        <th>Description</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="r" items="${requestScope.roleList}">
                                        <tr>
                                            <td>${r.roleID}</td>
                                            <td>${r.roleName}</td>
                                            <td>${r.description}</td>
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="loadRoleData(${r.roleID}); $('#ModalUP').modal('show');">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-danger btn-sm trash" type="button" title="Xóa"
                                                        onclick="deleteRole(${r.roleID})">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
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

        <!-- Modal -->
        <div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ModalLabel">Cập nhật thông tin vai trò</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="roleForm">
                            <div class="form-group">
                                <label for="roleID">Role ID</label>
                                <input type="text" class="form-control" name="roleID" readonly>
                            </div>
                            <div class="form-group">
                                <label for="roleName">Tên vai trò</label>
                                <input type="text" class="form-control" name="roleName" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Mô tả</label>
                                <textarea class="form-control" name="description" required></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="button" class="btn btn-primary" onclick="updateRole()">Cập nhật</button>
                    </div>
                </div>
            </div>
        </div>




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
        <!-- Thêm jsPDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <!-- Thêm autoTable -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.10/jspdf.plugin.autotable.min.js"></script>
        <!-- Font Awesome cho biểu tượng -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script type="text/javascript">$('#sampleTable').DataTable();</script>

        <script>
            function xuatPDF() {
                const {jsPDF} = window.jspdf;
                const doc = new jsPDF();

                // Tiêu đề PDF
                doc.setFontSize(18);
                doc.text("Danh sách nhân viên", 14, 20);

                // Tạo dữ liệu cho bảng
                const rows = [];
                const tableHeader = ['ID', 'Tên', 'Email', 'Địa chỉ', 'Số điện thoại', 'Vai trò'];

                const tableRows = document.querySelectorAll("tbody tr");
                tableRows.forEach((row) => {
                    const userID = row.cells[2].innerText; // userID
                    const fullName = row.cells[3].innerText; // Tên đầy đủ
                    const email = row.cells[4].innerText; // Email
                    const address = row.cells[5].innerText; // Địa chỉ
                    const phoneNumber = row.cells[6].innerText; // Số điện thoại
                    const roleID = row.cells[7].innerText; // Vai trò

                    // Thêm thông tin vào hàng bảng
                    rows.push([userID, fullName, email, address, phoneNumber, roleID]);
                });

                // Sử dụng autoTable để tạo bảng
                doc.autoTable({
                    head: [tableHeader],
                    body: rows,
                    startY: 30, // Vị trí bắt đầu
                    theme: 'grid', // Chủ đề của bảng
                    headStyles: {fillColor: [22, 160, 133]}, // Màu nền tiêu đề
                    styles: {cellWidth: 'auto', halign: 'left'}, // Định dạng các ô
                    margin: {top: 30}
                });

                // Tải xuống tệp PDF
                doc.save('danh_sach_nhan_vien.pdf');
            }
        </script>


        <script>
            $('#saveChangesBtn').on('click', function () {
                var user = {
                    userID: $('#ModalUP input[name="userID"]').val(),
                    firstName: $('#ModalUP input[name="firstName"]').val(),
                    lastName: $('#ModalUP input[name="lastName"]').val(),
                    phoneNumber: $('#ModalUP input[name="phoneNumber"]').val(),
                    email: $('#ModalUP input[name="email"]').val(),
                    roleID: $('#ModalUP select[name="roleID"]').val()
                };

                $.ajax({
                    url: 'updateUser', // URL của servlet để cập nhật thông tin
                    type: 'POST',
                    data: user,
                    success: function (response) {
                        swal("Đã cập nhật thành công!", {
                            icon: "success"
                        }).then(() => {
                            location.reload(); // Reload trang sau khi cập nhật
                        });
                    },
                    error: function () {
                        swal("Cập nhật thất bại!", {
                            icon: "error"
                        });
                    }
                });
            });

        </script>
        <script>
            function loadRoleData(roleID) {
                $.ajax({
                    url: 'getRole', // URL của servlet để lấy thông tin vai trò
                    type: 'GET',
                    data: {id: roleID},
                    success: function (role) {
                        // Hiển thị dữ liệu vào modal
                        $('#ModalUP input[name="roleID"]').val(role.roleID);
                        $('#ModalUP input[name="roleName"]').val(role.roleName);
                        $('#ModalUP textarea[name="description"]').val(role.description);
                    },
                    error: function () {
                        swal("Không thể tải dữ liệu vai trò!", {
                            icon: "error"
                        });
                    }
                });
            }

        </script>
        <script>
            function deleteUser(userID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa nhân viên này?",
                    buttons: ["Hủy bỏ", "Đồng ý"]
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: 'deleteUser', // URL của servlet xử lý xóa người dùng
                            type: 'POST',
                            data: {id: userID},
                            success: function (response) {
                                swal("Đã xóa thành công!", {
                                    icon: "success"
                                }).then(() => {
                                    location.reload(); // Reload trang để cập nhật danh sách
                                });
                            },
                            error: function () {
                                swal("Xóa thất bại!", {
                                    icon: "error"
                                });
                            }
                        });
                    }
                });
            }
        </script>
        <script>
            function updateRole() {
                var formData = $('#roleForm').serialize(); // Lấy dữ liệu từ form
                $.ajax({
                    url: 'updateRole', // URL của servlet cập nhật vai trò
                    type: 'POST',
                    data: formData,
                    success: function () {
                        swal("Cập nhật thành công!", {
                            icon: "success"
                        }).then(() => {
                            location.reload(); // Tải lại trang để cập nhật danh sách
                        });
                    },
                    error: function () {
                        swal("Không thể cập nhật vai trò!", {
                            icon: "error"
                        });
                    }
                });
            }


            //EXCEL
            // $(document).ready(function () {
            //   $('#').DataTable({

            //     dom: 'Bfrtip',
            //     "buttons": [
            //       'excel'
            //     ]
            //   });
            // });


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
            //In dữ liệu
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
            //     //Sao chép dữ liệu
            //     var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

            // copyTextareaBtn.addEventListener('click', function(event) {
            //   var copyTextarea = document.querySelector('.js-copytextarea');
            //   copyTextarea.focus();
            //   copyTextarea.select();

            //   try {
            //     var successful = document.execCommand('copy');
            //     var msg = successful ? 'successful' : 'unsuccessful';
            //     console.log('Copying text command was ' + msg);
            //   } catch (err) {
            //     console.log('Oops, unable to copy');
            //   }
            // });



        </script>
    </body>

</html>
