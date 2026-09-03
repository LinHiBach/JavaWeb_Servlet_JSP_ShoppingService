<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${requestScope.title != null ? requestScope.title : 'Admin Panel'}</title>
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
            --admin-dark-bg: #0f172a;
            --admin-dark-card: #1e293b;
            --admin-primary: #3b82f6;
            --admin-primary-hover: #2563eb;
            --admin-text-light: #f8fafc;
            --admin-text-muted: #94a3b8;
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: #f8fafc;
            margin: 0;
            padding: 0;
            color: #1e293b;
            min-height: 100vh;
        }

        /* TOPBAR NAVBAR */
        .top-navbar-admin {
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            height: 68px;
            padding: 0 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 18px rgba(15, 23, 42, 0.03);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .top-navbar-admin .brand-title {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .top-navbar-admin .brand-title i {
            color: #3b82f6;
        }

        .btn-profile-topbar {
            background: #eff6ff;
            color: #2563eb;
            font-weight: 700;
            font-size: 13.5px;
            padding: 7px 16px;
            border-radius: 10px;
            border: 1px solid #bfdbfe;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition-smooth);
        }
        .btn-profile-topbar:hover {
            background: #2563eb;
            color: #ffffff;
            border-color: #2563eb;
            transform: translateY(-1px);
        }

        .btn-logout-admin {
            background: #fee2e2;
            color: #dc2626;
            font-weight: 700;
            font-size: 13.5px;
            padding: 7px 16px;
            border-radius: 10px;
            border: 1px solid #fecaca;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition-smooth);
        }
        .btn-logout-admin:hover {
            background: #dc2626;
            color: #ffffff;
            border-color: #dc2626;
            transform: translateY(-1px);
        }

        /* WRAPPER & SIDEBAR */
        .admin-wrapper {
            display: flex;
            min-height: calc(100vh - 68px);
        }

        .admin-sidebar {
            width: 270px;
            background-color: var(--admin-dark-bg);
            color: #ffffff;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.05);
        }

        .sidebar-user-section {
            text-align: center;
            padding: 28px 20px 24px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .sidebar-user-section img {
            width: 88px;
            height: 88px;
            border-radius: 50%;
            border: 3px solid #3b82f6;
            object-fit: cover;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            margin-bottom: 12px;
            transition: var(--transition-smooth);
        }
        .sidebar-user-section:hover img {
            transform: scale(1.05);
        }
        .sidebar-user-section h6 {
            color: #ffffff;
            font-weight: 700;
            font-size: 16px;
            margin-bottom: 4px;
        }
        .sidebar-user-section .role-badge-tag {
            font-size: 12.5px;
            color: #93c5fd;
            font-weight: 600;
            background: rgba(59, 130, 246, 0.15);
            display: inline-block;
            padding: 4px 14px;
            border-radius: 20px;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .sidebar-nav-menu {
            list-style: none;
            padding: 16px 12px;
            margin: 0;
        }
        .sidebar-nav-menu li a {
            display: flex;
            align-items: center;
            padding: 12px 18px;
            color: var(--admin-text-muted);
            text-decoration: none;
            font-size: 14.5px;
            font-weight: 600;
            border-radius: 12px;
            margin-bottom: 4px;
            transition: var(--transition-smooth);
        }
        .sidebar-nav-menu li a:hover, .sidebar-nav-menu li a.active {
            background-color: rgba(59, 130, 246, 0.15);
            color: #ffffff;
        }
        .sidebar-nav-menu li a.active {
            background-color: var(--admin-primary);
            color: #ffffff;
            box-shadow: 0 4px 14px rgba(59, 130, 246, 0.4);
        }
        .sidebar-nav-menu li a i {
            font-size: 18px;
            margin-right: 12px;
        }

        /* MAIN CONTENT */
        .admin-main-content {
            flex-grow: 1;
            padding: 35px 40px;
            background-color: #ffffff;
        }
    </style>
    <c:out value="${requestScope.head}" escapeXml="false"/>
</head>
<body>

    <!-- TOP NAVBAR -->
    <div class="top-navbar-admin">
        <div class="brand-title">
            <i class="bi bi-grid-1x2-fill"></i> Admin Panel
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="text-secondary small">Xin chào, <strong class="text-dark">${sessionScope.account != null ? sessionScope.account.fullname : 'Quản trị viên'}</strong></span>
            <a href="${pageContext.request.contextPath}/profile" class="btn-profile-topbar">
                <i class="bi bi-person-circle"></i> Trang cá nhân
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout-admin">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </div>
    </div>

    <div class="admin-wrapper">
        <!-- SIDEBAR -->
        <div class="admin-sidebar">
            <div class="sidebar-user-section">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.avatar}">
                        <c:choose>
                            <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                <img src="${sessionScope.account.avatar}" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${sessionScope.account.avatar}" var="avtUrl"/>
                                <img src="${avtUrl}" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=3b82f6&color=ffffff&bold=true" alt="Avatar">
                    </c:otherwise>
                </c:choose>
                <h6>${sessionScope.account.fullname}</h6>
                <span class="role-badge-tag"><i class="bi bi-shield-check me-1"></i>Administrator</span>
            </div>

            <ul class="sidebar-nav-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/admin/home">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/category/list">
                        <i class="bi bi-folder2-open"></i> Quản lý Danh mục
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/profile">
                        <i class="bi bi-person-badge-fill"></i> Hồ sơ cá nhân (Profile)
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-globe"></i> Xem trang chính
                    </a>
                </li>
            </ul>
        </div>

        <!-- MAIN CONTENT (SITEMESH INJECTED) -->
        <div class="admin-main-content">
            <c:out value="${requestScope.body}" escapeXml="false"/>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
