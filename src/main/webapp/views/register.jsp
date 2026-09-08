<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản — Shopping Store</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; font-family: 'Plus Jakarta Sans', -apple-system, sans-serif; -webkit-font-smoothing: antialiased; }

        .auth-split-wrapper { display: flex; min-height: 100vh; }

        /* RIGHT: Brand Panel */
        .auth-brand-panel {
            order: 2;
            flex: 0 0 400px;
            background: linear-gradient(135deg, #064e3b 0%, #065f46 40%, #10b981 100%);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 40px;
        }
        .auth-brand-panel::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at 25% 75%, rgba(16,185,129,0.4), transparent 60%),
                        radial-gradient(ellipse at 75% 25%, rgba(5,150,105,0.3), transparent 55%);
        }
        .blob { position: absolute; border-radius: 50%; filter: blur(55px); animation: float-blob 8s ease-in-out infinite; }
        .blob-1 { width: 260px; height: 260px; background: rgba(52,211,153,0.2); top: -50px; right: -50px; }
        .blob-2 { width: 180px; height: 180px; background: rgba(6,78,59,0.3); bottom: 30px; left: -30px; animation-delay: 4s; }
        @keyframes float-blob { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-20px); } }

        .brand-panel-content { position: relative; z-index: 2; text-align: center; }
        .brand-panel-logo {
            width: 72px; height: 72px;
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
            font-size: 30px; color: #fff;
        }
        .brand-panel-title { font-size: 26px; font-weight: 900; color: #fff; margin-bottom: 10px; }
        .brand-panel-subtitle { font-size: 14px; color: rgba(255,255,255,0.65); margin-bottom: 36px; line-height: 1.65; }

        .benefit-list { list-style: none; text-align: left; display: flex; flex-direction: column; gap: 14px; }
        .benefit-list li {
            display: flex; align-items: flex-start; gap: 12px;
            font-size: 13.5px; color: rgba(255,255,255,0.85); font-weight: 600; line-height: 1.5;
        }
        .benefit-check {
            width: 26px; height: 26px; border-radius: 8px;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.2);
            display: flex; align-items: center; justify-content: center;
            color: #6ee7b7; font-size: 13px; flex-shrink: 0; margin-top: 1px;
        }

        /* LEFT: Form Panel */
        .auth-form-panel {
            order: 1; flex: 1;
            background: #ffffff;
            display: flex; flex-direction: column; justify-content: center;
            padding: 40px 52px;
            animation: slideInLeft 0.45s cubic-bezier(0.34,1.2,0.64,1);
        }
        @keyframes slideInLeft { from { opacity: 0; transform: translateX(-24px); } to { opacity: 1; transform: translateX(0); } }

        .form-panel-logo {
            display: flex; align-items: center; gap: 10px; margin-bottom: 32px;
        }
        .form-panel-logo-icon {
            width: 38px; height: 38px;
            background: linear-gradient(135deg, #059669, #10b981);
            border-radius: 10px; display: flex; align-items: center; justify-content: center;
            font-size: 18px; color: #fff; box-shadow: 0 4px 14px rgba(16,185,129,0.3);
        }
        .form-panel-logo-text { font-size: 17px; font-weight: 900; color: #0f172a; }

        .form-heading { font-size: 24px; font-weight: 900; color: #0f172a; letter-spacing: -0.3px; margin-bottom: 4px; }
        .form-subheading { font-size: 13.5px; color: #64748b; margin-bottom: 24px; }

        /* Alert */
        .auth-alert {
            display: flex; align-items: center; gap: 10px;
            padding: 11px 14px; border-radius: 10px;
            font-size: 13px; font-weight: 600; margin-bottom: 18px;
        }
        .auth-alert-danger { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }

        /* Form groups */
        .form-row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .form-group-custom { margin-bottom: 16px; }
        .form-label-custom { display: block; font-size: 12.5px; font-weight: 700; color: #374151; margin-bottom: 6px; }

        .input-wrapper { position: relative; display: flex; align-items: center; }
        .input-icon { position: absolute; left: 13px; color: #94a3b8; font-size: 16px; pointer-events: none; }
        .input-custom {
            width: 100%; padding: 11px 42px;
            border: 1.5px solid #e2e8f0; border-radius: 10px;
            font-size: 14px; font-weight: 500; color: #0f172a; background: #f8fafc;
            transition: all 0.22s; outline: none; font-family: inherit;
        }
        .input-custom:focus { border-color: #059669; background: #fff; box-shadow: 0 0 0 4px rgba(16,185,129,0.1); }
        .input-custom.is-invalid { border-color: #ef4444; background: #fff; }
        .input-custom.is-invalid:focus { box-shadow: 0 0 0 4px rgba(239,68,68,0.1); }
        .input-toggle-pw {
            position: absolute; right: 12px;
            background: none; border: none; color: #94a3b8; font-size: 16px; cursor: pointer; padding: 0;
        }
        .input-toggle-pw:hover { color: #059669; }
        .invalid-msg { font-size: 11.5px; color: #ef4444; font-weight: 600; margin-top: 4px; display: flex; align-items: center; gap: 3px; }

        /* Password Strength Meter */
        .pw-strength-bar {
            height: 4px; border-radius: 4px; margin-top: 8px;
            background: #e2e8f0; overflow: hidden;
        }
        .pw-strength-fill {
            height: 100%; border-radius: 4px; width: 0%;
            transition: width 0.35s, background 0.35s;
        }
        .pw-strength-label {
            font-size: 11.5px; font-weight: 700; margin-top: 4px; display: none;
        }
        .strength-weak  { color: #ef4444; }
        .strength-medium { color: #f59e0b; }
        .strength-strong { color: #10b981; }

        /* Submit Button */
        .btn-auth-submit {
            width: 100%; padding: 13px;
            border: none; border-radius: 10px;
            font-size: 15px; font-weight: 800;
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: #fff; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            box-shadow: 0 6px 20px rgba(16,185,129,0.35);
            transition: all 0.25s; margin-bottom: 16px; font-family: inherit;
        }
        .btn-auth-submit:hover { transform: translateY(-2px); box-shadow: 0 12px 30px rgba(16,185,129,0.45); }

        .auth-link-row { text-align: center; font-size: 13.5px; color: #64748b; }
        .auth-link-row a { color: #059669; font-weight: 800; text-decoration: none; }
        .auth-link-row a:hover { text-decoration: underline; }

        @media (max-width: 768px) {
            .auth-brand-panel { display: none; }
            .auth-form-panel { padding: 32px 20px; }
            .form-row-2 { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="auth-split-wrapper">

    <!-- LEFT: FORM -->
    <div class="auth-form-panel">
        <div class="form-panel-logo">
            <div class="form-panel-logo-icon"><i class="bi bi-bag-heart-fill"></i></div>
            <span class="form-panel-logo-text">Shopping Store</span>
        </div>

        <h1 class="form-heading">Tạo tài khoản mới 🎉</h1>
        <p class="form-subheading">Điền đầy đủ thông tin để bắt đầu mua sắm ngay hôm nay!</p>

        <c:if test="${not empty error}">
            <div class="auth-alert auth-alert-danger">
                <i class="bi bi-exclamation-circle-fill"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" novalidate>

            <!-- Fullname + Username -->
            <div class="form-row-2">
                <div class="form-group-custom">
                    <label class="form-label-custom" for="regFullname">Họ và tên *</label>
                    <div class="input-wrapper">
                        <i class="bi bi-person-fill input-icon"></i>
                        <input type="text" id="regFullname" name="fullname" value="${fullname}"
                               class="input-custom ${not empty errors.fullname ? 'is-invalid' : ''}"
                               placeholder="Nguyễn Văn A" required>
                    </div>
                    <c:if test="${not empty errors.fullname}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.fullname}</div>
                    </c:if>
                </div>
                <div class="form-group-custom">
                    <label class="form-label-custom" for="regUsername">Tên đăng nhập *</label>
                    <div class="input-wrapper">
                        <i class="bi bi-at input-icon"></i>
                        <input type="text" id="regUsername" name="username" value="${username}"
                               class="input-custom ${not empty errors.username ? 'is-invalid' : ''}"
                               placeholder="user123" required minlength="4" maxlength="30">
                    </div>
                    <c:if test="${not empty errors.username}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.username}</div>
                    </c:if>
                </div>
            </div>

            <!-- Email -->
            <div class="form-group-custom">
                <label class="form-label-custom" for="regEmail">Email *</label>
                <div class="input-wrapper">
                    <i class="bi bi-envelope-fill input-icon"></i>
                    <input type="email" id="regEmail" name="email" value="${email}"
                           class="input-custom ${not empty errors.email ? 'is-invalid' : ''}"
                           placeholder="example@email.com" required>
                </div>
                <c:if test="${not empty errors.email}">
                    <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.email}</div>
                </c:if>
            </div>

            <!-- Phone -->
            <div class="form-group-custom">
                <label class="form-label-custom" for="regPhone">Số điện thoại</label>
                <div class="input-wrapper">
                    <i class="bi bi-telephone-fill input-icon"></i>
                    <input type="tel" id="regPhone" name="phone" value="${phone}"
                           class="input-custom ${not empty errors.phone ? 'is-invalid' : ''}"
                           placeholder="0912345678" pattern="0[0-9]{9}" title="10 chữ số bắt đầu bằng 0">
                </div>
                <c:if test="${not empty errors.phone}">
                    <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.phone}</div>
                </c:if>
            </div>

            <!-- Password + Confirm -->
            <div class="form-row-2">
                <div class="form-group-custom">
                    <label class="form-label-custom" for="regPassword">Mật khẩu *</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock-fill input-icon"></i>
                        <input type="password" id="regPassword" name="password"
                               class="input-custom ${not empty errors.password ? 'is-invalid' : ''}"
                               placeholder="Tối thiểu 6 ký tự" required minlength="6"
                               oninput="checkPasswordStrength(this.value)">
                        <button type="button" class="input-toggle-pw" onclick="togglePassword('regPassword', this)" tabindex="-1">
                            <i class="bi bi-eye-slash"></i>
                        </button>
                    </div>
                    <!-- Password Strength -->
                    <div class="pw-strength-bar">
                        <div class="pw-strength-fill" id="pwStrengthFill"></div>
                    </div>
                    <div class="pw-strength-label" id="pwStrengthLabel"></div>
                    <c:if test="${not empty errors.password}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.password}</div>
                    </c:if>
                </div>
                <div class="form-group-custom">
                    <label class="form-label-custom" for="regRepassword">Xác nhận mật khẩu *</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock-fill input-icon"></i>
                        <input type="password" id="regRepassword" name="repassword"
                               class="input-custom ${not empty errors.repassword ? 'is-invalid' : ''}"
                               placeholder="Nhập lại mật khẩu" required>
                        <button type="button" class="input-toggle-pw" onclick="togglePassword('regRepassword', this)" tabindex="-1">
                            <i class="bi bi-eye-slash"></i>
                        </button>
                    </div>
                    <c:if test="${not empty errors.repassword}">
                        <div class="invalid-msg"><i class="bi bi-x-circle-fill"></i> ${errors.repassword}</div>
                    </c:if>
                </div>
            </div>

            <button type="submit" class="btn-auth-submit">
                <i class="bi bi-person-plus-fill"></i> Tạo tài khoản ngay
            </button>

            <p class="auth-link-row">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập →</a>
            </p>
        </form>
    </div>

    <!-- RIGHT: BRAND PANEL -->
    <div class="auth-brand-panel">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
        <div class="brand-panel-content">
            <div class="brand-panel-logo"><i class="bi bi-person-plus-fill"></i></div>
            <h2 class="brand-panel-title">Tham gia ngay hôm nay!</h2>
            <p class="brand-panel-subtitle">Đăng ký miễn phí và khám phá hàng trăm sản phẩm chất lượng từ hệ thống.</p>
            <ul class="benefit-list">
                <li>
                    <div class="benefit-check"><i class="bi bi-check-lg"></i></div>
                    Truy cập đầy đủ danh sách sản phẩm với bộ lọc và phân trang
                </li>
                <li>
                    <div class="benefit-check"><i class="bi bi-check-lg"></i></div>
                    Quản lý hồ sơ cá nhân và ảnh đại diện qua Multipart Upload
                </li>
                <li>
                    <div class="benefit-check"><i class="bi bi-check-lg"></i></div>
                    Khôi phục mật khẩu qua email với mã OTP 6 chữ số bảo mật
                </li>
                <li>
                    <div class="benefit-check"><i class="bi bi-check-lg"></i></div>
                    Cookie "Remember Me" giúp tự động đăng nhập lần sau
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
        if (input.type === 'password') { input.type = 'text'; icon.className = 'bi bi-eye'; }
        else { input.type = 'password'; icon.className = 'bi bi-eye-slash'; }
    }

    function checkPasswordStrength(pw) {
        const fill = document.getElementById('pwStrengthFill');
        const label = document.getElementById('pwStrengthLabel');
        label.style.display = 'block';

        let score = 0;
        if (pw.length >= 6) score++;
        if (pw.length >= 10) score++;
        if (/[A-Z]/.test(pw)) score++;
        if (/[0-9]/.test(pw)) score++;
        if (/[^A-Za-z0-9]/.test(pw)) score++;

        if (score <= 1) {
            fill.style.width = '25%';
            fill.style.background = '#ef4444';
            label.textContent = '⚠ Yếu — Dễ bị tấn công';
            label.className = 'pw-strength-label strength-weak';
        } else if (score <= 3) {
            fill.style.width = '60%';
            fill.style.background = '#f59e0b';
            label.textContent = '◑ Trung bình — Có thể mạnh hơn';
            label.className = 'pw-strength-label strength-medium';
        } else {
            fill.style.width = '100%';
            fill.style.background = '#10b981';
            label.textContent = '✓ Mạnh — Bảo mật tốt!';
            label.className = 'pw-strength-label strength-strong';
        }
        if (!pw) { fill.style.width = '0'; label.style.display = 'none'; }
    }
</script>
</body>
</html>