<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Danh Mục Mới - Admin Dashboard</title>
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
                <i class="bi bi-plus-circle text-primary me-2"></i>Thêm Danh Mục Mới
            </h2>
            <p class="text-muted small mb-0">Tạo danh mục phân loại sản phẩm mới trong cơ sở dữ liệu JPA</p>
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
        <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
            <div class="row g-4">
                <div class="col-md-12">
                    <label class="form-label fw-bold text-dark">Tên Danh Mục *</label>
                    <input type="text" name="name" value="${name}" class="form-control rounded-3" placeholder="Ví dụ: Điện thoại thông minh, Laptop, Thời trang..." required minlength="2" maxlength="100" autofocus>
                </div>

                <div class="col-md-8">
                    <label class="form-label fw-bold text-dark">Ảnh Đại Diện Danh Mục (Icon / Image)</label>
                    <input type="file" name="icon" id="fileInput" class="form-control rounded-3" accept="image/*" onchange="previewCategoryImg(event)">
                    <small class="text-muted mt-1 d-block">Hỗ trợ định dạng ảnh JPG, PNG, WEBP. Ảnh tải lên tự động lưu vào upload/category.</small>
                </div>

                <div class="col-md-4 text-center">
                    <label class="form-label fw-bold text-dark d-block">Xem Trước Ảnh</label>
                    <div style="width: 140px; height: 100px; border-radius: 10px; border: 2px dashed #cbd5e1; background: #f8fafc; margin: 0 auto; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                        <img id="imgPreview" src="https://placehold.co/140x100?text=Preview" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Preview">
                    </div>
                </div>

                <div class="col-12 d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-primary fw-bold px-4 py-2 rounded-3">
                        <i class="bi bi-save me-1"></i> Thêm Danh Mục
                    </button>
                    <button type="reset" class="btn btn-light px-4 py-2 rounded-3" onclick="document.getElementById('imgPreview').src='https://placehold.co/140x100?text=Preview'">
                        <i class="bi bi-arrow-counterclockwise me-1"></i> Nhập Lại
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