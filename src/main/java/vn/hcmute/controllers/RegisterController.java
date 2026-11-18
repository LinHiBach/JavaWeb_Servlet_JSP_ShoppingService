package vn.hcmute.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.hcmute.entity.User;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, service);
        if (user != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String repassword = req.getParameter("repassword");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Giữ lại thông tin đã nhập trên form khi có lỗi
        req.setAttribute("username", username != null ? username.trim() : "");
        req.setAttribute("email", email != null ? email.trim() : "");
        req.setAttribute("fullname", fullname != null ? fullname.trim() : "");
        req.setAttribute("phone", phone != null ? phone.trim() : "");

        Map<String, String> errors = new HashMap<>();

        // 1. Validate Fullname (bắt buộc trong DB)
        if (fullname == null || fullname.trim().isEmpty()) {
            errors.put("fullname", "Họ và tên không được để trống!");
        } else if (fullname.trim().length() < 2 || fullname.trim().length() > 100) {
            errors.put("fullname", "Họ và tên phải từ 2 đến 100 ký tự!");
        }

        // 2. Validate Username
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Tên tài khoản không được để trống!");
        } else {
            String u = username.trim();
            if (u.length() < 4 || u.length() > 30) {
                errors.put("username", "Tên tài khoản phải từ 4 đến 30 ký tự!");
            } else if (!u.matches("^[a-zA-Z0-9_]+$")) {
                errors.put("username", "Tên tài khoản chỉ được chứa chữ cái, số và dấu gạch dưới (_)");
            } else if (service.checkExistUsername(u)) {
                errors.put("username", "Tên tài khoản đã tồn tại trên hệ thống!");
            }
        }

        // 3. Validate Email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Địa chỉ email không được để trống!");
        } else {
            String em = email.trim();
            if (!em.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                errors.put("email", "Địa chỉ email không đúng định dạng (ví dụ: user@example.com)!");
            } else if (service.checkExistEmail(em)) {
                errors.put("email", "Địa chỉ email này đã được đăng ký trước đó!");
            }
        }

        // 4. Validate Password & Confirm Password
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống!");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
        }

        if (repassword != null || req.getParameterMap().containsKey("repassword")) {
            if (repassword == null || repassword.isEmpty()) {
                errors.put("repassword", "Vui lòng nhập lại mật khẩu xác nhận!");
            } else if (password != null && !password.equals(repassword)) {
                errors.put("repassword", "Mật khẩu xác nhận không khớp!");
            }
        }

        // 5. Validate Phone (tùy chọn nhưng nếu nhập phải hợp lệ)
        if (phone != null && !phone.trim().isEmpty()) {
            String p = phone.trim();
            if (!p.matches("^0[0-9]{9}$")) {
                errors.put("phone", "Số điện thoại phải gồm đúng 10 chữ số và bắt đầu bằng số 0!");
            } else if (service.checkExistPhone(p)) {
                errors.put("phone", "Số điện thoại này đã được sử dụng!");
            }
        }

        if (!errors.isEmpty()) {
            String errMsg = "Vui lòng kiểm tra và sửa các thông tin chưa hợp lệ!";
            req.setAttribute("errors", errors);
            req.setAttribute("error", errMsg);
            req.setAttribute("alert", errMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        boolean isSuccess = service.register(
                username.trim(),
                password,
                email.trim(),
                fullname.trim(),
                (phone != null && !phone.trim().isEmpty()) ? phone.trim() : null
        );
        if (isSuccess) {
            HttpSession session = req.getSession(true);
            session.setAttribute("pendingEmail", email.trim());
            session.setAttribute("pendingSuccess", "Đăng ký thành công! Vui lòng nhập mã OTP 6 số gửi tới email của bạn.");
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            String errMsg = "Lỗi hệ thống! Không thể hoàn tất đăng ký lúc này.";
            req.setAttribute("error", errMsg);
            req.setAttribute("alert", errMsg);
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
        }
    }
}
