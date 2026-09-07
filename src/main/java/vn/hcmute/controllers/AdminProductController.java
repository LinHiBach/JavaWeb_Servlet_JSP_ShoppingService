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
            String name = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String description = req.getParameter("description");
            String categoryIdStr = req.getParameter("categoryId");

            // Server-side validation
            String error = null;
            double price = 0;
            int categoryId = 0;
            Category category = null;

            if (name == null || name.trim().isEmpty()) {
                error = "Tên sản phẩm không được để trống!";
            } else if (name.trim().length() < 2 || name.trim().length() > 200) {
                error = "Tên sản phẩm phải từ 2 đến 200 ký tự!";
            } else if (priceStr == null || priceStr.trim().isEmpty()) {
                error = "Giá sản phẩm không được để trống!";
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price <= 0) {
                        error = "Giá bán sản phẩm phải lớn hơn 0 VNĐ!";
                    }
                } catch (NumberFormatException e) {
                    error = "Giá sản phẩm không hợp lệ! Vui lòng nhập số nguyên hoặc số thực dương.";
                }
            }

            if (error == null) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                    category = cateService.findById(categoryId);
                    if (category == null) {
                        error = "Danh mục được chọn không tồn tại trong hệ thống!";
                    }
                } catch (Exception e) {
                    error = "Vui lòng chọn danh mục sản phẩm hợp lệ!";
                }
            }

            Part filePart = null;
            try {
                filePart = req.getPart("images");
            } catch (Exception ignored) {}

            String fileName = null;
            if (error == null && filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                if (filePart.getSize() > 10 * 1024 * 1024) {
                    error = "Dung lượng ảnh tối đa là 10MB!";
                } else {
                    String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = "";
                    int dotIdx = submittedName.lastIndexOf(".");
                    if (dotIdx > 0) ext = submittedName.substring(dotIdx).toLowerCase();

                    if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp") && !ext.equals(".gif")) {
                        error = "Định dạng file không hợp lệ! Chỉ chấp nhận JPG, JPEG, PNG, WEBP, GIF.";
                    } else {
                        fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                        File uploadDir1 = new File(Constant.DIR + File.separator + "product");
                        if (!uploadDir1.exists()) uploadDir1.mkdirs();

                        String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                        filePart.write(savedPath);

                        // Backup to workspace
                        try {
                            File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\product");
                            if (!uploadDir2.exists()) uploadDir2.mkdirs();
                            Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                        } catch (Exception ignored) {}
                    }
                }
            }

            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("productName", name);
                req.setAttribute("price", priceStr);
                req.setAttribute("description", description);
                req.setAttribute("categoryId", categoryId);
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
                return;
            }

            try {
                Product product = new Product(name.trim(), price, description != null ? description.trim() : "", fileName != null ? "product/" + fileName : null, category);
                productService.insert(product);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi lưu sản phẩm vào cơ sở dữ liệu: " + e.getMessage());
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/admin/product/list");

        } else if (url.contains("edit")) {
            int id = 0;
            try {
                id = Integer.parseInt(req.getParameter("id"));
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/product/list");
                return;
            }

            Product product = productService.findById(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/product/list");
                return;
            }

            String name = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String description = req.getParameter("description");
            String categoryIdStr = req.getParameter("categoryId");

            String error = null;
            double price = 0;
            int categoryId = 0;
            Category category = null;

            if (name == null || name.trim().isEmpty()) {
                error = "Tên sản phẩm không được để trống!";
            } else if (name.trim().length() < 2 || name.trim().length() > 200) {
                error = "Tên sản phẩm phải từ 2 đến 200 ký tự!";
            } else if (priceStr == null || priceStr.trim().isEmpty()) {
                error = "Giá sản phẩm không được để trống!";
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price <= 0) {
                        error = "Giá bán sản phẩm phải lớn hơn 0 VNĐ!";
                    }
                } catch (NumberFormatException e) {
                    error = "Giá sản phẩm không hợp lệ! Vui lòng nhập số nguyên hoặc số thực dương.";
                }
            }

            if (error == null) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                    category = cateService.findById(categoryId);
                    if (category == null) {
                        error = "Danh mục được chọn không tồn tại trong hệ thống!";
                    }
                } catch (Exception e) {
                    error = "Vui lòng chọn danh mục sản phẩm hợp lệ!";
                }
            }

            Part filePart = null;
            try {
                filePart = req.getPart("images");
            } catch (Exception ignored) {}

            String fileName = null;
            if (error == null && filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                if (filePart.getSize() > 10 * 1024 * 1024) {
                    error = "Dung lượng ảnh tối đa là 10MB!";
                } else {
                    String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = "";
                    int dotIdx = submittedName.lastIndexOf(".");
                    if (dotIdx > 0) ext = submittedName.substring(dotIdx).toLowerCase();

                    if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp") && !ext.equals(".gif")) {
                        error = "Định dạng file không hợp lệ! Chỉ chấp nhận JPG, JPEG, PNG, WEBP, GIF.";
                    } else {
                        fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                        File uploadDir1 = new File(Constant.DIR + File.separator + "product");
                        if (!uploadDir1.exists()) uploadDir1.mkdirs();

                        String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                        filePart.write(savedPath);

                        try {
                            File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\product");
                            if (!uploadDir2.exists()) uploadDir2.mkdirs();
                            Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                        } catch (Exception ignored) {}
                    }
                }
            }

            if (error != null) {
                product.setProductName(name);
                product.setDescription(description);
                if (price > 0) product.setPrice(price);
                if (category != null) product.setCategory(category);

                req.setAttribute("error", error);
                req.setAttribute("product", product);
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
                return;
            }

            try {
                product.setProductName(name.trim());
                product.setPrice(price);
                product.setDescription(description != null ? description.trim() : "");
                product.setCategory(category);
                if (fileName != null) {
                    product.setImages("product/" + fileName);
                }
                productService.update(product);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi cập nhật sản phẩm vào CSDL: " + e.getMessage());
                req.setAttribute("product", product);
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }
}
