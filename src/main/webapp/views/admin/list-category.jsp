<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin Dashboard</title>
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
            --primary-hover: #0060d4;
            --primary-gradient: linear-gradient(135deg, #0088ff 0%, #0055dd 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning-gradient: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);
            --sidebar-bg: #0088ff;
            --bg-page: #f4f7fc;
            --card-shadow: 0 10px 30px rgba(0, 50, 150, 0.05);
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
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .top-navbar .brand-title i {
            transition: transform var(--transition-speed);
        }
        .top-navbar .brand-title:hover i {
            transform: rotate(15deg) scale(1.1);
        }
        .top-navbar .user-info {
            display: flex;
            align-items: center;
            gap: 18px;
            font-size: 15px;
        }
        .top-navbar .user-greeting {
            background: rgba(255, 255, 255, 0.15);
            padding: 6px 14px;
            border-radius: 50px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        /* Nút Đăng xuất */
        .btn-logout {
            background: var(--danger-gradient);
            color: #ffffff !important;
            font-weight: 600;
            font-size: 13.5px;
            padding: 7px 18px;
            border-radius: 8px;
            text-decoration: none;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 12px rgba(255, 75, 43, 0.35);
            transition: all var(--transition-speed);
        }
        .btn-logout:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 6px 18px rgba(255, 75, 43, 0.5);
            color: #fff;
        }
        .btn-logout:active {
            transform: translateY(0);
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
        .sidebar-profile .avatar-wrapper {
            position: relative;
            display: inline-block;
            margin-bottom: 12px;
        }
        .sidebar-profile img {
            width: 92px;
            height: 92px;
            border-radius: 50%;
            border: 3.5px solid #ffffff;
            object-fit: cover;
            background-color: #fff;
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
            letter-spacing: 0.2px;
        }

        /* SIDEBAR MENU */
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
            position: relative;
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
            color: #ffffff;
            box-shadow: inset 4px 0 0 var(--primary);
        }
        .sidebar-menu li a i {
            font-size: 19px;
            margin-right: 12px;
            transition: transform var(--transition-speed);
        }
        .sidebar-menu li a:hover i {
            transform: scale(1.2);
        }

        /* SUBMENU */
        .sidebar-submenu {
            list-style: none;
            padding: 5px 0;
            margin: 0;
            background-color: #006dd9;
        }
        .sidebar-submenu li a {
            padding: 10px 22px 10px 52px;
            font-size: 13.5px;
            font-weight: 500;
            color: #e0f2fe;
        }
        .sidebar-submenu li a:hover {
            background-color: #005bb8;
            color: #ffffff;
            padding-left: 56px;
        }
        .sidebar-submenu li a.active-sub {
            background-color: #0052a6;
            color: #ffffff;
            font-weight: 700;
            border-left: 3.5px solid #ffffff;
        }

        /* MAIN CONTENT */
        .main-content {
            flex-grow: 1;
            padding: 35px 40px;
            background-color: #ffffff;
        }
        .page-header {
            margin-bottom: 25px;
        }
        .page-title {
            color: #ef4444;
            font-size: 30px;
            font-weight: 800;
            margin-bottom: 4px;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-subtitle {
            color: #64748b;
            font-size: 14.5px;
            margin: 0;
        }

        /* CONTENT CARD */
        .content-card {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            background: #ffffff;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: box-shadow var(--transition-speed);
        }
        .content-card:hover {
            box-shadow: 0 15px 35px rgba(0, 50, 150, 0.08);
        }
        .content-card-header {
            padding: 16px 24px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 700;
            color: #334155;
            font-size: 16px;
        }

        /* Nút thêm mới */
        .btn-add-new {
            background: var(--success-gradient);
            color: #fff !important;
            font-weight: 600;
            padding: 7px 16px;
            border-radius: 8px;
            text-decoration: none;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 12px rgba(56, 239, 125, 0.3);
            transition: all var(--transition-speed);
        }
        .btn-add-new:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 6px 18px rgba(56, 239, 125, 0.45);
        }

        .content-card-body {
            padding: 24px;
        }

        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-input-group {
            position: relative;
            width: 280px;
        }
        .search-input-group .form-control {
            border-radius: 8px;
            padding-left: 36px;
            border: 1px solid #cbd5e1;
            font-size: 14px;
            transition: all var(--transition-speed);
        }
        .search-input-group .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3.5px rgba(0, 119, 255, 0.15);
        }
        .search-input-group .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            pointer-events: none;
        }

        /* TABLE */
        .category-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
        }
        .category-table th {
            background-color: #f8fafc;
            color: #475569;
            font-weight: 700;
            font-size: 13.5px;
            padding: 14px 18px;
            border-bottom: 1px solid #e2e8f0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .category-table td {
            padding: 16px 18px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14.5px;
            color: #1e293b;
            transition: background 0.2s;
        }
        .category-table tr:last-child td {
            border-bottom: none;
        }
        .category-table tbody tr:hover td {
            background-color: #f0f7ff;
        }

        /* IMAGE PREVIEW HOVER */
        .img-container {
            width: 130px;
            height: 95px;
            overflow: hidden;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
        }
        .img-preview {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform var(--transition-speed);
        }
        .img-container:hover .img-preview {
            transform: scale(1.15);
        }

        /* ACTION BUTTONS WITH HOVER EFFECTS */
        .btn-action-edit {
            color: #0284c7;
            background: #e0f2fe;
            padding: 6px 14px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13.5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: all var(--transition-speed);
        }
        .btn-action-edit:hover {
            background: #0284c7;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(2, 132, 199, 0.3);
        }

        .btn-action-delete {
            color: #ef4444;
            background: #fee2e2;
            padding: 6px 14px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13.5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: all var(--transition-speed);
        }
        .btn-action-delete:hover {
            background: #ef4444;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3);
        }
    </style>
