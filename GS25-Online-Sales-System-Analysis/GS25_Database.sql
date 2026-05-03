CREATE Database QuanLyBanHang_GS25
go
use QuanLyBanHang_GS25
Go
CREATE TABLE DanhMucSP
(
MaDanhMuc char (5) not null constraint PK_DanhMucSP Primary key,
TenDanhMuc nvarchar (100) not null
)

Create table SanPham
(
MaSanPham char (5) Constraint PK_SanPham Primary key,
TenSanPham nvarchar(100) not null,
GiaBan float not null,
Donvitinh nvarchar (50) not null,
MaDanhMuc char (5) not null,
Constraint FK_SanPham_DanhMucSP Foreign key (MaDanhMuc) references DanhMucSP(MaDanhMuc)
)

ALTER TABLE SanPham
ADD HinhAnh NVARCHAR(255) NULL;

Create table NhanVien
(
MaNhanVien char (5) not null Constraint PK_NhanVien Primary key,
TenNhanVien nvarchar (100) not null,
GioiTinhNhanVien nvarchar (10) not null check (GioiTinhNhanVien IN (N'Nam',N'Nữ',N'Khác')),
SdtNhanVien varchar (15) not null unique,
DiaChiNhanVien nvarchar (500) not null,
CccdNhanVien varchar (20) not null unique,
Ngayvaolam date not null,
ChucVu nvarchar (100) not null
)



Create table PhieuNhap
(
SoPhieuNhap char (10) not null Constraint PK_PhieuNhap Primary key,
NgayNhap date not null,
LyDoNhap nvarchar (100) not null,
TriGiaPhieuNhap Float not null,
TrangThaiPN nvarchar (50) not null,
MaNhanVien char (5) not null,
Constraint FK_PhieuNhap_NhanVien Foreign key (MaNhanVien) references NhanVien(MaNhanVien)
)

Create table ChiTietPhieuNhap
(
DonGiaPN Float not null,
SoLuongPN Int not null,
ThanhTienPN Float not null,
SoPhieuNhap char (10) not null,
MaSanPham char (5) not null,
Constraint PK_ChiTietPhieuNhap Primary key (SoPhieuNhap, MaSanPham),
Constraint FK_ChiTietPhieuNhap_PhieuNhap Foreign key (SoPhieuNhap) references PhieuNhap(SoPhieuNhap),
Constraint FK_ChiTietPhieuNhap_SanPham Foreign key (MaSanPham) references SanPham(MaSanPham)
)

Create table KhachHang
(
MaKhachHang char (5) not null Constraint PK_KhachHang Primary key,
TenKhachHang nvarchar (100) not null,
SdtKhachHang varchar (15) not null,
DiaChiKhachHang nvarchar (500) not null
)

Create table DonHang
(
MaDonHang char (5) not null Constraint PK_DonHang Primary key,
NgayDat Date not null,
NgayGiao Date not null,
TongTienDonHang Float not null,
PhuongThucTTDH nvarchar (100) not null,
TrangthaiDH nvarchar (50) not null,
MaKhachHang char (5) not null,
Constraint FK_DonHang_KhachHang Foreign key (MaKhachHang) references KhachHang(MaKhachHang)
)

Create table ChiTietDonHang
(
DonGiaDH Float not null,
SoLuongDH Int not null,
ThanhTienDH Float not null,
MaDonHang char (5) not null,
MaSanPham char (5) not null,
Constraint PK_ChiTietDonHang Primary key (MaDonHang, MaSanPham),
Constraint FK_CTDH_DonHang Foreign key (MaDonHang) references DonHang(MaDonHang),
Constraint FK_CTDH_SanPham Foreign key (MaSanPham) references SanPham(MaSanPham)
)

Create table HoaDon
(
SoHoaDon char (10) not null Constraint PK_HoaDon Primary key,
NgayLapHoaDon Date not null,
TongTienHDtruocVAT float not null,
VATHoaDon Float not null,
TongTienHoaDon Float not null,
PhuongThucTTHD nvarchar (100) not null,
TrangThaiHD nvarchar (50) not null,
MaDonHang char (5) null,
MaKhachHang char (5) not null,
MaNhanVien char (5) not null,
Constraint FK_HoaDon_DonHang Foreign key (MaDonHang) references DonHang(MaDonHang),
Constraint FK_HoaDon_KhachHang Foreign key (MaKhachHang) references KhachHang(MaKhachHang),
Constraint FK_HoaDon_NhanVien Foreign key (MaNhanVien) references NhanVien(MaNhanVien)
)

Create table ChiTietHD
(
DonGiaHD Float not null,
SoLuongHD Int not null,
ThanhTienHD Float not null,
SoHoaDon char (10) not null,
MaSanPham char (5) not null,
Constraint PK_ChiTietHD Primary key (SoHoaDon, MaSanPham),
Constraint FK_ChiTietHD_HoaDon Foreign key (SoHoaDon) references HoaDon(SoHoaDon),
Constraint FK_ChiTietHD_SanPham Foreign key (MaSanPham) references SanPham(MaSanPham)
)

Create table ChiNhanh
(
MaChiNhanh char (5) not null Constraint PK_ChiNhanh Primary key,
TenChiNhanh nvarchar (100) not null,
DiaChiChiNhanh nvarchar (500) not null
)

Create table Kho
(
MaKho char (5) not null Constraint PK_Kho Primary key,
TenKho nvarchar (100) not null,
DiaChiKho nvarchar (500) not null,
MaChiNhanh char (5) not null,
Constraint FK_Kho_ChiNhanh Foreign key (MaChiNhanh) references ChiNhanh(MaChiNhanh)
)

Create table TonKho
(
SoLuongTon Int not null,
MaKho char (5) not null,
MaSanPham char (5) not null,
Constraint PK_TonKho Primary key (MaKho, MaSanPham),
Constraint FK_TonKho_Kho Foreign key (MaKho) references Kho(MaKho),
Constraint FK_TonKho_SanPham Foreign key (MaSanPham) references SanPham(MaSanPham)
)

Create table TheThanhVien
(
MaTheThanhVien char (5) not null Constraint PK_TheThanhVien Primary key,
DiemTichLuy int not null,
MaKhachHang char (5) not null,
Constraint FK_TheThanhVien_KhachHang Foreign key (MaKhachHang) references KhachHang(MaKhachHang)
)

Create table VaiTro
(
MaVaiTro char (5) not null Constraint PK_VaiTro Primary key,
TenVaiTro nvarchar (100) not null
)

