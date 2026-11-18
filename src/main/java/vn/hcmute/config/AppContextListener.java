package vn.hcmute.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Khởi tạo sẵn EntityManagerFactory khi ứng dụng bắt đầu nếu DB sẵn sàng
        try {
            JpaConfig.getEntityManagerFactory();
        } catch (Exception e) {
            System.err.println("⚠️ [AppContextListener] Không thể kết nối DB lúc khởi động: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaConfig.close();
    }
}
