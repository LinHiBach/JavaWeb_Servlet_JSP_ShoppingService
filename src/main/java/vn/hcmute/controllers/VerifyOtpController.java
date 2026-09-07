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

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("pendingEmail") : null;

        if (email == null || email.trim().isEmpty()) {
            email = req.getParameter("email");
        }

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String action = req.getParameter("action");

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        // Xử lý gửi lại mã OTP (Resend)
        if ("resend".equalsIgnoreCase(action)) {
            User user = userService.findByEmail(email.trim());
            if (user != null) {
                String newOtp = EmailUtils.generateOtp();
                user.setCode(newOtp);
                userService.update(user);
                EmailUtils.sendOtpEmail(user.getEmail(), newOtp, "register");
                req.setAttribute("successAlert", "Mã OTP mới đã được gửi lại vào email của bạn!");
            }
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (otp == null || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập mã OTP xác thực!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // Tìm User theo Mã OTP và Email
        User user = userService.findByCodeAndEmail(otp.trim(), email.trim());
        if (user != null) {
            // Kích hoạt tài khoản thành công
            user.setStatus(1);
            user.setCode(null); // Xóa OTP đã dùng
            userService.update(user);

            // Xóa session pending
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.removeAttribute("pendingEmail");
            }

            resp.sendRedirect(req.getContextPath() + "/login?activated=1");
        } else {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