Create table TaiKhoan
(
MaNguoiDung char (5) not null Constraint PK_TaiKhoan Primary key,
TenTaiKhoan varchar (50) not null,
MatKhau varchar (50) not null,
MaVaiTro char (5) not null,
Constraint FK_TaiKhoan_VaiTro Foreign key (MaVaiTro) references VaiTro(MaVaiTro)
)

Create table NhanVienUser
(
MaNguoiDung char (5) not null,
MaNhanVien char (5) not null,
Constraint PK_NhanVienUser Primary key (MaNguoiDung, MaNhanVien),
Constraint FK_NVUser_TaiKhoan Foreign key (MaNguoiDung) references TaiKhoan(MaNguoiDung),
Constraint FK_NVUser_NhanVien Foreign key (MaNhanVien) references NhanVien(MaNhanVien)
)

Create table KhachHangUser
(
MaNguoiDung char (5) not null,
MaKhachHang char (5) not null,
Constraint PK_KhachHangUser Primary key (MaNguoiDung, MaKhachHang),
Constraint FK_KHUser_TaiKhoan Foreign key (MaNguoiDung) references TaiKhoan(MaNguoiDung),
Constraint FK_KHUser_KhachHang Foreign key (MaKhachHang) references KhachHang(MaKhachHang)
)

Create table BaoCao
(
MaBaoCao char (5) not null Constraint PK_BaoCao Primary key,
TenBaoCao nvarchar (100) not null
)

Create table KhuyenMai
(
MaKhuyenMai char (5) not null Constraint PK_KhuyenMai Primary key,
TenKhuyenMai nvarchar (100) not null
)

Create table ChiTietKhuyenMai
(
NgayBD Date not null,
NgayKT Date not null,
PhanTramGiam Float not null,
MaKhuyenMai char (5) not null,
MaSanPham char (5) not null,
Constraint PK_ChiTietKhuyenMai Primary key (MaKhuyenMai, MaSanPham),
Constraint FK_CTKM_KhuyenMai Foreign key (MaKhuyenMai) references KhuyenMai(MaKhuyenMai),
Constraint FK_CTKM_SanPham Foreign key (MaSanPham) references SanPham(MaSanPham)
)

--Rang Buoc Toan Ven
-- R1
ALTER TABLE SanPham
ADD CONSTRAINT CK_SanPham_GiaBan CHECK (GiaBan >= 0)

-- R2
ALTER TABLE TonKho
ADD CONSTRAINT CK_TonKho_SoLuongTon CHECK (SoLuongTon >= 0)

-- R3
ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_CTHD_SoLuong CHECK (SoLuongHD >= 0)

-- R4
ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_CTHD_ThanhTien CHECK (ThanhTienHD >= 0)

-- R5
ALTER TABLE HoaDon
ADD CONSTRAINT CK_HoaDon_TongTien CHECK (TongTienHoaDon >= 0)

-- R6
ALTER TABLE ChiTietDonHang
ADD CONSTRAINT CK_CTDH_SoLuong CHECK (SoLuongDH >= 0)

-- R7
ALTER TABLE ChiTietDonHang
ADD CONSTRAINT CK_CTDH_ThanhTien CHECK (ThanhTienDH >= 0)

-- R8
ALTER TABLE DonHang
ADD CONSTRAINT CK_DonHang_TongTien CHECK (TongTienDonHang >= 0)

-- R9
ALTER TABLE ChiTietPhieuNhap
ADD CONSTRAINT CK_CTPN_SoLuong CHECK (SoLuongPN >= 0)

-- R10
ALTER TABLE ChiTietPhieuNhap
ADD CONSTRAINT CK_CTPN_ThanhTien CHECK (ThanhTienPN >= 0)

-- R11
ALTER TABLE PhieuNhap
ADD CONSTRAINT CK_PhieuNhap_TriGia CHECK (TriGiaPhieuNhap >= 0)

-- R12
IF EXISTS (
    SELECT 1 FROM sys.check_constraints 
    WHERE name = 'CK_CTHD_TinhTien'
)
    ALTER TABLE ChiTietHD DROP CONSTRAINT CK_CTHD_TinhTien
GO

ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_CTHD_TinhTien 
CHECK (ABS(ThanhTienHD - SoLuongHD * DonGiaHD) < 0.0001)
GO


-- R13
IF EXISTS (
    SELECT 1 FROM sys.check_constraints 
    WHERE name = 'CK_CTPN_TinhTien'
)
    ALTER TABLE ChiTietPhieuNhap DROP CONSTRAINT CK_CTPN_TinhTien
GO

ALTER TABLE ChiTietPhieuNhap
ADD CONSTRAINT CK_CTPN_TinhTien 
CHECK (ABS(ThanhTienPN - SoLuongPN * DonGiaPN) < 0.0001)
GO


-- R14
IF EXISTS (
    SELECT 1 FROM sys.check_constraints 
    WHERE name = 'CK_CTDH_TinhTien'
)
    ALTER TABLE ChiTietDonHang DROP CONSTRAINT CK_CTDH_TinhTien
GO

ALTER TABLE ChiTietDonHang
ADD CONSTRAINT CK_CTDH_TinhTien 
CHECK (ABS(ThanhTienDH - SoLuongDH * DonGiaDH) < 0.0001)
GO


--TRIGGER
GO
CREATE TRIGGER TRG_CTHD_Validate
ON ChiTietHD
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE SoLuongHD <= 0
           OR DonGiaHD < 0
    )
    BEGIN
        RAISERROR (N'Dữ liệu ChiTietHD không hợp lệ!',16,1)
        ROLLBACK TRAN
        RETURN
    END
END
GO

CREATE TRIGGER TRG_HoaDon_UpdateTongTien
ON ChiTietHD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Lấy tất cả SoHoaDon bị ảnh hưởng
    ;WITH AffectedHD AS (
        SELECT SoHoaDon FROM inserted
        UNION
        SELECT SoHoaDon FROM deleted
    )

    UPDATE h
    SET 
        TongTienHDtruocVAT = ISNULL(t.TongTruoc,0),
        TongTienHoaDon = ISNULL(t.TongTruoc * (1 + h.VATHoaDon / 100.0),0)
    FROM HoaDon h
    JOIN AffectedHD a ON h.SoHoaDon = a.SoHoaDon
    OUTER APPLY (
        SELECT 
            SUM(SoLuongHD * DonGiaHD) AS TongTruoc
        FROM ChiTietHD c
        WHERE c.SoHoaDon = h.SoHoaDon
    ) t;
END
GO

CREATE TRIGGER TRG_HoaDon_NotEmpty
ON ChiTietHD
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE NOT EXISTS (
            SELECT 1 
            FROM ChiTietHD c 
            WHERE c.SoHoaDon = d.SoHoaDon
        )
    )
    BEGIN
        RAISERROR(N'Hóa đơn phải có ít nhất 1 chi tiết!',16,1)
        ROLLBACK TRAN
        RETURN
    END
