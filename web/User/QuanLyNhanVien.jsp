<%-- 
    Document   : QuanLyNhanVien
    Created on : 19 Sep 2024, 11:13:20 am
    Author     : ptrung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.RoleDAO" %>
<%
    RoleDAO roleDAO = new RoleDAO(); // Khởi tạo đối tượng RoleDAO
%>
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
        <!-- Include menu -->
        <jsp:include page="/menu.jsp" />


        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="userManage"><b>Danh sách nhân viên</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addUser" title="Thêm"><i class="fas fa-plus"></i>
                                        Tạo mới nhân viên</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm nhap-tu-file" type="button" title="Nhập" onclick="myFunction(this)"><i
                                            class="fas fa-file-upload"></i> Tải từ file</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()">
                                        <i class="fas fa-print"></i> In dữ liệu
                                    </a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="#" title="Xuất Excel">
                                        <i class="fas fa-file-excel"></i> Xuất Excel
                                    </a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm pdf-file" type="button" title="Xuất PDF" onclick="myApp.xuatPDF()">
                                        <i class="fas fa-file-pdf"></i> Xuất PDF
                                    </a>
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

                                        <th>Img</th>
                                        <th>ID nhân viên</th>
                                        <th width="150">Họ và tên</th>
                                        <th width="170">Email</th>
                                        <th width="170">Địa chỉ</th>
                                        <th>Số điện thoại</th>
                                        <th>Chức vụ</th>
                                        <th width="100" class="no-export">Tính năng</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="user" items="${requestScope.userList}">
                                        <tr>

                                            <td><img src="${user.img}" alt="User Image" style="width:100px;height:100px;"></td>
                                            <td>${user.userID}</td>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.address}</td>
                                            <td>${user.phoneNumber}</td>
                                            <td>${roleMap[user.roleID]}</td>
                                            <td class="no-export"> 
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="window.location.href = 'updateUser?userID=${user.userID}'">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                                        onclick="deleteUser('${user.userID}')"><i class="fas fa-trash-alt"></i></button>
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
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.10/jspdf.plugin.autotable.min.js"></script>
        <script src="src/jquery.table2excel.js"></script>
        <!-- Font Awesome cho biểu tượng -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script type="text/javascript">$('#sampleTable').DataTable();</script>

        <style>
            /* Ẩn cột Tính năng khi in */
            @media print {
                .no-print {
                    display: none !important;
                }
            }
        </style>

        <script>
            var myApp = {
                // Hàm in bảng, loại bỏ cột "Tính năng" khi in
                printTable: function () {
                    $('.no-export').hide(); // Ẩn cột Tính năng
                    var printContents = document.getElementById('sampleTable').outerHTML;
                    var originalContents = document.body.innerHTML;

                    document.body.innerHTML = printContents;
                    window.print();

                    document.body.innerHTML = originalContents;
                    $('.no-export').show(); // Hiển thị lại cột sau khi in
                    location.reload();
                },

                // Hàm xuất PDF
                xuatPDF: function () {
                    $('.no-export').hide(); // Ẩn cột Tính năng trước khi xuất PDF
                    var doc = new jsPDF();
                    doc.autoTable({
                        html: '#sampleTable',
                        theme: 'grid',
                        styles: {fontSize: 10},
                        margin: {top: 10}
                    });
                    doc.save('table_data.pdf'); // Lưu file PDF
                    $('.no-export').show(); // Hiển thị lại cột sau khi xuất PDF
                }
            };

            $(document).ready(function () {
                // Hàm xuất Excel
                $('.btn-excel').click(function (e) {
                    e.preventDefault(); // Ngăn không reload trang
                    $('.no-export').hide(); // Ẩn cột Tính năng trước khi xuất Excel
                    $("#sampleTable").table2excel({
                        exclude: ".no-export", // Loại bỏ các cột có class "no-export"
                        filename: "table_data.xls" // Tên file Excel
                    });
                    $('.no-export').show(); // Hiển thị lại cột sau khi xuất Excel
                });
            });
        </script>

        <script>
            // Hàm hiển thị cảnh báo xóa
            function showDeleteWarning(message, onConfirm) {
                swal({
                    title: "Cảnh báo",
                    text: message,
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then(onConfirm);
            }

// Hàm xóa người dùng
            function deleteUser(userID) {
                if (!userID) {
                    swal("Lỗi", "ID người dùng không hợp lệ", {icon: "error"});
                    return;
                }

                showDeleteWarning("Bạn có chắc chắn muốn xóa nhân viên này?", (willDelete) => {
                    if (willDelete) {
                        $.post('deleteUser', {id: userID})
                                .done(() => {
                                    swal("Đã xóa thành công!", {icon: "success"})
                                            .then(() => location.reload());
                                })
                                .fail(() => {
                                    swal("Xóa thất bại!", {icon: "error"});
                                });
                    }
                });
            }

// Hàm xóa hàng khỏi bảng mà không cần reload
            function deleteRow(row) {
                row.closest('tr').remove();
            }

// Thiết lập sự kiện cho nút xóa dòng
            $(document).ready(function () {
                // Sử dụng 'on' để bắt sự kiện cho các phần tử sinh ra sau khi DataTable load lại
                $('#sampleTable').on('click', '.trash', function () {
                    const userID = $(this).closest('tr').find('td:nth-child(2)').text().trim(); // Lấy ID từ cột tương ứng
                    deleteUser(userID);
                });

                // Khởi tạo DataTable
                $('#sampleTable').DataTable();
            });

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