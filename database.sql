
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ShoppingServiceMVC')
BEGIN
    CREATE DATABASE ShoppingServiceMVC;
END
GO

USE ShoppingServiceMVC;
GO


IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL
    DROP TABLE dbo.[User];
GO

CREATE TABLE [dbo].[User] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [email] VARCHAR(255) NOT NULL UNIQUE,
    [username] VARCHAR(50) NOT NULL UNIQUE,
    [fullname] NVARCHAR(255) NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    [avatar] NVARCHAR(500) NULL,
    [roleid] INT NOT NULL DEFAULT 3,      -- 1: Admin, 2: Manager, 3: User
    [phone] VARCHAR(20) NULL,
    [createdDate] DATE DEFAULT CAST(GETDATE() AS DATE)
);
GO


IF OBJECT_ID('dbo.[Category]', 'U') IS NOT NULL
    DROP TABLE dbo.[Category];
GO

CREATE TABLE [dbo].[Category] (
    [cate_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [cate_name] NVARCHAR(255) NOT NULL,
    [icons] NVARCHAR(255) NULL
);
GO


INSERT INTO [dbo].[User] ([email], [username], [fullname], [password], [avatar], [roleid], [phone], [createdDate])
VALUES 
('huybach219@gmail.com', 'admin', N'Lâm Huy Bách', '123', 'avt.png', 1, '0838020019', GETDATE()),
('nguyenvana@gmail.com', 'manager', N'Nguyễn Văn A', '123', NULL, 2, '0901234567', GETDATE()),
('banhthic@gmail.com', 'user', N'Bành Thị C', '123', NULL, 3, '0907654321', GETDATE());
GO


INSERT INTO [dbo].[Category] ([cate_name], [icons]) 
VALUES 
(N'Áo Thun Nam', 'men.jpg'),
(N'Váy Nữ Thời Trang', 'women.jpg'),
(N'Điện Thoại & Phụ Kiện', 'phone.jpg'),
(N'Laptop & Thiết Bị Số', 'laptop.jpg');
GO


SELECT * FROM [dbo].[User];
SELECT * FROM [dbo].[Category];
GO
