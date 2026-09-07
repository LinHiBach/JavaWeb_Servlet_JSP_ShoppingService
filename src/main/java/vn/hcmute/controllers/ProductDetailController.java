package vn.hcmute.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.hcmute.entity.Product;
import vn.hcmute.entity.User;
import vn.hcmute.services.IProductService;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.ProductServiceImpl;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = {"/product/detail", "/product/item"})
public class ProductDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam.trim());
            Product product = productService.findById(productId);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }

            req.setAttribute("product", product);

            // Gợi ý sản phẩm cùng danh mục
            List<Product> sameCategoryProducts = productService.findByCategoryIdPaged(product.getCategory().getCategoryId(), 1, 4);
            req.setAttribute("sameCategoryProducts", sameCategoryProducts);

            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
