package vn.hcmute.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.hcmute.models.UserModel;
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

        // 3. Hiển thị thông báo sau khi vừa đăng ký thành công
        String registered = req.getParameter("registered");
        if ("1".equals(registered)) {
            req.setAttribute("successAlert", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
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

        UserModel user = service.login(username.trim(), password);
        if (user != null) {
            // Lưu thông tin người dùng vào Session
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);

            // Xử lý Cookie Remember Me
            if (isRememberMe) {
                // Lưu cookie username trong 24 giờ (86400 giây)
                CookieUtils.add(resp, Constant.COOKIE_REMEMBER, username.trim(), 24 * 60 * 60);
            } else {
                // Nếu người dùng chủ động bỏ chọn ghi nhớ, xóa cookie cũ
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
