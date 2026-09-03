<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${requestScope.title != null ? requestScope.title : 'Shopping Store'}</title>
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
            --app-primary: #2563eb;
            --app-primary-hover: #1d4ed8;
            --app-bg: #f8fafc;
            --app-text: #0f172a;
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: var(--app-bg);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--app-text);
        }

        /* GLASSMORPHIC NAVBAR */
        .glass-navbar {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
            padding: 14px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.03);
        }

        .brand-gradient {
            font-weight: 800;
            font-size: 22px;
            text-decoration: none;
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .brand-gradient i {
            -webkit-text-fill-color: initial;
            color: #2563eb;
        }

        .nav-pill-item {
            color: #475569;
            font-weight: 600;
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 10px;
            text-decoration: none;
            transition: var(--transition-smooth);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .nav-pill-item:hover, .nav-pill-item.active {
            background: #eff6ff;
            color: var(--app-primary);
        }

        .user-avatar-pill {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--app-primary);
            box-shadow: 0 2px 8px rgba(37, 99, 235, 0.2);
        }

        .btn-action-admin {
            background: #fef3c7;
            color: #b45309;
            font-weight: 700;
            font-size: 13.5px;
            padding: 7px 16px;
            border-radius: 10px;
            text-decoration: none;
            border: 1px solid #fde68a;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition-smooth);
        }
        .btn-action-admin:hover {
            background: #fde68a;
            color: #92400e;
            transform: translateY(-1px);
        }

        .btn-action-logout {
            background: #fee2e2;
            color: #dc2626;
            font-weight: 700;
            font-size: 13.5px;
            padding: 7px 16px;
            border-radius: 10px;
            text-decoration: none;
            border: 1px solid #fecaca;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition-smooth);
        }
        .btn-action-logout:hover {
            background: #dc2626;
            color: #ffffff;
            border-color: #dc2626;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.25);
        }

        .main-wrapper-content {
            flex-grow: 1;
        }

        footer {
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
            padding: 24px 0;
            margin-top: auto;
            color: #64748b;
            font-size: 14px;
        }
    </style>
    <c:out value="${requestScope.head}" escapeXml="false"/>
</head>
<body>

    <!-- GLASSMORPHIC TOPBAR NAVBAR -->
    <div class="glass-navbar">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="brand-gradient">
                <i class="bi bi-bag-heart-fill fs-3"></i> Shopping Store
            </a>

            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/home" class="nav-pill-item">
                    <i class="bi bi-house-door-fill"></i> Trang chủ
                </a>

                <c:choose>
                    <c:when test="${empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm px-3 fw-bold rounded-3">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm px-3 fw-bold rounded-3">Đăng ký</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/profile" class="nav-pill-item active">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar}">
                                    <c:choose>
                                        <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                            <img src="${sessionScope.account.avatar}" class="user-avatar-pill" alt="Avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${sessionScope.account.avatar}" var="navAvt"/>
                                            <img src="${navAvt}" class="user-avatar-pill" alt="Avatar">
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-person-circle fs-5"></i>
                                </c:otherwise>
                            </c:choose>
                            <span>Hồ sơ: <strong>${sessionScope.account.fullname}</strong></span>
                        </a>

                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a href="${pageContext.request.contextPath}/admin/home" class="btn-action-admin">
                                <i class="bi bi-shield-lock-fill"></i> Trang Admin
                            </a>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/logout" class="btn-action-logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- MAIN BODY CONTENT INJECTED BY SITEMESH -->
    <div class="main-wrapper-content">
        <c:out value="${requestScope.body}" escapeXml="false"/>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="container d-flex justify-content-between align-items-center">
            <p class="mb-0">© 2026 <strong>Shopping Store MVC JPA SiteMesh</strong>. All rights reserved.</p>
            <span class="badge bg-light text-secondary border px-3 py-2 fw-semibold">JPA ORM &bull; Servlet 6.0</span>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
