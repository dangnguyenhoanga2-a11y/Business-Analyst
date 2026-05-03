using System;
using System.Data;
using System.Windows.Forms;

namespace _05_2321003989_DangNguyenHoang_8802
{
    public partial class Form_DonHang : Form
    {
        private readonly KetNoi data = new KetNoi();

        public Form_DonHang()
        {
            InitializeComponent();
        }

        private void Form_DonHang_Load(object sender, EventArgs e)
        {
            LoadDonHangKhachHang();
        }

        private void LoadDonHangKhachHang()
        {
            string maNguoiDung = Form_DangNhap.Session.MaNguoiDung;

            string sql = @"
SELECT
    dh.MaDonHang AS N'Mã đơn hàng',
    dh.NgayDat AS N'Ngày đặt',
    dh.NgayGiao AS N'Ngày giao',
    dh.TongTienDonHang AS N'Tổng tiền',
    dh.PhuongThucTTDH AS N'Phương thức thanh toán',
    dh.TrangthaiDH AS N'Trạng thái'
FROM DonHang dh
INNER JOIN KhachHangUser khu ON dh.MaKhachHang = khu.MaKhachHang
WHERE khu.MaNguoiDung = '" + maNguoiDung + @"'
ORDER BY dh.NgayDat DESC, dh.MaDonHang DESC";

            DataTable dt = data.ExecuteQuery(sql);
            dgvDonHang.DataSource = dt;

            dgvDonHang.AllowUserToAddRows = false;
            dgvDonHang.ReadOnly = true;
            dgvDonHang.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvDonHang.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvDonHang.MultiSelect = false;

            if (dgvDonHang.Columns.Contains("Tổng tiền"))
            {
                dgvDonHang.Columns["Tổng tiền"].DefaultCellStyle.Format = "N0";
            }

            lblSoDonValue.Text = dt.Rows.Count.ToString();
        }
    }
}
