package vn.hcmute.config;

import java.sql.Date;
import java.util.List;
import jakarta.persistence.EntityManager;
import vn.hcmute.dao.CategoryDao;
import vn.hcmute.dao.ICategoryDao;
import vn.hcmute.dao.IUserDao;
import vn.hcmute.dao.IVideoDao;
import vn.hcmute.dao.UserDao;
import vn.hcmute.dao.VideoDao;
import vn.hcmute.entity.Category;
import vn.hcmute.entity.User;
import vn.hcmute.entity.Video;

public class Test {
    public static void main(String[] args) {
        System.out.println("===============================================================");
        System.out.println("🚀 [BƯỚC 1]: KIỂM TRA KẾT NỐI DATABASE VÀ KÍCH HOẠT HIBERNATE DDL");
        System.out.println("===============================================================");

        EntityManager em = null;
        try {
            // Khởi tạo EntityManager -> Hibernate đọc persistence.xml, kết nối CSDL và tự động tạo bảng (hbm2ddl.auto=update)
            em = JpaConfig.getEntityManager();
            System.out.println("✅ Kết nối cơ sở dữ liệu SQL Server thành công!");
            System.out.println("✅ Đã kích hoạt Hibernate DDL - các bảng 'users', 'categories', 'videos' đã được cập nhật.");
        } catch (Exception e) {
            System.err.println("❌ KẾT NỐI THẤT BẠI! Vui lòng kiểm tra lại SQL Server, Port 1433, Username/Password trong persistence.xml");
            e.printStackTrace();
            return;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }

        System.out.println("\n===============================================================");
        System.out.println("🎯 [BƯỚC 2]: TỰ ĐỘNG CHÈN TÀI KHOẢN MẪU ĐỂ ĐĂNG NHẬP");
        System.out.println("===============================================================");

        IUserDao userDao = new UserDao();
        ICategoryDao categoryDao = new CategoryDao();
        IVideoDao videoDao = new VideoDao();

        try {
            // Chèn tài khoản Admin nếu chưa có
            if (!userDao.checkExistUsername("admin")) {
                User admin = new User("huybach219@gmail.com", "admin", "Lâm Huy Bách", "123", "avt.png", 1, "0838020019", new Date(System.currentTimeMillis()));
                userDao.insert(admin);
                System.out.println("✅ Đã tạo tài khoản: admin / 123 (Role: Admin - 1)");
            } else {
                System.out.println("ℹ️ Tài khoản 'admin' đã tồn tại sẵn.");
            }

            // Chèn tài khoản Manager nếu chưa có
            if (!userDao.checkExistUsername("manager")) {
                User manager = new User("nguyenvana@gmail.com", "manager", "Nguyễn Văn A", "123", null, 2, "0901234567", new Date(System.currentTimeMillis()));
                userDao.insert(manager);
                System.out.println("✅ Đã tạo tài khoản: manager / 123 (Role: Manager - 2)");
            } else {
                System.out.println("ℹ️ Tài khoản 'manager' đã tồn tại sẵn.");
            }

            // Chèn tài khoản User nếu chưa có
            if (!userDao.checkExistUsername("user")) {
                User user = new User("banhthic@gmail.com", "user", "Bành Thị C", "123", null, 3, "0907654321", new Date(System.currentTimeMillis()));
                userDao.insert(user);
                System.out.println("✅ Đã tạo tài khoản: user / 123 (Role: User - 3)");
            } else {
                System.out.println("ℹ️ Tài khoản 'user' đã tồn tại sẵn.");
            }

            System.out.println("\n===============================================================");
            System.out.println("🎯 [BƯỚC 3]: KIỂM TRA CÁC PHƯƠNG THỨC TẦNG DAO (CATEGORY & VIDEO)");
            System.out.println("===============================================================");

            // 1. Thêm danh mục nếu chưa có
            if (categoryDao.count() == 0) {
                Category cate1 = new Category("Áo Thun Nam", "category/men.jpg", 1);
                Category cate2 = new Category("Váy Nữ Thời Trang", "category/women.jpg", 1);
                categoryDao.insert(cate1);
                categoryDao.insert(cate2);
                System.out.println("✅ Đã thêm các danh mục mẫu.");
            }

            // 2. In danh sách người dùng & danh mục
            System.out.println("\n📋 Danh sách User có thể đăng nhập ngay:");
            for (User u : userDao.findAll()) {
                System.out.println("   + Username: " + u.getUsername() + " | Password: " + u.getPassword() + " | Fullname: " + u.getFullname() + " | RoleID: " + u.getRoleid());
            }

            System.out.println("\n📋 Danh sách Danh mục hiện có (" + categoryDao.count() + " bản ghi):");
            for (Category c : categoryDao.findAll()) {
                System.out.println("   + [ID: " + c.getCategoryId() + "] " + c.getCategoryname());
            }

            System.out.println("\n===============================================================");
            System.out.println("🎉 HOÀN TẤT! BÂY GIỜ BẠN ĐÃ CÓ THỂ ĐĂNG NHẬP VỚI: admin / 123");
            System.out.println("===============================================================");

        } catch (Exception e) {
            System.err.println("❌ Có lỗi xảy ra trong quá trình thực thi kiểm thử DAO:");
            e.printStackTrace();
        } finally {
            JpaConfig.close();
            System.out.println("🔒 Đã đóng EntityManagerFactory an toàn.");
        }
    }
}
