<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống - MVC JDBC</title>
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
            --transition-speed: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #0284c7 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 24px;
            position: relative;
            overflow-x: hidden;
        }

        /* Glass Card */
        .login-card {
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            max-width: 440px;
            width: 100%;
            padding: 40px 34px;
            border: 1px solid rgba(255, 255, 255, 0.6);
            position: relative;
            z-index: 10;
        }

        .brand-icon-wrapper {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 8px 20px rgba(0, 119, 255, 0.15);
            transition: transform var(--transition-speed);
        }
        .brand-icon-wrapper:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .login-title {
            color: #0f172a;
            font-weight: 800;
            font-size: 26px;
            text-align: center;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }
        .login-subtitle {
            color: #64748b;
            font-size: 14px;
            text-align: center;
            margin-bottom: 25px;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group-custom .form-label {
            font-size: 13.5px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
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
            font-size: 16px;
            transition: color var(--transition-speed);
            z-index: 5;
        }
        .input-group-custom .form-control {
            border-radius: 10px;
            padding: 12px 14px 12px 42px;
            border: 1.5px solid #cbd5e1;
            font-size: 14.5px;
            background: #f8fafc;
            transition: all var(--transition-speed);
        }
        .input-group-custom .form-control:focus {
            background: #ffffff;
            border-color: #0077ff;
            box-shadow: 0 0 0 4px rgba(0, 119, 255, 0.15);
        }

        /* Nút đăng nhập với hiệu ứng đổi màu & glow */
        .btn-login {
            background: var(--btn-gradient);
            color: #ffffff;
            font-weight: 700;
            font-size: 15.5px;
            padding: 13px;
            border-radius: 10px;
            border: none;
            width: 100%;
            box-shadow: 0 6px 18px rgba(0, 119, 255, 0.35);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all var(--transition-speed);
            cursor: pointer;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #0055dd 0%, #003db3 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 119, 255, 0.5);
            color: #ffffff;
        }
        .btn-login:active {
            transform: translateY(0);
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            cursor: pointer;
            z-index: 5;
            transition: color var(--transition-speed);
        }
        .toggle-password:hover {
            color: #0077ff;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="brand-icon-wrapper">
        <i class="bi bi-shield-lock-fill fs-2 text-primary"></i>
    </div>
    <h2 class="login-title">Đăng Nhập Hệ Thống</h2>
    <p class="login-subtitle">Nhập thông tin xác thực để truy cập hệ thống</p>

    <!-- Error Alert -->
    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2 px-3 text-center small mb-3 rounded-3 shadow-sm">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
        </div>
    </c:if>

    <!-- Success Alert -->
    <c:if test="${not empty successAlert}">
        <div class="alert alert-success py-2 px-3 text-center small mb-3 rounded-3 shadow-sm">
            <i class="bi bi-check-circle-fill me-1"></i> ${successAlert}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <!-- Username (Tự động điền nếu đã nhớ từ Cookie) -->
        <div class="input-group-custom">
            <label class="form-label">Tên tài khoản (Username)</label>
            <div class="input-wrapper">
                <i class="bi bi-person-fill input-icon"></i>
                <input type="text" name="username" value="${username}" class="form-control" placeholder="Ví dụ: admin" required <c:if test="${empty username}">autofocus</c:if>>
            </div>
        </div>

        <!-- Password -->
        <div class="input-group-custom">
            <label class="form-label">Mật khẩu</label>
            <div class="input-wrapper">
                <i class="bi bi-lock-fill input-icon"></i>
                <input type="password" name="password" id="passwordField" class="form-control" placeholder="Nhập mật khẩu" required <c:if test="${not empty username}">autofocus</c:if>>
                <i class="bi bi-eye-slash-fill toggle-password" id="togglePassword" onclick="togglePasswordVisibility()"></i>
            </div>
        </div>

        <!-- Remember Me & Forgot Password -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
                <input type="checkbox" name="remember" class="form-check-input" id="rememberMe" <c:if test="${isRemember}">checked</c:if> style="cursor: pointer;">
                <label class="form-check-label small fw-semibold text-muted" for="rememberMe" style="cursor: pointer;">
                    Ghi nhớ đăng nhập
                </label>
            </div>
            <a href="#" class="small text-primary text-decoration-none fw-semibold">Quên mật khẩu?</a>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn-login">
            <i class="bi bi-box-arrow-in-right"></i> Đăng Nhập
        </button>
    </form>

    <div class="text-center mt-4 pt-3 border-top small text-muted">
        Chưa có tài khoản? 
        <a href="${pageContext.request.contextPath}/register" class="fw-bold text-primary text-decoration-none ms-1">
            Đăng ký ngay <i class="bi bi-arrow-right-short"></i>
        </a>
    </div>
</div>

<script>
    function togglePasswordVisibility() {
        const pwdInput = document.getElementById('passwordField');
        const toggleIcon = document.getElementById('togglePassword');
        if (pwdInput.type === 'password') {
            pwdInput.type = 'text';
            toggleIcon.classList.remove('bi-eye-slash-fill');
            toggleIcon.classList.add('bi-eye-fill');
        } else {
            pwdInput.type = 'password';
            toggleIcon.classList.remove('bi-eye-fill');
            toggleIcon.classList.add('bi-eye-slash-fill');
        }
    }
</script>

</body>
</html>