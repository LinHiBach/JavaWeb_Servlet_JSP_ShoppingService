Cấu hình Tài khoản & Database
Mở file [persistence.xml](src/main/resources/META-INF/persistence.xml) theo đường dẫn:
```
src/main/resources/META-INF/persistence.xml
```
Kiểm tra và sửa lại thông tin đăng nhập SQL Server cho khớp với máy của bạn:
```xml
<!-- Đổi user và password SQL Server của bạn -->
<property name="jakarta.persistence.jdbc.url" 
          value="jdbc:sqlserver://localhost:1433;databaseName=ShoppingServiceMVC;encrypt=true;trustServerCertificate=true;" />
<property name="jakarta.persistence.jdbc.user" value="sa" />
<property name="jakarta.persistence.jdbc.password" value="YOUR_SQL_PASSWORD" />

Tài khoản mẫu:
| Vai trò | Tên đăng nhập | Mật khẩu mặc định | Ghi chú |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `123` | Toàn quyền quản trị danh mục và sản phẩm |
| **Manager** | `manager` | `123` | Trang điều hành manager |
| **Khách hàng** | Đăng ký trực tiếp | Theo bạn tạo | Đăng ký tại `/register` và nhập mã OTP |
