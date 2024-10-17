<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật giao dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Cập nhật giao dịch</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/cashbook" method="POST">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${transaction.transactionID}">
                            
                            <div class="mb-3">
                                <label for="transactionDate" class="form-label">Ngày giao dịch:</label>
                                <input type="datetime-local" class="form-control" id="transactionDate" 
                                       name="transactionDate" 
                                       value="<fmt:formatDate value="${transaction.transactionDate}" pattern="yyyy-MM-dd'T'HH:mm"/>" 
                                       required>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả:</label>
                                <input type="text" class="form-control" id="description" 
                                       name="description" value="${transaction.description}" required>
                            </div>

                            <div class="mb-3">
                                <label for="amount" class="form-label">Số tiền:</label>
                                <input type="number" class="form-control" id="amount" 
                                       name="amount" step="1000" value="${transaction.amount}" required>
                            </div>

                            <div class="mb-3">
                                <label for="transactionType" class="form-label">Loại giao dịch:</label>
                                <select class="form-select" id="transactionType" name="transactionType" required>
                                    <option value="Thu" ${transaction.transactionType == 'Thu' ? 'selected' : ''}>Thu</option>
                                    <option value="Chi" ${transaction.transactionType == 'Chi' ? 'selected' : ''}>Chi</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="orderID" class="form-label">Mã đơn hàng (nếu có):</label>
                                <input type="number" class="form-control" id="orderID" 
                                       name="orderID" value="${transaction.orderID}">
                            </div>

                            <div class="mb-3">
                                <label for="importID" class="form-label">Mã nhập hàng (nếu có):</label>
                                <input type="number" class="form-control" id="importID" 
                                       name="importID" value="${transaction.importID}">
                            </div>

                            <div class="text-end">
                                <a href="${pageContext.request.contextPath}/cashbook" 
                                   class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>