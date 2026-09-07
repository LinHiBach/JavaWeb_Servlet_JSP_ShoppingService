package vn.hcmute.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (user.getRoleid() != 1) {
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
            if (name == null || name.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục không được để trống!");
                req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
                return;
            }
            name = name.trim();
            if (name.length() < 2 || name.length() > 100) {
                req.setAttribute("error", "Tên danh mục phải từ 2 đến 100 ký tự!");
                req.setAttribute("name", name);
                req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
                return;
            }
            if (cateService.findByCategoryname(name) != null) {
                req.setAttribute("error", "Tên danh mục [" + name + "] đã tồn tại trong hệ thống!");
                req.setAttribute("name", name);
                req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
                return;
            }

            try {
                Category category = new Category();
                category.setName(name);
                category.setStatus(1);

                try {
                    Part filePart = req.getPart("icon");
                    if (filePart == null || filePart.getSize() == 0) {
                        filePart = req.getPart("images");
                    }

                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String ext = "";
                        int dotIdx = submittedName.lastIndexOf(".");
                        if (dotIdx > 0) {
                            ext = submittedName.substring(dotIdx + 1).toLowerCase();
                        }
                        if (ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png") || ext.equals("webp") || ext.equals("gif")) {
                            String fileName = System.currentTimeMillis() + "." + ext;

                            File uploadDir1 = new File(Constant.DIR + File.separator + "category");
                            if (!uploadDir1.exists()) {
                                uploadDir1.mkdirs();
                            }
                            String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                            filePart.write(savedPath);
                            category.setImages("category/" + fileName);

                            // Backup sang thư mục upload của dự án
                            try {
                                File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\category");
                                if (!uploadDir2.exists()) uploadDir2.mkdirs();
                                Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                            } catch (Exception ignored) {}
                        }
                    }
                } catch (Exception fileEx) {
                    fileEx.printStackTrace();
                }

                cateService.insert(category);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } else if (url.contains("edit")) {
            int id = -1;
            try {
                id = Integer.parseInt(req.getParameter("id"));
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");
                return;
            }

            Category currentCat = cateService.findById(id);
            if (currentCat == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");
                return;
            }

            String name = req.getParameter("name");
            if (name == null || name.trim().isEmpty()) {
                name = req.getParameter("categoryname");
            }
            if (name == null || name.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục không được để trống!");
                req.setAttribute("category", currentCat);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                return;
            }
            name = name.trim();
            if (name.length() < 2 || name.length() > 100) {
                req.setAttribute("error", "Tên danh mục phải từ 2 đến 100 ký tự!");
                req.setAttribute("category", currentCat);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                return;
            }

            Category checkCat = cateService.findByCategoryname(name);
            if (checkCat != null && checkCat.getCategoryId() != id) {
                req.setAttribute("error", "Tên danh mục [" + name + "] đã được sử dụng bởi danh mục khác!");
                req.setAttribute("category", currentCat);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                return;
            }

            try {
                currentCat.setName(name);

                try {
                    Part filePart = req.getPart("icon");
                    if (filePart == null || filePart.getSize() == 0) {
                        filePart = req.getPart("images");
                    }

                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String ext = "";
                        int dotIdx = submittedName.lastIndexOf(".");
                        if (dotIdx > 0) {
                            ext = submittedName.substring(dotIdx + 1).toLowerCase();
                        }
                        if (ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png") || ext.equals("webp") || ext.equals("gif")) {
                            String fileName = System.currentTimeMillis() + "." + ext;

                            File uploadDir1 = new File(Constant.DIR + File.separator + "category");
                            if (!uploadDir1.exists()) {
                                uploadDir1.mkdirs();
                            }
                            String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                            filePart.write(savedPath);
                            currentCat.setImages("category/" + fileName);

                            try {
                                File uploadDir2 = new File("C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload\\category");
                                if (!uploadDir2.exists()) uploadDir2.mkdirs();
                                Files.copy(Paths.get(savedPath), Paths.get(uploadDir2.getAbsolutePath() + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                            } catch (Exception ignored) {}
                        }
                    }
                } catch (Exception fileEx) {
                    fileEx.printStackTrace();
                }

                cateService.update(currentCat);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }
}