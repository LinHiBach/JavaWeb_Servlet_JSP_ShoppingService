package vn.hcmute.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.hcmute.entity.Category;
import vn.hcmute.entity.Product;
import vn.hcmute.entity.User;
import vn.hcmute.services.ICategoryService;
import vn.hcmute.services.IProductService;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.CategoryServiceImpl;
import vn.hcmute.services.impl.ProductServiceImpl;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = "/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 1. Lấy 10 sản phẩm mới nhất lên trang chủ
        List<Product> top10Products = productService.findTop10Newest();
        req.setAttribute("top10Products", top10Products);

        // 2. Lấy danh sách Danh mục cho thanh điều hướng
        List<Category> categories = cateService.findAll();
        req.setAttribute("categories", categories);

        req.getRequestDispatcher(Constant.Path.HOME).forward(req, resp);
    }
}
