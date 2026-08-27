<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Danh Mục - Admin Dashboard</title>
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
            --info-gradient: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
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
        .sidebar-menu li a.active-category {
            background: #0f172a;
            box-shadow: inset 4px 0 0 var(--primary);
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

        .form-card {
            max-width: 720px;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 50, 150, 0.05);
            overflow: hidden;
        }
        .form-card-header {
            padding: 16px 24px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            font-weight: 700;
            color: #1e293b;
            font-size: 17px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-card-body {
            padding: 30px;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            font-size: 14.5px;
            transition: all var(--transition-speed);
        }
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3.5px rgba(0, 119, 255, 0.15);
        }

        /* PREVIEW IMAGE HOVER */
        .preview-box-container {
            width: 140px;
            height: 105px;
            border-radius: 10px;
            border: 2px dashed #cbd5e1;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-bottom: 12px;
            transition: all var(--transition-speed);
        }
        .preview-box-container:hover {
            border-color: var(--primary);
            box-shadow: 0 6px 20px rgba(0, 119, 255, 0.12);
        }
        .preview-box {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform var(--transition-speed);
        }
        .preview-box-container:hover .preview-box {
            transform: scale(1.1);
        }

        /* NÚT BẤM VỚI HIỆU ỨNG ĐẶC BIỆT HOVER */
        .btn-custom-edit {
            background: var(--info-gradient);
            color: #ffffff;
            font-weight: 700;
            padding: 10px 24px;
            border-radius: 8px;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 14px rgba(0, 198, 255, 0.35);
            transition: all var(--transition-speed);
        }
        .btn-custom-edit:hover {
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 6px 20px rgba(0, 114, 255, 0.5);
            color: #ffffff;
        }

        .btn-custom-reset {
            background: #64748b;
            color: #ffffff;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all var(--transition-speed);
        }
        .btn-custom-reset:hover {
            background: #475569;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(71, 85, 105, 0.3);
        }

        .btn-custom-back {
            background: #f1f5f9;
            color: #475569;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all var(--transition-speed);
        }
        .btn-custom-back:hover {
            background: #e2e8f0;
            color: #0f172a;
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
                    <a href="${pageContext.request.contextPath}/admin/home">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="active-category">
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
            <div class="form-card">
                <div class="form-card-header">
                    <i class="bi bi-pencil-square text-warning"></i> Chỉnh sửa danh mục
                </div>
                <div class="form-card-body">
                    <h3 class="fw-bold mb-4" style="color: #0f172a; font-size: 20px;">Thông tin danh mục:</h3>

                    <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${category.id}">

                        <!-- Category Name -->
                        <div class="mb-4">
                            <label class="form-label fw-bold text-dark">Tên danh sách:</label>
                            <input type="text" name="name" class="form-control" value="${category.name}" required placeholder="Nhập tên danh mục...">
                        </div>

                        <!-- Image & Live Preview -->
                        <div class="mb-4">
                            <label class="form-label fw-bold text-dark d-block">Ảnh đại diện:</label>
                            <div class="preview-box-container">
                                <c:choose>
                                    <c:when test="${not empty category.icon}">
                                        <c:choose>
                                            <c:when test="${category.icon.startsWith('http')}">
                                                <img id="imgPreview" src="${category.icon}" class="preview-box" alt="Current icon">
                                            </c:when>
                                            <c:otherwise>
                                                <c:url value="/image?fname=${category.icon}" var="imgUrl"/>
                                                <img id="imgPreview" src="${imgUrl}" class="preview-box" alt="Current icon">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img id="imgPreview" src="https://placehold.co/150x100?text=No+Image" class="preview-box" alt="No icon">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <input type="file" name="icon" id="fileInput" class="form-control" accept="image/*" onchange="previewImage(event)">
                            <small class="text-muted mt-1 d-block">Chọn ảnh mới nếu muốn thay đổi ảnh hiện tại.</small>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex gap-3 mt-4 pt-2 border-top">
                            <button type="submit" class="btn-custom-edit">
                                <i class="bi bi-check2-circle"></i> Edit (Lưu thay đổi)
                            </button>
                            <button type="reset" class="btn-custom-reset">
                                <i class="bi bi-arrow-counterclockwise"></i> Reset
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn-custom-back">
                                <i class="bi bi-arrow-left"></i> Trở lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Live Preview Script -->
    <script>
        function previewImage(event) {
            const input = event.target;
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imgPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>