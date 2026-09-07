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
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = "/product")
public class ProductListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Đọc trang hiện tại (mặc định page = 1)
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam.trim());
                if (page < 1) page = 1;
            } catch (Exception ignored) {
                page = 1;
            }
        }

        int pageSize = 6; // Đề bài yêu cầu hiển thị 6 sản phẩm / trang
        int totalProducts = 0;
        List<Product> productList;

        // Lọc theo Category nếu có param cateId
        String cateIdParam = req.getParameter("cateId");
        if (cateIdParam != null && !cateIdParam.trim().isEmpty()) {
            try {
                int cateId = Integer.parseInt(cateIdParam.trim());
                totalProducts = productService.countByCategoryId(cateId);
                productList = productService.findByCategoryIdPaged(cateId, page, pageSize);
                req.setAttribute("selectedCateId", cateId);
            } catch (Exception e) {
                totalProducts = productService.countAll();
                productList = productService.findAllPaged(page, pageSize);
            }
        } else {
            totalProducts = productService.countAll();
            productList = productService.findAllPaged(page, pageSize);
        }

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages < 1) totalPages = 1;

        List<Category> categories = cateService.findAll();

        req.setAttribute("productList", productList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
    }
}
