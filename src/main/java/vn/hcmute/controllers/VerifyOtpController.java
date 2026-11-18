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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("pendingEmail") : null;

        if (email == null || email.trim().isEmpty()) {
            email = req.getParameter("email");
        }

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        if (session != null) {
            String pendingAlert = (String) session.getAttribute("pendingAlert");
            String pendingSuccess = (String) session.getAttribute("pendingSuccess");
            if (pendingAlert != null) {
                setError(req, pendingAlert);
                session.removeAttribute("pendingAlert");
            }
            if (pendingSuccess != null) {
                setSuccess(req, pendingSuccess);
                session.removeAttribute("pendingSuccess");
            }
        }

        req.setAttribute("email", email.trim());
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String email = req.getParameter("email");
        if ((email == null || email.trim().isEmpty()) && session != null) {
            email = (String) session.getAttribute("pendingEmail");
        }

        String otp = req.getParameter("otp");
        String action = req.getParameter("action");

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        email = email.trim();

        // Xử lý gửi lại mã OTP (Resend)
        if ("resend".equalsIgnoreCase(action)) {
            User user = userService.findByEmail(email);
            if (user != null && user.getStatus() == 0) {
                String newOtp = EmailUtils.generateOtp();
                user.setCode(newOtp);
                userService.update(user);
                EmailUtils.sendOtpEmail(user.getEmail(), newOtp, "register");
                HttpSession activeSession = req.getSession(true);
                activeSession.setAttribute("pendingEmail", email);
                setSuccess(req, "Mã OTP mới đã được tạo và gửi lại vào email của bạn!");
            } else {
                setError(req, "Không tìm thấy tài khoản chờ kích hoạt cho email này!");
            }
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (otp == null || otp.trim().isEmpty()) {
            setError(req, "Vui lòng nhập mã OTP xác thực!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (!otp.trim().matches("^[0-9]{6}$")) {
            setError(req, "Mã OTP phải gồm đúng 6 chữ số!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // Tìm User theo Mã OTP và Email
        User user = userService.findByCodeAndEmail(otp.trim(), email);
        if (user != null) {
            user.setStatus(1);
            user.setCode(null);
            userService.update(user);

            if (session != null) {
                session.removeAttribute("pendingEmail");
                session.removeAttribute("latestOtp");
            }

            resp.sendRedirect(req.getContextPath() + "/login?activated=1");
        } else {
            setError(req, "Mã OTP không đúng hoặc đã hết hạn!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }

    private void setError(HttpServletRequest req, String msg) {
        req.setAttribute("error", msg);
        req.setAttribute("alert", msg);
    }

    private void setSuccess(HttpServletRequest req, String msg) {
        req.setAttribute("message", msg);
        req.setAttribute("successAlert", msg);
    }
}
