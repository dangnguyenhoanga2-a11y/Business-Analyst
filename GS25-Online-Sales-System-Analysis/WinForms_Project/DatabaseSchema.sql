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

ALTER TABLE SanPham
ADD CONSTRAINT CK_SanPham_GiaBan CHECK (GiaBan >= 0)

ALTER TABLE TonKho
ADD CONSTRAINT CK_TonKho_SoLuongTon CHECK (SoLuongTon >= 0)

ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_CTHD_SoLuong CHECK (SoLuongHD >= 0)

ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_CTHD_ThanhTien CHECK (ThanhTienHD >= 0)

ALTER TABLE HoaDon
ADD CONSTRAINT CK_HoaDon_TongTien CHECK (TongTienHoaDon >= 0)

ALTER TABLE ChiTietDonHang
ADD CONSTRAINT CK_CTDH_SoLuong CHECK (SoLuongDH >= 0)

ALTER TABLE ChiTietDonHang
ADD CONSTRAINT CK_CTDH_ThanhTien CHECK (ThanhTienDH >= 0)

ALTER TABLE DonHang
ADD CONSTRAINT CK_DonHang_TongTien CHECK (TongTienDonHang >= 0)

ALTER TABLE ChiTietPhieuNhap
ADD CONSTRAINT CK_CTPN_SoLuong CHECK (SoLuongPN >= 0)

ALTER TABLE ChiTietPhieuNhap
ADD CONSTRAINT CK_CTPN_ThanhTien CHECK (ThanhTienPN >= 0)

ALTER TABLE PhieuNhap
ADD CONSTRAINT CK_PhieuNhap_TriGia CHECK (TriGiaPhieuNhap >= 0)

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
        SELECT SUM(SoLuongHD * DonGiaHD) AS TongTruoc
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

    MERGE TonKho AS target
    USING (
        SELECT MaSanPham, SUM(SoLuongPN) AS SoLuongNhap
        FROM inserted
        GROUP BY MaSanPham
    ) AS source
    ON target.MaSanPham = source.MaSanPham
       AND target.MaKho = 'K0001'

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

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'HoaDon', 'INSERT'
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

    INSERT INTO AuditLog (UserName, TableName, Action)
    SELECT SUSER_NAME(), 'HoaDon', 'DELETE'
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

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
