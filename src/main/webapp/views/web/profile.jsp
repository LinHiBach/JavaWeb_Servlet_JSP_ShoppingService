<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - User Profile</title>
    
    <style>
        :root {
            --profile-primary: #3b82f6;
            --profile-primary-hover: #2563eb;
            --profile-bg-slate: #f8fafc;
            --profile-border: #e2e8f0;
            --profile-text-dark: #0f172a;
            --profile-text-muted: #64748b;
            --radius-lg: 24px;
            --radius-md: 14px;
            --shadow-card: 0 20px 45px -15px rgba(15, 23, 42, 0.08);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .profile-wrapper {
            max-width: 980px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .profile-card-hero {
            background: #ffffff;
            border-radius: var(--radius-lg);
            border: 1px solid var(--profile-border);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            transition: var(--transition-smooth);
        }

        /* Cover Banner */
        .profile-cover {
            height: 180px;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 40%, #2563eb 100%);
            position: relative;
            padding: 24px 30px;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }
        .profile-cover::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 80% 20%, rgba(59, 130, 246, 0.25) 0%, transparent 60%);
            pointer-events: none;
        }

        .badge-role-pill {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 13.5px;
            font-weight: 700;
            letter-spacing: 0.3px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        /* Avatar Container & Overlap */
        .avatar-overlap-wrapper {
            padding: 0 35px;
            margin-top: -65px;
            position: relative;
            z-index: 10;
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
        }

        .avatar-main-box {
            position: relative;
            display: inline-block;
        }
        .profile-avatar-img {
            width: 145px;
            height: 145px;
            border-radius: 50%;
            border: 5px solid #ffffff;
            object-fit: cover;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            background: #ffffff;
            transition: var(--transition-smooth);
        }
        .profile-avatar-img:hover {
            transform: scale(1.03);
            box-shadow: 0 16px 36px rgba(0, 0, 0, 0.2);
        }

        .avatar-upload-trigger {
            position: absolute;
            bottom: 6px;
            right: 6px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: #ffffff;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 3px solid #ffffff;
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
            transition: var(--transition-smooth);
        }
        .avatar-upload-trigger:hover {
            transform: scale(1.12) rotate(8deg);
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
        }

        .user-title-box h3 {
            font-weight: 800;
            color: var(--profile-text-dark);
            margin-bottom: 2px;
            font-size: 24px;
        }
        .user-title-box p {
            color: var(--profile-text-muted);
            margin: 0;
            font-size: 14px;
            font-weight: 500;
        }

        /* Form Controls */
        .form-section {
            padding: 35px 40px 45px;
        }

        .section-header-title {
            font-weight: 800;
            color: var(--profile-text-dark);
            font-size: 17px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            letter-spacing: -0.3px;
        }
        .section-header-title i {
            color: var(--profile-primary);
            font-size: 20px;
        }

        .form-label-custom {
            font-weight: 700;
            color: #334155;
            font-size: 13.5px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .input-group-modern {
            border-radius: var(--radius-md);
            border: 1.5px solid #cbd5e1;
            background: #ffffff;
            overflow: hidden;
            transition: var(--transition-smooth);
            display: flex;
            align-items: center;
        }
        .input-group-modern:focus-within {
            border-color: var(--profile-primary);
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
        }

        .input-group-modern .input-icon-box {
            background: transparent;
            border: none;
            color: #64748b;
            font-size: 18px;
            padding-left: 16px;
            padding-right: 12px;
            display: flex;
            align-items: center;
        }
        .input-group-modern:focus-within .input-icon-box {
            color: var(--profile-primary);
        }

        .input-group-modern .form-control-modern {
            border: none;
            padding: 13px 16px 13px 0;
            font-size: 15px;
            font-weight: 600;
            color: var(--profile-text-dark);
            background: transparent;
            width: 100%;
            outline: none;
        }

        .input-group-readonly {
            background: #f1f5f9;
            border-color: #e2e8f0;
        }
        .input-group-readonly .form-control-modern {
            color: #64748b;
            font-weight: 500;
            cursor: not-allowed;
        }
        .input-group-readonly .input-icon-box {
            color: #94a3b8;
        }

        /* Action Buttons */
        .btn-save-profile {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            font-weight: 700;
            font-size: 15.5px;
            padding: 13px 32px;
            border-radius: 12px;
            border: none;
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
            transition: var(--transition-smooth);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        .btn-save-profile:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(37, 99, 235, 0.45);
            color: #ffffff;
        }
        .btn-save-profile:active {
            transform: translateY(0);
        }

        .btn-cancel-custom {
            background: #f1f5f9;
            color: #475569;
            font-weight: 700;
            font-size: 15px;
            padding: 13px 26px;
            border-radius: 12px;
            text-decoration: none;
            transition: var(--transition-smooth);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-cancel-custom:hover {
            background: #e2e8f0;
            color: #1e293b;
        }

        .upload-hint-box {
            background: #eff6ff;
            border: 1px dashed #93c5fd;
            border-radius: var(--radius-md);
            padding: 16px;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="profile-wrapper">

        <!-- NOTIFICATION ALERTS -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3 d-flex align-items-center gap-3" role="alert">
                <i class="bi bi-check-circle-fill text-success fs-4"></i>
                <div>
                    <strong class="d-block text-dark">Thành công!</strong>
                    <span class="text-muted small">${message}</span>
                </div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3 d-flex align-items-center gap-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill text-danger fs-4"></i>
                <div>
                    <strong class="d-block text-dark">Lỗi cập nhật!</strong>
                    <span class="text-muted small">${error}</span>
                </div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty info}">
            <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3 d-flex align-items-center gap-3" role="alert">
                <i class="bi bi-info-circle-fill text-info fs-4"></i>
                <div>
                    <strong class="d-block text-dark">Thông báo</strong>
                    <span class="text-muted small">${info}</span>
                </div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- MAIN PROFILE HERO CARD -->
        <div class="profile-card-hero">
            
            <!-- Cover Header -->
            <div class="profile-cover">
                <div class="text-white">
                    <h5 class="fw-bold mb-1 text-white opacity-90"><i class="bi bi-person-bounding-box me-2"></i>Quản Lý Hồ Sơ</h5>
                    <p class="mb-0 text-white-50 small">Cập nhật thông tin cá nhân & ảnh đại diện hệ thống JPA</p>
                </div>
                <div>
                    <span class="badge-role-pill">
                        <c:choose>
                            <c:when test="${user.roleid == 1}"><i class="bi bi-shield-check text-warning"></i> Quản Trị Viên (Admin)</c:when>
                            <c:when test="${user.roleid == 2}"><i class="bi bi-briefcase text-info"></i> Quản Lý (Manager)</c:when>
                            <c:otherwise><i class="bi bi-patch-check text-success"></i> Thành Viên (Member)</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <!-- PROFILE FORM (MULTIPART UPLOAD) -->
            <form action="${pageContext.request.contextPath}/profile" method="POST" enctype="multipart/form-data">

                <!-- Avatar & Header Info Overlap -->
                <div class="avatar-overlap-wrapper">
                    <div class="d-flex align-items-end gap-4">
                        <div class="avatar-main-box">
                            <c:choose>
                                <c:when test="${not empty user.avatar}">
                                    <c:choose>
                                        <c:when test="${user.avatar.startsWith('http')}">
                                            <img id="avatarPreview" src="${user.avatar}" class="profile-avatar-img" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${user.fullname}&amp;background=2563eb&amp;color=ffffff&amp;bold=true';">
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${user.avatar}" var="avatarUrl"/>
                                            <img id="avatarPreview" src="${avatarUrl}" class="profile-avatar-img" alt="Avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${user.fullname}&amp;background=2563eb&amp;color=ffffff&amp;bold=true';">
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <img id="avatarPreview" src="https://ui-avatars.com/api/?name=${user.fullname}&background=2563eb&color=ffffff&bold=true" class="profile-avatar-img" alt="Avatar">
                                </c:otherwise>
                            </c:choose>

                            <label for="imageUploadInput" class="avatar-upload-trigger" title="Đổi ảnh đại diện">
                                <i class="bi bi-camera-fill fs-5"></i>
                            </label>
                            <input type="file" id="imageUploadInput" name="images" accept="image/*" class="d-none" onchange="previewImage(this)">
                        </div>

                        <div class="user-title-box mb-2">
                            <h3>${user.fullname}</h3>
                            <p><i class="bi bi-at text-primary"></i>${user.username} &bull; <span class="text-muted">${user.email}</span></p>
                        </div>
                    </div>

                    <div class="mb-2">
                        <label for="imageUploadInput" class="btn btn-outline-primary btn-sm px-3 py-2 rounded-3 fw-bold">
                            <i class="bi bi-cloud-arrow-up-fill me-1"></i> Tải ảnh mới lên
                        </label>
                    </div>
                </div>

                <!-- Form Inputs -->
                <div class="form-section">
                    <div class="section-header-title pb-2 border-bottom">
                        <i class="bi bi-sliders"></i> Thông Tin Tài Khoản Chi Tiết
                    </div>

                    <div class="row g-4">
                        <!-- Fullname -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Họ và tên (Fullname) <span class="text-danger">*</span>
                            </label>
                            <div class="input-group-modern">
                                <div class="input-icon-box"><i class="bi bi-person"></i></div>
                                <input type="text" name="fullname" class="form-control-modern" value="${user.fullname}" required placeholder="Nhập họ và tên đầy đủ">
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Số điện thoại (Phone)
                            </label>
                            <div class="input-group-modern">
                                <div class="input-icon-box"><i class="bi bi-telephone"></i></div>
                                <input type="text" name="phone" class="form-control-modern" value="${user.phone}" placeholder="Nhập số điện thoại">
                            </div>
                        </div>

                        <!-- Username (Readonly) -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Tên đăng nhập (Username)
                            </label>
                            <div class="input-group-modern input-group-readonly">
                                <div class="input-icon-box"><i class="bi bi-lock-fill"></i></div>
                                <input type="text" class="form-control-modern" value="${user.username}" readonly>
                            </div>
                        </div>

                        <!-- Email (Readonly) -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Email đăng ký
                            </label>
                            <div class="input-group-modern input-group-readonly">
                                <div class="input-icon-box"><i class="bi bi-envelope-at-fill"></i></div>
                                <input type="text" class="form-control-modern" value="${user.email}" readonly>
                            </div>
                        </div>

                        <!-- Created Date (Readonly) -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Ngày tham gia
                            </label>
                            <div class="input-group-modern input-group-readonly">
                                <div class="input-icon-box"><i class="bi bi-calendar2-event-fill"></i></div>
                                <input type="text" class="form-control-modern" value="${user.createdDate}" readonly>
                            </div>
                        </div>

                        <!-- Role ID (Readonly) -->
                        <div class="col-md-6">
                            <label class="form-label-custom">
                                Quyền hệ thống
                            </label>
                            <div class="input-group-modern input-group-readonly">
                                <div class="input-icon-box"><i class="bi bi-shield-lock-fill"></i></div>
                                <input type="text" class="form-control-modern" value="Role ID: ${user.roleid} (${user.roleid == 1 ? 'Admin' : (user.roleid == 2 ? 'Manager' : 'User')})" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Upload Hint Box -->
                    <div class="upload-hint-box">
                        <span class="text-primary fw-bold small"><i class="bi bi-info-circle-fill me-1"></i> Định dạng hỗ trợ:</span>
                        <span class="text-muted small">JPG, PNG, WEBP. Ảnh sẽ được tự động xử lý Multipart và lưu vết vào CSDL SQL Server với JPA.</span>
                    </div>

                    <!-- Form Action Buttons -->
                    <div class="mt-4 pt-3 d-flex justify-content-end align-items-center gap-3">
                        <a href="${pageContext.request.contextPath}/home" class="btn-cancel-custom">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                        <button type="submit" class="btn-save-profile">
                            <i class="bi bi-check-circle-fill"></i> Cập Nhật Hồ Sơ (JPA)
                        </button>
                    </div>

                </div>

            </form>
        </div>

    </div>

    <!-- JAVASCRIPT FOR INSTANT IMAGE PREVIEW -->
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
