<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm - Admin Dashboard</title>
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
            <h2 class="fw-bold text-dark mb-1"><i class="bi bi-pencil-square text-warning me-2"></i>Chỉnh Sửa Sản Phẩm #${product.productId}</h2>
            <p class="text-muted small mb-0">Cập nhật thông tin giá, danh mục và tải ảnh mới nếu cần</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-light fw-bold rounded-3">
            <i class="bi bi-arrow-left me-1"></i> Quay Lại Danh Sách
        </a>
    </div>

    <div class="card border-0 shadow-sm rounded-4 p-4">
        <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${product.productId}">

            <div class="row g-3">
                <div class="col-md-8">
                    <label class="form-label fw-bold text-dark">Tên Sản Phẩm *</label>
                    <input type="text" name="productName" value="${product.productName}" class="form-control rounded-3" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label fw-bold text-dark">Giá Bán (VNĐ) *</label>
                    <input type="number" step="1000" name="price" value="${product.price}" class="form-control rounded-3" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold text-dark">Danh Mục Sản Phẩm *</label>
                    <select name="categoryId" class="form-select rounded-3" required>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.categoryId}" <c:if test="${product.category.categoryId == c.categoryId}">selected</c:if>>${c.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold text-dark">Hình Ảnh Hiện Tại / Tải Ảnh Mới</label>
                    <div class="d-flex align-items-center gap-3">
                        <c:if test="${not empty product.images}">
                            <c:url value="/image?fname=${product.images}" var="pImg"/>
                            <img src="${pImg}" width="50" height="50" class="rounded-3 border object-fit-cover" alt="Current Image">
                        </c:if>
                        <input type="file" name="images" accept="image/*" class="form-control rounded-3">
                    </div>
                </div>

                <div class="col-12">
                    <label class="form-label fw-bold text-dark">Mô Tả Sản Phẩm</label>
                    <textarea name="description" rows="4" class="form-control rounded-3">${product.description}</textarea>
                </div>

                <div class="col-12 text-end pt-3">
                    <button type="submit" class="btn btn-warning btn-lg rounded-3 fw-bold px-4 text-white">
                        <i class="bi bi-floppy-fill me-1"></i> Cập Nhật Thay Đổi
                    </button>
                </div>
            </div>
        </form>
    </div>

</body>
</html>
