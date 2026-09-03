<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
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
            --primary-gradient: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --transition-speed: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            display: flex;
            flex-direction: column;
        }

        .navbar-manager {
            background: var(--primary-gradient);
            box-shadow: 0 4px 20px rgba(30, 58, 138, 0.2);
            padding: 16px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .btn-topbar-logout {
            background: var(--danger-gradient);
            color: #ffffff !important;
            font-weight: 600;
            font-size: 13.5px;
            padding: 7px 18px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 12px rgba(255, 75, 43, 0.25);
            transition: all var(--transition-speed);
        }
        .btn-topbar-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 75, 43, 0.45);
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- TOPBAR NAVBAR (SITEMESH DECORATOR) -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-manager">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/manager/home">
                <i class="bi bi-briefcase-fill"></i> Manager Portal
            </a>
            <div class="d-flex align-items-center gap-3 text-white">
                <span class="small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-sm btn-light fw-bold">
                    <i class="bi bi-person-circle"></i> Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn-topbar-logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN BODY CONTENT -->
    <div class="flex-grow-1">
        <c:out value="${requestScope.body}" escapeXml="false"/>
    </div>

    <!-- FOOTER -->
    <footer class="bg-white border-top py-3 text-center text-muted small mt-auto">
        <div class="container">
            © 2026 Manager Portal - SiteMesh Decorator Layout
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
