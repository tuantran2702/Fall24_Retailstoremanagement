<%-- 
    Document   : test
    Created on : Sep 25, 2024, 10:19:04 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <!-- Sidebar User Info -->
    <div class="app-sidebar__user">
        <img class="app-sidebar__user-avatar" src="${sessionScope.User.getImg()}" width="50px" alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b>${sessionScope.User.getFirstName()} ${sessionScope.User.getLastName()}</b></p>
            <p class="app-sidebar__user-designation">Chào bạn trở lại!</p>
        </div>
    </div>
    <hr>

    <!-- Menu Sidebar -->
    <ul class="app-menu">
        <c:if test="${not empty sessionScope.assignedPermissions}">
            <!-- Bán Hàng -->
            <c:if test="${sessionScope.assignedPermissions.contains('ORDER-MANAGE')}">
                <li><a class="app-menu__item haha" href="order">
                    <i class="app-menu__icon bx bx-shopping-bag"></i>
                    <span class="app-menu__label">POS Bán Hàng</span>
                </a></li>
            </c:if>

            <!-- Bảng điều khiển -->
            <c:if test="${sessionScope.assignedPermissions.contains('HOMEPAGE')}">
                <li><a class="app-menu__item " href="homepage">
                    <i class="app-menu__icon bx bx-grid-alt"></i>
                    <span class="app-menu__label">Bảng điều khiển</span>
                </a></li>
            </c:if>

            <!-- Quản lý nhân viên -->
            <c:if test="${sessionScope.assignedPermissions.contains('USER-MANAGE')}">
                <li><a class="app-menu__item " href="userManage">
                    <i class="app-menu__icon bx bx-group"></i>
                    <span class="app-menu__label">Quản lý nhân viên</span>
                </a></li>
            </c:if>

            <!-- Quản lý sản phẩm -->
            <c:if test="${sessionScope.assignedPermissions.contains('PRODUCT-MANAGE')}">
                <li><a class="app-menu__item " href="product">
                    <i class="app-menu__icon bx bx-box"></i>
                    <span class="app-menu__label">Quản lý sản phẩm</span>
                </a></li>
            </c:if>

            <!-- Quản lý khách hàng -->
            <c:if test="${sessionScope.assignedPermissions.contains('CUSTOMER-MANAGE')}">
                <li><a class="app-menu__item " href="customer">
                    <i class="app-menu__icon bx bx-user"></i>
                    <span class="app-menu__label">Quản lý khách hàng</span>
                </a></li>
            </c:if>

            <!-- Quản lý sổ quỹ -->
            <c:if test="${sessionScope.assignedPermissions.contains('CASHBOOK-MANAGE')}">
                <li><a class="app-menu__item " href="cashbook">
                    <i class="app-menu__icon bx bx-wallet"></i>
                    <span class="app-menu__label">Quản lý sổ quỹ</span>
                </a></li>
            </c:if>

            <!-- Quản lý kho -->
            <c:if test="${sessionScope.assignedPermissions.contains('INVENTORY-MANAGE')}">
                <li><a class="app-menu__item " href="inventory">
                    <i class="app-menu__icon bx bx-store"></i>
                    <span class="app-menu__label">Quản lý kho</span>
                </a></li>
            </c:if>

            <!-- Thay đổi mật khẩu -->
            <c:if test="${sessionScope.assignedPermissions.contains('SETTING')}">
                <li><a class="app-menu__item " href="settingController">
                    <i class="app-menu__icon bx bx-key"></i>
                    <span class="app-menu__label">Thay đổi mật khẩu</span>
                </a></li>
            </c:if>

            <!-- Quản lý chức vụ -->
            <c:if test="${sessionScope.assignedPermissions.contains('ROLE-MANAGE')}">
                <li><a class="app-menu__item " href="roles">
                    <i class="app-menu__icon bx bx-user-pin"></i>
                    <span class="app-menu__label">Quản lý chức vụ</span>
                </a></li>
            </c:if>

            <!-- Quản lý phân quyền -->
            <c:if test="${sessionScope.assignedPermissions.contains('PERMISSION-MANAGE')}">
                <li><a class="app-menu__item " href="permissions">
                    <i class="app-menu__icon bx bx-lock-alt"></i>
                    <span class="app-menu__label">Quản lý phân quyền</span>
                </a></li>
            </c:if>
        </c:if>
    </ul>
</aside>
