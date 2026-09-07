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
        .stat-card-custom {
            border-radius: 16px;
            border: none;
            color: #fff;
            padding: 24px;
            transition: all 0.3s ease;
        }
        .stat-card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
        }
        .stat-blue {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }
        .stat-green {
            background: linear-gradient(135deg, #065f46 0%, #10b981 100%);
        }
        .stat-purple {
            background: linear-gradient(135deg, #4c1d95 0%, #8b5cf6 100%);
        }
    </style>
</head>
<body>

    <!-- PAGE HEADER -->
    <div class="mb-4">
        <h2 class="fw-bold text-dark mb-1">
            <i class="bi bi-speedometer2 text-primary me-2"></i>Bảng Điều Khiển Quản Trị (Admin Dashboard)
        </h2>
        <p class="text-muted small mb-0">Hệ thống phân quyền & quản trị kiến trúc Three-Tier Servlet JPA ORM</p>
    </div>

    <!-- STATS OVERVIEW CARDS -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stat-card-custom stat-blue shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <span class="text-white-50 small text-uppercase fw-bold">Danh Mục Sản Phẩm</span>
                        <h4 class="fw-bold mb-0 mt-1">Quản lý Categories</h4>
                    </div>
                    <i class="bi bi-folder2-open fs-1 text-white-50"></i>
                </div>
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-light btn-sm fw-bold text-primary w-100 rounded-3">
                    Xem danh mục <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card-custom stat-green shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <span class="text-white-50 small text-uppercase fw-bold">Sản Phẩm Cửa Hàng</span>
                        <h4 class="fw-bold mb-0 mt-1">Quản lý Products</h4>
                    </div>
                    <i class="bi bi-box-seam fs-1 text-white-50"></i>
                </div>
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-light btn-sm fw-bold text-success w-100 rounded-3">
                    Xem sản phẩm <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card-custom stat-purple shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <span class="text-white-50 small text-uppercase fw-bold">Phiên Làm Việc</span>
                        <h4 class="fw-bold mb-0 mt-1 text-truncate">${sessionScope.account.username}</h4>
                    </div>
                    <i class="bi bi-shield-check fs-1 text-white-50"></i>
                </div>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-light btn-sm fw-bold text-dark w-100 rounded-3">
                    Hồ sơ cá nhân <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- PROFILE DETAILS CARD -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex justify-content-between align-items-center">
            <span class="fw-bold text-dark fs-6">
                <i class="bi bi-person-badge-fill text-primary me-2"></i>Thông tin tài khoản Quản trị viên
            </span>
            <span class="badge bg-danger px-3 py-2 rounded-pill">Quản Trị Viên (Admin - Role ID 1)</span>
        </div>
        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Họ và tên</span>
                        <strong class="fs-6 text-dark">${sessionScope.account.fullname}</strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Tên đăng nhập (Username)</span>
                        <strong class="fs-6 text-dark">${sessionScope.account.username}</strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Địa chỉ Email</span>
                        <strong class="fs-6 text-dark">${sessionScope.account.email}</strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Số điện thoại</span>
                        <strong class="fs-6 text-dark">${not empty sessionScope.account.phone ? sessionScope.account.phone : 'Chưa cập nhật'}</strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Ngày tạo tài khoản</span>
                        <strong class="fs-6 text-dark">${sessionScope.account.createdDate}</strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3">
                        <span class="text-muted d-block small mb-1">Trạng thái tài khoản</span>
                        <span class="badge bg-success">Đã kích hoạt (Active)</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>