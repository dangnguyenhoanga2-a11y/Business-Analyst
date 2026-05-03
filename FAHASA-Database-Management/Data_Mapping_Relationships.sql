CREATE DATABASE QuanLyBanHangFAHASA;


/*==============================================================*/
/* Table: ChucVu                                                */
/*==============================================================*/

CREATE TABLE ChucVu 
(
   MaCV                 CHAR(5)        NOT NULL,
   TenCV                NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_ChucVu PRIMARY KEY (MaCV)
);

/*==============================================================*/
/* Table: DonViTinh                                             */
/*==============================================================*/

CREATE TABLE DonViTinh 
(
   MaDVT                CHAR(5)        NOT NULL,
   TenDVT               NVARCHAR(50)   NOT NULL,
   GhichuDVT			NVARCHAR(100)  NULL,
   CONSTRAINT PK_DonViTinh PRIMARY KEY (MaDVT)
);


/*==============================================================*/
/* Table: DVTQuyDoi                                             */
/*==============================================================*/

CREATE TABLE DVTQuyDoi 
(
   MaQD                 CHAR(5)        NOT NULL,
   MaDVT                CHAR(5)        NOT NULL,
   TenQD                NVARCHAR(50)   NOT NULL,
   SoluongQD            INT            NOT NULL,
   GhichuQD             NVARCHAR(100)  NULL,
   CONSTRAINT PK_DVTQuyDoi PRIMARY KEY (MaQD),
   CONSTRAINT FK_DVTQuyDoi_DonViTinh FOREIGN KEY (MaDVT)
      REFERENCES DonViTinh (MaDVT)
);

/*==============================================================*/
/* Table: Kho                                                   */
/*==============================================================*/

CREATE TABLE Kho 
(
   MaKho                CHAR(5)        NOT NULL,
   TenKho               NVARCHAR(50)   NOT NULL,
   DiachiKho            NVARCHAR(100)  NOT NULL,
   HotlineKho           VARCHAR(11)    NOT NULL,
   CONSTRAINT PK_Kho PRIMARY KEY (MaKho)
);

/*==============================================================*/
/* Table: ChiNhanh                                              */
/*==============================================================*/

CREATE TABLE ChiNhanh 
(
   MaCN                 CHAR(5)        NOT NULL,
   MaKho                CHAR(5)        NOT NULL,
   TenCN                NVARCHAR(50)   NOT NULL,
   HotlineCN            VARCHAR(11)    NOT NULL,
   EmailCN              VARCHAR(100)    NOT NULL,
   DiachiCN             NVARCHAR(100)  NOT NULL,
   CONSTRAINT PK_ChiNhanh PRIMARY KEY (MaCN),
   CONSTRAINT FK_ChiNhanh_Kho FOREIGN KEY (MaKho)
      REFERENCES Kho (MaKho)
);


/*==============================================================*/
/* Table: KhuyenMai                                             */
/*==============================================================*/

CREATE TABLE KhuyenMai 
(
   MaKM                 CHAR(5)        NOT NULL,
   TenKM                NVARCHAR(50)   NOT NULL,
   NgayBD               DATE           NOT NULL,
   NgayKT               DATE           NOT NULL,
   CONSTRAINT PK_KhuyenMai PRIMARY KEY (MaKM)
);

/*==============================================================*/
/* Table: LoaiKH                                                */
/*==============================================================*/

CREATE TABLE LoaiKH 
(
   MaLoaiKH             CHAR(5)        NOT NULL,
   TenLoaiKH            NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_LoaiKH PRIMARY KEY (MaLoaiKH)
);

/*==============================================================*/
/* Table: LoaiSP                                                */
/*==============================================================*/

CREATE TABLE LoaiSP 
(
   MaLoaiSP             CHAR(5)        NOT NULL,
   TenLoaiSP            NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_LoaiSP PRIMARY KEY (MaLoaiSP)
);

