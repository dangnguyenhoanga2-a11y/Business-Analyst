-- Tên đồng nghĩa sysnonym
CREATE SYNONYM dvt FOR dbo.DonViTinh;
CREATE SYNONYM dvtqd FOR dbo.DVTQuyDoi;
CREATE SYNONYM km FOR dbo.KhuyenMai;
CREATE SYNONYM bdg FOR dbo.BienDongGia;
CREATE SYNONYM cthd FOR dbo.ChitietHD;
CREATE SYNONYM ctdh FOR dbo.ChitietDH;
CREATE SYNONYM dtl FOR dbo.DiemTichLuy;
CREATE SYNONYM ctpn FOR dbo.ChitietPN;
CREATE SYNONYM ctpX FOR dbo.ChitietPX;
CREATE SYNONYM ctkm FOR dbo.CTKhuyenMai;
CREATE SYNONYM loaidt FOR dbo.LoaiDoiTuong;
CREATE SYNONYM kh FOR dbo.KhachHang;
CREATE SYNONYM sp FOR dbo.SanPham;

--INDEX

-- Bảng KhachHang: tìm kiếm theo mã, tên, số điện thoại
CREATE NONCLUSTERED INDEX idx_kh_makh ON KhachHang(MaKH);
CREATE NONCLUSTERED INDEX idx_kh_tenkh ON KhachHang(TenKH);
CREATE NONCLUSTERED INDEX idx_kh_sdtkh ON KhachHang(SDTKH);


-- Bảng HoaDon: lọc theo mã hóa đơn, khách hàng, nhân viên
CREATE NONCLUSTERED INDEX idx_hd_sohd ON HoaDon(SoHD);
CREATE NONCLUSTERED INDEX idx_hd_makh ON HoaDon(MaKH);
CREATE NONCLUSTERED INDEX idx_hd_manv ON HoaDon(MaNV);

-- Bảng DonHang: lọc theo mã đơn, khách hàng, nhân viên, trạng thái
CREATE NONCLUSTERED INDEX idx_dh_sodh ON DonHang(SoDH);
CREATE NONCLUSTERED INDEX idx_dh_makh ON DonHang(MaKH);
CREATE NONCLUSTERED INDEX idx_dh_manv ON DonHang(MaNV);
CREATE NONCLUSTERED INDEX idx_dh_trangthai ON DonHang(TrangThaiDH);

-- Bảng TonKho: tìm kiếm tồn kho theo kho, sản phẩm
CREATE NONCLUSTERED INDEX idx_tk_makho ON TonKho(MaKho);
CREATE NONCLUSTERED INDEX idx_tk_masp ON TonKho(MaSP);

-- Bảng PhieuNhap và PhieuXuat: tìm kiếm phiếu theo mã, nhân viên, ngày
CREATE NONCLUSTERED INDEX idx_pn_sopn ON PhieuNhap(SoPN);
CREATE NONCLUSTERED INDEX idx_pn_manv ON PhieuNhap(MaNV);
CREATE NONCLUSTERED INDEX idx_pn_ngaynhap ON PhieuNhap(NgayNhap);

CREATE NONCLUSTERED INDEX idx_px_sopx ON PhieuXuat(SoPX);
CREATE NONCLUSTERED INDEX idx_px_manv ON PhieuXuat(MaNV);
CREATE NONCLUSTERED INDEX idx_px_ngayxuat ON PhieuXuat(NgayXuat);

-- Bảng SanPham: tìm kiếm theo mã, tên, loại sản phẩm
CREATE NONCLUSTERED INDEX idx_sp_masp ON SanPham(MaSP);
CREATE NONCLUSTERED INDEX idx_sp_tensp ON SanPham(TenSP);
CREATE NONCLUSTERED INDEX idx_sp_maloaisp ON SanPham(MaLoaiSP);

