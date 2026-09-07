<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - Shopping Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --btn-gradient: linear-gradient(135deg, #0077ff 0%, #0052cc 100%);
        }

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

        .otp-card {
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            max-width: 440px;
            width: 100%;
            padding: 40px 34px;
            border: 1px solid rgba(255, 255, 255, 0.6);
        }

        .icon-wrapper {
            width: 70px;
            height: 70px;
            background: #e0f2fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .otp-input {
            letter-spacing: 8px;
            font-size: 24px;
            font-weight: 800;
            text-align: center;
            border-radius: 12px;
            padding: 12px;
            border: 2px solid #0077ff;
        }

        .btn-submit {
            background: var(--btn-gradient);
            color: #ffffff;
            font-weight: 700;
            font-size: 16px;
            padding: 12px;
            border-radius: 12px;
            border: none;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="otp-card text-center">
    <div class="icon-wrapper">
        <i class="bi bi-shield-check fs-2 text-primary"></i>
    </div>
    <h3 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h3>
    <p class="text-muted small mb-4">
        Mã OTP 6 chữ số đã được gửi tới email:<br>
        <strong class="text-primary">${email}</strong>
    </p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 px-3 small mb-3 rounded-3">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
        </div>
    </c:if>

    <c:if test="${not empty successAlert}">
        <div class="alert alert-success py-2 px-3 small mb-3 rounded-3">
            <i class="bi bi-check-circle-fill me-1"></i> ${successAlert}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="email" value="${email}">

        <div class="mb-4">
            <label class="form-label fw-bold text-dark small">Nhập Mã OTP (6 số)</label>
            <input type="text" name="otp" class="form-control otp-input" placeholder="------" maxlength="6" required autofocus>
        </div>

        <button type="submit" class="btn-submit mb-3">
            <i class="bi bi-patch-check-fill me-1"></i> Kích Hoạt Tài Khoản
        </button>
    </form>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="d-inline">
        <input type="hidden" name="email" value="${email}">
        <input type="hidden" name="action" value="resend">
        <button type="submit" class="btn btn-link text-decoration-none small text-primary p-0 border-0">
            <i class="bi bi-arrow-clockwise me-1"></i> Chưa nhận được mã? Gửi lại OTP
        </button>
    </form>
</div>

</body>
</html>