/*==============================================================*/
/* Table: NganHang                                              */
/*==============================================================*/

CREATE TABLE NganHang 
(
   MaNH                 CHAR(10)       NOT NULL,
   TenNH                NVARCHAR(100)   NOT NULL,
   VietTatNH			VARCHAR(20)	   NOT NULL,
   DiaChiNH				NVARCHAR(100)  NOT NULL,
   SDTNH				VARCHAR(11)	   NOT NULL,
   EmailNH				VARCHAR(50)    NOT NULL,
   CONSTRAINT PK_NganHang PRIMARY KEY (MaNH)
);

/*==============================================================*/
/* Table: KhachHang                                             */
/*==============================================================*/

CREATE TABLE KhachHang 
(
   MaKH                 CHAR(5)        NOT NULL,
   MaLoaiKH             CHAR(5)        NOT NULL,
   MaNH                 CHAR(10)       NOT NULL,
   TenKH                NVARCHAR(50)   NOT NULL,
   DiaChiKH             NVARCHAR(100)   NOT NULL,
   SDTKH                CHAR(10)       NOT NULL,
   EmailKH              VARCHAR(50)    NOT NULL,
   STK                  VARCHAR(15)    NOT NULL,
   CONSTRAINT PK_KhachHang PRIMARY KEY (MaKH),
   CONSTRAINT FK_KhachHang_LoaiKH FOREIGN KEY (MaLoaiKH)
      REFERENCES LoaiKH (MaLoaiKH),
   CONSTRAINT FK_KhachHang_NganHang FOREIGN KEY (MaNH)
      REFERENCES NganHang (MaNH)
);

/*==============================================================*/
/* Table: PhongBan                                              */
/*==============================================================*/

CREATE TABLE PhongBan 
(
   MaPB                 CHAR(5)        NOT NULL,
   MaCN                 CHAR(5)        NOT NULL,
   TenPB                NVARCHAR(50)   NOT NULL,
   SDTPB                CHAR(10)       NOT NULL,
   EmailPB              VARCHAR(30)    NOT NULL,
   CONSTRAINT PK_PhongBan PRIMARY KEY (MaPB),
   CONSTRAINT FK_PhongBan_ChiNhanh FOREIGN KEY (MaCN)
      REFERENCES ChiNhanh (MaCN)
);

/*==============================================================*/
/* Table: BoPhan                                                */
/*==============================================================*/

CREATE TABLE BoPhan 
(
   MaBP                 CHAR(5)        NOT NULL,
   MaPB                 CHAR(5)        NOT NULL,
   TenBP                NVARCHAR(50)   NOT NULL,
   SDTBP                CHAR(10)       NOT NULL,
   EmailBP              VARCHAR(30)    NOT NULL,
   CONSTRAINT PK_BoPhan PRIMARY KEY (MaBP),
   CONSTRAINT FK_BoPhan_PhongBan FOREIGN KEY (MaPB)
      REFERENCES PhongBan (MaPB)
);

/*==============================================================*/
/* Table: NhanVien                                              */
/*==============================================================*/

CREATE TABLE NhanVien 
(
   MaNV                 CHAR(5)       NOT NULL,
   MaKho                CHAR(5)        NULL,
   MaBP                 CHAR(5)        NOT NULL,
   MaCV                 CHAR(5)        NOT NULL,
   TenNV                NVARCHAR(50)   NOT NULL,
   SDTNV                CHAR(10)       NOT NULL,
   EmailNV              VARCHAR(50)    NOT NULL,
   TrangThaiNV          NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_NhanVien PRIMARY KEY (MaNV),
   CONSTRAINT FK_NhanVien_BoPhan FOREIGN KEY (MaBP)
      REFERENCES BoPhan (MaBP),
   CONSTRAINT FK_NhanVien_ChucVu FOREIGN KEY (MaCV)
      REFERENCES ChucVu (MaCV),
   CONSTRAINT FK_NhanVien_Kho FOREIGN KEY (MaKho)
      REFERENCES Kho (MaKho)
);

