package vn.hcmute.controllers;

import java.io.IOException;
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

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Nếu Session vẫn còn đang đăng nhập thì chuyển hướng vào trong
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // 2. Đọc Cookie Remember Me để tự động điền sẵn Username lên Form đăng nhập
        String rememberedUsername = CookieUtils.get(req, Constant.COOKIE_REMEMBER);
        if (rememberedUsername != null && !rememberedUsername.trim().isEmpty()) {
            req.setAttribute("username", rememberedUsername.trim());
            req.setAttribute("isRemember", true);
        }

        // 3. Hiển thị thông báo sau khi đăng ký hoặc kích hoạt hoặc đổi mật khẩu
        String registered = req.getParameter("registered");
        String activated = req.getParameter("activated");
        String resetSuccess = req.getParameter("resetSuccess");

        if ("1".equals(activated)) {
            req.setAttribute("successAlert", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
        } else if ("1".equals(resetSuccess)) {
            req.setAttribute("successAlert", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới.");
        } else if ("1".equals(registered)) {
            req.setAttribute("successAlert", "Đăng ký tài khoản thành công! Vui lòng kiểm tra email nhập mã OTP kích hoạt.");
        }

        req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        boolean isRememberMe = "on".equals(remember) || "true".equals(remember);

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không được để trống!");
            req.setAttribute("username", username);
            req.setAttribute("isRemember", isRememberMe);
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
            return;
        }

        User user = service.login(username.trim(), password);
        if (user != null) {
            // Kiểm tra trạng thái kích hoạt tài khoản OTP (0: Chưa kích hoạt, 1: Đã kích hoạt)
            if (user.getStatus() == 0) {
                HttpSession session = req.getSession(true);
                session.setAttribute("pendingEmail", user.getEmail());
                req.setAttribute("alert", "Tài khoản của bạn chưa được kích hoạt OTP! Vui lòng nhập mã OTP gửi tới email.");
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
                return;
            }

            // Lưu thông tin người dùng vào Session
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);

            // Xử lý Cookie Remember Me
            if (isRememberMe) {
                CookieUtils.add(resp, Constant.COOKIE_REMEMBER, username.trim(), 24 * 60 * 60);
            } else {
                CookieUtils.delete(resp, Constant.COOKIE_REMEMBER);
            }

            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không đúng!");
            req.setAttribute("username", username);
            req.setAttribute("isRemember", isRememberMe);
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
        }
    }
}
