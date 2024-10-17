<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Sổ quỹ | Quản lý tài chính</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .stats-card {
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                transition: transform 0.3s;
            }

            .stats-card:hover {
                transform: translateY(-5px);
            }

            .filter-card {
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .transaction-type-btn {
                border: 2px solid #ddd;
                background: #fff;
                padding: 8px 15px;
                border-radius: 20px;
                margin-right: 10px;
                transition: all 0.3s;
            }

            .transaction-type-btn.active {
                background: #007bff;
                color: white;
                border-color: #007bff;
            }

            .date-filter {
                border: 1px solid #ddd;
                padding: 7px;
                border-radius: 5px;
            }

            .stats-value {
                font-size: 24px;
                font-weight: bold;
                margin-top: 10px;
            }

            .stats-card.income {
                background: linear-gradient(45deg, #28a745, #20c997);
                color: white;
            }

            .stats-card.expense {
                background: linear-gradient(45deg, #dc3545, #fd7e14);
                color: white;
            }

            .stats-card.balance {
                background: linear-gradient(45deg, #007bff, #17a2b8);
                color: white;
            }

            .stats-card.initial-balance {
                background: linear-gradient(45deg, #6f42c1, #e83e8c);
                color: white;
            }

            .reset-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .reset-btn:hover {
                background-color: #0056b3;
            }

            .initial-balance-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .initial-balance-form input {
                flex: 1;
                max-width: 200px;
            }

            .initial-balance-form button {
                white-space: nowrap;
            }

            .btn-create-transaction {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s;
            }

            .btn-create-transaction:hover {
                background-color: #218838;
                color: white;
            }

            .tile-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
        </style>
    </head>

    <body class="app sidebar-mini rtl">
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
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getFirstName()} ${sessionScope.User.getLastName()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item" href="order"><i class='app-menu__icon bx bx-task'></i>Order</a></li>
                <li><a class="app-menu__item" href="userManage"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý nhân viên</span></a></li>
                <li><a class="app-menu__item" href="product"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="customer"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý khách hàng </span></a></li>
                <li><a class="app-menu__item active" href="cashbook"><i class='app-menu__icon bx bx-dollar'></i><span
                            class="app-menu__label">Quản lý sổ quỹ</span></a></li>
                <li><a class="app-menu__item" href="inventory"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý kho</span></a></li>
                <li><a class="app-menu__item" href="settingController"><i class='app-menu__icon bx bx-cog'></i><span
                            class="app-menu__label">Thay đổi mật khẩu </span></a></li>
            </ul>
        </aside>

        <main class="app-content">
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% session.removeAttribute("successMessage"); %>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% session.removeAttribute("errorMessage"); %>
                </div>
            </c:if>

            <div class="row mb-4">
                <div class="col-md-12 d-flex justify-content-between align-items-center">
                    <form method="POST" action="${pageContext.request.contextPath}/cashbook" onsubmit="return confirmReset()" class="me-2">
                        <input type="hidden" name="action" value="reset">
                        <button type="submit" class="reset-btn">
                            <i class="fa fa-refresh"></i> Reset Cashbook
                        </button>
                    </form>
                    <form method="POST" action="${pageContext.request.contextPath}/cashbook" class="initial-balance-form">
                        <input type="hidden" name="action" value="updateInitialBalance">
                        <input type="number" name="initialBalance" class="form-control" 
                               placeholder="Số dư đầu kỳ" value="${initialBalance}" 
                               required step="0.01" min="0">
                        <button type="submit" class="btn btn-primary">
                            Cập nhật
                        </button>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="stats-card initial-balance">
                        <h5><i class="fa fa-bank"></i> Quỹ đầu kỳ</h5>
                        <div class="stats-value">
                            <fmt:formatNumber value="${initialBalance}" type="currency" currencySymbol=""/> VNĐ
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card income">
                        <h5><i class="fa fa-arrow-up"></i> Tổng thu</h5>
                        <div class="stats-value">
                            <fmt:formatNumber value="${totalIncome}" type="currency" currencySymbol=""/> VNĐ
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card expense">
                        <h5><i class="fa fa-arrow-down"></i> Tổng chi</h5>
                        <div class="stats-value">
                            <fmt:formatNumber value="${totalExpense}" type="currency" currencySymbol=""/> VNĐ
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card balance">
                        <h5><i class="fa fa-balance-scale"></i> Số dư hiện tại</h5>
                        <div class="stats-value">
                            <fmt:formatNumber value="${initialBalance + totalIncome +totalExpense}" type="currency" currencySymbol=""/> VNĐ
                        </div>
                    </div>
                </div>
            </div>
            <div class="tile">
                <div class="tile-header">
                    <a href="${pageContext.request.contextPath}/cashbook?action=create" class="btn-create-transaction">
                        <i class="fa fa-plus"></i>
                        Tạo giao dịch mới
                    </a>
                </div>
                <div class="filter-card">
                    <form method="GET" action="${pageContext.request.contextPath}/cashbook" class="row align-items-end">
                        <div class="col-md-6">
                            <label class="form-label">Loại giao dịch</label>
                            <div>
                                <input type="radio" id="all" name="type" value="" ${empty param.type ? 'checked' : ''} class="btn-check">
                                <label class="transaction-type-btn ${empty param.type ? 'active' : ''}" for="all">Tất cả</label>

                                <input type="radio" id="income" name="type" value="Thu" ${param.type == 'Thu' ? 'checked' : ''} class="btn-check">
                                <label class="transaction-type-btn ${param.type == 'Thu' ? 'active' : ''}" for="income">Thu</label>

                                <input type="radio" id="expense" name="type" value="Chi" ${param.type == 'Chi' ? 'checked' : ''} class="btn-check">
                                <label class="transaction-type-btn ${param.type == 'Chi' ? 'active' : ''}" for="expense">Chi</label>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">Thời gian</label>
                            <div class="d-flex gap-2">
                                <input type="date" name="startDate" class="date-filter" value="${param.startDate}">
                                <input type="date" name="endDate" class="date-filter" value="${param.endDate}">
                            </div>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                            <tr>
                                <th>Ngày giao dịch</th>
                                <th>Mô tả</th>
                                <th>Loại</th>
                                <th>Số tiền (VNĐ)</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${transactions}" var="trans">
                                <tr>
                                    <td><fmt:formatDate value="${trans.transactionDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>${trans.description}</td>
                                    <td>
                                        <span class="badge ${trans.transactionType == 'Thu' ? 'bg-success' : 'bg-danger'}">
                                            ${trans.transactionType}
                                        </span>
                                    </td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${trans.amount}" type="currency" currencySymbol=""/> VNĐ
                                    </td>
                                  
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/plugins/pace.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/plugins/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/plugins/dataTables.bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
                // DataTable initialization
                $('#sampleTable').DataTable({
                    "order": [[0, "desc"]],
                    "pageLength": 10,
                    "language": {
                        "lengthMenu": "Hiển thị _MENU_ dòng mỗi trang",
                        "zeroRecords": "Không tìm thấy dữ liệu",
                        "info": "Trang _PAGE_ trên _PAGES_",
                        "infoEmpty": "Không có dữ liệu",
                        "infoFiltered": "(lọc từ _MAX_ dòng)",
                        "search": "Tìm kiếm:",
                        "paginate": {
                            "first": "Đầu",
                            "last": "Cuối",
                            "next": "Sau",
                            "previous": "Trước"
                        }
                    }
                });

                // Transaction type button styling
                $('.transaction-type-btn').click(function () {
                    $('.transaction-type-btn').removeClass('active');
                    $(this).addClass('active');
                });
            });
        </script>
    </body>
</html>
</antA