/*==============================================================*/
/* Table: SanPham                                               */
/*==============================================================*/

CREATE TABLE SanPham 
(
   MaSP                 CHAR(5)        NOT NULL,
   MaLoaiSP             CHAR(5)        NOT NULL,
   MaDVT                CHAR(5)        NOT NULL,
   MaQD                 CHAR(5)        NULL,
   TenSP                NVARCHAR(50)   NOT NULL,
   MotaSP               NVARCHAR(100)   NOT NULL,
   CONSTRAINT PK_SanPham PRIMARY KEY (MaSP),
   CONSTRAINT FK_SanPham_DonViTinh FOREIGN KEY (MaDVT)
      REFERENCES DonViTinh (MaDVT),
   CONSTRAINT FK_SanPham_LoaiSP FOREIGN KEY (MaLoaiSP)
      REFERENCES LoaiSP (MaLoaiSP),
   CONSTRAINT FK_SanPham_DVTQuyDoi FOREIGN KEY (MaQD)
      REFERENCES DVTQuyDoi (MaQD)
);

/*==============================================================*/
/* Table: TonKho                                                */
/*==============================================================*/

CREATE TABLE TonKho 
(
   MaKho                CHAR(5)        NOT NULL,
   MaSP                 CHAR(5)        NOT NULL,
   TonDK                INT            NOT NULL,
   TonCK                INT            NOT NULL,
   XuatTK               INT            NOT NULL,
   NhapTK               INT            NOT NULL,
   TrigiaTonDK          FLOAT          NOT NULL,
   TrigiaTonCK          FLOAT          NOT NULL,
   TrigiaXuatTK         FLOAT          NOT NULL,
   TrigiaNhapTK         FLOAT          NOT NULL,
   NgayCapNhatTon       DATE           NOT NULL,
   CONSTRAINT PK_TonKho PRIMARY KEY (MaKho, MaSP),
   CONSTRAINT FK_TonKho_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP),
   CONSTRAINT FK_TonKho_Kho FOREIGN KEY (MaKho)
      REFERENCES Kho (MaKho)
);

/*==============================================================*/
/* Table: BienDongGia                                           */
/*==============================================================*/

CREATE TABLE BienDongGia 
(
   MaSP                 CHAR(5)        NOT NULL,
   NgayCapNhatGia       DATE           NOT NULL,
   GiaBD                FLOAT          NOT NULL,
   CONSTRAINT PK_BienDongGia PRIMARY KEY (MaSP, NgayCapNhatGia),
   CONSTRAINT FK_BienDongGia_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP)
);

/*==============================================================*/
/* Table: DonHang                                               */
/*==============================================================*/

CREATE TABLE DonHang 
(
   SoDH                 CHAR(5)       NOT NULL,
   MaNV                 CHAR(5)       NOT NULL,
   MaKH                 CHAR(5)        NOT NULL,
   NgayDat              DATE           NOT NULL,
   NgayGiaoHang         DATE           NOT NULL,
   TrigiaDHTruocThue    FLOAT          NOT NULL,
   TrigiaDHSauThue      FLOAT          NOT NULL,
   TrangThaiDH          NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_DonHang PRIMARY KEY (SoDH),
   CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH)
      REFERENCES KhachHang (MaKH),
   CONSTRAINT FK_DonHang_NhanVien FOREIGN KEY (MaNV)
      REFERENCES NhanVien (MaNV)
);

/*==============================================================*/
/* Table: ChitietDH                                             */
/*==============================================================*/

