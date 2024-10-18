<%-- 
    Document   : Permissions
    Created on : 16 Oct 2024, 12:56:53 am
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
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="${sessionScope.User.getImg()}" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="order"><i class='app-menu__icon bx bx-cart-alt'></i>
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
                    <li class="breadcrumb-item active"><a href="roles"><b>Permissions List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addPermission" title="Thêm"><i class="fas fa-plus"></i>
                                        Add New Permission</a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="10">Permission ID</th>
                                        <th width="180">Permission Name</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Sử dụng JSTL để lặp qua danh sách quyền hạn -->
                                    <c:forEach var="permission" items="${permissionList}">
                                        <tr>
                                            <td>${permission.id}</td>
                                            <td>${permission.permissionName}</td>
                                            <td>
                                                <!-- Nút Sửa -->
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="loadPermissionData('${permission.id}'); $('#updatePermissionModal').modal('show');">
                                                    <i class="fas fa-edit"></i>
                                                </button>

                                                <!-- Nút Xóa -->
                                                <button class="btn btn-danger btn-sm trash" type="button" title="Xóa"
                                                        onclick="deletePermission(${permission.id})">
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
        <div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="updateRoleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateRoleModalLabel">Update Role</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!-- Form cập nhật role -->
                    <form id="updateRoleForm" method="POST">
                        <div class="modal-body">
                            <!-- Tên vai trò -->
                            <input name="roleID" value="${role.roleID}"> <!-- Đảm bảo roleID có giá trị đúng -->
                            <div class="form-group">
                                <label for="roleName">Role Name</label>
                                <input type="text" class="form-control" id="roleName" name="roleName" value="${role.roleName}" required>
                            </div>

                            <!-- Mô tả vai trò -->
                            <div class="form-group">
                                <label for="description">Description</label>
                                <input type="text" class="form-control" id="description" name="description" value="${role.description}" required>
                            </div>

                            <!-- Danh sách quyền (permissions) -->
                            <div class="form-group">
                                <label for="permissions">Permissions</label>
                                <div class="checkbox-group">
                                    <c:forEach var="permission" items="${permissions}">
                                        <label>
                                            <input type="checkbox" name="permissions" value="${permission}" <c:if test="${role.hasPermission(permission)}">checked</c:if>> ${permission}
                                            </label><br>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>




        <!-- Essential javascripts for application to work-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
            // Hàm tải dữ liệu vai trò vào modal
            function loadRoleData(roleID) {
                $.ajax({
                    url: 'getRole', // URL của servlet để lấy dữ liệu vai trò
                    type: 'GET',
                    data: {id: roleID},
                    success: function (role) {
                        if (role) {
                            // Hiển thị dữ liệu vai trò vào form modal
                            $('#updateRoleForm input[name="roleName"]').val(role.roleName);
                            $('#updateRoleForm input[name="description"]').val(role.description);
                            $('#updateRoleForm input[name="roleID"]').val(role.roleID); // Hidden field
                            // Hiển thị các quyền hạn trong modal
                            $('.checkbox-group').empty();
                            $.each(role.allPermissions, function (index, permission) {
                                // Kiểm tra xem quyền hạn này có nằm trong danh sách assignedPermissions hay không
                                var checked = role.assignedPermissions.includes(String(permission.id)) ? 'checked' : '';

                                // Tạo checkbox cho mỗi quyền hạn
                                $('.checkbox-group').append(
                                        '<div class="form-check">' +
                                        '<input class="form-check-input" type="checkbox" name="permissions" value="' + permission.id + '" ' + checked + '>' +
                                        '<label class="form-check-label">' + permission.permissionName + '</label>' +
                                        '</div>'
                                        );
                            });


                        }
                    },
                    error: function () {
                        swal("Không thể tải dữ liệu vai trò!", {icon: "error"});
                    }
                });
            }





            // Hàm cập nhật vai trò
            $(document).ready(function () {
                $('#updateRoleForm').submit(function (e) {
                    e.preventDefault(); // Ngăn submit mặc định

                    var formData = $(this).serialize(); // Lấy dữ liệu từ form

                    $.ajax({
                        url: 'getRole',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            // Không cần JSON.parse() vì response đã là đối tượng JavaScript
                            console.log("Response from server:", response);

                            if (response.status === "success") {
                                swal(response.message, {icon: "success"}).then(() => {
                                    location.reload(); // Reload lại trang sau khi cập nhật thành công
                                });
                            } else {
                                swal(response.message, {icon: "error"});
                            }
                        },
                        error: function () {
                            swal("Không thể cập nhật vai trò!", {icon: "error"});
                        }
                    });

                });
            });



            //Ham Xoa Role
            function deleteRole(roleID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa vai trò này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: 'deleteRole', // URL servlet xử lý xóa vai trò
                            type: 'POST',
                            data: {id: roleID},
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




        </script>
    </body>

</html>