</head>
<body>

    <!-- TOP NAVBAR -->
    <div class="top-navbar">
        <div class="brand-title">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </div>
        <div class="user-info">
            <div class="user-greeting">
                <i class="bi bi-person-check-fill me-1"></i> Xin chào <strong>${sessionScope.account != null ? sessionScope.account.fullname : 'Quản trị viên'}</strong>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </div>
    </div>

    <!-- WRAPPER -->
    <div class="wrapper">
        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-profile">
                <div class="avatar-wrapper">
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
                </div>
                <div class="d-block">
                    <span class="role-tag"><i class="bi bi-shield-lock-fill me-1"></i>Bạn là Admin</span>
                </div>
            </div>

            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/admin/home">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="active-category">
                        <i class="bi bi-folder2-open"></i> Quản lý Danh mục
                    </a>
                </li>
                <!-- Submenu -->
                <ul class="sidebar-submenu">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/category/add">
                            <i class="bi bi-plus-circle me-1"></i> Thêm danh mục mới
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="active-sub">
                            <i class="bi bi-list-ul me-1"></i> Danh sách danh mục
                        </a>
                    </li>
                </ul>

                <li>
                    <a href="#">
                        <i class="bi bi-display"></i> Quản lý sản phẩm
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="bi bi-people-fill"></i> Quản lý tài khoản
                    </a>
                </li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title"><i class="bi bi-tags-fill"></i> Quản lý danh mục</h1>
                <p class="page-subtitle">Nơi bạn có thể quản lý danh mục của mình</p>
            </div>

            <div class="content-card">
                <div class="content-card-header">
                    <span><i class="bi bi-card-list me-2 text-primary"></i>Danh sách danh mục</span>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn-add-new">
                        <i class="bi bi-plus-lg"></i> Thêm danh mục mới
                    </a>
                </div>

                <div class="content-card-body">
                    <!-- Filter and Search -->
                    <div class="filter-bar">
                        <div class="d-flex align-items-center gap-2 text-muted small">
                            <span>Hiển thị</span>
                            <select class="form-select form-select-sm" style="width: 80px; border-radius: 6px;">
                                <option>10</option>
                                <option>25</option>
                                <option>50</option>
                            </select>
                            <span>bản ghi</span>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="d-flex gap-2">
                            <div class="search-input-group">
                                <i class="bi bi-search search-icon"></i>
                                <input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm" placeholder="Tìm kiếm theo tên...">
                            </div>
                            <c:if test="${not empty keyword}">
                                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-sm btn-outline-secondary" style="border-radius: 8px;">
                                    <i class="bi bi-x-lg"></i> Đặt lại
                                </a>
                            </c:if>
                        </form>
                    </div>

                    <!-- Category Table -->
                    <div class="table-responsive">
                        <table class="category-table">
                            <thead>
                                <tr>
                                    <th style="width: 80px; text-align: center;">STT</th>
                                    <th style="width: 220px; text-align: center;">Hình ảnh</th>
                                    <th>Tên danh mục</th>
                                    <th style="width: 200px; text-align: center;">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                    <tr>
                                        <td style="text-align: center; font-weight: 700; color: #64748b;">
                                            #${STT.index + 1}
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="img-container">
                                                <c:choose>
                                                    <c:when test="${not empty cate.icon}">
                                                        <c:choose>
                                                            <c:when test="${cate.icon.startsWith('http')}">
                                                                <img src="${cate.icon}" alt="${cate.name}" class="img-preview">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                                                <img src="${imgUrl}" alt="${cate.name}" class="img-preview">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://placehold.co/150x100?text=No+Image" alt="No image" class="img-preview">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="font-weight: 700; font-size: 15.5px; color: #0f172a;">${cate.name}</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="d-inline-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" class="btn-action-edit">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" 
                                                   class="btn-action-delete"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục: ${cate.name}?');">
                                                    <i class="bi bi-trash-fill"></i> Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty cateList}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-5">
                                            <i class="bi bi-inbox fs-1 d-block mb-3 text-secondary"></i>
                                            <h5>Không tìm thấy danh mục nào</h5>
                                            <p class="small text-muted">Hãy thử từ khóa khác hoặc bấm Thêm danh mục mới.</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-3 text-muted" style="font-size: 13.5px;">
                        <span>Tổng số danh mục: <strong class="text-dark">${cateList.size()}</strong></span>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>