-- Bảng ChitietHD, ChitietDH, ChitietPN, ChitietPX: index hỗ trợ join
CREATE NONCLUSTERED INDEX idx_cthd_sohd ON ChitietHD(SoHD);
CREATE NONCLUSTERED INDEX idx_ctdh_sodh ON ChitietDH(SoDH);
CREATE NONCLUSTERED INDEX idx_ctpn_sopn ON ChitietPN(SoPN);
CREATE NONCLUSTERED INDEX idx_ctpx_sopx ON ChitietPX(SoPX);

-- Báo cáo thường GROUP BY MaKH hoặc ORDER BY NgayLapHD
CREATE INDEX idx_HoaDon_MaKH_NgayLap ON HoaDon(MaKH, NgayLapHD);
CREATE INDEX idx_HoaDon_NgayLapHD ON HoaDon(NgayLapHD);
-- Báo cáo tổng doanh thu theo ngày hoặc trạng thái
CREATE INDEX idx_DonHang_NgayDat_TrangThai ON DonHang(NgayDat, TrangThaiDH);
CREATE INDEX idx_DonHang_TrangThaiDH ON DonHang(TrangThaiDH);
-- Báo cáo doanh thu theo sản phẩm
CREATE INDEX idx_ChiTietDH_MaSP_SoDH ON ChitietDH(MaSP, SoDH);
CREATE INDEX idx_ChiTietHD_MaSP_SoHD ON ChitietHD(MaSP, SoHD);


--VIEW
CREATE VIEW nhanvien_view AS
SELECT 
    MaNV AS [Mã nhân viên],
    TenNV AS [Tên nhân viên],
    MaCV AS [Mã chức vụ]
FROM NhanVien;

Select * From nhanvien_view;
GO

CREATE VIEW hoadon_view AS
SELECT 
    hd.SoHD AS [Số hóa đơn],
    hd.NgayLapHD AS [Ngày lập hóa đơn],
    hd.TrigiaTruocThue AS [Trị giá hóa đơn trước thuế],
    SUM(ct.VATHD) AS [Tổng VAT],
    kh.TenKH AS [Tên khách hàng],
    nv.TenNV AS [Tên nhân viên]
FROM HoaDon hd
JOIN ChitietHD ct ON hd.SoHD = ct.SoHD
JOIN KhachHang kh ON hd.MaKH = kh.MaKH
JOIN NhanVien nv ON hd.MaNV = nv.MaNV
GROUP BY 
    hd.SoHD, hd.NgayLapHD, hd.TrigiaTruocThue, kh.TenKH, nv.TenNV;
GO

CREATE VIEW doanhthuNV_view AS
SELECT 
    nv.MaNV AS [Mã nhân viên],
    nv.TenNV AS [Tên nhân viên],
    COUNT(hd.SoHD) AS [Số hóa đơn],
    SUM(hd.TrigiaSauThue) AS [Tổng doanh thu]
FROM NhanVien nv
JOIN HoaDon hd ON nv.MaNV = hd.MaNV
GROUP BY nv.MaNV, nv.TenNV;
GO

CREATE VIEW doanhthuNV_tren800_view AS
SELECT *
FROM doanhthuNV_view
WHERE [Tổng doanh thu] > 800000;
GO

CREATE VIEW doanhthu_ngay_view AS
SELECT 
    NgayLapHD AS [Ngày],
    COUNT(*) AS [Số hóa đơn],
    SUM(TrigiaSauThue) AS [Tổng doanh thu]
FROM HoaDon
GROUP BY NgayLapHD;
GO

CREATE VIEW hoadon_chuathanhtoan_view AS
SELECT
    SoHD AS [Số hóa đơn],
    MaKH AS [Mã khách hàng],
    NgayLapHD AS [Ngày lập hóa đơn],
    TrigiaSauThue AS [Tổng tiền]
FROM HoaDon
WHERE TrangthaiHD = N'chưa thanh toán';
GO

CREATE VIEW diem_KH_view AS
SELECT 
    kh.MaKH AS [Mã khách hàng],
    kh.TenKH AS [Tên khách hàng],
    SUM(dt.DiemTLCuoiKy) AS [Tổng điểm tích lũy]
