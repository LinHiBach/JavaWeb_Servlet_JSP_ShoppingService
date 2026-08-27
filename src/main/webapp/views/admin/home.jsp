<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển - Admin Dashboard</title>
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
            --primary: #0077ff;
            --primary-gradient: linear-gradient(135deg, #0088ff 0%, #0055dd 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning-gradient: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);
            --sidebar-bg: #0088ff;
            --bg-page: #f4f7fc;
            --transition-speed: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: var(--bg-page);
            margin: 0;
            padding: 0;
            color: #1e293b;
        }

        /* TOPBAR */
        .top-navbar {
            background: var(--primary-gradient);
            color: #ffffff;
            height: 65px;
            padding: 0 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 20px rgba(0, 100, 255, 0.18);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .top-navbar .brand-title {
            font-size: 24px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-logout {
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
            box-shadow: 0 4px 12px rgba(255, 75, 43, 0.35);
            transition: all var(--transition-speed);
        }
        .btn-logout:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 6px 18px rgba(255, 75, 43, 0.5);
        }

        /* WRAPPER */
        .wrapper {
            display: flex;
            min-height: calc(100vh - 65px);
        }

        /* SIDEBAR */
        .sidebar {
            width: 270px;
            background-color: var(--sidebar-bg);
            color: #ffffff;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.04);
            border-top: 1px solid rgba(255,255,255,0.15);
        }
        .sidebar-profile {
            text-align: center;
            padding: 28px 15px 22px;
            border-bottom: 1px solid rgba(255,255,255,0.15);
        }
        .sidebar-profile img {
            width: 92px;
            height: 92px;
            border-radius: 50%;
            border: 3.5px solid #ffffff;
            object-fit: cover;
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
            transition: transform var(--transition-speed);
        }
        .sidebar-profile:hover img {
            transform: scale(1.06);
        }
        .sidebar-profile .role-tag {
            font-size: 14px;
            color: #e0f2fe;
            font-weight: 600;
            background: rgba(255,255,255,0.15);
            display: inline-block;
            padding: 3px 12px;
            border-radius: 20px;
            margin-top: 10px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 10px 0;
            margin: 0;
        }
        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 14px 22px;
            color: #ffffff;
            text-decoration: none;
            font-size: 14.5px;
            font-weight: 600;
            transition: all var(--transition-speed);
        }
        .sidebar-menu li a:hover {
            background-color: rgba(0, 0, 0, 0.15);
            padding-left: 28px;
        }
        .sidebar-menu li a.active-dashboard {
            background: #ff0000;
            box-shadow: inset 4px 0 0 #ffffff;
        }
        .sidebar-menu li a.active-category {
            background: #0f172a;
        }
        .sidebar-menu li a i {
            font-size: 19px;
            margin-right: 12px;
        }
        .sidebar-submenu {
            list-style: none;
            padding: 5px 0;
            margin: 0;
            background-color: #006dd9;
        }
        .sidebar-submenu li a {
            padding: 10px 22px 10px 52px;
            font-size: 13.5px;
            color: #e0f2fe;
        }
        .sidebar-submenu li a:hover {
            background-color: #005bb8;
            color: #ffffff;
            padding-left: 56px;
        }

        /* MAIN CONTENT */
        .main-content {
            flex-grow: 1;
            padding: 35px 40px;
            background-color: #ffffff;
        }

        /* STAT CARDS HOVER */
        .stat-card {
            border-radius: 14px;
            border: none;
            color: #fff;
            padding: 24px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            transition: all var(--transition-speed);
        }
        .stat-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 16px 32px rgba(0,0,0,0.15);
        }
        .stat-card-blue {
            background: linear-gradient(135deg, #0077ff 0%, #00b4d8 100%);
        }
        .stat-card-green {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
        }
        .stat-card-amber {
            background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
        }

        .btn-card-action {
            background: rgba(255, 255, 255, 0.9);
            color: #0f172a;
            font-weight: 700;
            font-size: 13.5px;
            border-radius: 8px;
            padding: 8px 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all var(--transition-speed);
        }
        .btn-card-action:hover {
            background: #ffffff;
            color: #0077ff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        /* PROFILE OVERVIEW CARD */
        .profile-card {
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 50, 150, 0.05);
            overflow: hidden;
            transition: box-shadow var(--transition-speed);
        }
        .profile-card:hover {
            box-shadow: 0 15px 35px rgba(0, 50, 150, 0.09);
        }
        .profile-card-header {
            padding: 16px 24px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            font-weight: 700;
            color: #0f172a;
            font-size: 16.5px;
        }
        .info-pill {
            background: #f8fafc;
            padding: 12px 18px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            transition: all var(--transition-speed);
        }
        .info-pill:hover {
            background: #f0f7ff;
            border-color: #93c5fd;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <!-- TOP NAVBAR -->
    <div class="top-navbar">
        <div class="brand-title">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="text-white">Xin chào <strong>${sessionScope.account != null ? sessionScope.account.fullname : 'Quản trị viên'}</strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </div>
    </div>

    <div class="wrapper">
        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-profile">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.avatar}">
                        <c:choose>
                            <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                <img src="${sessionScope.account.avatar}" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=ffffff&amp;color=0088ff&amp;bold=true';">
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${sessionScope.account.avatar}" var="avtUrl"/>
                                <img src="${avtUrl}" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=ffffff&amp;color=0088ff&amp;bold=true';">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=ffffff&color=0088ff&bold=true" alt="Avatar">
                    </c:otherwise>
                </c:choose>
                <div class="d-block">
                    <span class="role-tag"><i class="bi bi-shield-lock-fill me-1"></i>Bạn là Admin</span>
                </div>
            </div>

            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/admin/home" class="active-dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/category/list">
                        <i class="bi bi-folder2-open"></i> Quản lý Danh mục
                    </a>
                </li>
                <ul class="sidebar-submenu">
                    <li><a href="${pageContext.request.contextPath}/admin/category/add"><i class="bi bi-plus-circle me-1"></i> Thêm danh mục mới</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/category/list"><i class="bi bi-list-ul me-1"></i> Danh sách danh mục</a></li>
                </ul>
                <li><a href="#"><i class="bi bi-display"></i> Quản lý sản phẩm</a></li>
                <li><a href="#"><i class="bi bi-people-fill"></i> Quản lý tài khoản</a></li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <h2 class="fw-bold mb-1" style="color: #0f172a; font-size: 28px;">Bảng Điều Khiển Quản Trị</h2>
            <p class="text-muted mb-4">Hệ thống phân quyền & quản trị kiến trúc 3 tầng Servlet MVC JDBC.</p>

            <!-- Stat Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card stat-card-blue">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <span class="text-white-50 small text-uppercase fw-bold">Danh Mục</span>
                                <h3 class="fw-bold mb-0 mt-1">Quản lý CRUD</h3>
                            </div>
                            <i class="bi bi-folder2-open fs-1 text-white-50"></i>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn-card-action w-100">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card stat-card-green">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <span class="text-white-50 small text-uppercase fw-bold">Tài Khoản Hiện Tại</span>
                                <h3 class="fw-bold mb-0 mt-1">${sessionScope.account.username}</h3>
                            </div>
                            <i class="bi bi-shield-check fs-1 text-white-50"></i>
                        </div>
                        <span class="badge bg-white text-success fw-bold py-2 px-3">Role ID: 1 (Admin)</span>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card stat-card-amber">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <span class="text-white-50 small text-uppercase fw-bold">Liên Hệ</span>
                                <h5 class="fw-bold mb-0 mt-1 text-truncate">${sessionScope.account.email}</h5>
                            </div>
                            <i class="bi bi-envelope-check-fill fs-1 text-white-50"></i>
                        </div>
                        <span class="badge bg-white text-dark fw-bold py-2 px-3">SĐT: ${sessionScope.account.phone}</span>
                    </div>
                </div>
            </div>

            <!-- Profile Info Card -->
            <div class="profile-card">
                <div class="profile-card-header d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-person-badge-fill text-primary me-2"></i>Thông tin tài khoản Quản trị</span>
                    <span class="badge bg-danger">Quản Trị Viên (Admin)</span>
                </div>
                <div class="p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Họ và tên</span>
                                <strong class="fs-6 text-dark">${sessionScope.account.fullname}</strong>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Tên đăng nhập (Username)</span>
                                <strong class="fs-6 text-dark">${sessionScope.account.username}</strong>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Địa chỉ Email</span>
                                <strong class="fs-6 text-dark">${sessionScope.account.email}</strong>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Số điện thoại</span>
                                <strong class="fs-6 text-dark">${sessionScope.account.phone}</strong>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Ngày tạo tài khoản</span>
                                <strong class="fs-6 text-dark">${sessionScope.account.createdDate}</strong>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Quyền hạn hệ thống</span>
                                <strong class="fs-6 text-danger">Toàn quyền Admin (Level 1)</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>