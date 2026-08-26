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
import vn.hcmute.models.CategoryModel;
import vn.hcmute.models.UserModel;
import vn.hcmute.services.ICategoryService;
import vn.hcmute.services.IUserService;
import vn.hcmute.services.impl.CategoryServiceImpl;
import vn.hcmute.services.impl.UserServiceImpl;
import vn.hcmute.utils.Constant;
import vn.hcmute.utils.CookieUtils;

@WebServlet(urlPatterns = {
    "/admin/categories",
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
        UserModel user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (user.getRoleid() != 1) { // Chỉ Admin mới được vào trang quản lý danh mục
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("categories") || url.contains("list")) {
            String keyword = req.getParameter("keyword");
            List<CategoryModel> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.search(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = cateService.getAll();
            }
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);

        } else if (url.contains("add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                CategoryModel category = cateService.get(id);
                req.setAttribute("category", category);
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

        UserModel user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null || user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("add")) {
            String name = req.getParameter("name");
            CategoryModel category = new CategoryModel();
            category.setName(name);

            Part filePart = req.getPart("icon");
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
                category.setIcon("category/" + fileName);
            }
            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");

                CategoryModel category = new CategoryModel();
                category.setId(id);
                category.setName(name);

                Part filePart = req.getPart("icon");
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
                    category.setIcon("category/" + fileName);
                }
                cateService.edit(category);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }
}