FROM KhachHang kh
LEFT JOIN DiemTichLuy dt ON kh.MaKH = dt.MaKH
GROUP BY kh.MaKH, kh.TenKH;
GO

--Hàm
CREATE FUNCTION fn_TongTienHD (@SoHD CHAR(5))
RETURNS FLOAT
AS
BEGIN
    DECLARE @TongTien FLOAT;

    SELECT @TongTien = SUM(ThanhtienHD)
    FROM ChitietHD
    WHERE SoHD = @SoHD;

    RETURN ISNULL(@TongTien, 0);
END;
GO

CREATE FUNCTION fn_SoLuongBanTheoSP_Thang (@MaSP CHAR(5), @Thang INT, @Nam INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        ct.MaSP,
        SUM(ct.SoluongHD) AS TongSoLuongBan
    FROM HoaDon hd
    INNER JOIN ChitietHD ct ON ct.SoHD = hd.SoHD
    WHERE ct.MaSP = @MaSP
      AND MONTH(hd.NgayLapHD) = @Thang
      AND YEAR(hd.NgayLapHD) = @Nam
    GROUP BY ct.MaSP
);
GO

CREATE FUNCTION fn_TopSanPham_Thang (@Thang INT, @Nam INT)
RETURNS @BangKetQua TABLE
(
    MaSP CHAR(5),
    TenSP NVARCHAR(200),
    SoLuongBan INT
)
AS
BEGIN
    INSERT INTO @BangKetQua
    SELECT 
        sp.MaSP,
        sp.TenSP,
        SUM(ct.SoluongHD) AS SoLuongBan
    FROM HoaDon hd
    INNER JOIN ChitietHD ct ON hd.SoHD = ct.SoHD
    INNER JOIN SanPham sp ON sp.MaSP = ct.MaSP
    WHERE MONTH(hd.NgayLapHD) = @Thang
      AND YEAR(hd.NgayLapHD) = @Nam
    GROUP BY sp.MaSP, sp.TenSP;
    RETURN;
END;
GO

CREATE FUNCTION fn_DoanhThuKhachHang_Thang (@Thang INT, @Nam INT)
RETURNS @BangKetQua TABLE
(
    MaKH CHAR(5),
    TenKH NVARCHAR(100),
    TongTien FLOAT
)
AS
BEGIN
    INSERT INTO @BangKetQua
    SELECT 
        kh.MaKH,
        kh.TenKH,
        SUM(ct.ThanhtienHD) AS TongTien
    FROM HoaDon hd
    INNER JOIN ChitietHD ct ON hd.SoHD = ct.SoHD
    INNER JOIN KhachHang kh ON kh.MaKH = hd.MaKH
    WHERE MONTH(hd.NgayLapHD) = @Thang
      AND YEAR(hd.NgayLapHD) = @Nam
    GROUP BY kh.MaKH, kh.TenKH;

    RETURN;
END;
GO

CREATE FUNCTION f_HoaDonTheoNgay (@Ngay DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        hd.SoHD,
        hd.MaKH,
        hd.NgayLapHD,
        hd.TrigiaSauThue
    FROM HoaDon hd
    WHERE hd.NgayLapHD = @Ngay
);
GO

CREATE FUNCTION f_SanPhamChuaBan()
RETURNS TABLE
AS
RETURN
(
    SELECT sp.MaSP, sp.TenSP
    FROM SanPham sp
    WHERE sp.MaSP NOT IN (SELECT MaSP FROM ChitietHD)
);
GO

CREATE FUNCTION f_HoaDonTheoKhach(@MaKH CHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        hd.SoHD,
        hd.NgayLapHD,
        hd.TrigiaSauThue
    FROM HoaDon hd
    WHERE hd.MaKH = @MaKH
);
GO

CREATE FUNCTION f_TonKhoHienTai (@MaSP CHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        sp.MaSP,
        sp.TenSP,
        ISNULL(SUM(pn.SoLuongPN), 0) 
        - ISNULL(SUM(px.SoLuongPX), 0) AS TonKho
    FROM SanPham sp
    LEFT JOIN ChiTietPN pn ON pn.MaSP = sp.MaSP 
    LEFT JOIN ChiTietPX px ON px.MaSP = sp.MaSP
    WHERE sp.MaSP = @MaSP
    GROUP BY sp.MaSP, sp.TenSP
);
GO

