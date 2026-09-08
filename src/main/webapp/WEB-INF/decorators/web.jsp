<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Shopping Store</title>
    <!-- Google Fonts: Inter + Plus Jakarta Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- SiteMesh 3 Head Injection -->
    <sitemesh:write property="head"/>

    <style>
        /* ============================================
           NHÓM 1: DESIGN SYSTEM — CSS CUSTOM PROPERTIES
        ============================================ */
        :root {
            /* Brand Colors */
            --color-primary: #2563eb;
            --color-primary-dark: #1d4ed8;
            --color-primary-light: #eff6ff;
            --color-primary-glow: rgba(37, 99, 235, 0.22);
            --color-accent: #7c3aed;

            /* Semantic */
            --color-success: #10b981;
            --color-warning: #f59e0b;
            --color-danger: #ef4444;
            --color-info: #0ea5e9;

            /* Neutral Scale */
            --color-bg: #f1f5f9;
            --color-surface: #ffffff;
            --color-border: #e2e8f0;
            --color-border-light: #f1f5f9;
            --color-text: #0f172a;
            --color-text-secondary: #334155;
            --color-muted: #64748b;

            /* Shadows */
            --shadow-xs: 0 1px 3px rgba(15,23,42,0.06);
            --shadow-sm: 0 4px 16px rgba(15,23,42,0.06);
            --shadow-card: 0 8px 28px rgba(15,23,42,0.08);
            --shadow-hover: 0 16px 40px rgba(37,99,235,0.16);
            --shadow-elevated: 0 24px 56px rgba(15,23,42,0.14);

            /* Border Radius */
            --radius-xs: 6px;
            --radius-sm: 10px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --radius-xl: 28px;
            --radius-full: 9999px;

            /* Animation */
            --ease-smooth: cubic-bezier(0.4, 0, 0.2, 1);
            --ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
            --dur-fast: 0.15s;
            --dur-normal: 0.28s;
            --dur-slow: 0.45s;
        }

        /* ============================================
           BASE RESET & TYPOGRAPHY
        ============================================ */
        *, *::before, *::after { box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Plus Jakarta Sans', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: var(--color-bg);
            color: var(--color-text);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        /* ============================================
           NAVBAR — GLASSMORPHIC STICKY
        ============================================ */
        .glass-navbar {
            background: rgba(255,255,255,0.88);
            backdrop-filter: blur(18px) saturate(180%);
            -webkit-backdrop-filter: blur(18px) saturate(180%);
            border-bottom: 1px solid rgba(226,232,240,0.7);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1050;
            transition: box-shadow var(--dur-normal) var(--ease-smooth),
                        background var(--dur-normal) var(--ease-smooth);
        }
        .glass-navbar.scrolled {
            box-shadow: 0 4px 24px rgba(15,23,42,0.08);
            background: rgba(255,255,255,0.96);
        }

        .navbar-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 66px;
            padding: 0 20px;
            max-width: 1280px;
            margin: 0 auto;
            width: 100%;
        }

        /* Brand Logo */
        .brand-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 900;
            font-size: 20px;
            text-decoration: none;
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #7c3aed 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.4px;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .brand-logo:hover { opacity: 0.85; }
        .brand-logo .brand-icon {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 14px var(--color-primary-glow);
            flex-shrink: 0;
            -webkit-text-fill-color: initial;
        }
        .brand-logo .brand-icon i {
            color: #ffffff;
            font-size: 18px;
        }

        /* Nav Links */
        .nav-links {
            display: flex;
            align-items: center;
            gap: 4px;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: var(--radius-sm);
            color: var(--color-muted);
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all var(--dur-normal) var(--ease-smooth);
            white-space: nowrap;
        }
        .nav-pill:hover, .nav-pill.active {
            background: var(--color-primary-light);
            color: var(--color-primary);
        }
        .nav-pill i { font-size: 16px; }

        /* Navbar Actions (right side) */
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-nav-login {
            padding: 8px 18px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            border: 1.5px solid var(--color-primary);
            color: var(--color-primary);
            transition: all var(--dur-normal) var(--ease-smooth);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-nav-login:hover {
            background: var(--color-primary);
            color: #fff;
            transform: translateY(-1px);
        }

        .btn-nav-register {
            padding: 8px 18px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-accent) 100%);
            color: #ffffff;
            border: none;
            box-shadow: 0 4px 14px var(--color-primary-glow);
            transition: all var(--dur-normal) var(--ease-smooth);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-nav-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px var(--color-primary-glow);
            color: #fff;
        }

        /* User Avatar Dropdown */
        .user-dropdown-wrapper {
            position: relative;
        }
        .user-avatar-trigger {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px 6px 6px;
            border-radius: var(--radius-full);
            cursor: pointer;
            transition: background var(--dur-normal) var(--ease-smooth);
            border: none;
            background: transparent;
            text-decoration: none;
        }
        .user-avatar-trigger:hover { background: var(--color-primary-light); }

        .user-avatar-img {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--color-primary);
            box-shadow: 0 2px 10px var(--color-primary-glow);
        }
        .user-name-label {
            font-size: 13.5px;
            font-weight: 700;
            color: var(--color-text);
            max-width: 110px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .user-dropdown-arrow {
            font-size: 12px;
            color: var(--color-muted);
            transition: transform var(--dur-normal) var(--ease-smooth);
        }
        .user-dropdown-wrapper.open .user-dropdown-arrow { transform: rotate(180deg); }

        .user-dropdown-menu {
            position: absolute;
            right: 0;
            top: calc(100% + 8px);
            background: var(--color-surface);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-elevated);
            min-width: 220px;
            padding: 8px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-8px) scale(0.97);
            transition: all var(--dur-normal) var(--ease-smooth);
            z-index: 200;
        }
        .user-dropdown-wrapper.open .user-dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0) scale(1);
        }
        .dropdown-item-custom {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: var(--radius-xs);
            color: var(--color-text-secondary);
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all var(--dur-fast) var(--ease-smooth);
        }
        .dropdown-item-custom:hover { background: var(--color-primary-light); color: var(--color-primary); }
        .dropdown-item-custom.danger:hover { background: #fef2f2; color: var(--color-danger); }
        .dropdown-item-custom i { font-size: 16px; width: 18px; text-align: center; }
        .dropdown-divider-custom {
            height: 1px;
            background: var(--color-border-light);
            margin: 6px 0;
        }

        /* Admin Badge */
        .badge-admin-pill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 13px;
            border-radius: var(--radius-full);
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            font-size: 13px;
            font-weight: 700;
            border: 1px solid #fcd34d;
            text-decoration: none;
            transition: all var(--dur-normal) var(--ease-smooth);
        }
        .badge-admin-pill:hover {
            background: linear-gradient(135deg, #fde68a 0%, #fbbf24 100%);
            transform: translateY(-1px);
            color: #78350f;
        }

        /* Mobile Hamburger */
        .hamburger-btn {
            display: none;
            flex-direction: column;
            justify-content: center;
            gap: 5px;
            width: 40px;
            height: 40px;
            border: none;
            background: transparent;
            cursor: pointer;
            border-radius: var(--radius-xs);
            padding: 6px;
            transition: background var(--dur-fast) var(--ease-smooth);
        }
        .hamburger-btn:hover { background: var(--color-primary-light); }
        .hamburger-btn span {
            display: block;
            height: 2.5px;
            background: var(--color-text);
            border-radius: 2px;
            transition: all var(--dur-normal) var(--ease-smooth);
            width: 100%;
        }
        .hamburger-btn.open span:nth-child(1) { transform: translateY(7.5px) rotate(45deg); }
        .hamburger-btn.open span:nth-child(2) { opacity: 0; transform: scaleX(0); }
        .hamburger-btn.open span:nth-child(3) { transform: translateY(-7.5px) rotate(-45deg); }

        /* Mobile Nav Drawer */
        .mobile-nav-drawer {
            display: none;
            flex-direction: column;
            background: var(--color-surface);
            border-top: 1px solid var(--color-border);
            padding: 12px 16px 20px;
            gap: 4px;
        }
        .mobile-nav-drawer.open { display: flex; }

        /* ============================================
           MAIN CONTENT WRAPPER
        ============================================ */
        .main-wrapper-content { flex-grow: 1; }

        /* ============================================
           FOOTER — 3 COLUMNS PROFESSIONAL
        ============================================ */
        .site-footer {
            background: #0f172a;
            color: #94a3b8;
            padding: 56px 0 0;
            margin-top: auto;
        }
        .footer-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 48px;
            padding-bottom: 48px;
        }

        .footer-brand-col {}
        .footer-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 16px;
        }
        .footer-logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .footer-logo-icon i { color: #fff; font-size: 20px; }
        .footer-logo-text {
            font-size: 18px;
            font-weight: 800;
            color: #ffffff;
        }
        .footer-desc {
            font-size: 14px;
            line-height: 1.75;
            color: #64748b;
            max-width: 300px;
            margin-bottom: 24px;
        }
        .footer-tech-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }
        .tech-badge {
            padding: 4px 12px;
            border-radius: var(--radius-full);
            background: rgba(37,99,235,0.12);
            border: 1px solid rgba(37,99,235,0.25);
            color: #93c5fd;
            font-size: 12px;
            font-weight: 700;
        }

        .footer-nav-col {}
        .footer-nav-title {
            font-size: 13px;
            font-weight: 800;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 20px;
        }
        .footer-nav-list {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .footer-nav-list a {
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: color var(--dur-fast) var(--ease-smooth);
        }
        .footer-nav-list a:hover { color: #93c5fd; }
        .footer-nav-list a i { font-size: 14px; width: 16px; }

        .footer-info-col {}
        .footer-info-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 16px;
        }
        .footer-info-item i {
            color: #2563eb;
            font-size: 16px;
            margin-top: 2px;
            flex-shrink: 0;
        }
        .footer-info-item span {
            font-size: 13.5px;
            color: #64748b;
            line-height: 1.6;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.06);
            padding: 20px 0;
        }
        .footer-bottom-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }
        .footer-copyright {
            font-size: 13px;
            color: #475569;
        }
        .footer-copyright strong { color: #94a3b8; }
        .footer-status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 14px;
            border-radius: var(--radius-full);
            background: rgba(16,185,129,0.1);
            border: 1px solid rgba(16,185,129,0.25);
            color: #34d399;
            font-size: 12px;
            font-weight: 700;
        }
        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: #10b981;
            animation: pulse-dot 2s ease-in-out infinite;
        }
        @keyframes pulse-dot {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(0.8); }
        }

        /* ============================================
           RESPONSIVE
        ============================================ */
        @media (max-width: 768px) {
            .nav-links { display: none; }
            .nav-actions { display: none; }
            .hamburger-btn { display: flex; }

            .footer-grid {
                grid-template-columns: 1fr;
                gap: 32px;
            }
            .footer-bottom-inner { flex-direction: column; text-align: center; }
        }

        @media (min-width: 769px) {
            .mobile-nav-drawer { display: none !important; }
        }
    </style>
    <c:out value="${requestScope.head}" escapeXml="false"/>
