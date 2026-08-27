package vn.hcmute.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.hcmute.entity.Category;
import vn.hcmute.entity.User;
import vn.hcmute.services.ICategoryService;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.CategoryServiceImpl;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category",
    "/admin/category/list",
    "/admin/category/add",
    "/admin/category/edit",
    "/admin/category/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CategoryControllers extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICategoryService cateService = new CategoryServiceImpl();
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Kiểm tra quyền đăng nhập & tự động phục hồi từ Cookie Remember Me
        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (user.getRoleid() != 1) { // Chỉ Admin mới được vào trang quản lý danh mục
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("categories") || url.contains("list") || url.endsWith("/admin/category")) {
            String keyword = req.getParameter("keyword");
            List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = cateService.findAll();
            }
            // Đặt cả hai tên biến danh sách listcate và cateList vào Request Attribute
            req.setAttribute("cateList", list);
            req.setAttribute("listcate", list);
            req.setAttribute("categories", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);

        } else if (url.contains("add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateService.findById(id);
                req.setAttribute("category", category);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            }

        } else if (url.contains("delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
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
            String name = req.getParameter("name");
            if (name == null || name.trim().isEmpty()) {
                name = req.getParameter("categoryname");
            }
            Category category = new Category();
            category.setName(name);
            category.setStatus(1);

            Part filePart = req.getPart("icon");
            if (filePart == null || filePart.getSize() == 0) {
                filePart = req.getPart("images");
            }

            if (filePart != null && filePart.getSize() > 0) {
                String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int dotIdx = submittedName.lastIndexOf(".");
                if (dotIdx > 0) {
                    ext = submittedName.substring(dotIdx + 1);
                }
                String fileName = System.currentTimeMillis() + (ext.isEmpty() ? "" : "." + ext);

                File uploadDir = new File(Constant.DIR + File.separator + "category");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadDir.getAbsolutePath() + File.separator + fileName);
                category.setImages("category/" + fileName);
            }
            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                if (name == null || name.trim().isEmpty()) {
                    name = req.getParameter("categoryname");
                }

                Category category = new Category();
                category.setCategoryId(id);
                category.setCategoryname(name);
                category.setStatus(1);

                Part filePart = req.getPart("icon");
                if (filePart == null || filePart.getSize() == 0) {
                    filePart = req.getPart("images");
                }

                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = "";
                    int dotIdx = submittedName.lastIndexOf(".");
                    if (dotIdx > 0) {
                        ext = submittedName.substring(dotIdx + 1);
                    }
                    String fileName = System.currentTimeMillis() + (ext.isEmpty() ? "" : "." + ext);

                    File uploadDir = new File(Constant.DIR + File.separator + "category");
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    filePart.write(uploadDir.getAbsolutePath() + File.separator + fileName);
                    category.setImages("category/" + fileName);
                }
                cateService.update(category);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }
}