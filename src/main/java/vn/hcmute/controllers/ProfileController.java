package vn.hcmute.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.hcmute.entity.User;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = {"/profile", "/user/profile", "/profile/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User sessionUser = CookieUtils.checkAndRestoreSession(req, userService);
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Flash message handling for PRG pattern
        HttpSession session = req.getSession(false);
        if (session != null) {
            String message = (String) session.getAttribute("message");
            String error = (String) session.getAttribute("error");
            String info = (String) session.getAttribute("info");
            if (message != null) {
                req.setAttribute("message", message);
                session.removeAttribute("message");
            }
            if (error != null) {
                req.setAttribute("error", error);
                session.removeAttribute("error");
            }
            if (info != null) {
                req.setAttribute("info", info);
                session.removeAttribute("info");
            }
        }

        // Fetch fresh user entity from database via JPA
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = sessionUser;
        }

        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(true);
        User sessionUser = CookieUtils.checkAndRestoreSession(req, userService);
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Fetch user from DB via JPA using Session ID (prevents IDOR)
        User user = userService.findById(sessionUser.getId());
        if (user == null) {
            user = sessionUser;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Validation 1: Fullname validation
        if (fullname == null || fullname.trim().isEmpty()) {
            session.setAttribute("error", "Họ và tên không được để trống!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }
        if (fullname.trim().length() > 255) {
            session.setAttribute("error", "Họ và tên không được vượt quá 255 ký tự!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // Validation 2: Phone validation (optional field, trim and limit length)
        boolean isChanged = false;

        String oldFullname = user.getFullname() != null ? user.getFullname().trim() : "";
        String newFullname = fullname.trim();
        if (!oldFullname.equals(newFullname)) {
            user.setFullname(newFullname);
            isChanged = true;
        }

        String oldPhone = user.getPhone() != null ? user.getPhone().trim() : "";
        String newPhone = (phone != null && !phone.trim().isEmpty()) ? phone.trim() : "";
        if (!oldPhone.equals(newPhone)) {
            user.setPhone(newPhone.isEmpty() ? null : newPhone);
            isChanged = true;
        }

        // Process Multipart Avatar Image Upload
        try {
            Part filePart = req.getPart("images");
            if (filePart == null || filePart.getSize() == 0) {
                filePart = req.getPart("avatar");
            }

            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String contentType = filePart.getContentType();
                
                String ext = "";
                int dotIdx = submittedName.lastIndexOf(".");
                if (dotIdx > 0) {
                    ext = submittedName.substring(dotIdx).toLowerCase();
                }

                // Security & MIME / Extension Validation
                boolean isValidImage = false;
                if (contentType != null && contentType.startsWith("image/")) {
                    isValidImage = true;
                } else if (ext.equals(".jpg") || ext.equals(".jpeg") || ext.equals(".png") || ext.equals(".gif") || ext.equals(".webp")) {
                    isValidImage = true;
                }

                if (!isValidImage) {
                    session.setAttribute("error", "Định dạng file không hợp lệ! Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WEBP).");
                    resp.sendRedirect(req.getContextPath() + "/profile");
                    return;
                }

                // Unique collision-proof filename using timestamp and UUID
                String uniqueSuffix = UUID.randomUUID().toString().substring(0, 8);
                String fileName = System.currentTimeMillis() + "_" + uniqueSuffix + (ext.isEmpty() ? ".jpg" : ext);

                // Save to primary directory (Constant.DIR/user)
                File uploadDir1 = new File(Constant.DIR + File.separator + "user");
                if (!uploadDir1.exists()) {
                    uploadDir1.mkdirs();
                }
                String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                filePart.write(savedPath);

                user.setAvatar("user/" + fileName);
                isChanged = true;

                // Backup copy to local workspace upload folder
                try {
                    File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\user");
                    if (!uploadDir2.exists()) uploadDir2.mkdirs();
                    Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                } catch (Exception ignored) {}
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi trong quá trình tải lên hình ảnh: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        if (isChanged) {
            try {
                // Update user entity in DB using JPA (EntityManager.merge)
                userService.update(user);

                // Refresh session attribute
                session.setAttribute("account", user);
                session.setAttribute("message", "Cập nhật thông tin hồ sơ cá nhân thành công!");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            }
        } else {
            session.setAttribute("info", "Không có thông tin nào thay đổi.");
        }

        // Post-Redirect-Get pattern
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}
