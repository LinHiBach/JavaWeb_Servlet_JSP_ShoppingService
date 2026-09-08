<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Shopping Store MVC</title>
    <style>
        /* ======================================
           HOME PAGE — HERO & PRODUCT GRID
        ====================================== */

        /* HERO */
        .hero-section {
            background: linear-gradient(135deg, #1e1b4b 0%, #1d4ed8 50%, #7c3aed 100%);
            border-radius: 24px;
            padding: 56px 48px;
            margin-bottom: 36px;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 32px;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at 75% 50%, rgba(124,58,237,0.35), transparent 60%),
                        radial-gradient(ellipse at 20% 80%, rgba(37,99,235,0.25), transparent 55%);
        }
        /* Grid pattern overlay */
        .hero-section::after {
            content: '';
            position: absolute;
            inset: 0;
            background-image: linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
                              linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
            background-size: 32px 32px;
        }

        .hero-text { position: relative; z-index: 2; }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.2);
            color: #e0e7ff;
            font-size: 13px;
            font-weight: 700;
            padding: 6px 16px;
            border-radius: 99px;
            margin-bottom: 20px;
        }
        .hero-badge .dot {
            width: 8px; height: 8px; border-radius: 50%;
            background: #a78bfa;
            animation: pulse-dot 2s ease-in-out infinite;
        }
        @keyframes pulse-dot { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.7)} }

        .hero-title {
            font-size: 44px;
            font-weight: 900;
            color: #ffffff;
            letter-spacing: -1px;
            line-height: 1.1;
            margin-bottom: 16px;
        }
        .hero-title span { color: #a78bfa; }

        .hero-desc {
            font-size: 15.5px;
            color: rgba(255,255,255,0.65);
            margin-bottom: 32px;
            max-width: 440px;
            line-height: 1.7;
        }

        .hero-cta-row { display: flex; gap: 12px; flex-wrap: wrap; }
        .hero-btn-primary {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 14px 28px;
            background: #ffffff;
            color: #1d4ed8;
            font-weight: 800; font-size: 15px;
            border-radius: 12px; text-decoration: none;
            box-shadow: 0 6px 20px rgba(0,0,0,0.25);
            transition: all 0.25s;
        }
        .hero-btn-primary:hover { transform: translateY(-2px); box-shadow: 0 10px 28px rgba(0,0,0,0.3); color: #1e3a8a; }

        .hero-btn-outline {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 14px 28px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.25);
            color: #ffffff;
            font-weight: 700; font-size: 15px;
            border-radius: 12px; text-decoration: none;
            transition: all 0.25s;
        }
        .hero-btn-outline:hover { background: rgba(255,255,255,0.2); color: #fff; transform: translateY(-2px); }

        /* Hero right side: floating stat cards */
        .hero-visual {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            gap: 14px;
            flex-shrink: 0;
        }
        .hero-stat-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.18);
            border-radius: 16px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            min-width: 200px;
            animation: float-up 5s ease-in-out infinite;
        }
        .hero-stat-card:nth-child(2) { animation-delay: 2.5s; }
        @keyframes float-up { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-8px)} }
        .hero-stat-icon {
            width: 44px; height: 44px;
            background: rgba(255,255,255,0.15);
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
        }
        .hero-stat-value { font-size: 20px; font-weight: 900; color: #fff; }
        .hero-stat-label { font-size: 12px; color: rgba(255,255,255,0.6); font-weight: 600; }

        /* User Quick Card */
        .user-quick-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 16px 20px;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 16px rgba(15,23,42,0.06);
            flex-wrap: wrap;
            gap: 12px;
        }
        .user-quick-left { display: flex; align-items: center; gap: 14px; }
        .user-quick-avatar {
            width: 50px; height: 50px;
            border-radius: 50%; object-fit: cover;
            border: 2.5px solid #2563eb;
            box-shadow: 0 4px 12px rgba(37,99,235,0.2);
        }
        .user-quick-name { font-size: 15px; font-weight: 800; color: #0f172a; margin-bottom: 2px; }
        .user-quick-sub { font-size: 13px; color: #64748b; font-weight: 500; }

        /* Section Header */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        .section-title { font-size: 20px; font-weight: 900; color: #0f172a; letter-spacing: -0.3px; }
        .section-subtitle { font-size: 13px; color: #64748b; margin-top: 2px; }
        .section-view-all {
            font-size: 13.5px; font-weight: 700; color: #2563eb;
            text-decoration: none; display: flex; align-items: center; gap: 4px;
            padding: 7px 14px; border-radius: 8px;
            border: 1.5px solid #bfdbfe;
            background: #eff6ff;
            transition: all 0.2s;
        }
        .section-view-all:hover { background: #2563eb; color: #fff; border-color: #2563eb; }

        /* Product Card — Premium */
        .product-card-v2 {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        .product-card-v2:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 48px rgba(37,99,235,0.14);
            border-color: #bfdbfe;
        }

        .product-img-box {
            position: relative;
            height: 210px;
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            overflow: hidden;
            display: flex; align-items: center; justify-content: center;
        }
        .product-img-main {
            max-height: 100%; max-width: 100%;
            object-fit: cover;
            transition: transform 0.45s cubic-bezier(0.4,0,0.2,1);
        }
        .product-card-v2:hover .product-img-main { transform: scale(1.1); }

        /* Quick-view overlay */
        .product-overlay {
            position: absolute; inset: 0;
            background: rgba(15,23,42,0.45);
            display: flex; align-items: center; justify-content: center;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .product-card-v2:hover .product-overlay { opacity: 1; }
        .product-overlay-btn {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 10px 20px;
            background: #fff; color: #1d4ed8;
            font-size: 13.5px; font-weight: 800;
            border-radius: 10px; text-decoration: none;
            box-shadow: 0 4px 14px rgba(0,0,0,0.25);
            transform: translateY(12px);
            transition: transform 0.3s;
        }
        .product-card-v2:hover .product-overlay-btn { transform: translateY(0); }

        /* Product Badges */
        .product-badge {
            position: absolute; top: 12px; left: 12px;
            font-size: 11px; font-weight: 800;
            padding: 4px 10px; border-radius: 99px;
            text-transform: uppercase; letter-spacing: 0.05em;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .badge-new { background: #2563eb; color: #fff; }
        .badge-hot { background: #ef4444; color: #fff; }
        .badge-sale { background: #f59e0b; color: #fff; }

        /* Rating stars */
        .product-rating { color: #f59e0b; font-size: 12px; display: flex; align-items: center; gap: 3px; }
        .product-rating-count { font-size: 11px; color: #94a3b8; font-weight: 500; margin-left: 4px; }

        .product-info { padding: 16px 18px; flex-grow: 1; display: flex; flex-direction: column; }
        .product-category-tag {
            display: inline-flex; align-items: center; gap: 5px;
            background: #eff6ff; color: #2563eb;
            border: 1px solid #bfdbfe;
            font-size: 11.5px; font-weight: 700;
            padding: 3px 10px; border-radius: 99px;
            margin-bottom: 8px;
        }
        .product-name {
            font-size: 15px; font-weight: 800; color: #0f172a;
            margin-bottom: 6px;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
            text-decoration: none; line-height: 1.4;
        }
        .product-name:hover { color: #2563eb; }
        .product-desc {
            font-size: 13px; color: #64748b;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
            margin-bottom: 14px; flex-grow: 1; line-height: 1.5;
        }
        .product-footer {
            display: flex; align-items: center; justify-content: space-between;
            padding-top: 12px; border-top: 1px solid #f1f5f9;
        }
        .product-price {
            font-size: 19px; font-weight: 900; color: #2563eb;
        }
        .btn-product-detail {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 8px 16px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff; font-size: 13px; font-weight: 700;
            border-radius: 9px; text-decoration: none;
            transition: all 0.22s;
            box-shadow: 0 3px 10px rgba(37,99,235,0.3);
        }
        .btn-product-detail:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(37,99,235,0.4); color: #fff; }

        /* Empty state */
        .empty-state {
            text-align: center; padding: 64px 24px;
            background: #fff; border-radius: 20px;
            border: 2px dashed #e2e8f0;
        }
        .empty-state i { font-size: 56px; color: #e2e8f0; display: block; margin-bottom: 16px; }
        .empty-state p { font-size: 15px; color: #94a3b8; font-weight: 500; }

        @media (max-width: 768px) {
            .hero-section { padding: 36px 24px; flex-direction: column; }
            .hero-title { font-size: 30px; }
            .hero-visual { display: none; }
            .user-quick-card { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body>
<div class="container py-4">

    <!-- HERO SECTION -->
    <div class="hero-section">
        <div class="hero-text">
            <div class="hero-badge">
                <div class="dot"></div>
                🔥 Sản phẩm mới cập nhật hôm nay
            </div>
            <h1 class="hero-title">Khám phá<br>Shopping<br><span>Store MVC</span></h1>
            <p class="hero-desc">
                Nền tảng mua sắm được xây dựng trên kiến trúc Three-Tier chuẩn doanh nghiệp với Java Servlet, JPA/Hibernate ORM và SiteMesh Decorator 3.
            </p>
            <div class="hero-cta-row">
                <a href="${pageContext.request.contextPath}/product" class="hero-btn-primary">
                    <i class="bi bi-grid-3x3-gap-fill"></i> Xem tất cả sản phẩm
                </a>
                <a href="${pageContext.request.contextPath}/register" class="hero-btn-outline">
                    <i class="bi bi-person-plus-fill"></i> Đăng ký miễn phí
                </a>
            </div>
        </div>

        <div class="hero-visual">
            <div class="hero-stat-card">
                <div class="hero-stat-icon">📦</div>
                <div>
                    <div class="hero-stat-value">10+</div>
                    <div class="hero-stat-label">Sản phẩm mới nhất</div>
                </div>
            </div>
            <div class="hero-stat-card">
                <div class="hero-stat-icon">⚡</div>
                <div>
                    <div class="hero-stat-value">Real-time</div>
                    <div class="hero-stat-label">Cập nhật từ JPA CSDL</div>
                </div>
            </div>
        </div>
    </div>

    <!-- USER QUICK CARD -->
    <c:if test="${not empty sessionScope.account}">
        <div class="user-quick-card">
            <div class="user-quick-left">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.avatar}">
                        <c:choose>
                            <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                <img src="${sessionScope.account.avatar}" class="user-quick-avatar" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${sessionScope.account.avatar}" var="userAvt"/>
                                <img src="${userAvt}" class="user-quick-avatar" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=2563eb&color=ffffff&bold=true" class="user-quick-avatar" alt="Avatar">
                    </c:otherwise>
                </c:choose>
                <div>
                    <div class="user-quick-name">Xin chào, ${sessionScope.account.fullname}! 👋</div>
                    <div class="user-quick-sub">@${sessionScope.account.username} • ${sessionScope.account.email}</div>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-sm fw-bold rounded-3 px-3">
                <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa hồ sơ
            </a>
        </div>
    </c:if>

    <!-- SECTION: 10 SẢN PHẨM MỚI NHẤT -->
    <div class="section-header">
        <div>
            <h2 class="section-title"><i class="bi bi-stars text-warning me-2"></i>10 Sản Phẩm Mới Nhất</h2>
            <p class="section-subtitle">Được tải trực tiếp từ CSDL SQL Server thông qua JPA EntityManager</p>
        </div>
        <a href="${pageContext.request.contextPath}/product" class="section-view-all">
            Xem tất cả <i class="bi bi-arrow-right-short"></i>
        </a>
    </div>

    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty top10Products}">
                <c:forEach items="${top10Products}" var="p" varStatus="loop">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="product-card-v2">
                            <div class="product-img-box">
                                <!-- Badge based on position -->
                                <c:choose>
                                    <c:when test="${loop.index < 2}">
                                        <span class="product-badge badge-hot">🔥 HOT</span>
                                    </c:when>
                                    <c:when test="${loop.index < 5}">
                                        <span class="product-badge badge-new">✨ NEW</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="product-badge badge-sale">⭐ SALE</span>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Product Image -->
                                <c:choose>
                                    <c:when test="${not empty p.images}">
                                        <c:choose>
                                            <c:when test="${p.images.startsWith('http')}">
                                                <img src="${p.images}" class="product-img-main" alt="${p.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <c:url value="/image?fname=${p.images}" var="pImg"/>
                                                <img src="${pImg}" class="product-img-main" alt="${p.productName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="font-size:64px; color:#e2e8f0;">📦</div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Quick View Overlay -->
                                <div class="product-overlay">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="product-overlay-btn">
                                        <i class="bi bi-eye-fill"></i> Xem nhanh
                                    </a>
                                </div>
                            </div>

                            <div class="product-info">
                                <span class="product-category-tag">
                                    <i class="bi bi-tag-fill"></i> ${p.category.categoryname}
                                </span>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="product-name">
                                    ${p.productName}
                                </a>
                                <!-- Static 5-star rating -->
                                <div class="product-rating mb-2">
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-half"></i>
                                    <span class="product-rating-count">(24)</span>
                                </div>
                                <p class="product-desc">${p.description}</p>
                                <div class="product-footer">
                                    <span class="product-price">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn-product-detail">
                                        Chi tiết <i class="bi bi-arrow-right-short"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="empty-state">
                        <i class="bi bi-box-seam"></i>
                        <p>Chưa có sản phẩm nào trong cơ sở dữ liệu.</p>
                        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary mt-3">
                            <i class="bi bi-plus-circle me-1"></i> Thêm sản phẩm đầu tiên
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>
</body>
</html>