CREATE TABLE ChitietDH 
(
   SoDH                 CHAR(5)       NOT NULL,
   MaSP                 CHAR(5)        NOT NULL,
   SoluongDH            INT            NOT NULL,
   DongiaDH             FLOAT          NOT NULL,
   VATDH				FLOAT		   NOT NULL,
   ThanhtienDH          FLOAT          NOT NULL,
   CONSTRAINT PK_ChiTietDH PRIMARY KEY (SoDH, MaSP),
   CONSTRAINT FK_ChiTietDH_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP),
   CONSTRAINT FK_ChiTietDH_DonHang FOREIGN KEY (SoDH)
      REFERENCES DonHang (SoDH)
);

/*==============================================================*/
/* Table: HoaDon                                                */
/*==============================================================*/

CREATE TABLE HoaDon 
(
   SoHD                 CHAR(5)       NOT NULL,
   SoDH					CHAR(5)       NULL,
   MaNV                 CHAR(5)       NOT NULL,
   MaKH					CHAR(5)        NOT NULL,
   NgayLapHD            DATE           NOT NULL,
   MasoThue             VARCHAR(20)    NOT NULL,
   TrigiaTruocThue      FLOAT          NOT NULL,
   TrigiaSauThue        FLOAT          NOT NULL,
   PhuongThucTT         NVARCHAR(50)   NOT NULL,
   TrangthaiHD			NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_HoaDon PRIMARY KEY (SoHD),
   CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY (MaNV)
      REFERENCES NhanVien (MaNV),
   CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKH)
      REFERENCES KhachHang (MaKH),
   CONSTRAINT FK_HoaDon_DonHang FOREIGN KEY (SoDH)
	  REFERENCES DonHang(SoDH)
);

/*==============================================================*/
/* Table: ChitietHD                                             */
/*==============================================================*/

CREATE TABLE ChitietHD 
(
   SoHD                 CHAR(5)       NOT NULL,
   MaSP                 CHAR(5)        NOT NULL,
   SoluongHD            INT            NOT NULL,
   DongiaHD             FLOAT          NOT NULL,
   VATHD                  FLOAT          NOT NULL,
   ThanhtienHD          FLOAT          NOT NULL,
   CONSTRAINT PK_ChiTietHD PRIMARY KEY (SoHD, MaSP),
   CONSTRAINT FK_ChiTietHD_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP),
   CONSTRAINT FK_ChiTietHD_HoaDon FOREIGN KEY (SoHD)
      REFERENCES HoaDon (SoHD)
);

/*==============================================================*/
/* Table: DiemTichLuy                                           */
/*==============================================================*/

CREATE TABLE DiemTichLuy 
(
   SoHD                 CHAR(5)       NOT NULL,
   MaKH                 CHAR(5)        NOT NULL,
   NgayCNDiem           DATE           NOT NULL,
   DiemHT               FLOAT          NOT NULL,
   DiemTLTrongNgay      FLOAT          NOT NULL,
   DiemTLCuoiKy         FLOAT          NOT NULL,
   GhichuDTL            NVARCHAR(100)  NOT NULL,
   CONSTRAINT PK_DiemTichLuy PRIMARY KEY (SoHD, MaKH),
   CONSTRAINT FK_DiemTichLuy_KhachHang FOREIGN KEY (MaKH)
      REFERENCES KhachHang (MaKH),
   CONSTRAINT FK_DiemTichLuy_HoaDon FOREIGN KEY (SoHD)
      REFERENCES HoaDon (SoHD)
);

/*==============================================================*/
/* Table: PhieuNhap                                             */
/*==============================================================*/

CREATE TABLE PhieuNhap 
(
   SoPN                 CHAR(5)       NOT NULL,
   MaNV                 CHAR(5)       NOT NULL,
   SoHD                 CHAR(5)       NOT NULL,
   LyDoNhap             NVARCHAR(50)   NOT NULL,
   NgayNhap             DATE           NOT NULL,
   TrigiaPN             FLOAT          NOT NULL,
   GhichuPN             NVARCHAR(100)  NULL,
   CONSTRAINT PK_PhieuNhap PRIMARY KEY (SoPN),
   CONSTRAINT FK_PhieuNhap_NhanVien FOREIGN KEY (MaNV)
      REFERENCES NhanVien (MaNV),
   CONSTRAINT FK_PhieuNhap_HoaDon FOREIGN KEY (SoHD)
      REFERENCES HoaDon (SoHD)
);

