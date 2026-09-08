<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển - Admin Dashboard</title>
    <style>
        /* ===== ADMIN DASHBOARD PAGE STYLES ===== */

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 60%, #7c3aed 100%);
            border-radius: 20px;
            padding: 32px 36px;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 24px;
        }
        .welcome-banner::before {
            content: '';
            position: absolute; inset: 0;
            background: linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px),
                        linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px);
            background-size: 24px 24px;
        }
        .welcome-text { position: relative; z-index: 2; }
        .welcome-eyebrow {
            font-size: 12.5px; font-weight: 700; color: #a5b4fc;
            text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 6px;
        }
        .welcome-title { font-size: 28px; font-weight: 900; color: #fff; margin-bottom: 6px; }
        .welcome-sub { font-size: 14px; color: rgba(255,255,255,0.65); }
        .welcome-actions { position: relative; z-index: 2; display: flex; gap: 10px; flex-shrink: 0; flex-wrap: wrap; }

        .btn-welcome {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 11px 20px;
            border-radius: 11px;
            font-size: 13.5px; font-weight: 700;
            text-decoration: none; transition: all 0.22s;
        }
        .btn-welcome-primary {
            background: #fff; color: #1d4ed8;
            box-shadow: 0 4px 16px rgba(0,0,0,0.2);
        }
        .btn-welcome-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,0,0,0.3); color: #1e3a8a; }
        .btn-welcome-ghost {
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.22);
            color: #fff;
        }
        .btn-welcome-ghost:hover { background: rgba(255,255,255,0.2); color: #fff; transform: translateY(-2px); }

        /* KPI Cards */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 28px;
        }
        .kpi-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 24px;
            transition: all 0.28s;
            position: relative;
            overflow: hidden;
        }
        .kpi-card:hover { transform: translateY(-5px); box-shadow: 0 16px 40px rgba(15,23,42,0.1); }
        .kpi-card::after {
            content: '';
            position: absolute; top: 0; left: 0; right: 0;
            height: 4px;
        }
        .kpi-blue::after { background: linear-gradient(90deg, #1d4ed8, #3b82f6); }
        .kpi-green::after { background: linear-gradient(90deg, #065f46, #10b981); }
        .kpi-purple::after { background: linear-gradient(90deg, #4c1d95, #8b5cf6); }

        .kpi-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }
        .kpi-icon-box {
            width: 48px; height: 48px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
        }
        .kpi-blue .kpi-icon-box { background: #eff6ff; color: #2563eb; }
        .kpi-green .kpi-icon-box { background: #f0fdf4; color: #10b981; }
        .kpi-purple .kpi-icon-box { background: #faf5ff; color: #8b5cf6; }

        .kpi-trend {
            font-size: 12px; font-weight: 700;
            padding: 4px 10px; border-radius: 99px;
        }
        .kpi-trend-up { background: #f0fdf4; color: #16a34a; }
        .kpi-trend-info { background: #eff6ff; color: #2563eb; }
        .kpi-trend-warn { background: #fefce8; color: #ca8a04; }

        .kpi-label { font-size: 12.5px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 6px; }
        .kpi-value { font-size: 32px; font-weight: 900; color: #0f172a; letter-spacing: -1px; margin-bottom: 4px; }
        .kpi-sub { font-size: 13px; color: #64748b; font-weight: 500; }

        /* Quick Actions */
        .quick-actions-section { margin-bottom: 28px; }
        .section-title-sm {
            font-size: 16px; font-weight: 800; color: #0f172a;
            margin-bottom: 16px; display: flex; align-items: center; gap: 8px;
        }
        .quick-action-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }
        .quick-action-card {
            background: #fff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 18px;
            text-align: center;
            text-decoration: none;
            transition: all 0.25s;
            display: flex; flex-direction: column; align-items: center; gap: 10px;
        }
        .quick-action-card:hover {
            border-color: #2563eb;
            box-shadow: 0 8px 24px rgba(37,99,235,0.12);
            transform: translateY(-4px);
        }
        .qa-icon {
            width: 50px; height: 50px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 24px;
        }
        .qa-blue { background: #eff6ff; }
        .qa-green { background: #f0fdf4; }
        .qa-purple { background: #faf5ff; }
        .qa-orange { background: #fff7ed; }
        .qa-label { font-size: 13.5px; font-weight: 700; color: #374151; }
        .qa-sub { font-size: 11.5px; color: #94a3b8; font-weight: 500; }

        /* Admin Info Card */
        .admin-info-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
        }
        .admin-info-header {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            padding: 18px 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .admin-info-title { font-size: 15px; font-weight: 800; color: #0f172a; display: flex; align-items: center; gap: 8px; }
        .admin-info-body { padding: 24px; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .info-item {
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            border-radius: 12px;
            padding: 14px 16px;
        }
        .info-item-label { font-size: 11.5px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 6px; }
        .info-item-value { font-size: 14.5px; font-weight: 700; color: #0f172a; }

        @media (max-width: 900px) {
            .kpi-grid { grid-template-columns: 1fr; }
            .quick-action-grid { grid-template-columns: repeat(2, 1fr); }
            .info-grid { grid-template-columns: 1fr; }
            .welcome-banner { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body>

    <!-- WELCOME BANNER -->
    <div class="welcome-banner">
        <div class="welcome-text">
            <div class="welcome-eyebrow">⚡ Admin Panel — Bảng Điều Khiển</div>
            <h1 class="welcome-title">Xin chào, ${sessionScope.account.fullname}! 👋</h1>
            <p class="welcome-sub">Kiến trúc Three-Tier &bull; Servlet 6.0 &bull; JPA/Hibernate ORM &bull; SiteMesh Decorator 3</p>
        </div>
        <div class="welcome-actions">
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn-welcome btn-welcome-primary">
                <i class="bi bi-plus-circle-fill"></i> Thêm sản phẩm
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn-welcome btn-welcome-ghost">
                <i class="bi bi-globe"></i> Xem trang chính
            </a>
        </div>
    </div>

    <!-- KPI CARDS -->
    <div class="kpi-grid">
        <div class="kpi-card kpi-blue">
            <div class="kpi-header">
                <div class="kpi-icon-box"><i class="bi bi-folder2-open"></i></div>
                <span class="kpi-trend kpi-trend-up">↑ Active</span>
            </div>
            <div class="kpi-label">Danh mục sản phẩm</div>
            <div class="kpi-value">${not empty categoryCount ? categoryCount : '—'}</div>
            <div class="kpi-sub">Tổng danh mục trong hệ thống</div>
        </div>

        <div class="kpi-card kpi-green">
            <div class="kpi-header">
                <div class="kpi-icon-box"><i class="bi bi-box-seam"></i></div>
                <span class="kpi-trend kpi-trend-up">↑ Active</span>
            </div>
            <div class="kpi-label">Tổng sản phẩm</div>
            <div class="kpi-value">${not empty productCount ? productCount : '—'}</div>
            <div class="kpi-sub">Sản phẩm đang được quản lý</div>
        </div>

        <div class="kpi-card kpi-purple">
            <div class="kpi-header">
                <div class="kpi-icon-box"><i class="bi bi-shield-check-fill"></i></div>
                <span class="kpi-trend kpi-trend-info">Admin</span>
            </div>
            <div class="kpi-label">Phiên làm việc</div>
            <div class="kpi-value" style="font-size:20px; letter-spacing:-0.5px;">
                ${sessionScope.account.username}
            </div>
            <div class="kpi-sub">Vai trò: Quản trị viên (Role 1)</div>
        </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="quick-actions-section">
        <div class="section-title-sm">
            <i class="bi bi-lightning-charge-fill text-warning"></i> Thao tác nhanh
        </div>
        <div class="quick-action-grid">
            <a href="${pageContext.request.contextPath}/admin/product/add" class="quick-action-card">
                <div class="qa-icon qa-blue"><i class="bi bi-plus-circle-fill" style="color:#2563eb"></i></div>
                <div class="qa-label">Thêm sản phẩm</div>
                <div class="qa-sub">Tạo sản phẩm mới</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="quick-action-card">
                <div class="qa-icon qa-green"><i class="bi bi-folder-plus" style="color:#10b981"></i></div>
                <div class="qa-label">Thêm danh mục</div>
                <div class="qa-sub">Tạo danh mục mới</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/product/list" class="quick-action-card">
                <div class="qa-icon qa-purple"><i class="bi bi-list-task" style="color:#8b5cf6"></i></div>
                <div class="qa-label">DS Sản phẩm</div>
                <div class="qa-sub">Quản lý, sửa, xóa</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="quick-action-card">
                <div class="qa-icon qa-orange"><i class="bi bi-grid-3x3-gap-fill" style="color:#f59e0b"></i></div>
                <div class="qa-label">DS Danh mục</div>
                <div class="qa-sub">Quản lý danh mục</div>
            </a>
        </div>
    </div>

    <!-- ADMIN INFO -->
    <div class="admin-info-card">
        <div class="admin-info-header">
            <div class="admin-info-title">
                <i class="bi bi-person-badge-fill text-primary"></i>
                Thông tin tài khoản quản trị viên
            </div>
            <span class="badge bg-danger px-3 py-2 rounded-pill fs-7">
                <i class="bi bi-shield-lock-fill me-1"></i> Administrator — Role 1
            </span>
        </div>
        <div class="admin-info-body">
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-item-label">Họ và tên</div>
                    <div class="info-item-value">${sessionScope.account.fullname}</div>
                </div>
                <div class="info-item">
                    <div class="info-item-label">Tên đăng nhập</div>
                    <div class="info-item-value">@${sessionScope.account.username}</div>
                </div>
                <div class="info-item">
                    <div class="info-item-label">Địa chỉ email</div>
                    <div class="info-item-value">${sessionScope.account.email}</div>
                </div>
                <div class="info-item">
                    <div class="info-item-label">Số điện thoại</div>
                    <div class="info-item-value">
                        ${not empty sessionScope.account.phone ? sessionScope.account.phone : '(Chưa cập nhật)'}
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-item-label">Ngày tạo tài khoản</div>
                    <div class="info-item-value">${sessionScope.account.createdDate}</div>
                </div>
                <div class="info-item">
                    <div class="info-item-label">Trạng thái tài khoản</div>
                    <div class="info-item-value">
                        <span class="badge bg-success rounded-pill px-3 py-2">
                            <i class="bi bi-check-circle-fill me-1"></i> Đã kích hoạt (Active)
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>