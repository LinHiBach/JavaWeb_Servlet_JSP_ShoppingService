<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm (Phân Trang 6sp/trang) - Shopping Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
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
            height: 210px;
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

        .price-text {
            color: #0077ff;
            font-weight: 800;
            font-size: 19px;
        }

        .cate-filter-btn {
            border-radius: 20px;
            padding: 6px 18px;
            font-weight: 600;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <div class="container py-4">

        <!-- HEADER BANNER -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="bi bi-grid-3x3-gap-fill text-primary me-2"></i>Tất Cả Sản Phẩm (/product)
                </h3>
                <p class="text-muted small mb-0">Hiển thị tất cả sản phẩm được phân trang <strong>6 sản phẩm / trang</strong> bằng JPA Pagination</p>
            </div>
            <div>
                <span class="badge bg-primary fs-6 px-3 py-2 rounded-3">Tổng số: ${totalProducts} sản phẩm</span>
            </div>
        </div>

        <!-- CATEGORY FILTER BUTTONS -->
        <div class="mb-4 pb-2 border-bottom d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/product" class="btn ${empty selectedCateId ? 'btn-primary' : 'btn-outline-secondary'} cate-filter-btn">
                Tất cả
            </a>
            <c:forEach items="${categories}" var="c">
                <a href="${pageContext.request.contextPath}/product?cateId=${c.categoryId}" class="btn ${selectedCateId == c.categoryId ? 'btn-primary' : 'btn-outline-secondary'} cate-filter-btn">
                    ${c.categoryname}
                </a>
            </c:forEach>
        </div>

        <!-- PRODUCT GRID (6 PRODUCTS PER PAGE) -->
        <div class="row g-4 mb-5">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach items="${productList}" var="p">
                        <div class="col-lg-4 col-md-6">
                            <div class="product-card">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none">
                                    <div class="product-img-wrapper">
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
                                <div class="p-4 d-flex flex-column flex-grow-1">
                                    <span class="badge bg-light text-primary border me-auto mb-2 small">${p.category.categoryname}</span>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none text-dark">
                                        <h5 class="fw-bold text-truncate mb-2" title="${p.productName}">${p.productName}</h5>
                                    </a>
                                    <p class="text-muted small text-truncate-2 mb-3 flex-grow-1">${p.description}</p>
                                    <div class="d-flex align-items-center justify-content-between pt-3 border-top">
                                        <span class="price-text">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                        </span>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-primary rounded-3 fw-bold px-3">
                                            Xem chi tiết <i class="bi bi-arrow-right-short"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-inbox fs-1 text-muted"></i>
                        <p class="text-muted mt-2">Không tìm thấy sản phẩm nào ở trang này.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- PAGINATION CONTROLS (6 ITEMS / PAGE) -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <!-- Previous Page -->
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-3 me-1" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}" aria-label="Previous">
                            <i class="bi bi-chevron-left"></i> Trang trước
                        </a>
                    </li>

                    <!-- Page Numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link rounded-3 mx-1 fw-bold" href="${pageContext.request.contextPath}/product?page=${i}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Next Page -->
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link rounded-3 ms-1" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}${not empty selectedCateId ? '&cateId='.concat(selectedCateId) : ''}" aria-label="Next">
                            Trang sau <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

    </div>

</body>
</html>
