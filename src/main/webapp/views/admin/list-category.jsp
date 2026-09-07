<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin Dashboard</title>
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
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold text-dark mb-1">
                <i class="bi bi-folder2-open text-primary me-2"></i>Quản Lý Danh Mục (Category CRUD)
            </h2>
            <p class="text-muted small mb-0">Hệ thống phân loại sản phẩm theo danh mục cơ sở dữ liệu JPA</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary fw-bold rounded-3">
            <i class="bi bi-plus-circle me-1"></i> Thêm Danh Mục Mới
        </a>
    </div>

    <!-- SEARCH & FILTER -->
    <div class="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="row g-2 align-items-center">
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control border-0 bg-light" placeholder="Nhập tên danh mục cần tìm kiếm...">
                    </div>
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <button type="submit" class="btn btn-primary flex-grow-1 fw-bold">Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary">Đặt lại</a>
                    </c:if>
                </div>
            </form>
        </div>
    </div>

    <!-- CATEGORY LIST TABLE -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr class="text-secondary small fw-bold">
                        <th class="ps-4" style="width: 80px;">STT</th>
                        <th style="width: 140px;">Hình Ảnh</th>
                        <th>Tên Danh Mục</th>
                        <th style="width: 150px;">Mã Danh Mục</th>
                        <th class="text-end pe-4" style="width: 180px;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty cateList}">
                            <c:forEach items="${cateList}" var="cate" varStatus="stt">
                                <tr>
                                    <td class="ps-4 fw-bold text-muted">#${stt.index + 1}</td>
                                    <td>
                                        <div style="width: 80px; height: 60px; border-radius: 8px; overflow: hidden; background: #f8fafc; display: flex; align-items: center; justify-content: center; border: 1px solid #e2e8f0;">
                                            <c:choose>
                                                <c:when test="${not empty cate.images}">
                                                    <c:choose>
                                                        <c:when test="${cate.images.startsWith('http')}">
                                                            <img src="${cate.images}" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Icon">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" style="max-width: 100%; max-height: 100%; object-fit: cover;" alt="Icon">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-image text-muted fs-4"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark fs-6">
                                            ${not empty cate.name ? cate.name : cate.categoryname}
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-secondary border px-2 py-1">ID: ${cate.categoryId}</span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}" class="btn btn-outline-primary btn-sm rounded-2 me-1" title="Chỉnh sửa">
                                            <i class="bi bi-pencil-square me-1"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryId}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${not empty cate.name ? cate.name : cate.categoryname}] không?');" 
                                           class="btn btn-outline-danger btn-sm rounded-2" title="Xóa">
                                            <i class="bi bi-trash me-1"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Không tìm thấy danh mục nào trong hệ thống!
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>