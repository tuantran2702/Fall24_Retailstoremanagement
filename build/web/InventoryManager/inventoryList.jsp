<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Inventory List | Quản lý tồn kho</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            /* CSS để thay đổi màu và căn giữa thanh tìm kiếm */
            .search-form {
                display: flex;
                justify-content: center; /* Căn giữa */
                margin-bottom: 20px;
            }
            .input-group {
                width: 300px; /* Đặt chiều rộng nhỏ hơn */
            }
            .form-control {
                background-color: #f8f9fa; /* Màu nền thanh tìm kiếm */
                border: 1px solid #007bff; /* Màu viền */
                border-radius: 4px;
            }
            .btn-outline-secondary {
                background-color: #007bff; /* Màu nền nút tìm kiếm */
                color: white; /* Màu chữ */
            }
            /* New styles for the delete all form */
            .delete-all-form {
                text-align: center;
                margin: 20px 0; /* Margin for spacing */
                position: relative;
                left: -950px;
                top: -152px;/* Dịch chuyển sang phải 20px */
                /* Hoặc: left: -20px; /* Dịch chuyển sang trái 20px */
            }


            .btn-danger {
                background-color: #dc3545; /* Bootstrap danger button color */
                color: white; /* Button text color */
            }
        </style>
    </head>

    <body class="app sidebar-mini rtl">
        <!-- Navbar -->
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>

        <!-- Sidebar menu -->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <jsp:include page="/menu.jsp" />

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách tồn kho</li>
                </ul>

                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <form action="${pageContext.request.contextPath}/inventory" method="post" style="display: inline-block; margin-right: 10px;">
                            <input type="hidden" name="action" value="deleteAll"/>
                            <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa tất cả các mục không?');" class="btn btn-danger">
                                <i class="fa fa-trash"></i> Xóa tất cả
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/warehouse" class="btn btn-secondary" style="margin-right: 10px;">
                            <i class="fa fa-warehouse"></i> Danh Mục Kho
                        </a>


                        <a href="${pageContext.request.contextPath}/reportInventory" class="btn btn-secondary" style="margin-right: 10px;">
                            <i class=""></i>  Báo cáo Tồn kho
                        </a>
                        <a href="${pageContext.request.contextPath}/import" class="btn btn-secondary" style="margin-right: 10px;">
                            <i class="fa fa-upload"></i> Lịch sử nhập hàng 
                        </a>
                        <a href="${pageContext.request.contextPath}/import?action=create" class="btn btn-secondary" style="margin-right: 10px;">
                            <i class="fa fa-upload"></i> Nhập Hàng
                        </a>
                    </div>
                    <a href="${pageContext.request.contextPath}/inventory?action=create" class="btn btn-primary">
                        <i class="fa fa-plus"></i> Thêm mới tồn kho
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách tồn kho</h3>
                        <div class="tile-body">
                            <!-- Form tìm kiếm -->


                            </form>
                        </div>


                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>Tên sản phẩm</th>
                                    <th>Tên kho</th>
                                    <th>Số lượng</th>
                                    <th>Cập nhật lần cuối</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="inventory" items="${data}">
                                    <tr>
                                        <td>${inventory.productName}</td>
                                        <td>${inventory.warehouseName}</td>
                                        <td>${inventory.quantity}</td>
                                        <td>${inventory.lastUpdated}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/inventory?action=edit&id=${inventory.inventoryID}" class="btn btn-primary btn-sm"><i class="fa fa-edit"></i></a>
                                            <a href="${pageContext.request.contextPath}/inventory?action=delete&id=${inventory.inventoryID}" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></a>
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

    <!-- Essential javascripts for application to work -->
    <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="${pageContext.request.contextPath}/doc/js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <!-- Data table plugin-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/doc/js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/doc/js/plugins/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">$('#sampleTable').DataTable();</script>
</body>
</html>