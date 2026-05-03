using System;
using System.Data;
using System.Windows.Forms;

namespace _05_2321003989_DangNguyenHoang_8802
{
    public partial class Form_TheThanhVien : Form
    {
        private readonly KetNoi data = new KetNoi();

        public Form_TheThanhVien()
        {
            InitializeComponent();
        }

        private void Form_TheThanhVien_Load(object sender, EventArgs e)
        {
            LoadThongTinThe();
            LoadKhuyenMai();
        }

        private void LoadThongTinThe()
        {
            string maNguoiDung = Form_DangNhap.Session.MaNguoiDung;

            string sql = @"
SELECT TOP 1
    ttv.MaTheThanhVien,
    ttv.DiemTichLuy,
    kh.MaKhachHang,
    kh.TenKhachHang,
    kh.SdtKhachHang,
    kh.DiaChiKhachHang
FROM TheThanhVien ttv
INNER JOIN KhachHang kh ON ttv.MaKhachHang = kh.MaKhachHang
INNER JOIN KhachHangUser khu ON kh.MaKhachHang = khu.MaKhachHang
WHERE khu.MaNguoiDung = '" + maNguoiDung + "'";

            DataTable dt = data.ExecuteQuery(sql);

            if (dt.Rows.Count == 0)
            {
                MessageBox.Show("Tài khoản này chưa có thẻ thành viên.");
                Close();
                return;
            }

            DataRow row = dt.Rows[0];
            lblMaTheValue.Text = row["MaTheThanhVien"].ToString();
            lblDiemValue.Text = row["DiemTichLuy"].ToString();
            lblMaKHValue.Text = row["MaKhachHang"].ToString();
            lblTenKHValue.Text = row["TenKhachHang"].ToString();
            lblSDTValue.Text = row["SdtKhachHang"].ToString();
            txtDiaChi.Text = row["DiaChiKhachHang"].ToString();
        }

        private void LoadKhuyenMai()
        {
            string sql = @"
SELECT
    km.MaKhuyenMai AS N'Mã khuyến mãi',
    km.TenKhuyenMai AS N'Tên khuyến mãi',
    ctkm.MaSanPham AS N'Mã sản phẩm',
    sp.TenSanPham AS N'Tên sản phẩm',
    ctkm.PhanTramGiam AS N'Giảm (%)',
    ctkm.NgayBD AS N'Ngày bắt đầu',
    ctkm.NgayKT AS N'Ngày kết thúc'
FROM ChiTietKhuyenMai ctkm
INNER JOIN KhuyenMai km ON ctkm.MaKhuyenMai = km.MaKhuyenMai
INNER JOIN SanPham sp ON ctkm.MaSanPham = sp.MaSanPham
ORDER BY ctkm.NgayKT DESC, km.MaKhuyenMai";

            dgvKhuyenMai.DataSource = data.ExecuteQuery(sql);

            dgvKhuyenMai.AllowUserToAddRows = false;
            dgvKhuyenMai.ReadOnly = true;
            dgvKhuyenMai.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvKhuyenMai.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            if (dgvKhuyenMai.Columns.Contains("Giảm (%)"))
            {
                dgvKhuyenMai.Columns["Giảm (%)"].DefaultCellStyle.Format = "N0";
            }
        }
    }
}
