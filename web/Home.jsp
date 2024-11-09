<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Trang chủ | Quản lý bán hàng GR1</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="css/main_2.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

        <style>
            /* Custom styling for a better UI */
            body {
                background-color: #f4f7fc;
                font-family: 'Segoe UI', sans-serif;
            }

            .app-header {
                background-color: #34495e;
                padding: 15px;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .app-header .app-nav__item i {
                font-size: 24px;
                color: white;
            }

            .app-header .app-nav__item i:hover {
                color: #f39c12;
            }

            .tile {
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h3 {
                margin: 0;
                font-weight: 600;
                color: #2c3e50;
            }

            .text-center {
                margin-top: 30px;
            }

            .text-center p {
                font-size: 13px;
                color: #7f8c8d;
            }

            .text-center p b {
                color: #34495e;
            }

            /* Clock display */
            #clock {
                padding-right: 15px;
                color: white;
                font-weight: 600;
                background: transparent;
                display: flex; /* Sử dụng flexbox */
                align-items: center; /* Căn giữa theo chiều dọc */
            }
        </style>
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button-->
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <!-- Time Display -->
                <li class="app-nav__item" id="clock"></li>
                <!-- User Menu-->
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>

        <!-- Sidebar menu-->
        <jsp:include page="/menu.jsp" />

        <!-- Main content -->
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile text-center">
                        <h3>Vui lòng chọn công việc cần làm!</h3>
                    </div>
                </div>
            </div>

            <div class="text-center" style="font-size: 13px">
                <p><b>&copy; <script type="text/javascript">document.write(new Date().getFullYear());</script> Phần mềm quản lý bán hàng | GROUP1</b></p>
            </div>
        </main>

        <!-- Essential JavaScripts -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/plugins/pace.min.js"></script>

        <!-- Time Script -->
        <script type="text/javascript">
                    function time() {
                        var today = new Date();
                        var weekday = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"];
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
                            dd = '0' + dd;
                        }
                        if (mm < 10) {
                            mm = '0' + mm;
                        }
                        today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                        document.getElementById("clock").innerHTML = today + " - " + nowTime;
                        setTimeout(time, 1000);
                    }

                    function checkTime(i) {
                        return (i < 10) ? "0" + i : i;
                    }
        </script>
    </body>

</html>
