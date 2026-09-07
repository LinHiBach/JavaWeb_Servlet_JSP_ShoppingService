<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Chi Tiết Sản Phẩm</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        .detail-card {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 12px 35px rgba(0, 80, 200, 0.08);
            overflow: hidden;
        }

        .product-large-img-wrapper {
            background: #f8fafc;
            border-radius: 16px;
            height: 380px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .product-large-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }

        .price-highlight {
            font-size: 32px;
            font-weight: 800;
            color: #0077ff;
        }
    </style>
</head>
<body>

    <div class="container py-4">

        <!-- BREADCRUMB -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <!-- PRODUCT DETAIL CARD -->
        <div class="detail-card p-4 p-md-5 mb-5">
            <div class="row g-4 align-items-center">

                <!-- IMAGE COLUMN -->
                <div class="col-lg-5">
                    <div class="product-large-img-wrapper">
                        <c:choose>
                            <c:when test="${not empty product.images}">
                                <c:choose>
                                    <c:when test="${product.images.startsWith('http')}">
                                        <img src="${product.images}" class="product-large-img" alt="${product.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${product.images}" var="pImg"/>
                                        <img src="${pImg}" class="product-large-img" alt="${product.productName}">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/400x380?text=No+Image" class="product-large-img" alt="${product.productName}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- INFO COLUMN -->
                <div class="col-lg-7 ps-lg-4">
                    <span class="badge bg-light text-primary border mb-2 px-3 py-2 fs-6">
                        <i class="bi bi-tag-fill me-1"></i> ${product.category.categoryname}
                    </span>
                    <h2 class="fw-extrabold text-dark mb-3" style="font-size: 30px;">${product.productName}</h2>

                    <div class="price-highlight mb-4">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ"/>
                    </div>

                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-file-text-fill text-primary me-2"></i>Mô Tả Sản Phẩm</h6>
                    <p class="text-muted leading-relaxed mb-4 fs-6">
                        ${not empty product.description ? product.description : 'Sản phẩm chính hãng cao cấp, bảo hành uy tín tại hệ thống Shopping Store.'}
                    </p>

                    <div class="d-flex gap-3 pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-lg rounded-3 fw-semibold">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
                        </a>
                        <button class="btn btn-primary btn-lg rounded-3 fw-bold px-4">
                            <i class="bi bi-cart-plus-fill me-1"></i> Mua ngay / Đặt hàng
                        </button>
                    </div>
                </div>

            </div>
        </div>

        <!-- SAME CATEGORY PRODUCTS RECOMMENDATION -->
        <c:if test="${not empty sameCategoryProducts}">
            <h5 class="fw-bold text-dark mb-3"><i class="bi bi-boxes text-primary me-2"></i>Sản phẩm cùng danh mục</h5>
            <div class="row g-3">
                <c:forEach items="${sameCategoryProducts}" var="sp">
                    <c:if test="${sp.productId != product.productId}">
                        <div class="col-md-3 col-6">
                            <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${sp.productId}" class="text-decoration-none">
                                    <div class="text-center p-3 bg-light" style="height: 140px;">
                                        <c:choose>
                                            <c:when test="${not empty sp.images}">
                                                <c:url value="/image?fname=${sp.images}" var="sImg"/>
                                                <img src="${sImg}" style="max-height: 100%; max-width: 100%;" alt="${sp.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/150" style="max-height: 100%;" alt="${sp.productName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="p-3">
                                        <h6 class="fw-bold text-dark text-truncate mb-1">${sp.productName}</h6>
                                        <span class="text-primary fw-bold small">
                                            <fmt:formatNumber value="${sp.price}" type="currency" currencySymbol="đ"/>
                                        </span>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>

    </div>

</body>
</html>
