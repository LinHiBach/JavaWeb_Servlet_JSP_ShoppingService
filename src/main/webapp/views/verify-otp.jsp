<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP — Shopping Store</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #4f46e5 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            position: relative;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }
        /* Background Blobs */
        body::before {
            content: '';
            position: fixed;
            width: 400px; height: 400px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(124,58,237,0.3), transparent 70%);
            top: -100px; right: -100px;
            animation: float 8s ease-in-out infinite;
        }
        body::after {
            content: '';
            position: fixed;
            width: 300px; height: 300px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(37,99,235,0.25), transparent 70%);
            bottom: -80px; left: -60px;
            animation: float 8s ease-in-out infinite 4s;
        }
        @keyframes float { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-20px)} }

        .otp-card {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.35);
            max-width: 460px;
            width: 100%;
            padding: 48px 40px;
            position: relative;
            z-index: 10;
            animation: slideUp 0.5s cubic-bezier(0.34,1.2,0.64,1);
        }
        @keyframes slideUp { from{opacity:0;transform:translateY(28px)} to{opacity:1;transform:translateY(0)} }

        .otp-icon-wrapper {
            width: 80px; height: 80px;
            background: linear-gradient(135deg, #ede9fe, #ddd6fe);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
            font-size: 36px;
            animation: pulse-icon 2s ease-in-out infinite;
        }
        @keyframes pulse-icon {
            0%,100%{box-shadow:0 0 0 0 rgba(124,58,237,0.15)}
            50%{box-shadow:0 0 0 14px rgba(124,58,237,0)}
        }

        .otp-title {
            font-size: 24px; font-weight: 900; color: #0f172a;
            text-align: center; margin-bottom: 8px;
        }
        .otp-subtitle {
            font-size: 14px; color: #64748b;
            text-align: center; margin-bottom: 32px;
            line-height: 1.65;
        }
        .otp-subtitle strong { color: #2563eb; }

        /* Alert */
        .auth-alert {
            display: flex; align-items: center; gap: 10px;
            padding: 11px 14px; border-radius: 10px;
            font-size: 13.5px; font-weight: 600; margin-bottom: 24px;
        }
        .auth-alert-danger { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .auth-alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }

        /* OTP 6 digit boxes */
        .otp-input-row {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 28px;
        }
        .otp-digit {
            width: 54px; height: 62px;
            border: 2px solid #e2e8f0;
            border-radius: 14px;
            font-size: 26px; font-weight: 900;
            text-align: center;
            color: #0f172a;
            background: #f8fafc;
            outline: none;
            transition: all 0.2s;
            caret-color: #7c3aed;
            font-family: inherit;
        }
        .otp-digit:focus {
            border-color: #7c3aed;
            background: #faf5ff;
            box-shadow: 0 0 0 4px rgba(124,58,237,0.12);
            transform: scale(1.06);
        }
        .otp-digit.filled {
            border-color: #7c3aed;
            color: #7c3aed;
            background: #faf5ff;
        }

        /* Hidden real input */
        #otpHidden { display: none; }

        .btn-otp-submit {
            width: 100%; padding: 14px;
            border: none; border-radius: 12px;
            font-size: 15.5px; font-weight: 800;
            background: linear-gradient(135deg, #7c3aed 0%, #2563eb 100%);
            color: #fff; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            box-shadow: 0 6px 20px rgba(124,58,237,0.35);
            transition: all 0.25s; margin-bottom: 20px;
            font-family: inherit;
        }
        .btn-otp-submit:hover { transform: translateY(-2px); box-shadow: 0 12px 30px rgba(124,58,237,0.45); }
        .btn-otp-submit:disabled { opacity: 0.55; cursor: not-allowed; transform: none; }

        .auth-link-row { text-align: center; font-size: 13.5px; color: #64748b; }
        .auth-link-row a { color: #7c3aed; font-weight: 800; text-decoration: none; }
        .auth-link-row a:hover { text-decoration: underline; }

        .resend-timer { text-align: center; font-size: 13px; color: #94a3b8; margin-top: 12px; }
    </style>
</head>
<body>
    <div class="otp-card">
        <!-- Icon -->
        <div class="otp-icon-wrapper">📧</div>

        <h1 class="otp-title">Xác Thực Email OTP</h1>
        <p class="otp-subtitle">
            Mã OTP gồm <strong>6 chữ số</strong> đã được gửi đến email của bạn.<br>
            Vui lòng kiểm tra hộp thư và nhập mã xác thực bên dưới.
        </p>

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

        <!-- OTP Form -->
        <form action="${pageContext.request.contextPath}/verify-otp" method="post" id="otpForm" novalidate>
            <!-- Hidden input that carries the final 6-digit OTP -->
            <input type="hidden" name="otp" id="otpHidden">

            <!-- 6 Digit Input Boxes -->
            <div class="otp-input-row">
                <input type="text" class="otp-digit" id="d0" maxlength="1" inputmode="numeric" autocomplete="off">
                <input type="text" class="otp-digit" id="d1" maxlength="1" inputmode="numeric" autocomplete="off">
                <input type="text" class="otp-digit" id="d2" maxlength="1" inputmode="numeric" autocomplete="off">
                <input type="text" class="otp-digit" id="d3" maxlength="1" inputmode="numeric" autocomplete="off">
                <input type="text" class="otp-digit" id="d4" maxlength="1" inputmode="numeric" autocomplete="off">
                <input type="text" class="otp-digit" id="d5" maxlength="1" inputmode="numeric" autocomplete="off">
            </div>

            <button type="submit" class="btn-otp-submit" id="submitBtn" disabled>
                <i class="bi bi-shield-check-fill"></i> Xác nhận mã OTP
            </button>

            <p class="auth-link-row">
                <a href="${pageContext.request.contextPath}/register">
                    <i class="bi bi-arrow-left"></i> Quay lại đăng ký
                </a>
            </p>

            <p class="resend-timer" id="resendInfo">
                Không nhận được mã? Kiểm tra mục Spam hoặc <a href="${pageContext.request.contextPath}/register" style="color:#7c3aed;font-weight:700;">Đăng ký lại</a>
            </p>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const digits = document.querySelectorAll('.otp-digit');
        const hiddenInput = document.getElementById('otpHidden');
        const submitBtn = document.getElementById('submitBtn');

        function updateHiddenAndValidate() {
            const val = Array.from(digits).map(d => d.value).join('');
            hiddenInput.value = val;
            // Enable submit only when all 6 digits filled with numbers
            submitBtn.disabled = !/^[0-9]{6}$/.test(val);
        }

        digits.forEach((input, index) => {
            input.addEventListener('input', (e) => {
                const val = e.target.value.replace(/[^0-9]/g, '');
                input.value = val.charAt(0);
                input.classList.toggle('filled', !!input.value);

                if (input.value && index < digits.length - 1) {
                    digits[index + 1].focus();
                }
                updateHiddenAndValidate();
            });

            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && !input.value && index > 0) {
                    digits[index - 1].focus();
                    digits[index - 1].value = '';
                    digits[index - 1].classList.remove('filled');
                    updateHiddenAndValidate();
                }
                // Allow paste
                if (e.key === 'ArrowLeft' && index > 0) digits[index - 1].focus();
                if (e.key === 'ArrowRight' && index < digits.length - 1) digits[index + 1].focus();
            });

            // Handle paste on any box
            input.addEventListener('paste', (e) => {
                e.preventDefault();
                const pasted = (e.clipboardData || window.clipboardData).getData('text').replace(/[^0-9]/g,'');
                pasted.split('').slice(0, 6).forEach((char, i) => {
                    if (digits[i]) {
                        digits[i].value = char;
                        digits[i].classList.add('filled');
                    }
                });
                updateHiddenAndValidate();
                if (pasted.length >= 6) submitBtn.focus();
            });
        });

        // Focus first box on load
        digits[0].focus();

        // Form submit — validate before sending
        document.getElementById('otpForm').addEventListener('submit', (e) => {
            const val = hiddenInput.value;
            if (!/^[0-9]{6}$/.test(val)) {
                e.preventDefault();
                digits.forEach(d => { d.style.borderColor = '#ef4444'; d.style.background = '#fef2f2'; });
            }
        });
    </script>
</body>
</html>