</head>
<body>

    <!-- ============ GLASSMORPHIC STICKY NAVBAR ============ -->
    <header class="glass-navbar" id="mainNavbar">
        <div class="navbar-inner">

            <!-- Brand Logo -->
            <a href="${pageContext.request.contextPath}/home" class="brand-logo">
                <div class="brand-icon">
                    <i class="bi bi-bag-heart-fill"></i>
                </div>
                Shopping Store
            </a>

            <!-- Desktop Nav Links (center) -->
            <ul class="nav-links">
                <li>
                    <a href="${pageContext.request.contextPath}/home" class="nav-pill" id="nav-home">
                        <i class="bi bi-house-door-fill"></i> Trang chủ
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/product" class="nav-pill" id="nav-products">
                        <i class="bi bi-grid-fill"></i> Sản phẩm
                    </a>
                </li>
            </ul>

            <!-- Desktop Right Actions -->
            <div class="nav-actions">
                <c:choose>
                    <c:when test="${empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">
                            <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn-nav-register">
                            <i class="bi bi-person-plus-fill"></i> Đăng ký
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- Admin Badge -->
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a href="${pageContext.request.contextPath}/admin/home" class="badge-admin-pill">
                                <i class="bi bi-shield-lock-fill"></i> Admin
                            </a>
                        </c:if>

                        <!-- User Avatar Dropdown -->
                        <div class="user-dropdown-wrapper" id="userDropdown">
                            <button class="user-avatar-trigger" onclick="toggleUserDropdown()" type="button">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account.avatar}">
                                        <c:choose>
                                            <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                                <img src="${sessionScope.account.avatar}" class="user-avatar-img" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <c:url value="/image?fname=${sessionScope.account.avatar}" var="navAvt"/>
                                                <img src="${navAvt}" class="user-avatar-img" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=2563eb&color=ffffff&bold=true" class="user-avatar-img" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                                <span class="user-name-label">${sessionScope.account.fullname}</span>
                                <i class="bi bi-chevron-down user-dropdown-arrow"></i>
                            </button>

                            <!-- Dropdown Menu -->
                            <div class="user-dropdown-menu">
                                <div style="padding: 12px; border-bottom: 1px solid var(--color-border-light); margin-bottom: 6px;">
                                    <p style="font-size:13px; font-weight:800; color:var(--color-text); margin:0 0 2px;">
                                        ${sessionScope.account.fullname}
                                    </p>
                                    <p style="font-size:12px; color:var(--color-muted); margin:0;">
                                        @${sessionScope.account.username}
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item-custom">
                                    <i class="bi bi-person-circle"></i> Hồ sơ cá nhân
                                </a>
                                <a href="${pageContext.request.contextPath}/product" class="dropdown-item-custom">
                                    <i class="bi bi-grid-3x3-gap-fill"></i> Tất cả sản phẩm
                                </a>
                                <c:if test="${sessionScope.account.roleid == 1}">
                                    <div class="dropdown-divider-custom"></div>
                                    <a href="${pageContext.request.contextPath}/admin/home" class="dropdown-item-custom">
                                        <i class="bi bi-shield-lock-fill"></i> Trang quản trị
                                    </a>
                                </c:if>
                                <div class="dropdown-divider-custom"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item-custom danger">
                                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Mobile Hamburger -->
            <button class="hamburger-btn" id="hamburgerBtn" onclick="toggleMobileNav()" aria-label="Menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>

        <!-- Mobile Drawer (appended below navbar-inner) -->
        <div class="mobile-nav-drawer" id="mobileNavDrawer">
            <a href="${pageContext.request.contextPath}/home" class="nav-pill">
                <i class="bi bi-house-door-fill"></i> Trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/product" class="nav-pill">
                <i class="bi bi-grid-fill"></i> Sản phẩm
            </a>
            <c:choose>
                <c:when test="${empty sessionScope.account}">
                    <div style="height:1px; background:var(--color-border); margin:8px 0;"></div>
                    <a href="${pageContext.request.contextPath}/login" class="nav-pill">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="nav-pill" style="color:var(--color-primary); font-weight:700;">
                        <i class="bi bi-person-plus-fill"></i> Đăng ký ngay
                    </a>
                </c:when>
                <c:otherwise>
                    <div style="height:1px; background:var(--color-border); margin:8px 0;"></div>
                    <a href="${pageContext.request.contextPath}/profile" class="nav-pill">
                        <i class="bi bi-person-circle"></i> Hồ sơ: <strong>${sessionScope.account.fullname}</strong>
                    </a>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/home" class="nav-pill" style="color:#92400e;">
                            <i class="bi bi-shield-lock-fill"></i> Trang Admin
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-pill" style="color:var(--color-danger);">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <!-- ============ MAIN CONTENT (SITEMESH 3) ============ -->
    <main class="main-wrapper-content">
        <sitemesh:write property="body"/>
    </main>

    <!-- ============ FOOTER — 3 COLUMNS ============ -->
    <footer class="site-footer">
        <div class="footer-inner">
            <div class="footer-grid">
                <!-- Column 1: Brand -->
                <div class="footer-brand-col">
                    <div class="footer-logo">
                        <div class="footer-logo-icon">
                            <i class="bi bi-bag-heart-fill"></i>
                        </div>
                        <span class="footer-logo-text">Shopping Store</span>
                    </div>
                    <p class="footer-desc">
                        Hệ thống quản lý thương mại điện tử được xây dựng theo kiến trúc Three-Tier chuẩn doanh nghiệp sử dụng Java Servlet, JPA/Hibernate ORM và SiteMesh Decorator 3.
                    </p>
                    <div class="footer-tech-badges">
                        <span class="tech-badge">Java 17</span>
                        <span class="tech-badge">Servlet 6.0</span>
                        <span class="tech-badge">JPA/Hibernate</span>
                        <span class="tech-badge">SiteMesh 3</span>
                        <span class="tech-badge">Bootstrap 5</span>
                    </div>
                </div>

                <!-- Column 2: Quick Links -->
                <div class="footer-nav-col">
                    <p class="footer-nav-title">Điều hướng</p>
                    <ul class="footer-nav-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door"></i> Trang chủ
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/product">
                                <i class="bi bi-grid-3x3-gap"></i> Tất cả sản phẩm
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/profile">
                                <i class="bi bi-person-circle"></i> Hồ sơ cá nhân
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus"></i> Đăng ký tài khoản
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Column 3: System Info -->
                <div class="footer-info-col">
                    <p class="footer-nav-title">Thông tin hệ thống</p>
                    <div class="footer-info-item">
                        <i class="bi bi-cpu-fill"></i>
                        <span>Jakarta Servlet 6.0 / Tomcat 10+</span>
                    </div>
                    <div class="footer-info-item">
                        <i class="bi bi-database-fill"></i>
                        <span>Microsoft SQL Server<br>JPA (Hibernate ORM 6.x)</span>
                    </div>
                    <div class="footer-info-item">
                        <i class="bi bi-layers-fill"></i>
                        <span>Three-Tier Architecture<br>MVC Pattern</span>
                    </div>
                    <div class="footer-info-item">
                        <i class="bi bi-palette-fill"></i>
                        <span>SiteMesh 3 Decorator<br>Bootstrap 5.3 + Jakarta EE</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Bottom Bar -->
        <div class="footer-bottom">
            <div class="footer-bottom-inner">
                <p class="footer-copyright">
                    © 2026 <strong>Shopping Store MVC JPA</strong>. Bài tập thực hành Java Web.
                </p>
                <div class="footer-status-badge">
                    <div class="status-dot"></div>
                    System Online
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // ---- Navbar Scroll Shadow ----
        const navbar = document.getElementById('mainNavbar');
        window.addEventListener('scroll', () => {
            if (window.scrollY > 20) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // ---- User Dropdown ----
        function toggleUserDropdown() {
            const wrapper = document.getElementById('userDropdown');
            if (wrapper) wrapper.classList.toggle('open');
        }
        document.addEventListener('click', (e) => {
            const wrapper = document.getElementById('userDropdown');
            if (wrapper && !wrapper.contains(e.target)) {
                wrapper.classList.remove('open');
            }
        });

        // ---- Mobile Hamburger ----
        function toggleMobileNav() {
            const btn = document.getElementById('hamburgerBtn');
            const drawer = document.getElementById('mobileNavDrawer');
            if (btn && drawer) {
                btn.classList.toggle('open');
                drawer.classList.toggle('open');
            }
        }

        // ---- Auto Active Nav Link ----
        const path = window.location.pathname;
        document.querySelectorAll('.nav-pill[id]').forEach(el => {
            if (el.id === 'nav-home' && (path.includes('/home') || path.endsWith('/'))) {
                el.classList.add('active');
            } else if (el.id === 'nav-products' && path.includes('/product')) {
                el.classList.add('active');
            }
        });
    </script>
</body>
</html>