/*==============================================================*/
/* Table: ChitietPN                                             */
/*==============================================================*/

CREATE TABLE ChitietPN 
(
   MaSP                 CHAR(5)        NOT NULL,
   SoPN                 CHAR(5)       NOT NULL,
   SoluongPN            INT            NOT NULL,
   DongiaPN             FLOAT          NOT NULL,
   ThanhtienPN          FLOAT          NOT NULL,
   CONSTRAINT PK_ChiTietPN PRIMARY KEY (MaSP, SoPN),
   CONSTRAINT FK_ChiTietPN_PhieuNhap FOREIGN KEY (SoPN)
      REFERENCES PhieuNhap (SoPN),
   CONSTRAINT FK_ChiTietPN_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP)
);

/*==============================================================*/
/* Table: PhieuXuat                                             */
/*==============================================================*/

CREATE TABLE PhieuXuat 
(
   SoPX                 CHAR(5)       NOT NULL,
   SoHD                 CHAR(5)       NOT NULL,
   MaNV                 CHAR(5)       NOT NULL,
   LyDoXuat             NVARCHAR(50)   NOT NULL,
   NgayXuat             DATE           NOT NULL,
   TrigiaPX             FLOAT          NOT NULL,
   GhichuPX             NVARCHAR(100)  NULL,
   CONSTRAINT PK_PhieuXuat PRIMARY KEY (SoPX),
   CONSTRAINT FK_PhieuXuat_HoaDon FOREIGN KEY (SoHD)
      REFERENCES HoaDon (SoHD),
   CONSTRAINT FK_PhieuXuat_NhanVien FOREIGN KEY (MaNV)
      REFERENCES NhanVien (MaNV)
);

/*==============================================================*/
/* Table: ChitietPX                                             */
/*==============================================================*/

CREATE TABLE ChitietPX 
(
   MaSP                 CHAR(5)        NOT NULL,
   SoPX                 CHAR(5)       NOT NULL,
   SoluongPX            INT            NOT NULL,
   DongiaPX             FLOAT          NOT NULL,
   ThanhtienPX          FLOAT          NOT NULL,
   CONSTRAINT PK_ChiTietPX PRIMARY KEY (MaSP, SoPX),
   CONSTRAINT FK_ChiTietPX_PhieuXuat FOREIGN KEY (SoPX)
      REFERENCES PhieuXuat (SoPX),
   CONSTRAINT FK_ChiTietPX_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP)
);

/*==============================================================*/
/* Table: CTKhuyenMai                                           */
/*==============================================================*/

CREATE TABLE CTKhuyenMai 
(
   MaKM                 CHAR(5)        NOT NULL,
   MaSP                 CHAR(5)        NOT NULL,
   TyLePhanTram         FLOAT          NOT NULL,
   GiamTheoSP           NVARCHAR(50)   NOT NULL,
   GiamTheoTriGia       NVARCHAR(50)   NOT NULL,
   GhichuKM             NVARCHAR(100)  NOT NULL,
   CONSTRAINT PK_CTKhuyenMai PRIMARY KEY (MaKM, MaSP),
   CONSTRAINT FK_CTKhuyenMai_SanPham FOREIGN KEY (MaSP)
      REFERENCES SanPham (MaSP),
   CONSTRAINT FK_CTKhuyenMai_KhuyenMai FOREIGN KEY (MaKM)
      REFERENCES KhuyenMai (MaKM)
);

/*==============================================================*/
/* Table: VaiTro                                                */
/*==============================================================*/

