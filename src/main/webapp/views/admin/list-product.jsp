<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin Dashboard</title>
    <style>
        /* ===== LIST PRODUCT PAGE ===== */

        .page-header {
            display: flex; justify-content: space-between; align-items: flex-start;
            margin-bottom: 24px; flex-wrap: wrap; gap: 14px;
        }
        .page-title { font-size: 22px; font-weight: 900; color: #0f172a; margin-bottom: 4px; }
        .page-sub { font-size: 13px; color: #64748b; font-weight: 500; }

        .btn-add-new {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 11px 22px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff; font-size: 14px; font-weight: 800;
            border-radius: 11px; text-decoration: none;
            box-shadow: 0 4px 14px rgba(37,99,235,0.3);
            transition: all 0.22s;
        }
        .btn-add-new:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(37,99,235,0.4); color: #fff; }

        /* Flash Messages */
        .flash-alert {
            display: flex; align-items: center; gap: 10px;
            padding: 12px 16px; border-radius: 12px;
            font-size: 13.5px; font-weight: 600; margin-bottom: 20px;
        }
        .flash-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .flash-error   { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .flash-close { margin-left: auto; cursor: pointer; background: none; border: none; font-size: 18px; color: inherit; opacity: 0.7; }
        .flash-close:hover { opacity: 1; }

        /* Search Card */
        .search-card {
            background: #fff; border: 1px solid #e2e8f0;
            border-radius: 16px; padding: 16px 20px;
            margin-bottom: 20px; box-shadow: 0 2px 12px rgba(15,23,42,0.04);
        }
        .search-form { display: flex; gap: 10px; align-items: center; }
        .search-input-wrapper {
            flex: 1; display: flex; align-items: center;
            background: #f8fafc; border: 1.5px solid #e2e8f0;
            border-radius: 11px; padding: 0 14px; gap: 10px;
            transition: all 0.2s;
        }
        .search-input-wrapper:focus-within { border-color: #2563eb; background: #fff; box-shadow: 0 0 0 4px rgba(37,99,235,0.1); }
        .search-input-wrapper i { color: #94a3b8; font-size: 16px; }
        .search-input {
            border: none; background: transparent; outline: none;
            padding: 10px 0; font-size: 14px; font-weight: 500; color: #0f172a;
            width: 100%; font-family: inherit;
        }
        .btn-search {
            padding: 10px 22px; background: #2563eb; color: #fff;
            border: none; border-radius: 11px; font-size: 14px; font-weight: 700;
            cursor: pointer; transition: all 0.2s; font-family: inherit; white-space: nowrap;
        }
        .btn-search:hover { background: #1d4ed8; transform: translateY(-1px); }
        .btn-search-clear {
            padding: 10px 18px; background: #f1f5f9; color: #64748b;
            border: 1px solid #e2e8f0; border-radius: 11px; font-size: 13.5px; font-weight: 600;
            cursor: pointer; text-decoration: none; white-space: nowrap;
            display: inline-flex; align-items: center; gap: 5px;
        }

        /* Product Table Card */
        .table-card {
            background: #fff; border: 1px solid #e2e8f0;
            border-radius: 18px; overflow: hidden;
            box-shadow: 0 4px 16px rgba(15,23,42,0.05);
        }
        .table-card-header {
            padding: 16px 22px;
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-bottom: 1px solid #e2e8f0;
            display: flex; justify-content: space-between; align-items: center;
        }
        .table-card-title { font-size: 14px; font-weight: 800; color: #0f172a; display: flex; align-items: center; gap: 8px; }
        .table-count-badge {
            background: #2563eb; color: #fff;
            font-size: 12px; font-weight: 800;
            padding: 3px 10px; border-radius: 99px;
        }

        .product-table { width: 100%; border-collapse: collapse; }
        .product-table thead th {
            padding: 13px 16px;
            background: #f8fafc;
            font-size: 12px; font-weight: 800; color: #64748b;
            text-transform: uppercase; letter-spacing: 0.07em;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }
        .product-table thead th:first-child { padding-left: 22px; }
        .product-table thead th:last-child { padding-right: 22px; text-align: right; }

        .product-table tbody tr {
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.15s;
        }
        .product-table tbody tr:last-child { border-bottom: none; }
        .product-table tbody tr:hover { background: #f8fbff; }

        .product-table td {
            padding: 14px 16px;
            font-size: 14px; vertical-align: middle;
        }
        .product-table td:first-child { padding-left: 22px; }
        .product-table td:last-child { padding-right: 22px; text-align: right; }

        .product-id-badge {
            font-size: 12px; font-weight: 800; color: #94a3b8;
            background: #f1f5f9; padding: 3px 8px; border-radius: 6px;
        }
        .product-img-thumb {
            width: 52px; height: 52px; border-radius: 12px;
            object-fit: cover; border: 1.5px solid #e2e8f0;
        }
        .product-img-placeholder {
            width: 52px; height: 52px; border-radius: 12px;
            background: #f1f5f9; border: 1.5px solid #e2e8f0;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; color: #e2e8f0;
        }
        .product-name-cell { font-weight: 700; color: #0f172a; max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .product-price-cell { font-weight: 800; color: #2563eb; font-size: 14.5px; white-space: nowrap; }
        .category-badge {
            display: inline-flex; align-items: center; gap: 4px;
            background: #eff6ff; color: #2563eb;
            border: 1px solid #bfdbfe;
            font-size: 12px; font-weight: 700;
            padding: 4px 10px; border-radius: 99px;
        }
        .product-desc-cell { color: #64748b; font-size: 13px; max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

        .btn-table-edit, .btn-table-delete {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 7px 14px; border-radius: 9px;
            font-size: 12.5px; font-weight: 700;
            text-decoration: none; transition: all 0.2s;
            cursor: pointer; border: 1.5px solid;
        }
        .btn-table-edit {
            background: #fefce8; color: #ca8a04; border-color: #fde68a;
        }
        .btn-table-edit:hover { background: #fde68a; color: #78350f; transform: translateY(-1px); }
        .btn-table-delete {
            background: #fef2f2; color: #dc2626; border-color: #fecaca;
        }
        .btn-table-delete:hover { background: #dc2626; color: #fff; border-color: #dc2626; transform: translateY(-1px); }

        /* Empty State */
        .empty-row td { text-align: center; padding: 48px 24px; }
        .empty-icon { font-size: 48px; display: block; margin-bottom: 12px; }

        /* Skeleton rows */
        .skeleton-row td { padding: 14px 16px; }
        .skeleton-block {
            background: linear-gradient(90deg, #f1f5f9 25%, #e2e8f0 50%, #f1f5f9 75%);
            background-size: 400% 100%;
            animation: shimmer 1.5s ease-in-out infinite;
            border-radius: 8px; height: 16px;
        }
        @keyframes shimmer { 0%{background-position:100% 0} 100%{background-position:-100% 0} }

        /* Delete Confirm Modal */
        .modal-overlay {
            position: fixed; inset: 0;
            background: rgba(15,23,42,0.5);
            backdrop-filter: blur(4px);
            z-index: 1000;
            display: flex; align-items: center; justify-content: center;
            opacity: 0; visibility: hidden;
            transition: all 0.25s;
        }
        .modal-overlay.open { opacity: 1; visibility: visible; }
        .modal-box {
            background: #fff; border-radius: 20px;
            padding: 32px 28px;
            max-width: 380px; width: 100%;
            box-shadow: 0 30px 70px rgba(0,0,0,0.3);
            transform: translateY(16px) scale(0.97);
            transition: transform 0.28s cubic-bezier(0.34,1.2,0.64,1);
        }
        .modal-overlay.open .modal-box { transform: translateY(0) scale(1); }
        .modal-icon { font-size: 48px; text-align: center; margin-bottom: 16px; }
        .modal-title { font-size: 20px; font-weight: 900; color: #0f172a; text-align: center; margin-bottom: 8px; }
        .modal-sub { font-size: 14px; color: #64748b; text-align: center; margin-bottom: 24px; line-height: 1.6; }
        .modal-actions { display: flex; gap: 10px; }
        .btn-modal-cancel {
            flex: 1; padding: 12px; border-radius: 11px;
            background: #f1f5f9; color: #475569; font-weight: 700; font-size: 14px;
            border: 1.5px solid #e2e8f0; cursor: pointer; font-family: inherit;
            transition: all 0.2s;
        }
        .btn-modal-cancel:hover { background: #e2e8f0; }
        .btn-modal-confirm {
            flex: 1; padding: 12px; border-radius: 11px;
            background: #dc2626; color: #fff; font-weight: 800; font-size: 14px;
            border: none; cursor: pointer; font-family: inherit;
            box-shadow: 0 4px 12px rgba(220,38,38,0.3); transition: all 0.2s;
        }
        .btn-modal-confirm:hover { background: #b91c1c; transform: translateY(-1px); }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1 class="page-title"><i class="bi bi-box-seam text-primary me-2"></i>Quản Lý Sản Phẩm</h1>
            <p class="page-sub">Danh sách sản phẩm, thêm mới, chỉnh sửa và xóa dữ liệu qua JPA EntityManager</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn-add-new">
            <i class="bi bi-plus-circle-fill"></i> Thêm Sản Phẩm Mới
        </a>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.successMsg}">
        <div class="flash-alert flash-success" id="flashMsg">
            <i class="bi bi-check-circle-fill"></i> ${sessionScope.successMsg}
            <button class="flash-close" onclick="document.getElementById('flashMsg').style.display='none'">×</button>
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
        <div class="flash-alert flash-error" id="flashErr">
            <i class="bi bi-exclamation-circle-fill"></i> ${sessionScope.errorMsg}
            <button class="flash-close" onclick="document.getElementById('flashErr').style.display='none'">×</button>
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <!-- Search -->
    <div class="search-card">
        <form action="${pageContext.request.contextPath}/admin/product/list" method="get" class="search-form">
            <div class="search-input-wrapper">
                <i class="bi bi-search"></i>
                <input type="text" name="keyword" value="${keyword}" class="search-input" placeholder="Nhập tên sản phẩm cần tìm...">
            </div>
            <button type="submit" class="btn-search"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn-search-clear">
                    <i class="bi bi-x-circle"></i> Xóa
                </a>
            </c:if>
        </form>
    </div>

    <!-- Table Card -->
    <div class="table-card">
        <div class="table-card-header">
            <div class="table-card-title">
                <i class="bi bi-table"></i> Danh sách sản phẩm
                <c:if test="${not empty productList}">
                    <span class="table-count-badge">${fn:length(productList)}</span>
                </c:if>
            </div>
            <c:if test="${not empty keyword}">
                <span style="font-size:13px; color:#64748b; font-weight:600;">
                    Kết quả tìm kiếm: "<strong>${keyword}</strong>"
                </span>
            </c:if>
        </div>

        <div style="overflow-x: auto;">
            <table class="product-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá bán</th>
                        <th>Danh mục</th>
                        <th>Mô tả</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach items="${productList}" var="p">
                                <tr>
                                    <td><span class="product-id-badge">#${p.productId}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.images}">
                                                <c:choose>
                                                    <c:when test="${p.images.startsWith('http')}">
                                                        <img src="${p.images}" class="product-img-thumb" alt="${p.productName}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url value="/image?fname=${p.images}" var="pImg"/>
                                                        <img src="${pImg}" class="product-img-thumb" alt="${p.productName}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-img-placeholder">📦</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="product-name-cell" title="${p.productName}">${p.productName}</div>
                                    </td>
                                    <td class="product-price-cell">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                    </td>
                                    <td>
                                        <span class="category-badge">
                                            <i class="bi bi-tag-fill"></i> ${p.category.categoryname}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="product-desc-cell" title="${p.description}">${p.description}</span>
                                    </td>
                                    <td>
                                        <div style="display:flex; gap:6px; justify-content:flex-end;">
                                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn-table-edit">
                                                <i class="bi bi-pencil-fill"></i> Sửa
                                            </a>
                                            <button class="btn-table-delete"
                                                    onclick="confirmDelete(${p.productId}, '${p.productName}')">
                                                <i class="bi bi-trash-fill"></i> Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr class="empty-row">
                                <td colspan="7">
                                    <span class="empty-icon">📦</span>
                                    <strong style="display:block; font-size:15px; color:#475569; margin-bottom:4px;">
                                        Không tìm thấy sản phẩm nào
                                    </strong>
                                    <span style="font-size:13px; color:#94a3b8;">
                                        <c:choose>
                                            <c:when test="${not empty keyword}">Thử tìm với từ khóa khác hoặc <a href="${pageContext.request.contextPath}/admin/product/list">xóa bộ lọc</a>.</c:when>
                                            <c:otherwise>Hãy <a href="${pageContext.request.contextPath}/admin/product/add">thêm sản phẩm đầu tiên</a>!</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Delete Confirm Modal -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal-box">
            <div class="modal-icon">🗑️</div>
            <h2 class="modal-title">Xác nhận xóa</h2>
            <p class="modal-sub" id="deleteModalSub">
                Bạn có chắc chắn muốn xóa sản phẩm này không?<br>
                Hành động này <strong>không thể hoàn tác</strong>.
            </p>
            <div class="modal-actions">
                <button class="btn-modal-cancel" onclick="closeDeleteModal()">
                    <i class="bi bi-x-lg"></i> Hủy bỏ
                </button>
                <a href="#" class="btn-modal-confirm" id="deleteConfirmLink" style="display:flex;align-items:center;justify-content:center;gap:6px;text-decoration:none;">
                    <i class="bi bi-trash-fill"></i> Xóa ngay
                </a>
            </div>
        </div>
    </div>

    <script>
        let deleteUrl = '';

        function confirmDelete(productId, productName) {
            deleteUrl = '${pageContext.request.contextPath}/admin/product/delete?id=' + productId;
            document.getElementById('deleteModalSub').innerHTML =
                'Bạn có chắc chắn muốn xóa sản phẩm <strong>"' + productName + '"</strong>?<br>Hành động này <strong>không thể hoàn tác</strong>.';
            document.getElementById('deleteConfirmLink').href = deleteUrl;
            document.getElementById('deleteModal').classList.add('open');
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('open');
        }

        // Close on overlay click
        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) closeDeleteModal();
        });

        // ESC to close
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') closeDeleteModal();
        });

        // Auto-hide flash messages after 5s
        setTimeout(() => {
            const f1 = document.getElementById('flashMsg');
            const f2 = document.getElementById('flashErr');
            if (f1) f1.style.opacity = '0';
            if (f2) f2.style.opacity = '0';
            setTimeout(() => {
                if (f1) f1.style.display = 'none';
                if (f2) f2.style.display = 'none';
            }, 400);
        }, 5000);
    </script>
</body>
</html>