END
GO

CREATE TRIGGER TRG_DonHang_UpdateTongTien
ON ChiTietDonHang
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH AffectedDH AS (
        SELECT MaDonHang FROM inserted
        UNION
        SELECT MaDonHang FROM deleted
    )

    UPDATE d
    SET TongTienDonHang = ISNULL(t.Tong,0)
    FROM DonHang d
    JOIN AffectedDH a ON d.MaDonHang = a.MaDonHang
    OUTER APPLY (
        SELECT SUM(ThanhTienDH) AS Tong
        FROM ChiTietDonHang c
        WHERE c.MaDonHang = d.MaDonHang
    ) t;
END
GO

CREATE TRIGGER TRG_DonHang_NotEmpty
ON ChiTietDonHang
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE NOT EXISTS (
            SELECT 1 
            FROM ChiTietDonHang c 
            WHERE c.MaDonHang = d.MaDonHang
        )
    )
    BEGIN
        RAISERROR(N'Đơn hàng phải có ít nhất 1 sản phẩm!',16,1)
        ROLLBACK TRAN
    END
END
GO

CREATE TRIGGER TRG_PhieuNhap_UpdateTriGia
ON ChiTietPhieuNhap
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH AffectedPN AS (
        SELECT SoPhieuNhap FROM inserted
        UNION
        SELECT SoPhieuNhap FROM deleted
    )

    UPDATE p
    SET TriGiaPhieuNhap = ISNULL(t.Tong,0)
    FROM PhieuNhap p
    JOIN AffectedPN a ON p.SoPhieuNhap = a.SoPhieuNhap
    OUTER APPLY (
        SELECT SUM(ThanhTienPN) AS Tong
        FROM ChiTietPhieuNhap c
        WHERE c.SoPhieuNhap = p.SoPhieuNhap
    ) t;
END
GO

CREATE TRIGGER TRG_PhieuNhap_NotEmpty
ON ChiTietPhieuNhap
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE NOT EXISTS (
            SELECT 1 
            FROM ChiTietPhieuNhap c 
            WHERE c.SoPhieuNhap = d.SoPhieuNhap
        )
    )
    BEGIN
        RAISERROR(N'Phiếu nhập phải có ít nhất 1 sản phẩm!',16,1)
        ROLLBACK TRAN
    END
END
GO

GO
CREATE TRIGGER TRG_TonKho_Nhap
ON ChiTietPhieuNhap
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Giả sử mỗi chi nhánh 1 kho → lấy kho mặc định (ví dụ K0001)
    -- Nếu muốn chuẩn hơn → join theo chi nhánh sau

    MERGE TonKho AS target
    USING (
        SELECT MaSanPham, SUM(SoLuongPN) AS SoLuongNhap
        FROM inserted
        GROUP BY MaSanPham
    ) AS source
    ON target.MaSanPham = source.MaSanPham
       AND target.MaKho = 'K0001'  -- kho mặc định

    WHEN MATCHED THEN
        UPDATE SET SoLuongTon = target.SoLuongTon + source.SoLuongNhap

    WHEN NOT MATCHED THEN
        INSERT (MaKho, MaSanPham, SoLuongTon)
        VALUES ('K0001', source.MaSanPham, source.SoLuongNhap);
END
GO

GO
CREATE TRIGGER TRG_TonKho_Ban
ON ChiTietHD
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra đủ tồn kho trước khi trừ
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TonKho t 
            ON t.MaSanPham = i.MaSanPham
           AND t.MaKho = 'K0001'
        WHERE t.SoLuongTon < i.SoLuongHD
    )
    BEGIN
        RAISERROR (N'Không đủ tồn kho để bán!',16,1)
        ROLLBACK TRAN
        RETURN
    END

    -- Trừ tồn
    UPDATE t
    SET t.SoLuongTon = t.SoLuongTon - i.SoLuongHD
    FROM TonKho t
    JOIN inserted i
        ON t.MaSanPham = i.MaSanPham
       AND t.MaKho = 'K0001';
END
GO

CREATE TABLE AuditLog (
    ID INT IDENTITY PRIMARY KEY,
    UserName NVARCHAR(100),
    TableName NVARCHAR(100),
    Action NVARCHAR(10),
    TimeStamp DATETIME DEFAULT GETDATE() NOT NULL
)

GO 
CREATE TRIGGER trg_Audit_HoaDon
ON HoaDon
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'HoaDon', 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

    -- DELETE
    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'HoaDon', 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

    -- UPDATE
    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'HoaDon', 'UPDATE'
    FROM inserted i
    JOIN deleted d ON i.SoHoaDon = d.SoHoaDon;
END
GO

CREATE TRIGGER trg_Audit_DonHang
ON DonHang
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'DonHang', 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'DonHang', 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'DonHang', 'UPDATE'
    FROM inserted i
    JOIN deleted d ON i.MaDonHang = d.MaDonHang;
END
GO

CREATE TRIGGER trg_Audit_PhieuNhap
ON PhieuNhap
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'PhieuNhap', 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'PhieuNhap', 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'PhieuNhap', 'UPDATE'
    FROM inserted i
    JOIN deleted d ON i.SoPhieuNhap = d.SoPhieuNhap;
END
GO

CREATE TRIGGER trg_TinhThanhTienHD
ON ChiTietHD
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET ThanhTienHD = c.DonGiaHD * c.SoLuongHD
    FROM ChiTietHD c
    INNER JOIN inserted i
        ON c.SoHoaDon = i.SoHoaDon
        AND c.MaSanPham = i.MaSanPham;
END

INSERT INTO DanhMucSP VALUES
('DM001', N'Đồ ăn nhanh'),
('DM002', N'Nước uống'),
('DM003', N'Đồ dùng cá nhân'),
('DM004', N'Thực phẩm đóng gói'),
('DM005', N'Đồ gia dụng nhỏ');

INSERT INTO SanPham VALUES
('SP001', N'Mì ly Hảo Hảo', 15000, N'Ly', 'DM001'),
('SP002', N'Cơm gà xối mỡ', 35000, N'Hộp', 'DM001'),
('SP003', N'Bánh mì sandwich', 20000, N'Ổ', 'DM001'),
('SP004', N'Xúc xích CP', 12000, N'Cây', 'DM001'),
('SP005', N'Cơm thịt kho trứng', 40000, N'Hộp', 'DM001'),

