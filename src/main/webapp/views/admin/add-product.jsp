<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới - Admin Dashboard</title>
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
            <h2 class="fw-bold text-dark mb-1"><i class="bi bi-plus-circle text-primary me-2"></i>Thêm Sản Phẩm Mới</h2>
            <p class="text-muted small mb-0">Tạo mới sản phẩm và tải ảnh minh họa bằng Multipart Upload</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-light fw-bold rounded-3">
            <i class="bi bi-arrow-left me-1"></i> Quay Lại Danh Sách
        </a>
    </div>

    <!-- ERROR ALERT -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3 d-flex align-items-center gap-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill text-danger fs-4"></i>
            <div>
                <strong class="d-block text-dark">Lỗi thao tác!</strong>
                <span class="text-muted small">${error}</span>
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-4 p-4">
        <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
            <div class="row g-3">
                <div class="col-md-8">
                    <label class="form-label fw-bold text-dark">Tên Sản Phẩm *</label>
                    <input type="text" name="productName" value="${productName}" class="form-control rounded-3" placeholder="Nhập tên sản phẩm..." minlength="2" maxlength="200" required autofocus>
                </div>

                <div class="col-md-4">
                    <label class="form-label fw-bold text-dark">Giá Bán (VNĐ) *</label>
                    <input type="number" step="1000" min="1" name="price" value="${price}" class="form-control rounded-3" placeholder="Ví dụ: 250000" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold text-dark">Danh Mục Sản Phẩm *</label>
                    <select name="categoryId" class="form-select rounded-3" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.categoryId}" <c:if test="${categoryId == c.categoryId}">selected</c:if>>${c.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold text-dark">Hình Ảnh Sản Phẩm (Multipart File)</label>
                    <input type="file" name="images" accept="image/*" class="form-control rounded-3">
                </div>

                <div class="col-12">
                    <label class="form-label fw-bold text-dark">Mô Tả Sản Phẩm</label>
                    <textarea name="description" rows="4" class="form-control rounded-3" placeholder="Nhập thông tin mô tả chi tiết sản phẩm...">${description}</textarea>
                </div>

                <div class="col-12 text-end pt-3">
                    <button type="submit" class="btn btn-primary btn-lg rounded-3 fw-bold px-4">
                        <i class="bi bi-floppy-fill me-1"></i> Lưu Sản Phẩm Mới
                    </button>
                </div>
            </div>
        </form>
    </div>

</body>
</html>
