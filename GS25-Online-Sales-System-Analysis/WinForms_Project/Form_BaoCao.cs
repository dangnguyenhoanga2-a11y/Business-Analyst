using System;
using System.Data;
using System.Windows.Forms;

namespace _05_2321003989_DangNguyenHoang_8802
{
    public partial class Form_BaoCao : Form
    {
        private readonly KetNoi data = new KetNoi();

        public Form_BaoCao()
        {
            InitializeComponent();
        }

        private void Form_BaoCao_Load(object sender, EventArgs e)
        {
            cboLoaiBaoCao.SelectedIndex = 0;
            dtpTuNgay.Value = DateTime.Today.AddDays(-30);
            dtpDenNgay.Value = DateTime.Today;
            TaiBaoCao();
        }

        private void btnXemBaoCao_Click(object sender, EventArgs e)
        {
            TaiBaoCao();
        }

        private void cboLoaiBaoCao_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsHandleCreated)
            {
                TaiBaoCao();
            }
        }

        private void TaiBaoCao()
        {
            if (dtpTuNgay.Value.Date > dtpDenNgay.Value.Date)
            {
                MessageBox.Show("Từ ngày không được lớn hơn đến ngày.");
                return;
            }

            DataTable dt = cboLoaiBaoCao.SelectedIndex == 0
                ? LayBaoCaoKho()
                : LayBaoCaoDoanhThu();

            dgvBaoCao.DataSource = dt;

            lblSoDong.Text = dt.Rows.Count.ToString();
            lblTongTien.Text = TinhTongTien(dt).ToString("N0");
            lblMoTa.Text = cboLoaiBaoCao.SelectedIndex == 0
                ? "Dữ liệu lấy từ phiếu nhập và chi tiết phiếu nhập."
                : "Dữ liệu lấy từ hóa đơn và chi tiết hóa đơn.";

            DinhDangLuoi();
        }

        private DataTable LayBaoCaoKho()
        {
            string tuNgay = dtpTuNgay.Value.Date.ToString("yyyy-MM-dd");
            string denNgay = dtpDenNgay.Value.Date.ToString("yyyy-MM-dd");

            string sql = "SELECT pn.SoPhieuNhap AS N'Số phiếu nhập', " +
                         "pn.NgayNhap AS N'Ngày nhập', " +
                         "sp.MaSanPham AS N'Mã sản phẩm', " +
                         "sp.TenSanPham AS N'Tên sản phẩm', " +
                         "ct.SoLuongPN AS N'Số lượng nhập', " +
                         "ct.DonGiaPN AS N'Đơn giá nhập', " +
                         "ct.ThanhTienPN AS N'Thành tiền', " +
                         "pn.LyDoNhap AS N'Lý do nhập', " +
                         "pn.TrangThaiPN AS N'Trạng thái', " +
                         "pn.MaNhanVien AS N'Mã nhân viên' " +
                         "FROM PhieuNhap pn " +
                         "INNER JOIN ChiTietPhieuNhap ct ON pn.SoPhieuNhap = ct.SoPhieuNhap " +
                         "INNER JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham " +
                         "WHERE CONVERT(date, pn.NgayNhap) BETWEEN '" + tuNgay + "' AND '" + denNgay + "' " +
                         "ORDER BY pn.NgayNhap, pn.SoPhieuNhap, sp.MaSanPham";

            return data.ExecuteQuery(sql);
        }

        private DataTable LayBaoCaoDoanhThu()
        {
            string tuNgay = dtpTuNgay.Value.Date.ToString("yyyy-MM-dd");
            string denNgay = dtpDenNgay.Value.Date.ToString("yyyy-MM-dd");

            string sql = "SELECT hd.SoHoaDon AS N'Số hóa đơn', " +
                         "hd.NgayLapHoaDon AS N'Ngày lập', " +
                         "sp.MaSanPham AS N'Mã sản phẩm', " +
                         "sp.TenSanPham AS N'Tên sản phẩm', " +
                         "ct.SoLuongHD AS N'Số lượng bán', " +
                         "ct.DonGiaHD AS N'Đơn giá bán', " +
                         "ct.ThanhTienHD AS N'Thành tiền', " +
                         "hd.VATHoaDon AS N'VAT (%)', " +
                         "hd.PhuongThucTTHD AS N'Phương thức thanh toán', " +
                         "hd.TrangThaiHD AS N'Trạng thái', " +
                         "hd.MaKhachHang AS N'Mã khách hàng', " +
                         "hd.MaNhanVien AS N'Mã nhân viên' " +
                         "FROM HoaDon hd " +
                         "INNER JOIN ChiTietHD ct ON hd.SoHoaDon = ct.SoHoaDon " +
                         "INNER JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham " +
                         "WHERE CONVERT(date, hd.NgayLapHoaDon) BETWEEN '" + tuNgay + "' AND '" + denNgay + "' " +
                         "ORDER BY hd.NgayLapHoaDon, hd.SoHoaDon, sp.MaSanPham";

            return data.ExecuteQuery(sql);
        }

        private decimal TinhTongTien(DataTable dt)
        {
            decimal tongTien = 0;
            const string tenCotTien = "Thành tiền";

            foreach (DataRow row in dt.Rows)
            {
                if (row[tenCotTien] != DBNull.Value)
                {
                    tongTien += Convert.ToDecimal(row[tenCotTien]);
                }
            }

            return tongTien;
        }

        private void DinhDangLuoi()
        {
            dgvBaoCao.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvBaoCao.ReadOnly = true;
            dgvBaoCao.AllowUserToAddRows = false;
            dgvBaoCao.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            const string tenCotTien = "Thành tiền";

            if (dgvBaoCao.Columns.Contains(tenCotTien))
            {
                dgvBaoCao.Columns[tenCotTien].DefaultCellStyle.Format = "N0";
            }

            if (dgvBaoCao.Columns.Contains("Đơn giá nhập"))
            {
                dgvBaoCao.Columns["Đơn giá nhập"].DefaultCellStyle.Format = "N0";
            }

            if (dgvBaoCao.Columns.Contains("Đơn giá bán"))
            {
                dgvBaoCao.Columns["Đơn giá bán"].DefaultCellStyle.Format = "N0";
            }
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            DateTime tuNgay = dtpTuNgay.Value.Date;
            DateTime denNgay = dtpDenNgay.Value.Date;

            if (tuNgay > denNgay)
            {
                MessageBox.Show("Từ ngày không được lớn hơn đến ngày.");
                return;
            }

            if (cboLoaiBaoCao.SelectedIndex == 0) // Báo cáo kho
            {
                Form_InTonKho f = new Form_InTonKho();
                f.LoadReport(tuNgay, denNgay);
                f.ShowDialog();
            }
            else // Báo cáo doanh thu
            {
                Form_InBCDT f = new Form_InBCDT();
                f.LoadReport(tuNgay, denNgay);
                f.ShowDialog();
            }
        }
    }
}
