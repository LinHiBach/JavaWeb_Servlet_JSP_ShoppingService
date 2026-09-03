<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Người Dùng - Shopping Store</title>
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
            --primary-gradient: linear-gradient(135deg, #0077ff 0%, #0055dd 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --transition-speed: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: #f1f5f9;
            margin: 0;
            padding: 0;
            color: #1e293b;
        }

        .topbar-user {
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 14px 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .brand-logo {
            color: #0077ff;
            font-weight: 800;
            font-size: 22px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: transform var(--transition-speed);
        }
        .brand-logo:hover {
            transform: scale(1.03);
            color: #0055dd;
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

        .profile-card {
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 50, 150, 0.06);
            padding: 35px 30px;
            transition: all var(--transition-speed);
        }
        .profile-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 40px rgba(0, 50, 150, 0.1);
        }

        .user-avatar {
            width: 105px;
            height: 105px;
            border-radius: 50%;
            border: 4px solid #e0f2fe;
            object-fit: cover;
            box-shadow: 0 8px 20px rgba(0, 119, 255, 0.15);
            transition: transform var(--transition-speed);
        }
        .user-avatar:hover {
            transform: scale(1.08) rotate(3deg);
        }

        .info-row {
            padding: 12px 16px;
            border-radius: 10px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            transition: all var(--transition-speed);
        }
        .info-row:hover {
            background: #f0f7ff;
            border-color: #93c5fd;
            transform: translateX(4px);
        }
    </style>
</head>
<body>

    <!-- TOPBAR -->
    <div class="topbar-user">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="brand-logo">
                <i class="bi bi-bag-heart-fill fs-3"></i> Shopping Store
            </a>

            <c:choose>
                <c:when test="${empty sessionScope.account}">
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm px-3 fw-semibold">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm px-3 fw-semibold">Đăng ký</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex align-items-center gap-3">
                        <span class="small">Xin chào, <strong class="text-primary">${sessionScope.account.fullname}</strong></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-topbar-logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng Xuất
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- MAIN BODY -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="profile-card text-center">
                    <div class="mb-3">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <c:choose>
                                    <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                        <img src="${sessionScope.account.avatar}" class="user-avatar" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=0077ff&amp;color=ffffff&amp;bold=true';">
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${sessionScope.account.avatar}" var="avtUrl"/>
                                        <img src="${avtUrl}" class="user-avatar" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&amp;background=0077ff&amp;color=ffffff&amp;bold=true';">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=0077ff&color=ffffff&bold=true" class="user-avatar" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h4 class="fw-bold text-dark mb-1">${sessionScope.account.fullname}</h4>
                    <span class="badge bg-success py-2 px-3 mb-4 rounded-pill">
                        <i class="bi bi-patch-check-fill me-1"></i> Thành viên (Member)
                    </span>

                    <div class="text-start mb-4">
                        <div class="info-row">
                            <span class="text-muted small">Tên đăng nhập:</span>
                            <span class="fw-bold text-dark">${sessionScope.account.username}</span>
                        </div>
                        <div class="info-row">
                            <span class="text-muted small">Email liên hệ:</span>
                            <span class="fw-bold text-dark">${sessionScope.account.email}</span>
                        </div>
                        <div class="info-row">
                            <span class="text-muted small">Số điện thoại:</span>
                            <span class="fw-bold text-dark">${sessionScope.account.phone}</span>
                        </div>
                        <div class="info-row">
                            <span class="text-muted small">Ngày tham gia:</span>
                            <span class="fw-bold text-dark">${sessionScope.account.createdDate}</span>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary w-100 justify-content-center py-2 fs-6 fw-bold">
                            <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa Profile (JPA)
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-topbar-logout w-100 justify-content-center py-2 fs-6">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
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