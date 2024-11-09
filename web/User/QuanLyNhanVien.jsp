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
        <title>Danh sách nhân viên | GROUP1</title>
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
                                        Thêm nhân viên</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-sm btn-delete print-file" type="button" title="In" onclick="printTable()">
                                        <i class="fas fa-print"></i> In dữ liệu
                                    </a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-sm btn-excel" type="button" title="Xuất Excel" onclick="exportToExcel()">
                                        <i class="fas fa-file-excel"></i> Xuất Excel
                                    </a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-sm btn-delete pdf-file" type="button" title="Xuất PDF" onclick="exportToPDF()">
                                        <i class="fas fa-file-pdf"></i> Xuất PDF
                                    </a>
                                </div>


                                
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>

                                        <th class="no-export" width="150">Img</th>
                                        <th>Employee ID</th>
                                        <th width="150">Employee Name</th>
                                        <th width="170">Email</th>
                                        <th width="170">Address</th>
                                        <th>Phone Number</th>
                                        <th>Role</th>
                                        <th width="100" class="no-export">Features</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="user" items="${requestScope.userList}">
                                        <tr>

                                            <td class="no-export"><img src="${user.img}" alt="User Image" style="width:100px;height:100px;"></td>
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


        <!-- Font Awesome cho biểu tượng -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- SheetJS for Excel export -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>

        <!-- jsPDF for PDF export -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>



        <script type="text/javascript">$('#sampleTable').DataTable();</script>

        <script>
            $(document).ready(function () {
                $('#sampleTable').DataTable();
            });
// Function to export table to Excel (without the "Tính năng" column)
            function exportToExcel() {
                var table = document.getElementById('sampleTable').cloneNode(true);
                removeNoExportColumns(table);
                var wb = XLSX.utils.table_to_book(table, {sheet: "Sheet1"});
                XLSX.writeFile(wb, 'employee_list.xlsx');
            }

// Function to export table to PDF (without the "Tính năng" column)
            function exportToPDF() {
                // Tạo đối tượng jsPDF
                var {jsPDF} = window.jspdf;
                var doc = new jsPDF();

                // Clone bảng và xóa các cột không cần xuất
                var table = document.getElementById('sampleTable').cloneNode(true);
                removeNoExportColumns(table);

                // Sử dụng autoTable với font hỗ trợ tiếng Việt
                doc.autoTable({
                    html: table,
                    columnStyles: {
                        0: {cellWidth: 20},
                        1: {cellWidth: 20},
                        2: {cellWidth: 40},
                        3: {cellWidth: 40}
                    },
                    margin: {top: 10}
                });

                doc.save('employee_list.pdf');
            }



// Function to print the table (without the "Tính năng" column)
            function printTable() {
                var printContent = document.getElementById('sampleTable').cloneNode(true);
                removeNoExportColumns(printContent);
                var originalContent = document.body.innerHTML;

                document.body.innerHTML = "<html><head><title>Print</title></head><body>" + printContent.outerHTML + "</body></html>";
                window.print();
                document.body.innerHTML = originalContent;
            }

// Function to remove columns with class 'no-export'
            function removeNoExportColumns(table) {
                // Remove header columns
                var headers = table.querySelectorAll('th.no-export');
                headers.forEach(function (header) {
                    header.parentNode.removeChild(header);
                });

                // Remove data columns
                var rows = table.querySelectorAll('tr');
                rows.forEach(function (row) {
                    var cells = row.querySelectorAll('td.no-export');
                    cells.forEach(function (cell) {
                        cell.parentNode.removeChild(cell);
                    });
                });
            }
        </script>



        <script>
            // Hàm hiển thị cảnh báo xóa
            function showDeleteWarning(message, onConfirm) {
                swal({
                    title: "Thông báo",
                    text: message,
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then(onConfirm);
            }

// Hàm xóa người dùng
            function deleteUser(userID) {
                if (!userID) {
                    swal("Error", "Không tồn tại ID", {icon: "error"});
                    return;
                }

                showDeleteWarning("Bạn chắc chắn muốn xóa nhân viên này?", (willDelete) => {
                    if (willDelete) {
                        $.post('deleteUser', {id: userID})
                                .done(() => {
                                    swal("Xóa nhân viên thành công!", {icon: "success"})
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