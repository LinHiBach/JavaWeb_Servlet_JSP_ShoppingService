IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ShoppingServiceMVC')
BEGIN
    CREATE DATABASE ShoppingServiceMVC;
END
GO

USE ShoppingServiceMVC;
GO

/* =========================================================
   1. BỔ SUNG COLUMNS CODE + STATUS CHO BẢNG USER
   ========================================================= */

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.[User]')
      AND name = 'code'
)
BEGIN
    ALTER TABLE dbo.[User]
    ADD [code] VARCHAR(10) NULL;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.[User]')
      AND name = 'status'
)
BEGIN
    ALTER TABLE dbo.[User]
    ADD [status] INT NOT NULL DEFAULT 1;
END;
GO

-- User cũ mặc định đã kích hoạt
UPDATE dbo.[User]
SET [status] = 1
WHERE [status] IS NULL OR [status] = 0;
GO


/* =========================================================
   2. TẠO HOẶC CẬP NHẬT BẢNG CATEGORY
   ========================================================= */

IF OBJECT_ID('dbo.[Category]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[Category] (
        [cate_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [cate_name] NVARCHAR(255) NOT NULL,
        [icons] NVARCHAR(255) NULL,
        [status] INT DEFAULT 1
    );
END;
GO


/* =========================================================
   3. TẠO BẢNG PRODUCT
   ========================================================= */

IF OBJECT_ID('dbo.[Product]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[Product] (
        [product_id] INT IDENTITY(1,1) PRIMARY KEY,
        [product_name] NVARCHAR(255) NOT NULL,
        [price] DECIMAL(18,2) NOT NULL,
        [description] NVARCHAR(MAX) NULL,
        [images] NVARCHAR(500) NULL,
        [color] NVARCHAR(100) NULL,
        [created_date] DATETIME NOT NULL DEFAULT GETDATE(),
        [category_id] INT NOT NULL,

        CONSTRAINT FK_Product_Category
            FOREIGN KEY ([category_id])
            REFERENCES dbo.[Category]([cate_id])
            ON DELETE CASCADE
    );
END;
GO


/* =========================================================
   4. BỔ SUNG CỘT COLOR NẾU CHƯA CÓ
   ========================================================= */

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.[Product]')
      AND name = 'color'
)
BEGIN
    ALTER TABLE dbo.[Product]
    ADD [color] NVARCHAR(100) NULL;
END;
GO


/* =========================================================
   5. LÀM SẠCH DỮ LIỆU CŨ
   ========================================================= */

DELETE FROM dbo.[Product];
GO

DELETE FROM dbo.[Category];
GO

-- Reset ID tự tăng về 0
DBCC CHECKIDENT ('dbo.[Category]', RESEED, 0);
GO
DBCC CHECKIDENT ('dbo.[Product]', RESEED, 0);
GO


/* =========================================================
   6. INSERT DANH MỤC GIÀY, ÁO BÓNG ĐÁ NAM & PHỤ KIỆN
   ========================================================= */

INSERT INTO dbo.[Category] ([cate_name], [icons], [status])
VALUES
(N'Giày Sân Cỏ Nhân Tạo (TF)', 'GIAYBONGDA_VAPOR16.webp', 1),
(N'Giày Sân Cỏ Tự Nhiên (FG)', 'GIAYBONGDA17.webp', 1),
(N'Giày Futsal Trong Nhà (IC)', 'GIAYBONGDA2.webp', 1),
(N'Áo Bóng Đá Nam', 'aobongda_nam_BDN.webp', 1),
(N'Phụ Kiện Bóng Đá & Thể Thao', 'vn-11134207-81ztc-mo0r6jn03mde45.webp', 1);
GO


/* =========================================================
   7. INSERT SẢN PHẨM MẪU SHOP BÓNG ĐÁ
   ========================================================= */

INSERT INTO dbo.[Product]
(
    [product_name],
    [price],
    [description],
    [images],
    [color],
    [created_date],
    [category_id]
)
VALUES

/* ===================== ÁO BÓNG ĐÁ NAM - CATE 4 ===================== */

(
    N'Áo Bóng Đá Nam Đội Tuyển Bồ Đào Nha 2024',
    195000,
    N'Áo đấu đội tuyển Bồ Đào Nha chất vải thun lạnh co giãn 4 chiều thoáng mát, thấm hút mồ hôi hiệu quả khi thi đấu.',
    N'aobongda_nam_BDN.webp',
    N'Đỏ Đô',
    DATEADD(MINUTE, -1, GETDATE()),
    4
),

(
    N'Áo Bóng Đá Nam Argentina World Cup Trắng Xanh',
    195000,
    N'Áo đấu đội tuyển Argentina vô địch World Cup, họa tiết sọc trắng xanh chuẩn phom thể thao nam.',
    N'aobongda_nam_argentina.webp',
    N'Trắng Xanh',
    DATEADD(MINUTE, -2, GETDATE()),
    4
),

(
    N'Áo Đá Bóng Nam Argentina Đen Sân Khách',
    195000,
    N'Áo bóng đá nam Argentina phiên bản sân khách màu Đen cực ngầu, logo thêu sắc nét, vải hạt mè cao cấp.',
    N'aobongda_nam_argentina_den.jpg',
    N'Đen',
    DATEADD(MINUTE, -3, GETDATE()),
    4
),