CREATE TABLE VaiTro 
(
   MaVT                 CHAR(5)        NOT NULL,
   TenVT                NVARCHAR(50)    NOT NULL,
   CONSTRAINT PK_VaiTro PRIMARY KEY (MaVT)
);
/*==============================================================*/
/* Table: LoaiDoiTuong                                          */
/*==============================================================*/


CREATE TABLE LoaiDoiTuong 
(
   MaLoaiDT             CHAR(5)        NOT NULL,
   TenLoaiDT            NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_LoaiDoiTuong PRIMARY KEY (MaLoaiDT)
);

/*==============================================================*/
/* Table: DoiTuong                                              */
/*==============================================================*/

CREATE TABLE DoiTuong 
(
   MaDT                 CHAR(5)        NOT NULL,
   MaLoaiDT             CHAR(5)        NOT NULL,
   TenDT                NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_DoiTuong PRIMARY KEY (MaDT),
   CONSTRAINT FK_DoiTuong_LoaiDoiTuong FOREIGN KEY (MaLoaiDT)
      REFERENCES LoaiDoiTuong (MaLoaiDT)
);

/*==============================================================*/
/* Table: TaiKhoan                                              */
/*==============================================================*/

CREATE TABLE TaiKhoan 
(
   MaTK                 INT				NOT NULL,
   MaNV                 CHAR(5)         NOT NULL,
   MaVT                 CHAR(5)         NULL,
   TenDN                VARCHAR(50)     NOT NULL,
   MatKhau              VARBINARY (8000)     NOT NULL,
   TrangThaiTK			NVARCHAR(50)    NOT NULL,
   CONSTRAINT PK_TaiKhoan PRIMARY KEY (MaTK),
   CONSTRAINT FK_TaiKhoan_NhanVien FOREIGN KEY (MaNV)
      REFERENCES NhanVien (MaNV),
   CONSTRAINT FK_TaiKhoan_VaiTro FOREIGN KEY (MaVT)
      REFERENCES VaiTro (MaVT)
);  

/*==============================================================*/
/* Table: LoaiQuyen                                             */
/*==============================================================*/

CREATE TABLE LoaiQuyen 
(
   MaLoaiQuyen          CHAR(5)        NOT NULL,
   TenLoaiQuyen         NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_LoaiQuyen PRIMARY KEY (MaLoaiQuyen)
);

/*==============================================================*/
/* Table: Quyen                                                 */
/*==============================================================*/

CREATE TABLE Quyen 
(
   MaQuyen              CHAR(5)        NOT NULL,
   MaLoaiQuyen          CHAR(5)        NOT NULL,
   TenQuyen             NVARCHAR(50)   NOT NULL,
   CONSTRAINT PK_Quyen PRIMARY KEY (MaQuyen),
   CONSTRAINT FK_Quyen_LoaiQuyen FOREIGN KEY (MaLoaiQuyen)
      REFERENCES LoaiQuyen (MaLoaiQuyen)
);

/*==============================================================*/
/* Table: PhanQuyen                                             */
/*==============================================================*/

CREATE TABLE PhanQuyen 
(
   MaDT                 CHAR(5)        NOT NULL,
   MaQuyen              CHAR(5)        NOT NULL,
   MaVT                 CHAR(5)        NOT NULL,
   NgayCap              DATE           NOT NULL,
   NgayCapNhatQuyen     DATE           NOT NULL,
   CONSTRAINT PK_PhanQuyen PRIMARY KEY (MaDT, MaQuyen, MaVT),
   CONSTRAINT FK_PhanQuyen_VaiTro FOREIGN KEY (MaVT)
      REFERENCES VaiTro (MaVT),
   CONSTRAINT FK_PhanQuyen_DoiTuong FOREIGN KEY (MaDT)
      REFERENCES DoiTuong (MaDT),
   CONSTRAINT FK_PhanQuyen_Quyen FOREIGN KEY (MaQuyen)
      REFERENCES Quyen (MaQuyen)
);