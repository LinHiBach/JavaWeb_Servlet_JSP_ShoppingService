<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin Dashboard</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1"><i class="bi bi-box-seam text-primary me-2"></i>Quản Lý Sản Phẩm (Product CRUD)</h2>
            <p class="text-muted small mb-0">Quản lý danh sách sản phẩm, giá, ảnh và danh mục tương ứng</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary fw-bold rounded-3">
            <i class="bi bi-plus-circle me-1"></i> Thêm Sản Phẩm Mới
        </a>
    </div>

    <!-- SEARCH & FILTER -->
    <div class="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/admin/product/list" method="get" class="row g-2 align-items-center">
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control border-0 bg-light" placeholder="Nhập tên sản phẩm cần tìm...">
                    </div>
                </div>
                <div class="col-md-3 text-end">
                    <button type="submit" class="btn btn-primary w-100 fw-bold">Tìm kiếm</button>
                </div>
            </form>
        </div>
    </div>

    <!-- TABLE PRODUCT LIST -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Giá Bán</th>
                            <th>Danh Mục</th>
                            <th>Mô Tả</th>
                            <th class="text-end pe-4">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty productList}">
                                <c:forEach items="${productList}" var="p">
                                    <tr>
                                        <td class="ps-4 fw-bold text-muted">#${p.productId}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.images}">
                                                    <c:choose>
                                                        <c:when test="${p.images.startsWith('http')}">
                                                            <img src="${p.images}" width="50" height="50" class="rounded-3 border object-fit-cover" alt="${p.productName}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:url value="/image?fname=${p.images}" var="pImg"/>
                                                            <img src="${pImg}" width="50" height="50" class="rounded-3 border object-fit-cover" alt="${p.productName}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/50" width="50" height="50" class="rounded-3 border" alt="${p.productName}">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><strong class="text-dark">${p.productName}</strong></td>
                                        <td class="fw-bold text-primary">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                        </td>
                                        <td><span class="badge bg-light text-primary border">${p.category.categoryname}</span></td>
                                        <td class="text-muted small text-truncate" style="max-width: 200px;">${p.description}</td>
                                        <td class="text-end pe-4">
                                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-outline-warning btn-sm fw-semibold me-1">
                                                <i class="bi bi-pencil-fill"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" class="btn btn-outline-danger btn-sm fw-semibold" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                <i class="bi bi-trash-fill"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">Không tìm thấy sản phẩm nào.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