(
    N'Áo Thi Đấu Nam Ronaldo CR7 Số 7 Tẩy Rồng',
    220000,
    N'Áo bóng đá nam in tên và số áo 7 Ronaldo CR7 chất lượng cao, mực in chuyển nhiệt không bong tróc.',
    N'aobongda_nam_ronaldo.jpg',
    N'Đỏ / Vàng',
    DATEADD(MINUTE, -4, GETDATE()),
    4
),


/* ===================== GIÀY SÂN CỎ NHÂN TẠO (TF) - CATE 1 ===================== */

(
    N'Vapor 16 Elite Việt Nam - Đen',
    369000,
    N'Giày bóng đá Vapor 16 Elite Việt Nam màu Đen, thiết kế tốc độ và ôm chân, phù hợp sân cỏ nhân tạo. Đế giày bám sân tốt, trọng lượng nhẹ.',
    N'GIAYBONGDA_VAPOR16.webp',
    N'Đen',
    DATEADD(MINUTE, -5, GETDATE()),
    1
),

(
    N'Vapor 16 Elite Việt Nam - Trắng',
    369000,
    N'Giày bóng đá Vapor 16 Elite Việt Nam màu Trắng, thiết kế tốc độ và ôm chân, phù hợp sân cỏ nhân tạo. Đế giày bám sân tốt, trọng lượng nhẹ.',
    N'GIAYBONGDA.webp',
    N'Trắng',
    DATEADD(MINUTE, -6, GETDATE()),
    1
),

(
    N'Vapor 16 Elite Việt Nam - Đỏ',
    369000,
    N'Giày bóng đá Vapor 16 Elite Việt Nam màu Đỏ nổi bật, thiết kế tốc độ và ôm chân, phù hợp sân cỏ nhân tạo.',
    N'GIAYBONGDA2.webp',
    N'Đỏ',
    DATEADD(MINUTE, -7, GETDATE()),
    1
),

(
    N'Vapor 16 Elite Việt Nam - Xanh Nhám',
    369000,
    N'Giày bóng đá Vapor 16 Elite Việt Nam màu Xanh nhám thể thao, hỗ trợ kiểm soát bóng tối ưu.',
    N'giaybongda16vapor_xanh4nham.webp',
    N'Xanh',
    DATEADD(MINUTE, -8, GETDATE()),
    1
),

(
    N'Vapor 17 Elite Việt Nam - Đen Xám',
    389000,
    N'Giày bóng đá Vapor 17 Elite Việt Nam, kiểu dáng hiện đại, trọng lượng nhẹ, hỗ trợ tăng tốc và kiểm soát bóng tốt trên sân cỏ nhân tạo.',
    N'GIAYBONGDA17.webp',
    N'Đen',
    DATEADD(MINUTE, -9, GETDATE()),
    1
),

(
    N'Vapor 17 Elite Việt Nam - Trắng Xanh',
    389000,
    N'Giày bóng đá Vapor 17 Elite Việt Nam màu Trắng Xanh, kiểu dáng hiện đại, trọng lượng nhẹ, hỗ trợ tăng tốc tốt trên sân cỏ nhân tạo.',
    N'GIAYBONGDA17_2.webp',
    N'Trắng',
    DATEADD(MINUTE, -10, GETDATE()),
    1
),


/* ===================== GIÀY SÂN CỎ TỰ NHIÊN (FG) - CATE 2 ===================== */

(
    N'Giày Cỏ Tự Nhiên Vapor 17 Elite FG - Đỏ Cam',
    389000,
    N'Giày bóng đá Vapor 17 Elite FG chuyên cho sân cỏ tự nhiên, đinh cao bám cỏ cực chuẩn.',
    N'GIAYBONGDA2.webp',
    N'Đỏ',
    DATEADD(MINUTE, -11, GETDATE()),
    2
),

(
    N'Giày Sân Cỏ Tự Nhiên Vapor 16 FG - Xanh Dương',
    389000,
    N'Giày bóng đá Vapor 16 FG chuyên dụng thi đấu sân cỏ tự nhiên 11 người.',
    N'giaybongda16vapor_xanh4nham.webp',
    N'Xanh',
    DATEADD(MINUTE, -12, GETDATE()),
    2
),


/* ===================== GIÀY FUTSAL TRONG NHÀ (IC) - CATE 3 ===================== */

(
    N'Giày Futsal Trong Nhà IC - Trắng Kim',
    350000,
    N'Giày Futsal đế bằng cao su bám sàn gỗ, thiết kế da êm nhẹ chuyên cho thi đấu trong nhà.',
    N'GIAYBONGDA.webp',
    N'Trắng',
    DATEADD(MINUTE, -13, GETDATE()),
    3
),


/* ===================== PHỤ KIỆN BÓNG ĐÁ & THỂ THAO - CATE 5 ===================== */

(
    N'Bóng đá FIFA Quality Pro',
    299000,
    N'Bóng đá thi đấu tiêu chuẩn FIFA Quality Pro, bề mặt bám tốt và độ ổn định cao.',
    N'vn-11134207-81ztc-mo0r6jn03mde45.webp',
    N'Trắng',
    DATEADD(MINUTE, -14, GETDATE()),
    5
),

(
    N'Tất bóng đá chống trượt Fox Socks',
    89000,
    N'Tất bóng đá chống trượt, co giãn tốt và hỗ trợ cố định bàn chân khi tăng tốc.',
    N'men.jpg',
    N'Đen',
    DATEADD(MINUTE, -15, GETDATE()),
    5
);
GO


/* =========================================================
   8. KIỂM TRA DỮ LIỆU
   ========================================================= */

SELECT * FROM dbo.[Category];
SELECT * FROM dbo.[Product] ORDER BY created_date DESC;
GO