CREATE FUNCTION f_LichSuNhapKho_SP (@MaSP CHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        pn.SoPN,
        pn.NgayNhap,
        ctpn.MaSP,
        ctpn.SoluongPN
    FROM PhieuNhap pn
    INNER JOIN ChiTietPN ctpn ON pn.SoPN = ctpn.SoPN
    WHERE ctpn.MaSP = @MaSP
);
GO

--Thủ tục
CREATE PROCEDURE sp_DoanhThuKhachHang_ThangNam
    @Thang INT,
    @Nam INT
AS
BEGIN
    SELECT 
        kh.MaKH,
        kh.TenKH,
        kh.DiaChiKH,
        kh.SDTKH,
        SUM(ct.ThanhtienHD) AS TongTien
    FROM HoaDon hd
    INNER JOIN ChitietHD ct ON ct.SoHD = hd.SoHD
    INNER JOIN KhachHang kh ON kh.MaKH = hd.MaKH
    WHERE MONTH(hd.NgayLapHD) = @Thang
      AND YEAR(hd.NgayLapHD) = @Nam
    GROUP BY 
        kh.MaKH, kh.TenKH, kh.DiaChiKH, kh.SDTKH
    ORDER BY TongTien DESC;
END;
GO

CREATE PROCEDURE sp_ThemHoaDon
    @MaNV CHAR(5),
    @MaKH CHAR(5),
    @NgayLapHD DATE,
    @PhuongThucTT NVARCHAR(50),
    @MasoThue VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạo SoHD tự động dạng 'HD001', 'HD002', ...
    DECLARE @SoHD CHAR(5);
    DECLARE @MaxSoHD INT;

    SELECT @MaxSoHD = ISNULL(MAX(CAST(SUBSTRING(SoHD,3,3) AS INT)), 0)
    FROM HoaDon;

    SET @SoHD = 'HD' + RIGHT('000' + CAST(@MaxSoHD + 1 AS VARCHAR(3)), 3);

    -- Chèn hóa đơn mới (trị giá tạm thời = 0)
    INSERT INTO HoaDon(SoHD, MaNV, MaKH, NgayLapHD, MasoThue, TrigiaTruocThue, TrigiaSauThue, PhuongThucTT, TrangthaiHD)
    VALUES(@SoHD, @MaNV, @MaKH, @NgayLapHD, @MasoThue, 0, 0, @PhuongThucTT, N'Chưa thanh toán');

    SELECT @SoHD AS SoHD;
END
GO

CREATE PROCEDURE sp_ThemChiTietHD
    @SoHD CHAR(5),
    @MaSP CHAR(5),
    @SoluongHD INT,
    @VAT FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Dongia FLOAT;
    DECLARE @Thanhtien FLOAT;

    -- Lấy giá sản phẩm hiện tại (lấy giá mới nhất từ BienDongGia)
    SELECT TOP 1 @Dongia = GiaBD
    FROM BienDongGia
    WHERE MaSP = @MaSP
    ORDER BY NgayCapNhatGia DESC;

    -- Tính tiền
    SET @Thanhtien = @SoluongHD * @Dongia * (1 + @VAT/100);

    -- Chèn chi tiết hóa đơn
    INSERT INTO ChitietHD(SoHD, MaSP, SoluongHD, DongiaHD, VATHD, ThanhtienHD)
    VALUES(@SoHD, @MaSP, @SoluongHD, @Dongia, @VAT, @Thanhtien);

    -- Cập nhật tổng trị giá hóa đơn
    DECLARE @TrigiaTruocThue FLOAT;
    DECLARE @TrigiaSauThue FLOAT;

    SELECT @TrigiaTruocThue = SUM(DongiaHD * SoluongHD),
           @TrigiaSauThue = SUM(ThanhtienHD)
    FROM ChitietHD
    WHERE SoHD = @SoHD;

    UPDATE HoaDon
    SET TrigiaTruocThue = @TrigiaTruocThue,
        TrigiaSauThue = @TrigiaSauThue
    WHERE SoHD = @SoHD;
