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
import vn.hcmute.utils.EmailUtils;

@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String input = req.getParameter("email");
        req.setAttribute("email", input != null ? input.trim() : "");

        if (input == null || input.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập Email hoặc Tên tài khoản (Username)!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Tìm theo Email trước, nếu không có thì tìm theo Username
        User user = userService.findByEmail(input.trim());
        if (user == null) {
            user = userService.findByUsername(input.trim());
        }

        if (user == null) {
            req.setAttribute("alert", "Không tìm thấy tài khoản hoặc email này trong hệ thống!");
            req.setAttribute("email", input);
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Sinh mã OTP đặt lại mật khẩu
        String otp = EmailUtils.generateOtp();
        user.setCode(otp);
        userService.update(user);

        // Gửi email OTP (chạy ngầm, in console rõ ràng)
        EmailUtils.sendOtpEmail(user.getEmail(), otp, "reset");

        HttpSession session = req.getSession(true);
        session.setAttribute("resetEmail", user.getEmail());
        session.setAttribute("latestOtp", otp); // Hỗ trợ hiển thị thử nghiệm

        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }
}
