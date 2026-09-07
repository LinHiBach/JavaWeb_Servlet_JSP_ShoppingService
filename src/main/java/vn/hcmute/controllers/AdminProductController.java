package vn.hcmute.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

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

@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/list",
    "/admin/product/add",
    "/admin/product/edit",
    "/admin/product/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService cateService = new CategoryServiceImpl();
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null || user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("add")) {
            List<Category> categories = cateService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.findById(id);
                List<Category> categories = cateService.findAll();
                req.setAttribute("product", product);
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            }

        } else if (url.contains("delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");

        } else {
            // Default: List products
            String keyword = req.getParameter("keyword");
            List<Product> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = productService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = productService.findAll();
            }
            req.setAttribute("productList", list);
            req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null || user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("add")) {
            try {
                String name = req.getParameter("productName");
                String priceStr = req.getParameter("price");
                String description = req.getParameter("description");
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));

                double price = Double.parseDouble(priceStr);
                Category category = cateService.findById(categoryId);

                Product product = new Product(name, price, description, null, category);

                // Handle Image Upload
                Part filePart = req.getPart("images");
                if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                    String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = "";
                    int dotIdx = submittedName.lastIndexOf(".");
                    if (dotIdx > 0) ext = submittedName.substring(dotIdx);

                    String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + (ext.isEmpty() ? ".jpg" : ext);

                    File uploadDir1 = new File(Constant.DIR + File.separator + "product");
                    if (!uploadDir1.exists()) uploadDir1.mkdirs();

                    String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                    filePart.write(savedPath);

                    product.setImages("product/" + fileName);

                    // Backup to workspace
                    try {
                        File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\product");
                        if (!uploadDir2.exists()) uploadDir2.mkdirs();
                        Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                    } catch (Exception ignored) {}
                }

                productService.insert(product);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("productName");
                String priceStr = req.getParameter("price");
                String description = req.getParameter("description");
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));

                Product product = productService.findById(id);
                if (product != null) {
                    product.setProductName(name);
                    product.setPrice(Double.parseDouble(priceStr));
                    product.setDescription(description);

                    Category category = cateService.findById(categoryId);
                    if (category != null) {
                        product.setCategory(category);
                    }

                    Part filePart = req.getPart("images");
                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String ext = "";
                        int dotIdx = submittedName.lastIndexOf(".");
                        if (dotIdx > 0) ext = submittedName.substring(dotIdx);

                        String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + (ext.isEmpty() ? ".jpg" : ext);

                        File uploadDir1 = new File(Constant.DIR + File.separator + "product");
                        if (!uploadDir1.exists()) uploadDir1.mkdirs();

                        String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                        filePart.write(savedPath);

                        product.setImages("product/" + fileName);

                        try {
                            File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\product");
                            if (!uploadDir2.exists()) uploadDir2.mkdirs();
                            Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                        } catch (Exception ignored) {}
                    }

                    productService.update(product);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }
}
