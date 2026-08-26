<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản Mới - MVC JDBC</title>
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
            --btn-gradient: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --transition-speed: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #0f172a 0%, #064e3b 50%, #047857 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 30px 20px;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            max-width: 480px;
            width: 100%;
            padding: 40px 35px;
            border: 1px solid rgba(255, 255, 255, 0.6);
        }

        .brand-icon-wrapper {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.2);
            transition: transform var(--transition-speed);
        }
        .brand-icon-wrapper:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .register-title {
            color: #0f172a;
            font-weight: 800;
            font-size: 26px;
            text-align: center;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }
        .register-subtitle {
            color: #64748b;
            font-size: 14px;
            text-align: center;
            margin-bottom: 24px;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 16px;
        }
        .input-group-custom .form-label {
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 5px;
            display: block;
        }
        .input-group-custom .input-wrapper {
            position: relative;
        }
        .input-group-custom .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 15px;
            z-index: 5;
        }
        .input-group-custom .form-control {
            border-radius: 10px;
            padding: 10px 14px 10px 42px;
            border: 1.5px solid #cbd5e1;
            font-size: 14px;
            background: #f8fafc;
            transition: all var(--transition-speed);
        }
        .input-group-custom .form-control:focus {
            background: #ffffff;
            border-color: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
        }

        /* Nút tạo tài khoản đổi màu & hover glow */
        .btn-register {
            background: var(--btn-gradient);
            color: #ffffff;
            font-weight: 700;
            font-size: 15.5px;
            padding: 12px;
            border-radius: 10px;
            border: none;
            width: 100%;
            box-shadow: 0 6px 18px rgba(16, 185, 129, 0.35);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all var(--transition-speed);
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-register:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.5);
            color: #ffffff;
        }
        .btn-register:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>

<div class="register-card">
    <div class="brand-icon-wrapper">
        <i class="bi bi-person-plus-fill fs-2 text-success"></i>
    </div>
    <h2 class="register-title">Tạo Tài Khoản Mới</h2>
    <p class="register-subtitle">Điền thông tin để đăng ký thành viên hệ thống</p>

    <!-- Alert Message -->
    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 px-3 text-center small mb-3 rounded-3 shadow-sm">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <!-- Username -->
        <div class="input-group-custom">
            <label class="form-label">Tên tài khoản (Username) *</label>
            <div class="input-wrapper">
                <i class="bi bi-person-badge-fill input-icon"></i>
                <input type="text" name="username" class="form-control" placeholder="Nhập tên tài khoản" required autofocus>
            </div>
        </div>

        <!-- Fullname -->
        <div class="input-group-custom">
            <label class="form-label">Họ và tên</label>
            <div class="input-wrapper">
                <i class="bi bi-person-vcard-fill input-icon"></i>
                <input type="text" name="fullname" class="form-control" placeholder="Ví dụ: Nguyễn Văn A">
            </div>
        </div>

        <!-- Email -->
        <div class="input-group-custom">
            <label class="form-label">Địa chỉ Email *</label>
            <div class="input-wrapper">
                <i class="bi bi-envelope-fill input-icon"></i>
                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
            </div>
        </div>

        <!-- Phone -->
        <div class="input-group-custom">
            <label class="form-label">Số điện thoại</label>
            <div class="input-wrapper">
                <i class="bi bi-telephone-fill input-icon"></i>
                <input type="tel" name="phone" class="form-control" placeholder="Ví dụ: 0901234567">
            </div>
        </div>

        <!-- Password -->
        <div class="input-group-custom">
            <label class="form-label">Mật khẩu *</label>
            <div class="input-wrapper">
                <i class="bi bi-shield-lock-fill input-icon"></i>
                <input type="password" name="password" class="form-control" placeholder="Tạo mật khẩu an toàn" required>
            </div>
        </div>

        <button type="submit" class="btn-register">
            <i class="bi bi-check-circle-fill"></i> Đăng Ký Tài Khoản
        </button>
    </form>

    <div class="text-center mt-4 pt-3 border-top small text-muted">
        Đã có tài khoản? 
        <a href="${pageContext.request.contextPath}/login" class="fw-bold text-success text-decoration-none ms-1">
            Đăng nhập tại đây <i class="bi bi-arrow-right-short"></i>
        </a>
    </div>
</div>

</body>
</html>