<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm giao dịch mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        /* CSS styles as before */
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-plus-circle me-2"></i>Thêm giao dịch mới</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/cashbook" method="POST">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="mb-4">
                                <label for="transactionDate" class="form-label"><i class="far fa-calendar-alt me-2"></i>Ngày giao dịch:</label>
                                <input type="datetime-local" class="form-control" id="transactionDate" name="transactionDate" required>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label"><i class="fas fa-align-left me-2"></i>Mô tả:</label>
                                <input type="text" class="form-control" id="description" name="description" required>
                            </div>

                            <div class="mb-4">
                                <label for="amount" class="form-label"><i class="fas fa-money-bill-wave me-2"></i>Số tiền:</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="amount" name="amount" step="1000" required>
                                    <span class="input-group-text">VNĐ</span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="transactionType" class="form-label"><i class="fas fa-exchange-alt me-2"></i>Loại giao dịch:</label>
                                <select class="form-select" id="transactionType" name="transactionType" required>
                                    <option value="Thu">Thu</option>
                                    <option value="Chi">Chi</option>
                                </select>
                            </div>

                            <div class="text-end">
                                <a href="${pageContext.request.contextPath}/cashbook" class="btn btn-secondary me-2"><i class="fas fa-times me-2"></i>Hủy</a>
                                <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.getElementById('transactionType').addEventListener('change', function() {
            const amountField = document.getElementById('amount');
            let amountValue = parseFloat(amountField.value);

            if (this.value === 'Chi' && amountValue > 0) {
                amountField.value = -Math.abs(amountValue); // Thêm dấu -
            } else if (this.value === 'Thu' && amountValue < 0) {
                amountField.value = Math.abs(amountValue); // Xóa dấu -
            }
        });
    </script>
</body>
</html>
