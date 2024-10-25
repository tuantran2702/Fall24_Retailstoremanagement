<%-- 
    Document   : test
    Created on : Sep 25, 2024, 10:19:04 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>


<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="${sessionScope.User.getImg()}" width="50px"
                                        alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b>${sessionScope.User.getFirstName()} ${sessionScope.User.getLastName()}</b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">
        <%
            // Lấy danh sách quyền từ session
            List<String> permissions = (List<String>) session.getAttribute("assignedPermissions");
            session.setAttribute("permissions", permissions);  // Đặt biến vào session để sử dụng trong JSTL
        %>

        <c:if test="${permissions != null}">

            <c:if test="${permissions.contains('ORDER')}">
                <li><a class="app-menu__item haha" href="order"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                    </c:if>

            <c:if test="${permissions.contains('HOMEPAGE')}">
                <li><a class="app-menu__item " href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                        </c:if>

            <c:if test="${permissions.contains('USER-MANAGE')}">
                <li><a class="app-menu__item " href="userManage"><i class='app-menu__icon bx bx-id-card'></i>
                        <span class="app-menu__label">Quản lý nhân viên</span></a></li>
                    </c:if>


            <c:if test="${permissions.contains('PRODUCT-MANAGE')}">
                <li><a class="app-menu__item" href="product"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
            </c:if>

            <c:if test="${permissions.contains('CUSTOMER-MANAGE')}">
                <li><a class="app-menu__item " href="customer"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý khách hàng </span></a></li>
                    </c:if>

            <c:if test="${permissions.contains('CASHBOOK-MANAGE')}">
                <li><a class="app-menu__item " href="cashbook"><i class='app-menu__icon bx bx-dollar'></i><span
                            class="app-menu__label">Quản lý sổ quỹ</span></a></li>
                        </c:if>
                        <c:if test="${permissions.contains('INVENTORY-MANAGE')}">

                <li><a class="app-menu__item" href="inventory"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý   kho</span></a></li>
                        </c:if>


            <c:if test="${permissions.contains('SETTING')}">
                <li><a class="app-menu__item" href="settingController"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Thay đổi mật khẩu </span></a></li>
                        </c:if>


            <c:if test="${permissions.contains('ROLE-MANAGE')}">
                <li><a class="app-menu__item" href="roles"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Role Manage</span></a></li>
                        </c:if>


            <c:if test="${permissions.contains('PERMISSION-MANAGE')}">
                <li><a class="app-menu__item" href="permissions"><i class='app-menu__icon bx bx-run'></i><span
                            class="app-menu__label">Permission Manage</span></a></li>
                        </c:if>


        </c:if>
    </ul>


</aside>





