<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập — Shopping Store</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            height: 100%;
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        /* ===================== SPLIT SCREEN LAYOUT ===================== */
        .auth-split-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* LEFT PANEL — White Form */
        .auth-form-panel {
            flex: 0 0 480px;
            background: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 48px 52px;
            position: relative;
            z-index: 10;
        }

        /* RIGHT PANEL — Brand */
        .auth-brand-panel {
            flex: 1;
            background: linear-gradient(135deg, #1e1b4b 0%, #1d4ed8 45%, #7c3aed 100%);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px;
        }
        .auth-brand-panel::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at 30% 70%, rgba(124,58,237,0.4) 0%, transparent 60%),
                        radial-gradient(ellipse at 70% 20%, rgba(37,99,235,0.35) 0%, transparent 55%);
        }
        /* Floating blobs */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            animation: float-blob 7s ease-in-out infinite;
        }
        .blob-1 {
            width: 280px; height: 280px;
            background: rgba(124,58,237,0.25);
            top: -60px; right: -60px;
            animation-delay: 0s;
        }
        .blob-2 {
            width: 200px; height: 200px;
            background: rgba(37,99,235,0.2);
            bottom: 40px; left: -40px;
            animation-delay: 3.5s;
        }
        @keyframes float-blob {
            0%, 100% { transform: translateY(0px) scale(1); }
            50% { transform: translateY(-24px) scale(1.06); }
        }

        .brand-panel-content {
            position: relative;
            z-index: 2;
            text-align: center;
        }
        .brand-panel-logo {
            width: 72px;
            height: 72px;
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 28px;
            font-size: 32px;
            color: #ffffff;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        }
        .brand-panel-title {
            font-size: 30px;
            font-weight: 900;
            color: #ffffff;
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }
        .brand-panel-subtitle {
            font-size: 15px;
            color: rgba(255,255,255,0.65);
            margin-bottom: 40px;
            line-height: 1.65;
            max-width: 320px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Feature List */
        .feature-list {
            list-style: none;
            text-align: left;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .feature-list li {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
            color: rgba(255,255,255,0.8);
            font-weight: 600;
        }
        .feature-list li .feat-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            color: #93c5fd;
            flex-shrink: 0;
        }

        /* Floating product cards */
        .floating-cards {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }
        .float-card {
            position: absolute;
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.14);
            border-radius: 14px;
            padding: 12px 16px;
            font-size: 12px;
            color: rgba(255,255,255,0.9);
            font-weight: 700;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }
        .float-card-1 {
            top: 12%;
            right: 10%;
            animation: float-card 5s ease-in-out infinite;
        }
        .float-card-2 {
            bottom: 20%;
            left: 8%;
            animation: float-card 5s ease-in-out infinite 2.5s;
        }
        @keyframes float-card {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-12px); }
        }

        /* ===================== FORM PANEL ===================== */
        .form-panel-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 40px;
        }
        .form-panel-logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #fff;
            box-shadow: 0 4px 14px rgba(37,99,235,0.3);
        }
        .form-panel-logo-text {
            font-size: 18px;
            font-weight: 900;
            background: linear-gradient(135deg, #1e3a8a, #2563eb, #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-heading {
            font-size: 26px;
            font-weight: 900;
            color: #0f172a;
            letter-spacing: -0.4px;
            margin-bottom: 6px;
        }
        .form-subheading {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 32px;
        }

        /* Error Alert */
        .auth-alert {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 24px;
        }
        .auth-alert-danger {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        .auth-alert-info {
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
        }
        .auth-alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        /* Form Controls */
        .form-group-custom {
            margin-bottom: 18px;
        }
        .form-label-custom {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #374151;
            margin-bottom: 8px;
        }
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-icon {
            position: absolute;
            left: 14px;
            color: #94a3b8;
            font-size: 17px;
            pointer-events: none;
            transition: color 0.2s;
        }
        .input-custom {
            width: 100%;
            padding: 12px 44px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 500;
            color: #0f172a;
            background: #f8fafc;
            transition: all 0.22s cubic-bezier(0.4,0,0.2,1);
            outline: none;
            font-family: inherit;
        }
        .input-custom:focus {
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(37,99,235,0.1);
        }
        .input-custom::placeholder { color: #94a3b8; }
        .input-custom.is-invalid {
            border-color: #ef4444;
            background: #fff;
        }
        .input-custom.is-invalid:focus {
            box-shadow: 0 0 0 4px rgba(239,68,68,0.1);
        }
        .invalid-msg {
            font-size: 12px;
            color: #ef4444;
            font-weight: 600;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Password Toggle */
        .input-toggle-pw {
            position: absolute;
            right: 14px;
            background: none;
            border: none;
            color: #94a3b8;
            font-size: 17px;
            cursor: pointer;
            padding: 0;
            line-height: 1;
            transition: color 0.2s;
        }
        .input-toggle-pw:hover { color: #2563eb; }

        /* Checkbox Remember */
        .remember-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .remember-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 13.5px;
            color: #475569;
            font-weight: 600;
        }
        .remember-label input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: #2563eb;
            cursor: pointer;
        }
        .forgot-link {
            font-size: 13.5px;
            font-weight: 700;
            color: #2563eb;
            text-decoration: none;
        }
        .forgot-link:hover { text-decoration: underline; }

        /* Submit Button */
        .btn-auth-submit {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 15.5px;
            font-weight: 800;
            background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
            color: #ffffff;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 6px 20px rgba(37,99,235,0.35);
            transition: all 0.28s cubic-bezier(0.4,0,0.2,1);
            margin-bottom: 20px;
            font-family: inherit;
        }
        .btn-auth-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(37,99,235,0.45);
        }
        .btn-auth-submit:active { transform: translateY(0); }

        .auth-divider {
            text-align: center;
            font-size: 13px;
            color: #94a3b8;
            margin-bottom: 16px;
        }
        .auth-link-row {
            text-align: center;
            font-size: 14px;
            color: #64748b;
        }
        .auth-link-row a {
            color: #2563eb;
            font-weight: 800;
            text-decoration: none;
        }
        .auth-link-row a:hover { text-decoration: underline; }

        /* Animation on form panel */
        .auth-form-panel {
            animation: slideInLeft 0.5s cubic-bezier(0.34,1.26,0.64,1);
        }
        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-32px); }
            to   { opacity: 1; transform: translateX(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .auth-brand-panel { display: none; }
            .auth-form-panel {
                flex: 1;
                padding: 36px 24px;
            }
        }
    </style>
</head>
<body>
    <div class="auth-split-wrapper">

        <!-- ====== LEFT: FORM PANEL ====== -->
        <div class="auth-form-panel">

            <!-- Mini Logo -->
            <div class="form-panel-logo">
                <div class="form-panel-logo-icon">
                    <i class="bi bi-bag-heart-fill"></i>
                </div>
                <span class="form-panel-logo-text">Shopping Store</span>
            </div>

            <h1 class="form-heading">Chào mừng trở lại! 👋</h1>
            <p class="form-subheading">Đăng nhập để tiếp tục trải nghiệm mua sắm của bạn.</p>

            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="auth-alert auth-alert-danger">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="auth-alert auth-alert-success">
                    <i class="bi bi-check-circle-fill"></i> ${message}
                </div>
            </c:if>
            <c:if test="${not empty info}">
                <div class="auth-alert auth-alert-info">
                    <i class="bi bi-info-circle-fill"></i> ${info}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/login" method="post" novalidate>

                <!-- Username -->
                <div class="form-group-custom">
                    <label class="form-label-custom" for="loginUsername">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <i class="bi bi-person-fill input-icon"></i>
                        <input type="text" id="loginUsername" name="username"
                               value="${username}"
                               class="input-custom ${not empty errors.username ? 'is-invalid' : ''}"
                               placeholder="Nhập tên đăng nhập..." required autofocus>
                    </div>
                    <c:if test="${not empty errors.username}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.username}</div>
                    </c:if>
                </div>

                <!-- Password -->
                <div class="form-group-custom">
                    <label class="form-label-custom" for="loginPassword">Mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock-fill input-icon"></i>
                        <input type="password" id="loginPassword" name="password"
                               class="input-custom ${not empty errors.password ? 'is-invalid' : ''}"
                               placeholder="Nhập mật khẩu..." required>
                        <button type="button" class="input-toggle-pw" onclick="togglePassword('loginPassword', this)" tabindex="-1">
                            <i class="bi bi-eye-slash"></i>
                        </button>
                    </div>
                    <c:if test="${not empty errors.password}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.password}</div>
                    </c:if>
                </div>

                <!-- Remember + Forgot -->
                <div class="remember-row">
                    <label class="remember-label">
                        <input type="checkbox" name="remember" value="true"> Ghi nhớ đăng nhập
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Quên mật khẩu?</a>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn-auth-submit">
                    <i class="bi bi-box-arrow-in-right"></i> Đăng nhập ngay
                </button>

                <!-- Register Link -->
                <p class="auth-link-row">
                    Chưa có tài khoản?
                    <a href="${pageContext.request.contextPath}/register">Đăng ký miễn phí →</a>
                </p>
            </form>
        </div>

        <!-- ====== RIGHT: BRAND PANEL ====== -->
        <div class="auth-brand-panel">
            <!-- Blobs -->
            <div class="blob blob-1"></div>
            <div class="blob blob-2"></div>

            <!-- Floating product-like cards -->
            <div class="floating-cards">
                <div class="float-card float-card-1">
                    🛍️ Sản phẩm mới hôm nay
                    <br><small style="opacity:0.7;">Cập nhật liên tục từ CSDL JPA</small>
                </div>
                <div class="float-card float-card-2">
                    🔒 Bảo mật tài khoản
                    <br><small style="opacity:0.7;">Mã hóa BCrypt + Session</small>
                </div>
            </div>

            <!-- Main content -->
            <div class="brand-panel-content">
                <div class="brand-panel-logo">
                    <i class="bi bi-bag-heart-fill"></i>
                </div>
                <h2 class="brand-panel-title">Shopping Store MVC</h2>
                <p class="brand-panel-subtitle">
                    Nền tảng thương mại điện tử được xây dựng theo kiến trúc Three-Tier chuẩn doanh nghiệp với Java Servlet & JPA/Hibernate.
                </p>
                <ul class="feature-list">
                    <li>
                        <div class="feat-icon"><i class="bi bi-layers-fill"></i></div>
                        Kiến trúc Three-Tier (Entity → DAO → Service → Controller → View)
                    </li>
                    <li>
                        <div class="feat-icon"><i class="bi bi-database-fill"></i></div>
                        JPA / Hibernate ORM + SQL Server Database
                    </li>
                    <li>
                        <div class="feat-icon"><i class="bi bi-layout-split"></i></div>
                        SiteMesh 3 Decorator với Bootstrap 5 Template
                    </li>
                    <li>
                        <div class="feat-icon"><i class="bi bi-shield-lock-fill"></i></div>
                        Bảo mật BCrypt Hash + Session + Cookie "Remember Me"
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'bi bi-eye';
            } else {
                input.type = 'password';
                icon.className = 'bi bi-eye-slash';
            }
        }
    </script>
</body>
</html>