('SP006', N'Nước suối Aquafina', 10000, N'Chai', 'DM002'),
('SP007', N'Coca Cola lon', 12000, N'Lon', 'DM002'),
('SP008', N'Pepsi lon', 12000, N'Lon', 'DM002'),
('SP009', N'Trà xanh C2', 10000, N'Chai', 'DM002'),
('SP010', N'Cà phê lon Nescafe', 15000, N'Lon', 'DM002'),

('SP011', N'Khăn giấy Tempo', 8000, N'Gói', 'DM003'),
('SP012', N'Bàn chải đánh răng', 15000, N'Cây', 'DM003'),
('SP013', N'Kem đánh răng P/S', 25000, N'Tuýp', 'DM003'),
('SP014', N'Khẩu trang y tế', 5000, N'Cái', 'DM003'),

('SP015', N'Bánh Oreo', 18000, N'Gói', 'DM004'),
('SP016', N'Snack khoai tây Lay’s', 15000, N'Gói', 'DM004'),
('SP017', N'Kẹo dẻo Haribo', 20000, N'Gói', 'DM004'),
('SP018', N'Chocolate KitKat', 22000, N'Thanh', 'DM004'),

('SP019', N'Ly nhựa dùng 1 lần', 5000, N'Cái', 'DM005'),
('SP020', N'Muỗng nhựa', 3000, N'Cái', 'DM005');

UPDATE SanPham SET HinhAnh = 'images/SP01.jpg' WHERE MaSanPham = 'SP001';
UPDATE SanPham SET HinhAnh = 'images/SP02.jpg' WHERE MaSanPham = 'SP002';
UPDATE SanPham SET HinhAnh = 'images/SP03.jpg' WHERE MaSanPham = 'SP003';
UPDATE SanPham SET HinhAnh = 'images/SP04.jpg' WHERE MaSanPham = 'SP004';
UPDATE SanPham SET HinhAnh = 'images/SP05.jpg' WHERE MaSanPham = 'SP005';

UPDATE SanPham SET HinhAnh = 'images/SP06.jpg' WHERE MaSanPham = 'SP006';
UPDATE SanPham SET HinhAnh = 'images/SP07.jpg' WHERE MaSanPham = 'SP007';
UPDATE SanPham SET HinhAnh = 'images/SP08.jpg' WHERE MaSanPham = 'SP008';
UPDATE SanPham SET HinhAnh = 'images/SP09.jpg' WHERE MaSanPham = 'SP009';
UPDATE SanPham SET HinhAnh = 'images/SP10.jpg' WHERE MaSanPham = 'SP010';

UPDATE SanPham SET HinhAnh = 'images/SP11.jpg' WHERE MaSanPham = 'SP011';
UPDATE SanPham SET HinhAnh = 'images/SP12.jpg' WHERE MaSanPham = 'SP012';
UPDATE SanPham SET HinhAnh = 'images/SP13.jpg' WHERE MaSanPham = 'SP013';
UPDATE SanPham SET HinhAnh = 'images/SP14.jpg' WHERE MaSanPham = 'SP014';
UPDATE SanPham SET HinhAnh = 'images/SP15.jpg' WHERE MaSanPham = 'SP015';

UPDATE SanPham SET HinhAnh = 'images/SP16.jpg' WHERE MaSanPham = 'SP016';
UPDATE SanPham SET HinhAnh = 'images/SP17.jpg' WHERE MaSanPham = 'SP017';
UPDATE SanPham SET HinhAnh = 'images/SP18.jpg' WHERE MaSanPham = 'SP018';
UPDATE SanPham SET HinhAnh = 'images/SP19.jpg' WHERE MaSanPham = 'SP019';
UPDATE SanPham SET HinhAnh = 'images/SP20.jpg' WHERE MaSanPham = 'SP020';


INSERT INTO NhanVien VALUES
('NV001', N'Nguyễn Văn An', N'Nam', '0900000001', N'123 Nguyễn Trãi, Q1, TP.HCM', '100000000001', '2022-01-01', N'Quản lý'),
('NV002', N'Trần Thị Bình', N'Nữ', '0900000002', N'45 Lê Lợi, Q1, TP.HCM', '100000000002', '2022-02-01', N'Quản trị viên hệ thống'),

('NV003', N'Lê Văn Cường', N'Nam', '0900000003', N'78 Trần Hưng Đạo, Q5, TP.HCM', '100000000003', '2023-01-10', N'Nhân viên bán hàng'),
('NV004', N'Phạm Thị Dung', N'Nữ', '0900000004', N'22 Nguyễn Văn Cừ, Q5, TP.HCM', '100000000004', '2023-01-12', N'Nhân viên kho'),
('NV005', N'Hoàng Văn Em', N'Nam', '0900000005', N'90 Lý Thường Kiệt, Q10, TP.HCM', '100000000005', '2023-02-01', N'Nhân viên bán hàng'),
('NV006', N'Nguyễn Thị Hoa', N'Nữ', '0900000006', N'15 Tô Hiến Thành, Q10, TP.HCM', '100000000006', '2023-02-05', N'Nhân viên kho'),
('NV007', N'Võ Văn Hải', N'Nam', '0900000007', N'101 Điện Biên Phủ, Q3, TP.HCM', '100000000007', '2023-03-01', N'Nhân viên bán hàng'),
('NV008', N'Đặng Thị Lan', N'Nữ', '0900000008', N'33 Võ Thị Sáu, Q3, TP.HCM', '100000000008', '2023-03-03', N'Nhân viên kho'),
('NV009', N'Bùi Văn Long', N'Nam', '0900000009', N'55 Cách Mạng Tháng 8, Q10, TP.HCM', '100000000009', '2023-03-10', N'Nhân viên bán hàng'),
('NV010', N'Lý Thị Mai', N'Nữ', '0900000010', N'12 Nguyễn Chí Thanh, Q5, TP.HCM', '100000000010', '2023-03-12', N'Nhân viên kho'),
('NV011', N'Ngô Văn Nam', N'Nam', '0900000011', N'88 Phan Xích Long, Phú Nhuận, TP.HCM', '100000000011', '2023-04-01', N'Nhân viên bán hàng'),
('NV012', N'Phan Thị Oanh', N'Nữ', '0900000012', N'47 Nguyễn Kiệm, Gò Vấp, TP.HCM', '100000000012', '2023-04-05', N'Nhân viên kho'),
('NV013', N'Đỗ Văn Phúc', N'Nam', '0900000013', N'19 Quang Trung, Gò Vấp, TP.HCM', '100000000013', '2023-04-10', N'Nhân viên bán hàng'),
('NV014', N'Huỳnh Thị Quỳnh', N'Nữ', '0900000014', N'64 Lê Đức Thọ, Gò Vấp, TP.HCM', '100000000014', '2023-04-15', N'Nhân viên kho'),
('NV015', N'Trịnh Văn Sơn', N'Nam', '0900000015', N'200 Nguyễn Thị Minh Khai, Q3, TP.HCM', '100000000015', '2023-05-01', N'Nhân viên bán hàng'),
('NV016', N'Lê Thị Trang', N'Nữ', '0900000016', N'75 Hai Bà Trưng, Q1, TP.HCM', '100000000016', '2023-05-05', N'Nhân viên kho'),
('NV017', N'Nguyễn Văn Tuấn', N'Nam', '0900000017', N'150 Lê Văn Sỹ, Phú Nhuận, TP.HCM', '100000000017', '2023-05-10', N'Nhân viên bán hàng'),
('NV018', N'Phạm Thị Uyên', N'Nữ', '0900000018', N'29 Phạm Văn Đồng, Bình Thạnh, TP.HCM', '100000000018', '2023-05-15', N'Nhân viên kho'),
('NV019', N'Vũ Văn Vinh', N'Nam', '0900000019', N'310 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM', '100000000019', '2023-06-01', N'Nhân viên bán hàng'),
('NV020', N'Đặng Thị Yến', N'Nữ', '0900000020', N'11 Đinh Bộ Lĩnh, Bình Thạnh, TP.HCM', '100000000020', '2023-06-05', N'Nhân viên kho');