END
GO

CREATE PROCEDURE sp_CapNhatDiemTichLuy
    @SoHD CHAR(5),
    @MaKH CHAR(5)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NgayCN DATE;
    DECLARE @DiemHT FLOAT;
    DECLARE @DiemTLTrongNgay FLOAT;
    DECLARE @DiemTLCuoiKy FLOAT;

    -- Lấy ngày hiện tại để ghi vào NgayCNDiem
    SET @NgayCN = GETDATE();

    -- Lấy tổng trị giá sau thuế của hóa đơn
    SELECT @DiemTLTrongNgay = TrigiaSauThue / 1000
    FROM HoaDon
    WHERE SoHD = @SoHD;

    -- Lấy DiemTLCuoiKy trước đó của khách hàng (nếu có)
    SELECT TOP 1 @DiemHT = DiemTLCuoiKy
    FROM DiemTichLuy
    WHERE MaKH = @MaKH
    ORDER BY NgayCNDiem DESC;

    IF @DiemHT IS NULL
        SET @DiemHT = 0;

    -- Tính DiemTLCuoiKy mới
    SET @DiemTLCuoiKy = @DiemHT + @DiemTLTrongNgay;

    -- Chèn hoặc cập nhật vào bảng DiemTichLuy
    IF EXISTS(SELECT 1 FROM DiemTichLuy WHERE SoHD = @SoHD AND MaKH = @MaKH)
    BEGIN
        UPDATE DiemTichLuy
        SET NgayCNDiem = @NgayCN,
            DiemHT = @DiemHT,
            DiemTLTrongNgay = @DiemTLTrongNgay,
            DiemTLCuoiKy = @DiemTLCuoiKy,
            GhichuDTL = N'Đã cập nhật điểm từ hóa đơn'
        WHERE SoHD = @SoHD AND MaKH = @MaKH;
    END
    ELSE
    BEGIN
        INSERT INTO DiemTichLuy(SoHD, MaKH, NgayCNDiem, DiemHT, DiemTLTrongNgay, DiemTLCuoiKy, GhichuDTL)
        VALUES(@SoHD, @MaKH, @NgayCN, @DiemHT, @DiemTLTrongNgay, @DiemTLCuoiKy, N'Điểm từ hóa đơn');
    END
END
GO

CREATE PROCEDURE sp_ThemKhachHang
    @MaKH CHAR(5),
    @TenKH NVARCHAR(50),
    @MaLoaiKH CHAR(5),
    @MaNH CHAR(10),
    @DiaChiKH NVARCHAR(100),
    @SDTKH CHAR(10),
    @EmailKH VARCHAR(50),
    @STK VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra khách hàng đã tồn tại chưa
    IF EXISTS(SELECT 1 FROM KhachHang WHERE MaKH = @MaKH)
    BEGIN
        PRINT 'Khách hàng đã tồn tại. Không thể thêm.';
        RETURN;
    END

    BEGIN TRY
        -- Thêm khách hàng mới
        INSERT INTO KhachHang(MaKH, MaLoaiKH, MaNH, TenKH, DiaChiKH, SDTKH, EmailKH, STK)
        VALUES(@MaKH, @MaLoaiKH, @MaNH, @TenKH, @DiaChiKH, @SDTKH, @EmailKH, @STK);

        PRINT 'Đã thêm khách hàng thành công.';
    END TRY
    BEGIN CATCH
        PRINT N'Lỗi: Không thể thêm khách hàng. Nguyên nhân: ' + ERROR_MESSAGE();
    END CATCH
END
GO

CREATE PROCEDURE sp_KiemTraKH
    @MaKH CHAR(5)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM KhachHang WHERE MaKH = @MaKH)
        SELECT 1 AS TonTai;
    ELSE
        SELECT 0 AS TonTai;
