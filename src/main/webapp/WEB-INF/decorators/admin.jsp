<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Admin Panel</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <sitemesh:write property="head"/>

    <style>
        /* ============================================
           DESIGN SYSTEM — CSS TOKENS (Admin Dark)
        ============================================ */
        :root {
            --color-primary: #2563eb;
            --color-primary-dark: #1d4ed8;
            --color-primary-light: #eff6ff;
            --color-primary-glow: rgba(37,99,235,0.22);
            --color-accent: #7c3aed;
            --color-success: #10b981;
            --color-warning: #f59e0b;
            --color-danger: #ef4444;
            --color-surface: #ffffff;
            --color-bg: #f1f5f9;
            --color-border: #e2e8f0;
            --color-text: #0f172a;
            --color-muted: #64748b;
            --shadow-card: 0 4px 20px rgba(15,23,42,0.07);
            --shadow-hover: 0 12px 32px rgba(37,99,235,0.16);
            --shadow-elevated: 0 24px 56px rgba(15,23,42,0.14);
            --radius-xs: 6px;
            --radius-sm: 10px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --radius-full: 9999px;
            --ease-smooth: cubic-bezier(0.4,0,0.2,1);
            --ease-bounce: cubic-bezier(0.34,1.56,0.64,1);
            --dur-fast: 0.15s;
            --dur-normal: 0.28s;
            --dur-slow: 0.45s;

            /* Sidebar specific */
            --sidebar-width: 272px;
            --sidebar-collapsed-width: 72px;
            --sidebar-bg: #0f172a;
            --sidebar-hover: rgba(255,255,255,0.07);
            --sidebar-active-bg: var(--color-primary);
            --sidebar-text: #94a3b8;
            --sidebar-text-active: #ffffff;
            --topbar-height: 64px;
        }

        *, *::before, *::after { box-sizing: border-box; }
        html { scroll-behavior: smooth; }

        body {
            font-family: 'Plus Jakarta Sans', 'Inter', -apple-system, sans-serif;
            background-color: var(--color-bg);
            color: var(--color-text);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        /* ============================================
           LAYOUT STRUCTURE
        ============================================ */
        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        /* ============================================
           SIDEBAR
        ============================================ */
        .admin-sidebar {
            width: var(--sidebar-width);
            min-height: 100vh;
            background: var(--sidebar-bg);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 200;
            transition: width var(--dur-normal) var(--ease-smooth);
            overflow: hidden;
        }
        .admin-sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }

        /* Sidebar Header */
        .sidebar-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 20px 18px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            height: var(--topbar-height);
            flex-shrink: 0;
        }
        .sidebar-brand-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-accent) 100%);
            border-radius: var(--radius-xs);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .sidebar-brand-icon i { color: #fff; font-size: 18px; }
        .sidebar-brand-text {
            font-size: 16px;
            font-weight: 900;
            color: #ffffff;
            white-space: nowrap;
            opacity: 1;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .admin-sidebar.collapsed .sidebar-brand-text { opacity: 0; width: 0; overflow: hidden; }

        /* Sidebar User */
        .sidebar-user {
            padding: 20px 16px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            display: flex;
            align-items: center;
            gap: 12px;
            flex-shrink: 0;
        }
        .sidebar-user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(37,99,235,0.6);
            flex-shrink: 0;
        }
        .sidebar-user-info {
            overflow: hidden;
            opacity: 1;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .admin-sidebar.collapsed .sidebar-user-info { opacity: 0; width: 0; }
        .sidebar-user-name {
            font-size: 14px;
            font-weight: 700;
            color: #ffffff;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .sidebar-user-role {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 11.5px;
            font-weight: 700;
            color: #60a5fa;
            margin-top: 2px;
        }

        /* Sidebar Nav */
        .sidebar-nav {
            flex: 1;
            padding: 16px 10px;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .sidebar-nav::-webkit-scrollbar { width: 4px; }
        .sidebar-nav::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 4px; }

        .nav-section-label {
            font-size: 10.5px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: rgba(255,255,255,0.25);
            padding: 16px 10px 8px;
            white-space: nowrap;
            opacity: 1;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .admin-sidebar.collapsed .nav-section-label { opacity: 0; }

        .sidebar-nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 12px;
            border-radius: var(--radius-sm);
            color: var(--sidebar-text);
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all var(--dur-normal) var(--ease-smooth);
            margin-bottom: 2px;
            white-space: nowrap;
            position: relative;
        }
        .sidebar-nav-item:hover {
            background: var(--sidebar-hover);
            color: #e2e8f0;
        }
        .sidebar-nav-item.active {
            background: var(--color-primary);
            color: #ffffff;
            box-shadow: 0 4px 14px rgba(37,99,235,0.45);
        }
        .sidebar-nav-item.active-ghost {
            background: rgba(37,99,235,0.15);
            color: #93c5fd;
        }
        .sidebar-nav-item i {
            font-size: 18px;
            width: 22px;
            text-align: center;
            flex-shrink: 0;
        }
        .nav-item-text {
            opacity: 1;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .admin-sidebar.collapsed .nav-item-text { opacity: 0; width: 0; overflow: hidden; }

        /* Tooltip for collapsed mode */
        .sidebar-nav-item::after {
            content: attr(data-tooltip);
            position: absolute;
            left: calc(var(--sidebar-collapsed-width) + 8px);
            top: 50%;
            transform: translateY(-50%);
            background: #1e293b;
            color: #e2e8f0;
            font-size: 13px;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: var(--radius-xs);
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            box-shadow: var(--shadow-elevated);
            z-index: 300;
        }
        .admin-sidebar.collapsed .sidebar-nav-item:hover::after {
            opacity: 1;
            visibility: visible;
        }

        /* Sidebar Toggle Button */
        .sidebar-toggle-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin: 12px 10px 20px;
            padding: 10px 12px;
            border-radius: var(--radius-sm);
            border: 1px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.04);
            color: rgba(255,255,255,0.5);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--dur-normal) var(--ease-smooth);
            white-space: nowrap;
            width: calc(100% - 20px);
        }
        .sidebar-toggle-btn:hover {
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.8);
        }
        .sidebar-toggle-btn i { font-size: 16px; flex-shrink: 0; }
        .sidebar-toggle-text {
            opacity: 1;
            transition: opacity var(--dur-fast) var(--ease-smooth);
        }
        .admin-sidebar.collapsed .sidebar-toggle-text { opacity: 0; width: 0; overflow: hidden; }

        /* ============================================
           TOPBAR
        ============================================ */
        .admin-topbar {
            position: fixed;
            top: 0;
            left: var(--sidebar-width);
            right: 0;
            height: var(--topbar-height);
            background: var(--color-surface);
            border-bottom: 1px solid var(--color-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 28px;
            z-index: 100;
            box-shadow: var(--shadow-card);
            transition: left var(--dur-normal) var(--ease-smooth);
        }
        .admin-topbar.sidebar-collapsed { left: var(--sidebar-collapsed-width); }

        .topbar-left {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .topbar-page-title {
            font-size: 17px;
            font-weight: 800;
            color: var(--color-text);
            margin: 0;
            line-height: 1.2;
        }
        .topbar-breadcrumb {
            display: flex;
            align-items: center;
            gap: 6px;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .topbar-breadcrumb li {
            font-size: 12.5px;
            color: var(--color-muted);
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .topbar-breadcrumb li a {
            color: var(--color-primary);
            text-decoration: none;
            font-weight: 600;
        }
        .topbar-breadcrumb li a:hover { text-decoration: underline; }
        .topbar-breadcrumb li::before { content: '/'; color: #cbd5e1; }
        .topbar-breadcrumb li:first-child::before { display: none; }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .topbar-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 8px 16px;
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-weight: 700;
            text-decoration: none;
            transition: all var(--dur-normal) var(--ease-smooth);
            border: 1.5px solid transparent;
        }
        .topbar-btn-profile {
            background: var(--color-primary-light);
            color: var(--color-primary);
            border-color: #bfdbfe;
        }
        .topbar-btn-profile:hover {
            background: var(--color-primary);
            color: #fff;
            border-color: var(--color-primary);
            transform: translateY(-1px);
        }
        .topbar-btn-logout {
            background: #fef2f2;
            color: var(--color-danger);
            border-color: #fecaca;
        }
        .topbar-btn-logout:hover {
            background: var(--color-danger);
            color: #fff;
            border-color: var(--color-danger);
            transform: translateY(-1px);
        }

        /* Notification Bell */
        .topbar-bell-btn {
            width: 38px;
            height: 38px;
            border-radius: var(--radius-sm);
            border: 1.5px solid var(--color-border);
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: var(--color-muted);
            font-size: 18px;
            transition: all var(--dur-normal) var(--ease-smooth);
            position: relative;
        }
        .topbar-bell-btn:hover {
            background: var(--color-primary-light);
            color: var(--color-primary);
            border-color: #bfdbfe;
        }
        .bell-badge {
            position: absolute;
            top: 6px;
            right: 7px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--color-danger);
            border: 2px solid var(--color-surface);
        }

        /* ============================================
           MAIN CONTENT AREA
        ============================================ */
        .admin-content-wrapper {
            margin-left: var(--sidebar-width);
            margin-top: var(--topbar-height);
            padding: 32px 36px;
            min-height: calc(100vh - var(--topbar-height));
            transition: margin-left var(--dur-normal) var(--ease-smooth);
            background: var(--color-bg);
        }
        .admin-content-wrapper.sidebar-collapsed {
            margin-left: var(--sidebar-collapsed-width);
        }

        /* ============================================
           RESPONSIVE MOBILE
        ============================================ */
        @media (max-width: 900px) {
            .admin-sidebar {
                transform: translateX(-100%);
                width: var(--sidebar-width) !important;
            }
            .admin-sidebar.mobile-open { transform: translateX(0); }
            .admin-topbar { left: 0 !important; }
            .admin-content-wrapper { margin-left: 0 !important; }
            .sidebar-mobile-overlay {
                display: block !important;
            }
        }
        .sidebar-mobile-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 199;
            backdrop-filter: blur(2px);
        }
    </style>
    <c:out value="${requestScope.head}" escapeXml="false"/>
</head>
<body>
    <!-- Mobile Overlay -->
    <div class="sidebar-mobile-overlay" id="sidebarOverlay" onclick="closeMobileSidebar()"></div>

    <!-- ============ SIDEBAR ============ -->
    <aside class="admin-sidebar" id="adminSidebar">

        <!-- Sidebar Header -->
        <div class="sidebar-header">
            <div class="sidebar-brand-icon">
                <i class="bi bi-grid-1x2-fill"></i>
            </div>
            <span class="sidebar-brand-text">Admin Panel</span>
        </div>

        <!-- User Info -->
        <div class="sidebar-user">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <c:choose>
                        <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                            <img src="${sessionScope.account.avatar}" class="sidebar-user-avatar" alt="Avatar">
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${sessionScope.account.avatar}" var="avtUrl"/>
                            <img src="${avtUrl}" class="sidebar-user-avatar" alt="Avatar">
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=2563eb&color=ffffff&bold=true" class="sidebar-user-avatar" alt="Avatar">
                </c:otherwise>
            </c:choose>
            <div class="sidebar-user-info">
                <div class="sidebar-user-name">${sessionScope.account.fullname}</div>
                <div class="sidebar-user-role">
                    <i class="bi bi-shield-check-fill"></i> Administrator
                </div>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="sidebar-nav">
            <div class="nav-section-label">Quản lý chính</div>

            <a href="${pageContext.request.contextPath}/admin/home"
               class="sidebar-nav-item" id="nav-dashboard" data-tooltip="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="nav-item-text">Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/category/list"
               class="sidebar-nav-item" id="nav-category" data-tooltip="Danh mục">
                <i class="bi bi-folder2-open"></i>
                <span class="nav-item-text">Quản lý Danh mục</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/product/list"
               class="sidebar-nav-item" id="nav-product" data-tooltip="Sản phẩm">
                <i class="bi bi-box-seam"></i>
                <span class="nav-item-text">Quản lý Sản phẩm</span>
            </a>

            <div class="nav-section-label">Tài khoản</div>

            <a href="${pageContext.request.contextPath}/profile"
               class="sidebar-nav-item" id="nav-profile" data-tooltip="Hồ sơ">
                <i class="bi bi-person-badge-fill"></i>
                <span class="nav-item-text">Hồ sơ cá nhân</span>
            </a>

            <div class="nav-section-label">Xem trang</div>

            <a href="${pageContext.request.contextPath}/home"
               class="sidebar-nav-item" data-tooltip="Trang chủ">
                <i class="bi bi-globe"></i>
                <span class="nav-item-text">Xem trang chính</span>
            </a>

            <a href="${pageContext.request.contextPath}/logout"
               class="sidebar-nav-item" data-tooltip="Đăng xuất"
               style="color: #f87171; margin-top: 4px;">
                <i class="bi bi-box-arrow-right"></i>
                <span class="nav-item-text">Đăng xuất</span>
            </a>
        </nav>

        <!-- Collapse Button -->
        <button class="sidebar-toggle-btn" id="sidebarToggleBtn" onclick="toggleSidebar()" title="Thu gọn / Mở rộng">
            <i class="bi bi-layout-sidebar-reverse" id="sidebarToggleIcon"></i>
            <span class="sidebar-toggle-text">Thu gọn sidebar</span>
        </button>
    </aside>

    <!-- ============ TOPBAR ============ -->
    <div class="admin-topbar" id="adminTopbar">
        <div class="topbar-left">
            <h1 class="topbar-page-title" id="topbarPageTitle">Dashboard</h1>
            <ul class="topbar-breadcrumb" id="topbarBreadcrumb">
                <li><a href="${pageContext.request.contextPath}/admin/home"><i class="bi bi-speedometer2"></i> Admin</a></li>
                <li id="breadcrumbCurrent">Dashboard</li>
            </ul>
        </div>

        <div class="topbar-right">
            <!-- Mobile sidebar toggle -->
            <button class="topbar-bell-btn d-block d-lg-none" onclick="openMobileSidebar()">
                <i class="bi bi-list"></i>
            </button>

            <button class="topbar-bell-btn" title="Thông báo">
                <i class="bi bi-bell-fill"></i>
                <div class="bell-badge"></div>
            </button>

            <a href="${pageContext.request.contextPath}/profile" class="topbar-btn topbar-btn-profile">
                <i class="bi bi-person-circle"></i>
                <span class="d-none d-sm-inline">Trang cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="topbar-btn topbar-btn-logout">
                <i class="bi bi-box-arrow-right"></i>
                <span class="d-none d-sm-inline">Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- ============ MAIN CONTENT (SITEMESH 3) ============ -->
    <div class="admin-content-wrapper" id="adminContent">
        <sitemesh:write property="body"/>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // ---- Sidebar Collapse State ----
        const SIDEBAR_COLLAPSED_KEY = 'adminSidebarCollapsed';
        let isCollapsed = localStorage.getItem(SIDEBAR_COLLAPSED_KEY) === 'true';

        function applySidebarState() {
            const sidebar = document.getElementById('adminSidebar');
            const topbar = document.getElementById('adminTopbar');
            const content = document.getElementById('adminContent');
            const toggleIcon = document.getElementById('sidebarToggleIcon');

            if (isCollapsed) {
                sidebar.classList.add('collapsed');
                topbar.classList.add('sidebar-collapsed');
                content.classList.add('sidebar-collapsed');
                toggleIcon.className = 'bi bi-layout-sidebar';
            } else {
                sidebar.classList.remove('collapsed');
                topbar.classList.remove('sidebar-collapsed');
                content.classList.remove('sidebar-collapsed');
                toggleIcon.className = 'bi bi-layout-sidebar-reverse';
            }
        }

        function toggleSidebar() {
            isCollapsed = !isCollapsed;
            localStorage.setItem(SIDEBAR_COLLAPSED_KEY, isCollapsed);
            applySidebarState();
        }

        // Mobile sidebar
        function openMobileSidebar() {
            document.getElementById('adminSidebar').classList.add('mobile-open');
            document.getElementById('sidebarOverlay').style.display = 'block';
        }
        function closeMobileSidebar() {
            document.getElementById('adminSidebar').classList.remove('mobile-open');
            document.getElementById('sidebarOverlay').style.display = 'none';
        }

        // ---- Auto Active Nav Link based on URL ----
        function setActiveNav() {
            const path = window.location.pathname;
            const navMap = {
                'nav-dashboard': ['/admin/home'],
                'nav-category': ['/admin/category'],
                'nav-product': ['/admin/product'],
                'nav-profile': ['/profile']
            };
            const breadcrumbMap = {
                'nav-dashboard': ['Dashboard', 'Dashboard'],
                'nav-category': ['Quản lý Danh mục', 'Danh mục'],
                'nav-product': ['Quản lý Sản phẩm', 'Sản phẩm'],
                'nav-profile': ['Hồ sơ cá nhân', 'Hồ sơ']
            };

            for (const [id, patterns] of Object.entries(navMap)) {
                const el = document.getElementById(id);
                if (!el) continue;
                const matched = patterns.some(p => path.includes(p));
                if (matched) {
                    el.classList.add('active');
                    // Update topbar
                    const [title, crumb] = breadcrumbMap[id];
                    const titleEl = document.getElementById('topbarPageTitle');
                    const crumbEl = document.getElementById('breadcrumbCurrent');
                    if (titleEl) titleEl.textContent = title;
                    if (crumbEl) crumbEl.textContent = crumb;
                } else {
                    el.classList.remove('active');
                }
            }
        }

        // Init on page load
        document.addEventListener('DOMContentLoaded', () => {
            applySidebarState();
            setActiveNav();
        });
    </script>
</body>
</html>