INSERT INTO PhieuNhap VALUES
('PN00000001','2026-04-01',N'Nhập hàng định kỳ',0,N'Đã nhập','NV004'),
('PN00000002','2026-04-02',N'Nhập bổ sung',0,N'Đã nhập','NV006'),
('PN00000003','2026-04-03',N'Nhập hàng mới',0,N'Đã nhập','NV008'),
('PN00000004','2026-04-04',N'Nhập định kỳ',0,N'Đã nhập','NV010'),
('PN00000005','2026-04-05',N'Nhập bổ sung',0,N'Đã nhập','NV012'),
('PN00000006','2026-04-06',N'Nhập hàng',0,N'Đã nhập','NV014'),
('PN00000007','2026-04-07',N'Nhập hàng',0,N'Đã nhập','NV016'),
('PN00000008','2026-04-08',N'Nhập hàng',0,N'Đã nhập','NV018'),
('PN00000009','2026-04-09',N'Nhập hàng',0,N'Đã nhập','NV020'),
('PN00000010','2026-04-10',N'Nhập hàng',0,N'Đã nhập','NV004'),

('PN00000011','2026-04-11',N'Nhập hàng',0,N'Đã nhập','NV006'),
('PN00000012','2026-04-12',N'Nhập hàng',0,N'Đã nhập','NV008'),
('PN00000013','2026-04-13',N'Nhập hàng',0,N'Đã nhập','NV010'),
('PN00000014','2026-04-14',N'Nhập hàng',0,N'Đã nhập','NV012'),
('PN00000015','2026-04-15',N'Nhập hàng',0,N'Đã nhập','NV014'),
('PN00000016','2026-04-16',N'Nhập hàng',0,N'Đã nhập','NV016'),
('PN00000017','2026-04-17',N'Nhập hàng',0,N'Đã nhập','NV018'),
('PN00000018','2026-04-18',N'Nhập hàng',0,N'Đã nhập','NV020'),
('PN00000019','2026-04-19',N'Nhập hàng',0,N'Đã nhập','NV004'),
('PN00000020','2026-04-20',N'Nhập hàng',0,N'Đã nhập','NV006');

INSERT INTO ChiTietPhieuNhap VALUES
(10000,10,100000,'PN00000001','SP006'),
(15000,5,75000,'PN00000001','SP001'),

(12000,8,96000,'PN00000002','SP007'),

(15000,10,150000,'PN00000003','SP002'),
(10000,6,60000,'PN00000003','SP003'),

(12000,12,144000,'PN00000004','SP004'),

(8000,15,120000,'PN00000005','SP011'),
(25000,4,100000,'PN00000005','SP013'),

(18000,6,108000,'PN00000006','SP015'),

(15000,7,105000,'PN00000007','SP016'),
(20000,5,100000,'PN00000007','SP017'),

(22000,6,132000,'PN00000008','SP018'),

(5000,20,100000,'PN00000009','SP019'),

(3000,30,90000,'PN00000010','SP020'),
(12000,10,120000,'PN00000010','SP007'),

(15000,6,90000,'PN00000011','SP001'),

(35000,4,140000,'PN00000012','SP002'),
(10000,8,80000,'PN00000012','SP003'),

(12000,10,120000,'PN00000013','SP004'),

(8000,10,80000,'PN00000014','SP011'),

(25000,5,125000,'PN00000015','SP013'),

(18000,7,126000,'PN00000016','SP015'),

(15000,8,120000,'PN00000017','SP016'),

(20000,6,120000,'PN00000018','SP017'),

(22000,5,110000,'PN00000019','SP018'),

(5000,25,125000,'PN00000020','SP019'),
(3000,40,120000,'PN00000020','SP020');


INSERT INTO KhachHang VALUES
('KH001', N'Nguyễn Minh Anh', '0910000001', N'12 Nguyễn Trãi, Q1, TP.HCM'),
('KH002', N'Trần Thị Bích', '0910000002', N'45 Lê Lợi, Q1, TP.HCM'),
('KH003', N'Lê Văn Cường', '0910000003', N'78 Trần Hưng Đạo, Q5, TP.HCM'),
('KH004', N'Phạm Thị Dung', '0910000004', N'22 Nguyễn Văn Cừ, Q5, TP.HCM'),
('KH005', N'Hoàng Văn Em', '0910000005', N'90 Lý Thường Kiệt, Q10, TP.HCM'),
('KH006', N'Nguyễn Thị Hoa', '0910000006', N'15 Tô Hiến Thành, Q10, TP.HCM'),
('KH007', N'Võ Văn Hải', '0910000007', N'101 Điện Biên Phủ, Q3, TP.HCM'),
('KH008', N'Đặng Thị Lan', '0910000008', N'33 Võ Thị Sáu, Q3, TP.HCM'),
('KH009', N'Bùi Văn Long', '0910000009', N'55 Cách Mạng Tháng 8, Q10, TP.HCM'),
('KH010', N'Lý Thị Mai', '0910000010', N'12 Nguyễn Chí Thanh, Q5, TP.HCM'),

