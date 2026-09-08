<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Chi Tiết Sản Phẩm</title>
    <style>
        /* ===== PRODUCT DETAIL PAGE ===== */

        /* Breadcrumb */
        .breadcrumb-custom {
            display: flex; align-items: center; gap: 6px;
            font-size: 13px; color: #94a3b8;
            margin-bottom: 28px; flex-wrap: wrap;
        }
        .breadcrumb-custom a { color: #2563eb; text-decoration: none; font-weight: 600; }
        .breadcrumb-custom a:hover { text-decoration: underline; }
        .breadcrumb-custom .sep { color: #e2e8f0; }
        .breadcrumb-current { color: #64748b; font-weight: 600; }

        /* Product Detail Card */
        .product-detail-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(15,23,42,0.07);
            margin-bottom: 40px;
        }

        /* Image Section */
        .product-img-section {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            padding: 32px;
            display: flex; align-items: center; justify-content: center;
            min-height: 400px;
            position: relative;
            overflow: hidden;
        }
        .product-main-img {
            max-height: 360px; max-width: 100%;
            object-fit: contain;
            transition: transform 0.4s cubic-bezier(0.4,0,0.2,1);
            cursor: zoom-in;
        }
        .product-main-img:hover { transform: scale(1.06); }
        .product-img-placeholder {
            font-size: 100px; color: #e2e8f0;
        }

        /* Category ribbon */
        .img-category-ribbon {
            position: absolute; top: 20px; left: 20px;
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(37,99,235,0.9);
            color: #fff; font-size: 12px; font-weight: 800;
            padding: 5px 14px; border-radius: 99px;
            backdrop-filter: blur(8px);
        }

        /* Info Section */
        .product-info-section {
            padding: 36px 40px;
        }

        .product-category-tag {
            display: inline-flex; align-items: center; gap: 6px;
            background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe;
            font-size: 12.5px; font-weight: 700; padding: 5px 14px; border-radius: 99px;
            margin-bottom: 14px;
        }
        .product-title {
            font-size: 30px; font-weight: 900; color: #0f172a;
            letter-spacing: -0.5px; margin-bottom: 12px; line-height: 1.2;
        }

        /* Rating Row */
        .product-meta-row {
            display: flex; align-items: center; gap: 16px;
            margin-bottom: 20px; flex-wrap: wrap;
        }
        .rating-stars { color: #f59e0b; font-size: 15px; display: flex; align-items: center; gap: 3px; }
        .rating-count { font-size: 13px; color: #64748b; font-weight: 600; }
        .stock-badge {
            display: inline-flex; align-items: center; gap: 5px;
            background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0;
            font-size: 12.5px; font-weight: 700; padding: 4px 12px; border-radius: 99px;
        }

        /* Price */
        .product-price-block { margin-bottom: 24px; }
        .price-label { font-size: 12px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.07em; margin-bottom: 4px; }
        .price-value { font-size: 40px; font-weight: 900; color: #2563eb; letter-spacing: -1px; }

        /* Divider */
        .info-divider { height: 1px; background: #f1f5f9; margin: 20px 0; }

        /* Description */
        .desc-label { font-size: 13px; font-weight: 800; color: #0f172a; text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 10px; }
        .desc-text { font-size: 15px; color: #475569; line-height: 1.75; }

        /* Action Buttons */
        .action-row { display: flex; gap: 12px; margin-top: 28px; flex-wrap: wrap; }
        .btn-back {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 13px 22px; border-radius: 12px;
            font-size: 14.5px; font-weight: 700; text-decoration: none;
            background: #f1f5f9; color: #475569; border: 1.5px solid #e2e8f0;
            transition: all 0.22s;
        }
        .btn-back:hover { background: #e2e8f0; color: #0f172a; }
        .btn-add-cart {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 13px 28px; border-radius: 12px;
            font-size: 14.5px; font-weight: 800;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff; border: none; cursor: pointer;
            box-shadow: 0 6px 20px rgba(37,99,235,0.35);
            transition: all 0.25s; font-family: inherit;
        }
        .btn-add-cart:hover { transform: translateY(-2px); box-shadow: 0 10px 28px rgba(37,99,235,0.45); }
        .btn-wishlist {
            display: inline-flex; align-items: center; justify-content: center;
            width: 50px; height: 50px; border-radius: 12px;
            background: #fef2f2; color: #dc2626; border: 1.5px solid #fecaca;
            font-size: 20px; cursor: pointer; transition: all 0.22s;
        }
        .btn-wishlist:hover { background: #dc2626; color: #fff; border-color: #dc2626; }

        /* Related Products */
        .related-section { margin-top: 16px; }
        .related-title {
            font-size: 20px; font-weight: 900; color: #0f172a;
            margin-bottom: 20px; display: flex; align-items: center; gap: 8px;
        }

        .related-card {
            background: #fff; border: 1px solid #e2e8f0; border-radius: 16px;
            overflow: hidden; transition: all 0.25s; text-decoration: none;
            display: block;
        }
        .related-card:hover { transform: translateY(-5px); box-shadow: 0 12px 32px rgba(37,99,235,0.12); border-color: #bfdbfe; }

        .related-img-box {
            height: 160px; background: #f8fafc;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden;
        }
        .related-img { max-height: 100%; max-width: 100%; object-fit: cover; transition: transform 0.3s; }
        .related-card:hover .related-img { transform: scale(1.06); }

        .related-info { padding: 14px; }
        .related-name { font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 4px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .related-price { font-size: 15px; font-weight: 900; color: #2563eb; }

        @media (max-width: 768px) {
            .product-info-section { padding: 24px 20px; }
            .product-title { font-size: 22px; }
            .price-value { font-size: 30px; }
            .action-row { flex-direction: column; }
        }
    </style>
</head>
<body>
<div class="container py-4">

    <!-- Breadcrumb -->
    <nav class="breadcrumb-custom" aria-label="breadcrumb">
        <a href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door-fill"></i> Trang chủ</a>
        <span class="sep">/</span>
        <a href="${pageContext.request.contextPath}/product"><i class="bi bi-grid-fill"></i> Sản phẩm</a>
        <span class="sep">/</span>
        <span class="breadcrumb-current">${product.productName}</span>
    </nav>

    <!-- Product Detail Card -->
    <div class="product-detail-card">
        <div class="row g-0">
            <!-- Image Column -->
            <div class="col-lg-5">
                <div class="product-img-section">
                    <span class="img-category-ribbon">
                        <i class="bi bi-tag-fill"></i> ${product.category.categoryname}
                    </span>

                    <c:choose>
                        <c:when test="${not empty product.images}">
                            <c:choose>
                                <c:when test="${product.images.startsWith('http')}">
                                    <img src="${product.images}" class="product-main-img" alt="${product.productName}" title="Hover để zoom">
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${product.images}" var="pImg"/>
                                    <img src="${pImg}" class="product-main-img" alt="${product.productName}" title="Hover để zoom">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="product-img-placeholder">📦</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Info Column -->
            <div class="col-lg-7">
                <div class="product-info-section">

                    <span class="product-category-tag">
                        <i class="bi bi-tag-fill"></i> ${product.category.categoryname}
                    </span>

                    <h1 class="product-title">${product.productName}</h1>

                    <!-- Meta Row: Rating + Stock -->
                    <div class="product-meta-row">
                        <div class="rating-stars">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                            <span class="rating-count ms-1">4.5 (${product.productId + 18} đánh giá)</span>
                        </div>
                        <span class="stock-badge">
                            <i class="bi bi-check-circle-fill"></i> Còn hàng
                        </span>
                    </div>

                    <!-- Price -->
                    <div class="product-price-block">
                        <div class="price-label">Giá bán lẻ</div>
                        <div class="price-value">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ"/>
                        </div>
                    </div>

                    <div class="info-divider"></div>

                    <!-- Description -->
                    <div>
                        <div class="desc-label"><i class="bi bi-file-text-fill text-primary me-2"></i>Mô tả sản phẩm</div>
                        <p class="desc-text">
                            ${not empty product.description ? product.description : 'Sản phẩm chính hãng chất lượng cao, bảo hành uy tín tại hệ thống Shopping Store. Giao hàng nhanh trong vòng 24 - 48 giờ.'}
                        </p>
                    </div>

                    <div class="info-divider"></div>

                    <!-- Product ID info -->
                    <div style="font-size:13px; color:#94a3b8; font-weight:600; margin-bottom:8px;">
                        Mã sản phẩm: <strong>#${product.productId}</strong> &bull;
                        Danh mục: <strong>${product.category.categoryname}</strong>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-row">
                        <a href="${pageContext.request.contextPath}/product" class="btn-back">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách
                        </a>
                        <button class="btn-add-cart" onclick="showCartToast()">
                            <i class="bi bi-cart-plus-fill"></i> Thêm vào giỏ hàng
                        </button>
                        <button class="btn-wishlist" title="Yêu thích" onclick="this.innerHTML='<i class=\'bi bi-heart-fill\'></i>'">
                            <i class="bi bi-heart"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- RELATED PRODUCTS -->
    <c:if test="${not empty sameCategoryProducts}">
        <div class="related-section">
            <h2 class="related-title">
                <i class="bi bi-boxes text-primary"></i> Sản phẩm cùng danh mục
            </h2>
            <div class="row g-3">
                <c:forEach items="${sameCategoryProducts}" var="sp">
                    <c:if test="${sp.productId != product.productId}">
                        <div class="col-lg-3 col-md-4 col-6">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${sp.productId}" class="related-card">
                                <div class="related-img-box">
                                    <c:choose>
                                        <c:when test="${not empty sp.images}">
                                            <c:choose>
                                                <c:when test="${sp.images.startsWith('http')}">
                                                    <img src="${sp.images}" class="related-img" alt="${sp.productName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="/image?fname=${sp.images}" var="sImg"/>
                                                    <img src="${sImg}" class="related-img" alt="${sp.productName}">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="font-size:52px; color:#e2e8f0;">📦</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="related-info">
                                    <div class="related-name" title="${sp.productName}">${sp.productName}</div>
                                    <div class="related-price">
                                        <fmt:formatNumber value="${sp.price}" type="currency" currencySymbol="đ"/>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>

</div>

<!-- Toast notification (Add to cart) -->
<div id="cartToast" style="
    position: fixed; bottom: 28px; right: 28px;
    background: #0f172a; color: #fff;
    padding: 14px 22px; border-radius: 14px;
    font-size: 14px; font-weight: 700;
    display: flex; align-items: center; gap: 10px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.25);
    transform: translateY(80px); opacity: 0;
    transition: all 0.35s cubic-bezier(0.34,1.2,0.64,1);
    z-index: 9999;
">
    <i class="bi bi-cart-check-fill" style="color:#10b981; font-size:20px;"></i>
    Đã thêm vào giỏ hàng! (UI Demo)
</div>

<script>
    function showCartToast() {
        const toast = document.getElementById('cartToast');
        toast.style.transform = 'translateY(0)';
        toast.style.opacity = '1';
        setTimeout(() => {
            toast.style.transform = 'translateY(80px)';
            toast.style.opacity = '0';
        }, 2800);
    }
</script>
</body>
</html>
