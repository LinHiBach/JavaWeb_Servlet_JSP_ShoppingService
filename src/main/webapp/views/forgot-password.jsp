<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Shopping Store</title>
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
            background: linear-gradient(135deg, #0077ff 0%, #0052cc 100%);
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
        <i class="bi bi-key-fill fs-1 text-primary"></i>
    </div>
    <h3 class="fw-bold text-dark mb-1">Quên Mật Khẩu?</h3>
    <p class="text-muted small mb-4">Nhập địa chỉ email đăng ký để nhận mã xác thực OTP đặt lại mật khẩu.</p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 px-3 small mb-3 rounded-3">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="text-start mb-4">
            <label class="form-label fw-bold text-dark small">Địa chỉ Email đăng ký</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                <input type="email" name="email" value="${email}" class="form-control" placeholder="example@gmail.com" required autofocus>
            </div>
        </div>

        <button type="submit" class="btn-custom mb-3">
            <i class="bi bi-send-fill me-1"></i> Gửi Mã OTP Xác Thực
        </button>
    </form>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/login" class="small text-muted text-decoration-none">
            <i class="bi bi-arrow-left me-1"></i> Quay lại Đăng nhập
        </a>
    </div>
</div>

</body>
</html>
