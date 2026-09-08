<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm - Shopping Store</title>
    <style>
        /* ===== PRODUCT LIST PAGE ===== */

        /* Page Header */
        .pl-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 24px; flex-wrap: wrap; gap: 12px;
        }
        .pl-title { font-size: 24px; font-weight: 900; color: #0f172a; margin-bottom: 3px; }
        .pl-sub { font-size: 13px; color: #64748b; }

        .product-count-badge {
            display: inline-flex; align-items: center; gap: 7px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff; font-size: 13.5px; font-weight: 800;
            padding: 8px 18px; border-radius: 99px;
            box-shadow: 0 4px 14px rgba(37,99,235,0.3);
        }

        /* Category Chip Bar */
        .category-chip-bar {
            display: flex; gap: 8px; flex-wrap: wrap;
            margin-bottom: 28px;
        }
        .cate-chip {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 18px;
            border-radius: 99px;
            font-size: 13.5px; font-weight: 700;
            text-decoration: none; transition: all 0.22s;
            border: 1.5px solid #e2e8f0;
            background: #fff; color: #475569;
        }
        .cate-chip:hover { border-color: #2563eb; color: #2563eb; background: #eff6ff; transform: translateY(-1px); }
        .cate-chip.active { background: #2563eb; color: #fff; border-color: #2563eb; box-shadow: 0 4px 14px rgba(37,99,235,0.3); }

        /* Product Card */
        .product-card-v2 {
            background: #ffffff; border: 1px solid #e2e8f0; border-radius: 20px;
            overflow: hidden; transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
            height: 100%; display: flex; flex-direction: column; position: relative;
        }
        .product-card-v2:hover { transform: translateY(-8px); box-shadow: 0 20px 48px rgba(37,99,235,0.13); border-color: #bfdbfe; }

        .product-img-box {
            position: relative; height: 220px;
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            overflow: hidden; display: flex; align-items: center; justify-content: center;
        }
        .product-img-main { max-height: 100%; max-width: 100%; object-fit: cover; transition: transform 0.4s cubic-bezier(0.4,0,0.2,1); }
        .product-card-v2:hover .product-img-main { transform: scale(1.09); }

        .product-overlay {
            position: absolute; inset: 0; background: rgba(15,23,42,0.42);
            display: flex; align-items: center; justify-content: center;
            opacity: 0; transition: opacity 0.28s;
        }
        .product-card-v2:hover .product-overlay { opacity: 1; }
        .product-overlay-btn {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 10px 20px; background: #fff; color: #1d4ed8;
            font-size: 13.5px; font-weight: 800; border-radius: 10px; text-decoration: none;
            box-shadow: 0 4px 14px rgba(0,0,0,0.22);
            transform: translateY(10px); transition: transform 0.28s;
        }
        .product-card-v2:hover .product-overlay-btn { transform: translateY(0); }

        .product-badge {
            position: absolute; top: 12px; left: 12px;
            font-size: 11px; font-weight: 800;
            padding: 4px 10px; border-radius: 99px; text-transform: uppercase;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .badge-new { background: #2563eb; color: #fff; }
        .badge-hot { background: #ef4444; color: #fff; }

        .product-info { padding: 16px 18px; flex-grow: 1; display: flex; flex-direction: column; }
        .product-category-tag {
            display: inline-flex; align-items: center; gap: 4px;
            background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe;
            font-size: 11.5px; font-weight: 700; padding: 3px 10px; border-radius: 99px; margin-bottom: 8px;
        }
        .product-name {
            font-size: 15px; font-weight: 800; color: #0f172a; margin-bottom: 6px;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
            text-decoration: none; line-height: 1.4;
        }
        .product-name:hover { color: #2563eb; }
        .product-rating { color: #f59e0b; font-size: 12px; display: flex; align-items: center; gap: 3px; margin-bottom: 6px; }
        .product-rating-count { font-size: 11px; color: #94a3b8; margin-left: 4px; }
        .product-desc {
            font-size: 13px; color: #64748b; flex-grow: 1; line-height: 1.5;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
            margin-bottom: 14px;
        }
        .product-footer {
            display: flex; align-items: center; justify-content: space-between;
            padding-top: 12px; border-top: 1px solid #f1f5f9;
        }
        .product-price { font-size: 19px; font-weight: 900; color: #2563eb; }
        .btn-product-detail {
            display: inline-flex; align-items: center; gap: 5px; padding: 8px 16px;
            background: linear-gradient(135deg, #2563eb, #7c3aed); color: #fff;
            font-size: 13px; font-weight: 700; border-radius: 9px; text-decoration: none;
            transition: all 0.2s; box-shadow: 0 3px 10px rgba(37,99,235,0.28);
        }
        .btn-product-detail:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(37,99,235,0.38); color: #fff; }

        /* Empty State */
        .empty-state { text-align: center; padding: 64px 24px; background: #fff; border-radius: 20px; border: 2px dashed #e2e8f0; }

        /* Pagination */
        .pagination-custom { display: flex; justify-content: center; gap: 6px; margin-top: 40px; flex-wrap: wrap; }
        .page-btn {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 9px 16px; border-radius: 10px;
            font-size: 14px; font-weight: 700;
            text-decoration: none; transition: all 0.2s;
            border: 1.5px solid #e2e8f0; background: #fff; color: #475569;
        }
        .page-btn:hover { border-color: #2563eb; color: #2563eb; background: #eff6ff; }
        .page-btn.active { background: #2563eb; color: #fff; border-color: #2563eb; box-shadow: 0 4px 12px rgba(37,99,235,0.3); }
        .page-btn.disabled { opacity: 0.45; pointer-events: none; }

        @media (max-width: 576px) {
            .pl-header { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body>
<div class="container py-4">

    <!-- Page Header -->
    <div class="pl-header">
        <div>
            <h1 class="pl-title"><i class="bi bi-grid-3x3-gap-fill text-primary me-2"></i>Tất Cả Sản Phẩm</h1>
            <p class="pl-sub">Hiển thị <strong>6 sản phẩm / trang</strong> bằng JPA Pagination &bull; OFFSET / LIMIT</p>
        </div>
        <span class="product-count-badge">
            <i class="bi bi-box-seam"></i> ${totalProducts} sản phẩm
        </span>
    </div>

    <!-- Category Chips Bar -->
    <div class="category-chip-bar">
        <a href="${pageContext.request.contextPath}/product"
           class="cate-chip ${empty selectedCateId ? 'active' : ''}">
            <i class="bi bi-grid-fill"></i> Tất cả
        </a>
        <c:forEach items="${categories}" var="c">
            <a href="${pageContext.request.contextPath}/product?cateId=${c.categoryId}"
               class="cate-chip ${selectedCateId == c.categoryId ? 'active' : ''}">
                <i class="bi bi-tag-fill"></i> ${c.categoryname}
            </a>
        </c:forEach>
    </div>

    <!-- Product Grid -->
    <div class="row g-4 mb-5">
        <c:choose>
            <c:when test="${not empty productList}">
                <c:forEach items="${productList}" var="p" varStatus="loop">
                    <div class="col-lg-4 col-md-6">
                        <div class="product-card-v2">
                            <div class="product-img-box">
                                <c:choose>
                                    <c:when test="${loop.index < 2}">
                                        <span class="product-badge badge-hot">🔥 HOT</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="product-badge badge-new">✨ NEW</span>
                                    </c:otherwise>
                                </c:choose>

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
                                        <div style="font-size:72px; color:#e2e8f0;">📦</div>
                                    </c:otherwise>
                                </c:choose>

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
                                <div class="product-rating">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-half"></i>
                                    <span class="product-rating-count">(${p.productId + 10})</span>
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
                        <div style="font-size:64px; margin-bottom:16px;">📦</div>
                        <h3 style="font-size:18px; color:#475569; font-weight:800; margin-bottom:8px;">Không tìm thấy sản phẩm</h3>
                        <p style="color:#94a3b8; font-size:14px;">Hãy thử chọn danh mục khác hoặc quay lại trang chủ.</p>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-primary mt-3">Xem tất cả</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="pagination-custom">
            <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}"
               class="page-btn ${currentPage <= 1 ? 'disabled' : ''}">
                <i class="bi bi-chevron-left"></i> Trước
            </a>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${pageContext.request.contextPath}/product?page=${i}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}"
                   class="page-btn ${currentPage == i ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}"
               class="page-btn ${currentPage >= totalPages ? 'disabled' : ''}">
                Sau <i class="bi bi-chevron-right"></i>
            </a>
        </div>
        <p style="text-align:center; font-size:13px; color:#94a3b8; margin-top:12px;">
            Trang <strong>${currentPage}</strong> / ${totalPages} &bull; Tổng ${totalProducts} sản phẩm
        </p>
    </c:if>

</div>
</body>
</html>
