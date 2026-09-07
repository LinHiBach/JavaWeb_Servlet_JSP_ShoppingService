<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Shopping Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #0284c7 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            margin: 0;
        }

        .card-custom {
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            max-width: 440px;
            width: 100%;
            padding: 40px 34px;
        }

        .btn-custom {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #ffffff;
            font-weight: 700;
            padding: 12px;
            border-radius: 12px;
            border: none;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="card-custom text-center">
    <div class="mb-3">
        <i class="bi bi-shield-lock-fill fs-1 text-success"></i>
    </div>
    <h3 class="fw-bold text-dark mb-1">Đặt Lại Mật Khẩu</h3>
    <p class="text-muted small mb-4">Nhập mã OTP vừa nhận từ email và tạo mật khẩu mới.</p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 px-3 small mb-3 rounded-3">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.latestOtp}">
        <div class="alert alert-info py-2 px-3 small mb-3 rounded-3 text-start">
            <div class="d-flex align-items-center justify-content-between">
                <span><i class="bi bi-key-fill text-primary me-1"></i> <strong>Mã OTP:</strong></span>
                <span class="badge bg-primary fs-6 px-3 py-2 letter-spacing-1">${sessionScope.latestOtp}</span>
            </div>
            <div class="text-muted mt-1" style="font-size: 11px;">
                (Mã OTP gửi về: <strong>${email}</strong> & hiển thị tại đây để bạn tiện thử nghiệm)
            </div>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="email" value="${email}">

        <div class="text-start mb-3">
            <label class="form-label fw-bold text-dark small">Mã OTP (6 số)</label>
            <input type="text" name="otp" value="${otp}" class="form-control text-center fw-bold fs-5" placeholder="Mã OTP" maxlength="6" pattern="^[0-9]{6}$" required autofocus>
        </div>

        <div class="text-start mb-3">
            <label class="form-label fw-bold text-dark small">Mật khẩu mới (Tối thiểu 6 ký tự)</label>
            <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" minlength="6" required>
        </div>

        <div class="text-start mb-4">
            <label class="form-label fw-bold text-dark small">Xác nhận mật khẩu mới</label>
            <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" minlength="6" required>
        </div>

        <button type="submit" class="btn-custom mb-3">
            <i class="bi bi-check-circle-fill me-1"></i> Đổi Mật Khẩu
        </button>
    </form>
</div>

</body>
</html>
