<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Shopping Store MVC</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #0077ff 0%, #0055dd 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0, 119, 255, 0.2);
        }

        .product-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 35px rgba(0, 80, 200, 0.12);
        }

        .product-img-wrapper {
            position: relative;
            height: 200px;
            background: #f8fafc;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .product-card:hover .product-img {
            transform: scale(1.08);
        }

        .badge-new {
            position: absolute;
            top: 12px;
            left: 12px;
            background: #ff4757;
            color: #ffffff;
            font-size: 11px;
            font-weight: 800;
            padding: 4px 10px;
            border-radius: 20px;
            text-transform: uppercase;
        }

        .price-text {
            color: #0077ff;
            font-weight: 800;
            font-size: 18px;
        }
    </style>
</head>
<body>

    <div class="container py-4">

        <!-- HERO BANNER -->
        <div class="hero-banner d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <span class="badge bg-white text-primary fw-bold px-3 py-2 mb-2">🔥 Khuyến Mãi Hot</span>
                <h2 class="fw-extrabold fs-1 mb-2">Chào mừng đến với Shopping Store</h2>
                <p class="text-white-50 fs-6 mb-0">Khám phá 10 sản phẩm mới nhất được cập nhật liên tục từ hệ thống CSDL JPA!</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-light btn-lg rounded-3 fw-bold text-primary shadow">
                    <i class="bi bi-grid-fill me-1"></i> Xem Tất Cả Sản Phẩm (/product)
                </a>
            </div>
        </div>

        <!-- USER PROFILE QUICK CARD -->
        <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                <div class="d-flex align-items-center gap-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account.avatar}">
                            <c:choose>
                                <c:when test="${sessionScope.account.avatar.startsWith('http')}">
                                    <img src="${sessionScope.account.avatar}" width="50" height="50" class="rounded-circle border" alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${sessionScope.account.avatar}" var="userAvt"/>
                                    <img src="${userAvt}" width="50" height="50" class="rounded-circle border" alt="Avatar">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullname}&background=0077ff&color=ffffff&bold=true" width="50" height="50" class="rounded-circle" alt="Avatar">
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <h6 class="fw-bold mb-0 text-dark">${sessionScope.account.fullname}</h6>
                        <span class="text-muted small">@${sessionScope.account.username} • SĐT: ${sessionScope.account.phone}</span>
                    </div>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-sm rounded-3 fw-semibold">
                        <i class="bi bi-pencil-square me-1"></i> Sửa Profile
                    </a>
                </div>
            </div>
        </div>

        <!-- SECTION: 10 SẢN PHẨM MỚI NHẤT -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1">
                    <i class="bi bi-stars text-warning me-2"></i>10 Sản Phẩm Mới Nhất
                </h4>
                <p class="text-muted small mb-0">Hiển thị các sản phẩm mới thêm vào CSDL</p>
            </div>
            <a href="${pageContext.request.contextPath}/product" class="text-primary text-decoration-none fw-semibold small">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty top10Products}">
                    <c:forEach items="${top10Products}" var="p">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none">
                                    <div class="product-img-wrapper">
                                        <span class="badge-new">NEW</span>
                                        <c:choose>
                                            <c:when test="${not empty p.images}">
                                                <c:choose>
                                                    <c:when test="${p.images.startsWith('http')}">
                                                        <img src="${p.images}" class="product-img" alt="${p.productName}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url value="/image?fname=${p.images}" var="pImg"/>
                                                        <img src="${pImg}" class="product-img" alt="${p.productName}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/300x200?text=No+Image" class="product-img" alt="${p.productName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </a>
                                <div class="p-3 d-flex flex-column flex-grow-1">
                                    <span class="badge bg-light text-primary border me-auto mb-2 small">${p.category.categoryname}</span>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark">
                                        <h6 class="fw-bold text-truncate mb-2" title="${p.productName}">${p.productName}</h6>
                                    </a>
                                    <p class="text-muted small text-truncate-2 mb-3 flex-grow-1">${p.description}</p>
                                    <div class="d-flex align-items-center justify-content-between pt-2 border-top">
                                        <span class="price-text">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                        </span>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-primary btn-sm rounded-3 fw-bold">
                                            Chi tiết <i class="bi bi-arrow-right-short"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-box-seam fs-1 text-muted"></i>
                        <p class="text-muted mt-2">Chưa có sản phẩm nào trong CSDL.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</body>
</html>
