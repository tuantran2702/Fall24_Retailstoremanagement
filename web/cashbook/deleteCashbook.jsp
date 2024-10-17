<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xóa giao dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title text-danger">Xác nhận xóa giao dịch</h3>
                    </div>
                    <div class="card-body">
                        <p class="text-center">Bạn có chắc chắn muốn xóa giao dịch này không?</p>
                        <p class="text-center text-danger">Lưu ý: Hành động này không thể hoàn tác!</p>
                        
                        <form action="${pageContext.request.contextPath}/cashbook" method="POST" 
                              class="text-center mt-4">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${id}">
                            
                            <div class="d-grid gap-2 d-md-block">
                                <a href="${pageContext.request.contextPath}/cashbook" 
                                   class="btn btn-secondary me-2">Hủy</a>
                                <button type="submit" class="btn btn-danger">Xác nhận xóa</button>
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