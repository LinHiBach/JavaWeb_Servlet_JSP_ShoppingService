<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cổng Quản Lý - Manager Portal</title>
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

        .manager-card {
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 50, 150, 0.06);
            padding: 35px;
            transition: all var(--transition-speed);
        }
        .manager-card:hover {
            box-shadow: 0 16px 40px rgba(0, 50, 150, 0.1);
        }

        .info-pill {
            background: #f8fafc;
            padding: 14px 18px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            transition: all var(--transition-speed);
        }
        .info-pill:hover {
            background: #eff6ff;
            border-color: #93c5fd;
            transform: translateY(-2px);
        }

        .btn-category-link {
            background: #3b82f6;
            color: #ffffff;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all var(--transition-speed);
        }
        .btn-category-link:hover {
            background: #2563eb;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body>

    <!-- TOPBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-manager">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/manager/home">
                <i class="bi bi-briefcase-fill"></i> Manager Portal
            </a>
            <div class="d-flex align-items-center gap-3 text-white">
                <span class="small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <span class="badge bg-warning text-dark px-3 py-2 fw-bold">Role: Manager</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn-topbar-logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="manager-card">
                    <div class="d-flex align-items-center gap-4 mb-4 pb-4 border-bottom">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <c:choose>
                                    <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                        <img src="${sessionScope.account.avatar}" class="rounded-circle border" width="80" height="80" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=3b82f6&amp;color=ffffff&amp;bold=true';">
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${sessionScope.account.avatar}" var="avtUrl"/>
                                        <img src="${avtUrl}" class="rounded-circle border" width="80" height="80" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=3b82f6&amp;color=ffffff&amp;bold=true';">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=3b82f6&color=ffffff&bold=true" class="rounded-circle" width="80" height="80" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                        <div>
                            <h3 class="mb-1 fw-bold text-dark">${sessionScope.account.fullname}</h3>
                            <span class="text-muted small">${sessionScope.account.email}</span>
                        </div>
                    </div>

                    <h5 class="fw-bold mb-3 text-primary"><i class="bi bi-person-lines-fill me-2"></i>Thông tin tài khoản Quản lý</h5>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Tên đăng nhập (Username):</span>
                                <strong class="fw-bold text-dark">${sessionScope.account.username}</strong>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Số điện thoại:</span>
                                <strong class="fw-bold text-dark">${sessionScope.account.phone}</strong>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Vai trò:</span>
                                <div><span class="badge bg-primary">Quản lý (Manager - Role ID: ${sessionScope.account.roleid})</span></div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="info-pill">
                                <span class="text-muted d-block small">Ngày đăng ký:</span>
                                <strong class="fw-bold text-dark">${sessionScope.account.createdDate}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4 pt-3 border-top d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn-category-link">
                            <i class="bi bi-folder2-open"></i> Xem danh mục sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger px-4">
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