('KH011', N'Ngô Văn Nam', '0910000011', N'88 Phan Xích Long, Phú Nhuận, TP.HCM'),
('KH012', N'Phan Thị Oanh', '0910000012', N'47 Nguyễn Kiệm, Gò Vấp, TP.HCM'),
('KH013', N'Đỗ Văn Phúc', '0910000013', N'19 Quang Trung, Gò Vấp, TP.HCM'),
('KH014', N'Huỳnh Thị Quỳnh', '0910000014', N'64 Lê Đức Thọ, Gò Vấp, TP.HCM'),
('KH015', N'Trịnh Văn Sơn', '0910000015', N'200 Nguyễn Thị Minh Khai, Q3, TP.HCM'),
('KH016', N'Lê Thị Trang', '0910000016', N'75 Hai Bà Trưng, Q1, TP.HCM'),
('KH017', N'Nguyễn Văn Tuấn', '0910000017', N'150 Lê Văn Sỹ, Phú Nhuận, TP.HCM'),
('KH018', N'Phạm Thị Uyên', '0910000018', N'29 Phạm Văn Đồng, Bình Thạnh, TP.HCM'),
('KH019', N'Vũ Văn Vinh', '0910000019', N'310 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM'),
('KH020', N'Đặng Thị Yến', '0910000020', N'11 Đinh Bộ Lĩnh, Bình Thạnh, TP.HCM');

INSERT INTO DonHang 
(MaDonHang, NgayDat, NgayGiao, TongTienDonHang, PhuongThucTTDH, TrangThaiDH, MaKhachHang)
VALUES
('DH001','2026-04-01','2026-04-02',0,N'Tiền mặt',N'Đang xử lý','KH001'),
('DH002','2026-04-02','2026-04-03',0,N'Thẻ',N'Đang xử lý','KH002'),
('DH003','2026-04-03','2026-04-04',0,N'Momo',N'Đang xử lý','KH003'),
('DH004','2026-04-04','2026-04-05',0,N'Tiền mặt',N'Đang xử lý','KH004'),
('DH005','2026-04-05','2026-04-06',0,N'Thẻ',N'Đang xử lý','KH005'),
('DH006','2026-04-06','2026-04-07',0,N'Momo',N'Đang xử lý','KH006'),
('DH007','2026-04-07','2026-04-08',0,N'Tiền mặt',N'Đang xử lý','KH007'),
('DH008','2026-04-08','2026-04-09',0,N'Thẻ',N'Đang xử lý','KH008'),
('DH009','2026-04-09','2026-04-10',0,N'Momo',N'Đang xử lý','KH009'),
('DH010','2026-04-10','2026-04-11',0,N'Tiền mặt',N'Đang xử lý','KH010'),
('DH011','2026-04-11','2026-04-12',0,N'Thẻ',N'Đang xử lý','KH011'),
('DH012','2026-04-12','2026-04-13',0,N'Momo',N'Đang xử lý','KH012'),
('DH013','2026-04-13','2026-04-14',0,N'Tiền mặt',N'Đang xử lý','KH013'),
('DH014','2026-04-14','2026-04-15',0,N'Thẻ',N'Đang xử lý','KH014'),
('DH015','2026-04-15','2026-04-16',0,N'Momo',N'Đang xử lý','KH015'),
('DH016','2026-04-16','2026-04-17',0,N'Tiền mặt',N'Đang xử lý','KH016'),
('DH017','2026-04-17','2026-04-18',0,N'Thẻ',N'Đang xử lý','KH017'),
('DH018','2026-04-18','2026-04-19',0,N'Momo',N'Đang xử lý','KH018'),
('DH019','2026-04-19','2026-04-20',0,N'Tiền mặt',N'Đang xử lý','KH019'),
('DH020','2026-04-20','2026-04-21',0,N'Thẻ',N'Đang xử lý','KH020');

INSERT INTO ChiTietDonHang VALUES
(15000,2,30000,'DH001','SP001'),
(10000,1,10000,'DH001','SP006'),

(35000,1,35000,'DH002','SP002'),

(20000,2,40000,'DH003','SP003'),
(12000,2,24000,'DH003','SP004'),

(12000,3,36000,'DH004','SP004'),

(15000,2,30000,'DH005','SP001'),
(18000,1,18000,'DH005','SP015'),

(10000,2,20000,'DH006','SP006'),

(15000,1,15000,'DH007','SP016'),
(20000,1,20000,'DH007','SP017'),

(22000,2,44000,'DH008','SP018'),

(8000,3,24000,'DH009','SP011'),

(25000,1,25000,'DH010','SP013'),
(12000,2,24000,'DH010','SP007'),

(15000,2,30000,'DH011','SP001'),

(35000,1,35000,'DH012','SP002'),
(10000,2,20000,'DH012','SP003'),

(12000,2,24000,'DH013','SP004'),

(8000,2,16000,'DH014','SP011'),

(25000,2,50000,'DH015','SP013'),

(18000,2,36000,'DH016','SP015'),

(15000,3,45000,'DH017','SP016'),

(20000,2,40000,'DH018','SP017'),

(22000,1,22000,'DH019','SP018'),

(5000,5,25000,'DH020','SP019'),
(3000,10,30000,'DH020','SP020');

INSERT INTO HoaDon 
(SoHoaDon, NgayLapHoaDon, TongTienHDtruocVAT, VATHoaDon, TongTienHoaDon,
 PhuongThucTTHD, TrangThaiHD, MaDonHang, MaKhachHang, MaNhanVien)
