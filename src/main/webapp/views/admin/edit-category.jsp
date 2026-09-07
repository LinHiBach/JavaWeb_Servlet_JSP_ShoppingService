<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Danh Mục - Admin Dashboard</title>
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

    <!-- PAGE HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1">
                <i class="bi bi-pencil-square text-primary me-2"></i>Chỉnh Sửa Danh Mục
            </h2>
            <p class="text-muted small mb-0">Cập nhật thông tin danh mục ID #${not empty category.categoryId ? category.categoryId : category.id}</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-light fw-bold rounded-3">
            <i class="bi bi-arrow-left me-1"></i> Quay Lại Danh Sách
        </a>
    </div>

    <!-- ERROR ALERT -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 px-3 mb-4 rounded-3 shadow-sm">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
        </div>
    </c:if>

    <!-- FORM CARD -->
    <div class="card border-0 shadow-sm rounded-4 p-4">
        <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${not empty category.categoryId ? category.categoryId : category.id}">

            <div class="row g-4">
                <div class="col-md-12">
                    <label class="form-label fw-bold text-dark">Tên Danh Mục *</label>
                    <input type="text" name="name" class="form-control rounded-3" value="${not empty category.name ? category.name : category.categoryname}" required minlength="2" maxlength="100" autofocus>
                </div>

                <div class="col-md-8">
                    <label class="form-label fw-bold text-dark">Thay Đổi Ảnh Đại Diện (Tùy chọn)</label>
                    <input type="file" name="icon" id="fileInput" class="form-control rounded-3" accept="image/*" onchange="previewCategoryImg(event)">
                    <small class="text-muted mt-1 d-block">Để trống nếu muốn giữ nguyên ảnh đại diện hiện tại.</small>
                </div>

                <div class="col-md-4 text-center">
                    <label class="form-label fw-bold text-dark d-block">Ảnh Hiện Tại / Mới</label>
                    <div style="width: 140px; height: 100px; border-radius: 10px; border: 2px dashed #cbd5e1; background: #f8fafc; margin: 0 auto; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                        <c:set var="catImg" value="${not empty category.images ? category.images : category.icon}"/>
                        <c:choose>
                            <c:when test="${not empty catImg}">
                                <c:choose>
                                    <c:when test="${catImg.startsWith('http')}">
                                        <img id="imgPreview" src="${catImg}" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Preview">
                                    </c:when>
                                    <c:otherwise>
                                        <img id="imgPreview" src="${pageContext.request.contextPath}/image?fname=${catImg}" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Preview">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img id="imgPreview" src="https://placehold.co/140x100?text=No+Image" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Preview">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-12 d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-primary fw-bold px-4 py-2 rounded-3">
                        <i class="bi bi-check2-circle me-1"></i> Lưu Thay Đổi
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary px-4 py-2 rounded-3">
                        Hủy Bỏ
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- Live Preview Script -->
    <script>
        function previewCategoryImg(event) {
            const input = event.target;
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imgPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>