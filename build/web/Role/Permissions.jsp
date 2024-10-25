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
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

    </head>
    <body onload="displayTime()" class="app sidebar-mini rtl">
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>
        <jsp:include page="/menu.jsp" />
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="roles"><b>Permissions List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="tile">
                <div class="tile-body">
                    <div class="element-button">
                        <a class="btn btn-add btn-sm" href="#" data-toggle="modal" data-target="#addPermissionModal">
                            <i class="fas fa-plus"></i> Add New Permission
                        </a>
                    </div>
                    <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                            <tr>
                                <th>Permission ID</th>
                                <th>Permission Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="permission" items="${permissionList}">
                                <tr>
                                    <td>${permission.id}</td>
                                    <td>${permission.permissionName}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm edit" data-id="${permission.id}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm delete" data-id="${permission.id}">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>



        <!-- Modal Update Permission -->
        <div class="modal fade" id="updatePermissionModal" tabindex="-1" role="dialog" aria-labelledby="updatePermissionModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updatePermissionModalLabel">Update Permission</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!-- Form cập nhật quyền -->
                    <form id="updatePermissionForm" method="POST">
                        <div class="modal-body">
                            <!-- Hidden field cho permission ID -->
                            <input type="hidden" name="permissionID" value="${permission.permissionID}">

                            <!-- Tên quyền -->
                            <div class="form-group">
                                <label for="permissionName">Permission Name</label>
                                <input type="text" class="form-control" id="permissionName" name="permissionName" value="${permission.permissionName}" required>
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


        <!-- Modal Add New Permission -->
        <div class="modal fade" id="addPermissionModal" tabindex="-1" role="dialog" aria-labelledby="addPermissionModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addPermissionModalLabel">Add New Permission</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!-- Form thêm mới quyền -->
                    <form id="addPermissionForm" method="POST">
                        <div class="modal-body">
                            <!-- Tên quyền -->
                            <div class="form-group">
                                <label for="permissionName">Permission Name</label>
                                <input type="text" class="form-control" id="permissionName" name="permissionName" placeholder="Enter permission name" required>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Add Permission</button>
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

        <script>
        $(document).ready(function () {
            var table = $('#sampleTable').DataTable();

            // Delegate click events for dynamically added elements
            $(document).on('click', '.edit', function () {
                const permissionID = $(this).data('id');
                loadPermissionData(permissionID);
                $('#updatePermissionModal').modal('show');
            });

            $(document).on('click', '.delete', function () {
                const permissionID = $(this).data('id');
                deletePermission(permissionID);
            });

            // Update form submission
            $('#updatePermissionForm').submit(function (e) {
                e.preventDefault();
                $.post('getPermission', $(this).serialize(), function (response) {
                    handleAjaxResponse(response, "Permission updated successfully");
                });
            });

            // Add form submission
            $('#addPermissionForm').submit(function (e) {
                e.preventDefault();
                $.post('addPermission', $(this).serialize(), function (response) {
                    handleAjaxResponse(response, "Permission added successfully");
                });
            });

            function deletePermission(permissionID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa quyền này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then((willDelete) => {
                    if (willDelete) {
                        $.post('deletePermission', {id: permissionID}, function (response) {
                            handleAjaxResponse(response, "Deleted successfully");
                        });
                    }
                });
            }

            function loadPermissionData(permissionID) {
                $.get('getPermission', {id: permissionID}, function (permission) {
                    if (permission) {
                        $('#updatePermissionForm').find('input[name="permissionName"]').val(permission.permissionName);
                        $('#updatePermissionForm').find('input[name="permissionID"]').val(permission.id);
                    }
                });
            }

            function handleAjaxResponse(response, successMessage) {
                if (response.status === "success") {
                    swal(successMessage, {icon: "success"}).then(() => location.reload());
                } else {
                    swal(response.message, {icon: "error"});
                }
            }
        });

        </script>

        <script>

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