VALUES
('HD00000001','2026-04-02',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH001','KH001','NV003'),
('HD00000002','2026-04-03',0,10,0,N'Thẻ',N'Đã thanh toán','DH002','KH002','NV005'),
('HD00000003','2026-04-04',0,10,0,N'Momo',N'Đã thanh toán','DH003','KH003','NV007'),
('HD00000004','2026-04-05',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH004','KH004','NV009'),
('HD00000005','2026-04-06',0,10,0,N'Thẻ',N'Đã thanh toán','DH005','KH005','NV011'),
('HD00000006','2026-04-07',0,10,0,N'Momo',N'Đã thanh toán','DH006','KH006','NV013'),
('HD00000007','2026-04-08',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH007','KH007','NV015'),
('HD00000008','2026-04-09',0,10,0,N'Thẻ',N'Đã thanh toán','DH008','KH008','NV017'),
('HD00000009','2026-04-10',0,10,0,N'Momo',N'Đã thanh toán','DH009','KH009','NV019'),
('HD00000010','2026-04-11',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH010','KH010','NV003'),

('HD00000011','2026-04-12',0,10,0,N'Thẻ',N'Đã thanh toán','DH011','KH011','NV005'),
('HD00000012','2026-04-13',0,10,0,N'Momo',N'Đã thanh toán','DH012','KH012','NV007'),
('HD00000013','2026-04-14',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH013','KH013','NV009'),
('HD00000014','2026-04-15',0,10,0,N'Thẻ',N'Đã thanh toán','DH014','KH014','NV011'),
('HD00000015','2026-04-16',0,10,0,N'Momo',N'Đã thanh toán','DH015','KH015','NV013'),
('HD00000016','2026-04-17',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH016','KH016','NV015'),
('HD00000017','2026-04-18',0,10,0,N'Thẻ',N'Đã thanh toán','DH017','KH017','NV017'),
('HD00000018','2026-04-19',0,10,0,N'Momo',N'Đã thanh toán','DH018','KH018','NV019'),
('HD00000019','2026-04-20',0,10,0,N'Tiền mặt',N'Đã thanh toán','DH019','KH019','NV003'),
('HD00000020','2026-04-21',0,10,0,N'Thẻ',N'Đã thanh toán','DH020','KH020','NV005');

INSERT INTO ChiTietHD VALUES
(15000,2,30000,'HD00000001','SP001'),
(10000,1,10000,'HD00000001','SP006'),

(35000,1,35000,'HD00000002','SP002'),

(20000,2,40000,'HD00000003','SP003'),
(12000,2,24000,'HD00000003','SP004'),

(12000,3,36000,'HD00000004','SP004'),

(15000,2,30000,'HD00000005','SP001'),
(18000,1,18000,'HD00000005','SP015'),

(10000,2,20000,'HD00000006','SP006'),

(15000,1,15000,'HD00000007','SP016'),
(20000,1,20000,'HD00000007','SP017'),

(22000,2,44000,'HD00000008','SP018'),

(8000,3,24000,'HD00000009','SP011'),

(25000,1,25000,'HD00000010','SP013'),
(12000,2,24000,'HD00000010','SP007'),

(15000,2,30000,'HD00000011','SP001'),

(35000,1,35000,'HD00000012','SP002'),
(10000,2,20000,'HD00000012','SP003'),

(12000,2,24000,'HD00000013','SP004'),

(8000,2,16000,'HD00000014','SP011'),

(25000,2,50000,'HD00000015','SP013'),

(18000,2,36000,'HD00000016','SP015'),

(15000,3,45000,'HD00000017','SP016'),

(20000,2,40000,'HD00000018','SP017'),

(22000,1,22000,'HD00000019','SP018'),

(5000,5,25000,'HD00000020','SP019'),
(3000,10,30000,'HD00000020','SP020');

INSERT INTO ChiNhanh VALUES
('CN001', N'GS25 Quận 1', N'25 Nguyễn Huệ, Q1, TP.HCM'),
('CN002', N'GS25 Quận 3', N'120 Võ Thị Sáu, Q3, TP.HCM'),
('CN003', N'GS25 Quận 5', N'88 Trần Hưng Đạo, Q5, TP.HCM'),
('CN004', N'GS25 Gò Vấp', N'45 Quang Trung, Gò Vấp, TP.HCM'),
('CN005', N'GS25 Bình Thạnh', N'210 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM');

INSERT INTO Kho VALUES
('K0001', N'Kho Quận 1', N'25 Nguyễn Huệ, Q1, TP.HCM', 'CN001'),
('K0002', N'Kho Quận 3', N'120 Võ Thị Sáu, Q3, TP.HCM', 'CN002'),
('K0003', N'Kho Quận 5', N'88 Trần Hưng Đạo, Q5, TP.HCM', 'CN003'),
('K0004', N'Kho Gò Vấp', N'45 Quang Trung, Gò Vấp, TP.HCM', 'CN004'),
('K0005', N'Kho Bình Thạnh', N'210 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM', 'CN005');

INSERT INTO TonKho VALUES
-- ===== K0001 =====
(100,'K0001','SP001'),(90,'K0001','SP002'),(80,'K0001','SP003'),(120,'K0001','SP004'),(110,'K0001','SP005'),
(130,'K0001','SP006'),(95,'K0001','SP007'),(85,'K0001','SP008'),(75,'K0001','SP009'),(60,'K0001','SP010'),
(140,'K0001','SP011'),(150,'K0001','SP012'),(160,'K0001','SP013'),(170,'K0001','SP014'),(180,'K0001','SP015'),
(190,'K0001','SP016'),(200,'K0001','SP017'),(210,'K0001','SP018'),(220,'K0001','SP019'),(230,'K0001','SP020'),

-- ===== K0002 =====
(95,'K0002','SP001'),(85,'K0002','SP002'),(75,'K0002','SP003'),(110,'K0002','SP004'),(105,'K0002','SP005'),
(125,'K0002','SP006'),(90,'K0002','SP007'),(80,'K0002','SP008'),(70,'K0002','SP009'),(55,'K0002','SP010'),
(135,'K0002','SP011'),(145,'K0002','SP012'),(155,'K0002','SP013'),(165,'K0002','SP014'),(175,'K0002','SP015'),
(185,'K0002','SP016'),(195,'K0002','SP017'),(205,'K0002','SP018'),(215,'K0002','SP019'),(225,'K0002','SP020'),

-- ===== K0003 =====
(110,'K0003','SP001'),(100,'K0003','SP002'),(90,'K0003','SP003'),(130,'K0003','SP004'),(120,'K0003','SP005'),
(140,'K0003','SP006'),(105,'K0003','SP007'),(95,'K0003','SP008'),(85,'K0003','SP009'),(70,'K0003','SP010'),
(150,'K0003','SP011'),(160,'K0003','SP012'),(170,'K0003','SP013'),(180,'K0003','SP014'),(190,'K0003','SP015'),
(200,'K0003','SP016'),(210,'K0003','SP017'),(220,'K0003','SP018'),(230,'K0003','SP019'),(240,'K0003','SP020'),

-- ===== K0004 =====
(105,'K0004','SP001'),(95,'K0004','SP002'),(85,'K0004','SP003'),(125,'K0004','SP004'),(115,'K0004','SP005'),
(135,'K0004','SP006'),(100,'K0004','SP007'),(90,'K0004','SP008'),(80,'K0004','SP009'),(65,'K0004','SP010'),
(145,'K0004','SP011'),(155,'K0004','SP012'),(165,'K0004','SP013'),(175,'K0004','SP014'),(185,'K0004','SP015'),
(195,'K0004','SP016'),(205,'K0004','SP017'),(215,'K0004','SP018'),(225,'K0004','SP019'),(235,'K0004','SP020'),

-- ===== K0005 =====
(115,'K0005','SP001'),(105,'K0005','SP002'),(95,'K0005','SP003'),(135,'K0005','SP004'),(125,'K0005','SP005'),
(145,'K0005','SP006'),(110,'K0005','SP007'),(100,'K0005','SP008'),(90,'K0005','SP009'),(75,'K0005','SP010'),
(155,'K0005','SP011'),(165,'K0005','SP012'),(175,'K0005','SP013'),(185,'K0005','SP014'),(195,'K0005','SP015'),
(205,'K0005','SP016'),(215,'K0005','SP017'),(225,'K0005','SP018'),(235,'K0005','SP019'),(245,'K0005','SP020');

INSERT INTO TheThanhVien VALUES
('TV001', 120, 'KH001'),
('TV002', 50,  'KH002'),
('TV003', 200, 'KH003'),
('TV004', 75,  'KH004'),
('TV005', 300, 'KH005'),
('TV006', 90,  'KH006'),
('TV007', 40,  'KH007'),
('TV008', 180, 'KH008'),
('TV009', 220, 'KH009'),
('TV010', 60,  'KH010'),

('TV011', 130, 'KH011'),
('TV012', 80,  'KH012'),
('TV013', 170, 'KH013'),
('TV014', 55,  'KH014'),
('TV015', 260, 'KH015'),
('TV016', 95,  'KH016'),
('TV017', 110, 'KH017'),
('TV018', 140, 'KH018'),
('TV019', 210, 'KH019'),
('TV020', 70,  'KH020');

INSERT INTO VaiTro VALUES
('VT001', N'Khách hàng'),
('VT002', N'Nhân viên bán hàng'),
('VT003', N'Nhân viên kho'),
('VT004', N'Quản lý'),
('VT005', N'Quản trị viên');

-- =======================
-- KHÁCH HÀNG (ND001–ND020)
-- =======================
INSERT INTO TaiKhoan VALUES
('ND001','nguyenminhanh','123','VT001'),
('ND002','tranthibich','123','VT001'),
('ND003','levancuong','123','VT001'),
('ND004','phamthidung','123','VT001'),
('ND005','hoangvanem','123','VT001'),
('ND006','nguyenthihoa','123','VT001'),
('ND007','vovanhai','123','VT001'),
('ND008','dangthilan','123','VT001'),
('ND009','buivanlong','123','VT001'),
('ND010','lythimai','123','VT001'),
('ND011','ngovannam','123','VT001'),
('ND012','phanthioanh','123','VT001'),
('ND013','dovanphuc','123','VT001'),
('ND014','huynhthiquynh','123','VT001'),
('ND015','trinhvanson','123','VT001'),
('ND016','lethitrang','123','VT001'),
('ND017','nguyenvantuan','123','VT001'),
('ND018','phamthuyen','123','VT001'),
('ND019','vuvanvinh','123','VT001'),
('ND020','dangthiyen','123','VT001');

-- =======================
-- NHÂN VIÊN (ND021–ND040)
-- =======================
INSERT INTO TaiKhoan VALUES
('ND021','nguyenvanan_quanly','123','VT004'),
('ND022','tranthibinh_quantrivien','123','VT005'),

('ND023','levancuong_banhang','123','VT002'),
('ND024','phamthidung_kho','123','VT003'),
('ND025','hoangvanem_banhang','123','VT002'),
('ND026','nguyenthihoa_kho','123','VT003'),
('ND027','vovanhai_banhang','123','VT002'),
('ND028','dangthilan_kho','123','VT003'),
('ND029','buivanlong_banhang','123','VT002'),
('ND030','lythimai_kho','123','VT003'),
('ND031','ngovannam_banhang','123','VT002'),
('ND032','phanthioanh_kho','123','VT003'),
('ND033','dovanphuc_banhang','123','VT002'),
('ND034','huynhthiquynh_kho','123','VT003'),
('ND035','trinhvanson_banhang','123','VT002'),
('ND036','lethitrang_kho','123','VT003'),
('ND037','nguyenvantuan_banhang','123','VT002'),
('ND038','phamthuyen_kho','123','VT003'),
('ND039','vuvanvinh_banhang','123','VT002'),
('ND040','dangthiyen_kho','123','VT003');

INSERT INTO KhachHangUser VALUES
('ND001','KH001'),
('ND002','KH002'),
('ND003','KH003'),
('ND004','KH004'),
('ND005','KH005'),
('ND006','KH006'),
('ND007','KH007'),
('ND008','KH008'),
('ND009','KH009'),
('ND010','KH010'),
('ND011','KH011'),
('ND012','KH012'),
('ND013','KH013'),
('ND014','KH014'),
('ND015','KH015'),
('ND016','KH016'),
('ND017','KH017'),
('ND018','KH018'),
('ND019','KH019'),
('ND020','KH020');

INSERT INTO NhanVienUser VALUES
('ND021','NV001'),
('ND022','NV002'),
('ND023','NV003'),
('ND024','NV004'),
('ND025','NV005'),
('ND026','NV006'),
('ND027','NV007'),
('ND028','NV008'),
('ND029','NV009'),
('ND030','NV010'),
('ND031','NV011'),
('ND032','NV012'),
('ND033','NV013'),
('ND034','NV014'),
('ND035','NV015'),
('ND036','NV016'),
('ND037','NV017'),
('ND038','NV018'),
('ND039','NV019'),
('ND040','NV020');

INSERT INTO BaoCao VALUES
('BC001', N'Báo cáo doanh thu theo tháng'),
('BC002', N'Báo cáo tồn kho sản phẩm'),
('BC003', N'Báo cáo khách hàng mới'),
('BC004', N'Báo cáo nhân viên bán hàng'),
('BC005', N'Báo cáo nhập hàng theo nhà cung cấp');

INSERT INTO KhuyenMai VALUES
('KM001', N'Tết Nguyên Đán 2026 - Giảm giá đầu năm'),
('KM002', N'Chào hè 2026 - Giải nhiệt mùa nóng'),
('KM003', N'Flash Sale cuối tuần - Siêu giảm giá'),
('KM004', N'Ưu đãi khách hàng mới tháng 4/2026'),
('KM005', N'Combo tiết kiệm - Mua nhiều giảm nhiều');

INSERT INTO ChiTietKhuyenMai VALUES
-- Tết: nhu yếu phẩm + đồ ăn nhanh
('2026-01-20','2026-02-05',12,'KM001','SP001'),

-- Mùa hè: đồ uống
('2026-05-01','2026-05-14',15,'KM002','SP006'),

-- Flash sale cuối tuần
('2026-04-18','2026-04-19',20,'KM003','SP010'),

-- Khách hàng mới (tháng 4)
('2026-04-01','2026-04-10',10,'KM004','SP015'),

-- Combo snack + chocolate
('2026-03-25','2026-04-05',18,'KM005','SP018');