END

GO

CREATE PROCEDURE sp_KiemTraTonKho
    @MaSP CHAR(5)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        MaSP,
        TonCK,
        CASE 
            WHEN TonCK > 0 THEN N'Còn hàng'
            ELSE N'Hết hàng'
        END AS TrangThai
    FROM TonKho
    WHERE MaSP = @MaSP;
END
GO

CREATE PROCEDURE sp_LichSuGia
    @MaSP CHAR(5)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        MaSP,
        GiaBD,
        NgayCapNhatGia
    FROM BienDongGia
    WHERE MaSP = @MaSP
    ORDER BY NgayCapNhatGia DESC;
END
GO

CREATE PROCEDURE sp_Top10SanPhamBanChay
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 10
        sp.MaSP,
        sp.TenSP,
        SUM(ct.SoluongHD) AS TongSoLuongBan,
        SUM(ct.ThanhtienHD) AS TongDoanhThu
    FROM ChitietHD ct
    INNER JOIN SanPham sp ON sp.MaSP = ct.MaSP
    GROUP BY sp.MaSP, sp.TenSP
    ORDER BY TongSoLuongBan DESC;
END
GO

--TRIGGER
CREATE TRIGGER trg_CheckChiTietHD
ON ChitietHD
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE SoluongHD <= 0
           OR DongiaHD < 0
           OR VATHD < 0 OR VATHD > 100
           OR ABS(ThanhtienHD - (SoluongHD * DongiaHD * (1 + VATHD / 100.0))) > 0.01
    )
    BEGIN
        RAISERROR ('Dữ liệu ChiTietHD không hợp lệ!', 16, 1)
        ROLLBACK TRAN
        RETURN
    END
END;
GO

--TRIGGER 2

CREATE TRIGGER trg_UpdateTongTienHD
ON ChitietHD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SoHD CHAR(5);
    SELECT @SoHD = SoHD FROM inserted;
    IF (@SoHD IS NULL)
        SELECT @SoHD = SoHD FROM deleted;

    UPDATE HoaDon
    SET TrigiaTruocThue =
        ISNULL(
            (SELECT SUM(SoluongHD * DongiaHD)
             FROM ChitietHD
             WHERE SoHD = @SoHD), 0
        )
    WHERE SoHD = @SoHD;

    UPDATE HoaDon
    SET TrigiaSauThue =
        ISNULL(
            (SELECT SUM(ThanhtienHD)
             FROM ChitietHD
             WHERE SoHD = @SoHD), 0
        )
    WHERE SoHD = @SoHD;
END;
GO

CREATE TRIGGER trg_HDNotEmpty
ON ChitietHD
FOR DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM HoaDon h
        WHERE h.SoHD IN (SELECT SoHD FROM deleted)
        AND NOT EXISTS (SELECT 1 FROM ChitietHD c WHERE c.SoHD = h.SoHD)
    )
    BEGIN
        RAISERROR('Không thể xóa chi tiết cuối cùng của hóa đơn!',16,1);
        ROLLBACK TRAN;
        RETURN;
    END
END;
GO

CREATE TRIGGER trg_CheckDonHangDate
ON DonHang
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Ngaygiaohang < Ngaydat)
    BEGIN
        RAISERROR('Ngày giao hàng phải ≥ ngày đặt!',16,1);
        ROLLBACK TRAN;
        RETURN;
    END
END;
GO


CREATE TABLE AuditLog (
    ID INT IDENTITY PRIMARY KEY,
    UserName NVARCHAR(100),
    TableName NVARCHAR(100),
    Action NVARCHAR(10),
    TimeStamp DATETIME DEFAULT GETDATE()
);

GO

CREATE TRIGGER trg_Audit_HoaDon
ON HoaDon
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action NVARCHAR(10)

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @action = 'UPDATE'
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @action = 'INSERT'
    ELSE
        SET @action = 'DELETE'

    INSERT INTO AuditLog (UserName, TableName, Action)
    VALUES (SUSER_NAME(), 'HoaDon', @action)
END;
GO

--USER
--Tạo hàm mã hoá mật khẩu

CREATE FUNCTION f_MaHoaMK (@matkhau nvarchar(128)) 
RETURNS VARBINARY (8000) 
AS 
BEGIN 
    DECLARE @kq varbinary (8000) 
    SET @kq = EncryptByPassPhrase('FAHASA',@matkhau) 
    RETURN @kq     
END;
GO

--Thủ tục tạo tài khoản nhân viên

CREATE OR ALTER PROCEDURE sp_TaoTaiKhoanNV
(
    @MaNV CHAR(5),
    @UserName NVARCHAR(50),
    @MatKhau NVARCHAR(128)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Tạo login
        IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = @UserName)
        BEGIN
            DECLARE @SQL NVARCHAR(MAX) =
            'CREATE LOGIN [' + @UserName + '] 
             WITH PASSWORD = N''' + @MatKhau + ''',
                  CHECK_POLICY = ON, CHECK_EXPIRATION = OFF,
                  DEFAULT_DATABASE = [QuanLyBanHangFAHASA];';
            EXEC sp_executesql @SQL;
        END
        ELSE
        BEGIN
            PRINT N'Login đã tồn tại!';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Tạo user trong DB
        IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = @UserName)
        BEGIN
            EXEC('CREATE USER [' + @UserName + '] FOR LOGIN [' + @UserName + '];');
        END

        --Tạo MaTK và TrangThaiTK
        DECLARE @MaTK INT;
        SELECT @MaTK = ISNULL(MAX(MaTK), 0) + 1
        FROM TaiKhoan;
        DECLARE @TrangThaiTK NVARCHAR (50)
        SET @TrangThaiTK = N'Hoạt động'

        -- Lưu mật khẩu mã hoá vào bảng TaiKhoanNV
        DECLARE @MatKhauMaHoa VARBINARY(8000);
        SET @MatKhauMaHoa = dbo.f_MaHoaMK(@MatKhau);

        INSERT INTO TaiKhoan (MaTK, MaNV, TenDN, MatKhau, TrangThaiTK)
        VALUES (@MaTK, @MaNV, @UserName, @MatKhauMaHoa, @TrangThaiTK);

        COMMIT TRANSACTION;
        PRINT N'Tạo tài khoản thành công!';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT N'Lỗi khi tạo tài khoản: ' + ERROR_MESSAGE();
    END CATCH
END;


--Kiểm thử: Tạo user cho nhân viên có manv là NV012, thuộc bộ phận bán hàng
--Truy xuất lại vào bảng TaiKhoanNV

EXEC sp_TaoTaiKhoanNV 'NV025', nguyenhuulong_banhang, banhang123; 
EXEC sp_TaoTaiKhoanNV 'NV014', phanhauyen_quanly, quanly123; 
EXEC sp_TaoTaiKhoanNV 'NV021', tranhoangvu_kho, kho123;
GO

--Thủ tục tạo role

CREATE OR ALTER PROCEDURE sp_TaoRole
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @RoleName AND type = 'R')
        BEGIN
            EXEC('CREATE ROLE [' + @RoleName + ']');
            PRINT N'Đã tạo role: ' + @RoleName;
        END
        ELSE
            PRINT N'Role ' + @RoleName + N' đã tồn tại.';
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT N'Lỗi khi tạo role: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC sp_TaoRole 'QLChiNhanh'
EXEC sp_TaoRole 'NVBanHang'
EXEC sp_TaoRole 'NVKho'
GO

--Gán quyền cho Role

CREATE OR ALTER PROCEDURE sp_GanQuyenChoRole
    @RoleName NVARCHAR(50),
    @TableName NVARCHAR(128),
    @Permission NVARCHAR(100),
    @SchemaName NVARCHAR(50) = 'dbo'
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra Role có tồn tại
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @RoleName AND type = 'R')
    BEGIN
        PRINT N'Vai trò ' + @RoleName + N' không tồn tại.';
        RETURN;
    END

    -- Kiểm tra bảng có tồn tại
    IF OBJECT_ID(@SchemaName + '.' + @TableName) IS NOT NULL
    BEGIN
        DECLARE @GrantSQL NVARCHAR(MAX) = 
            'GRANT ' + @Permission + ' ON [' + @SchemaName + '].[' + @TableName + '] TO [' + @RoleName + ']';
        EXEC sp_executesql @GrantSQL;
        PRINT N'Đã cấp quyền ' + @Permission + N' trên bảng ' + @TableName + N' cho vai trò ' + @RoleName
    END
    ELSE
        PRINT N'Bảng ' + @TableName + N' không tồn tại.';
END;

EXEC sp_GanQuyenChoRole 
     @RoleName = 'QLChiNhanh',
     @TableName = 'SanPham',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'QLChiNhanh',
     @TableName = 'TonKho',
     @Permission = 'SELECT'
GO
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVBanHang',
     @TableName = 'HoaDon',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVBanHang',
     @TableName = 'ChitietHD',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVBanHang',
     @TableName = 'DonHang',
     @Permission = 'SELECT'
GO
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVKho',
     @TableName = 'TonKho',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVKho',
     @TableName = 'PhieuNhap',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVKho',
     @TableName = 'PhieuXuat',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVKho',
     @TableName = 'ChitietPN',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
EXEC sp_GanQuyenChoRole 
     @RoleName = 'NVKho',
     @TableName = 'ChitietPX',
     @Permission = 'SELECT, UPDATE, INSERT, DELETE'
GO

CREATE OR ALTER PROCEDURE sp_GanRoleChoUser
    @UserName NVARCHAR(50),
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra user có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @UserName)
        BEGIN
            PRINT N'User không tồn tại trong database.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Kiểm tra role có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @RoleName AND type = 'R')
        BEGIN
            PRINT N'Role không tồn tại.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Kiểm tra user đã được gán role chưa
        IF EXISTS (SELECT 1 
                   FROM sys.database_role_members rm
                   JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
                   JOIN sys.database_principals u ON rm.member_principal_id = u.principal_id
                   WHERE r.name = @RoleName AND u.name = @UserName)
        BEGIN
            PRINT N'User đã được gán role ' + @RoleName;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Gán role
        DECLARE @AddRole NVARCHAR(MAX) =
            'ALTER ROLE [' + @RoleName + '] ADD MEMBER [' + @UserName + ']';
        EXEC sp_executesql @AddRole;

        PRINT N'Đã thêm user ' + @UserName + N' vào role ' + @RoleName;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT N'Lỗi khi gán role cho user: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC sp_GanRoleChoUser nguyenhuulong_banhang, NVBanhang
EXEC sp_GanRoleChoUser phanhauyen_quanly, QLChiNhanh
EXEC sp_GanRoleChoUser tranhoangvu_kho, NVKho
EXEC sp_GanRoleChoUser nguyenthanhhung_banhang, NVBanhang

--TRANSACTION
--Transaction 1
-- USER A (Session 1)

BEGIN TRAN;

UPDATE HoaDon
SET TrangthaiHD = N'đã thanh toán'
WHERE SoHD = 'HD001';

-- GIỮ TRANSACTION MỞ
-- KHÔNG COMMIT, KHÔNG ROLLBACK

COMMIT TRAN;

-- hoặc ROLLBACK TRAN;

--Transaction 2

BEGIN TRAN;

UPDATE HoaDon
SET PhuongThucTT = N'EWallet'
WHERE SoHD = 'HD002';

-- GIỮ TRANSACTION – KHÔNG COMMIT

COMMIT TRAN;
-- USER B (Session 2)

SELECT *
FROM HoaDon
WHERE SoHD = 'HD001';

UPDATE HoaDon
SET TrangthaiHD = N'chưa thanh toán'
WHERE SoHD = 'HD001';

--Transaction 2

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT *
FROM HoaDon
WHERE SoHD = 'HD002';


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT *
FROM HoaDon
WHERE SoHD = 'HD002';
