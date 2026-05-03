using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _05_2321003989_DangNguyenHoang_8802
{
    public partial class Form_BanHang : Form
    {
        public Form_BanHang()
        {
            InitializeComponent();
        }

        KetNoi data = new KetNoi();

        private void LoadChiTietHD()
        {
            string str = "SELECT c.MaSanPham AS N'Mã sản phẩm', " +
                         "s.TenSanPham AS N'Tên sản phẩm', " +
                         "c.DonGiaHD AS N'Đơn giá', " +
                         "c.SoLuongHD AS N'Số lượng', " +
                         "c.ThanhTienHD AS N'Thành tiền' " +
                         "FROM ChiTietHD c " +
                         "INNER JOIN SanPham s ON c.MaSanPham = s.MaSanPham " +
                         "WHERE c.SoHoaDon = '" + txtMaHD.Text + "'";

            SqlDataAdapter da = new SqlDataAdapter(str, data.GetConnection());
            DataTable dt = new DataTable();
            da.Fill(dt);

            dgvChitietHD.DataSource = dt;   // 🔴 PHẢI đặt trước

            if (dgvChitietHD.Columns.Count >= 5)
            {
                dgvChitietHD.Columns[0].Width = 100;
                dgvChitietHD.Columns[1].Width = 300;
                dgvChitietHD.Columns[2].Width = 100;
                dgvChitietHD.Columns[3].Width = 100;
                dgvChitietHD.Columns[4].Width = 150;

                dgvChitietHD.Columns[0].ReadOnly = true; // Mã SP
                dgvChitietHD.Columns[1].ReadOnly = true; // Tên SP
                dgvChitietHD.Columns[4].ReadOnly = true; // Thành tiền
            }
        }

        private string TaoMaHoaDon()
        {
            string sql = "SELECT TOP 1 SoHoaDon FROM HoaDon ORDER BY SoHoaDon DESC";
            object result = data.ExecuteScalar(sql);

            if (result == null)
                return "HD00000001";   // 10 ký tự

            string last = result.ToString().Trim(); // bỏ khoảng trắng do char(10)

            int number = int.Parse(last.Substring(2));
            number++;

            return "HD" + number.ToString("D8"); // 8 chữ số
        }

        private void Form_BanHang_Load(object sender, EventArgs e)
        {
            string maHD = TaoMaHoaDon();

            txtMaHD.Text = maHD;
            lblSoChungTu.Text = maHD;
        }

        bool daTaoHoaDon = false;

        private void btnTaoHD_Click(object sender, EventArgs e)
        {
            if (cboMoney.SelectedIndex == -1)
            {
                MessageBox.Show("Vui lòng chọn phương thức thanh toán");
                return;
            }

            string sql = "INSERT INTO HoaDon " +
                "(SoHoaDon, NgayLapHoaDon, TongTienHDtruocVAT, VATHoaDon, " +
                "TongTienHoaDon, PhuongThucTTHD, TrangThaiHD, MaKhachHang, MaNhanVien) " +
                "VALUES ('" + txtMaHD.Text + "', '" +
                dtpChungtu.Value.ToString("yyyy-MM-dd") + "', " +
                "0, 10, 0, " +  // ban đầu chưa có chi tiết thì tiền = 0
                "N'" + cboMoney.Text + "', " +
                "N'Đã tạo', '" +
                txtMaKH.Text + "', '" +
                txtMaNV.Text + "')";

            try
            {
                data.ExecuteNonQuery(sql);
                MessageBox.Show("Tạo hóa đơn thành công");

                daTaoHoaDon = true;
                btnTaoHD.Enabled = false;   // tránh tạo lại
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void LoadTongTien()
        {
            string sql = "SELECT TongTienHDtruocVAT, TongTienHoaDon " +
                         "FROM HoaDon WHERE SoHoaDon = '" + txtMaHD.Text + "'";

            DataTable dt = data.ExecuteQuery(sql);

            if (dt.Rows.Count > 0)
            {
                lblTruocVAT.Text = dt.Rows[0]["TongTienHDtruocVAT"].ToString();
                lblSauVAT.Text = dt.Rows[0]["TongTienHoaDon"].ToString();
            }
        }

        private void btnThem_Click_1(object sender, EventArgs e)
        {
            if (!daTaoHoaDon)
            {
                MessageBox.Show("Vui lòng tạo hóa đơn trước khi thêm sản phẩm.");
                return;
            }

            if (!int.TryParse(txtSoLuong.Text, out int soLuong) || soLuong <= 0)
            {
                MessageBox.Show("Số lượng phải là số nguyên dương.");
                return;
            }

            if (!double.TryParse(txtGiaBan.Text.Replace(",", ""), out double giaBan) || giaBan < 0)
            {
                MessageBox.Show("Giá bán không hợp lệ.");
                return;
            }

            double thanhTien = soLuong * giaBan;

            string sql = "INSERT INTO ChiTietHD " +
                "(SoHoaDon, MaSanPham, SoLuongHD, DonGiaHD, ThanhTienHD) " +
                "VALUES ('" + txtMaHD.Text + "', '" +
                txtMaSP.Text + "', " +
                soLuong + ", " +
                giaBan.ToString().Replace(",", ".") + ", " +
                thanhTien.ToString().Replace(",", ".") + ")";

            try
            {
                data.ExecuteNonQuery(sql);
                LoadChiTietHD();
                LoadTongTien();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void txtMaKH_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (string.IsNullOrWhiteSpace(txtMaKH.Text))
                    return;

                string sql = "SELECT TenKhachHang, SdtKhachHang, DiaChiKhachHang " +
                             "FROM KhachHang WHERE MaKhachHang = N'" + txtMaKH.Text.Trim() + "'";

                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                {
                    txtTenKH.Text = dt.Rows[0]["TenKhachHang"].ToString();
                    txtSDTKH.Text = dt.Rows[0]["SdtKhachHang"].ToString();
                    TXTDiachiKH.Text = dt.Rows[0]["DiaChiKhachHang"].ToString();
                }
                else
                {
                    MessageBox.Show("Không tìm thấy khách hàng");
                    txtTenKH.Clear();
                    txtSDTKH.Clear();
                    TXTDiachiKH.Clear();
                }

                e.SuppressKeyPress = true; // tránh tiếng "ting"
            }
        }

        private void txtMaNV_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (string.IsNullOrWhiteSpace(txtMaNV.Text))
                    return;

                string sql = "SELECT TenNhanVien FROM NhanVien " +
                             "WHERE MaNhanVien = N'" + txtMaNV.Text.Trim() + "'";

                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                {
                    txtTenNV.Text = dt.Rows[0]["TenNhanVien"].ToString();
                }
                else
                {
                    MessageBox.Show("Không tìm thấy nhân viên");
                    txtTenNV.Clear();
                }

                e.SuppressKeyPress = true; // tránh tiếng "ting"
            }
        }

        private void txtMaSP_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (string.IsNullOrWhiteSpace(txtMaSP.Text))
                    return;

                string sql = "SELECT TenSanPham, GiaBan FROM SanPham " +
                             "WHERE MaSanPham = N'" + txtMaSP.Text.Trim() + "'";

                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                {
                    txtTenSP.Text = dt.Rows[0]["TenSanPham"].ToString();

                    // format giá đẹp hơn
                    decimal gia = Convert.ToDecimal(dt.Rows[0]["GiaBan"]);
                    txtGiaBan.Text = gia.ToString("N0"); // 50,000
                }
                else
                {
                    MessageBox.Show("Không tìm thấy sản phẩm");
                    txtTenSP.Clear();
                    txtGiaBan.Clear();
                }

                e.SuppressKeyPress = true; // tránh tiếng "ding"
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            if (dgvChitietHD.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn dòng cần xóa");
                return;
            }

            string maSP = dgvChitietHD.CurrentRow.Cells[0].Value.ToString();

            DialogResult rs = MessageBox.Show(
                "Bạn có chắc muốn xóa sản phẩm này?",
                "Xác nhận",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);

            if (rs == DialogResult.No)
                return;

            string sql = "DELETE FROM ChiTietHD " +
                         "WHERE SoHoaDon = '" + txtMaHD.Text + "' " +
                         "AND MaSanPham = '" + maSP + "'";

            try
            {
                data.ExecuteNonQuery(sql);

                LoadChiTietHD();     // load lại grid
                LoadTongTien();      // load lại label

                MessageBox.Show("Xóa thành công");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            if (dgvChitietHD.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn dòng cần sửa");
                return;
            }

            string maSP = dgvChitietHD.CurrentRow.Cells[0].Value.ToString();
            string donGia = dgvChitietHD.CurrentRow.Cells[2].Value.ToString().Replace(",", "");
            string soLuong = dgvChitietHD.CurrentRow.Cells[3].Value.ToString();
            double thanhTien = double.Parse(donGia) * int.Parse(soLuong);

            string sql = "UPDATE ChiTietHD SET " +
                         "DonGiaHD = " + donGia + ", " +
                         "SoLuongHD = " + soLuong + ", " +
                         "ThanhTienHD = " + thanhTien.ToString().Replace(",", ".") + " " +
                         "WHERE SoHoaDon = '" + txtMaHD.Text + "' " +
                         "AND MaSanPham = '" + maSP + "'";

            try
            {
                data.ExecuteNonQuery(sql);

                LoadChiTietHD();     // load lại grid
                LoadTongTien();      // load lại label

                MessageBox.Show("Cập nhật thành công");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            if (!daTaoHoaDon)
            {
                MessageBox.Show("Hóa đơn chưa được tạo nên không thể in!");
                return;
            }

            string soHD = txtMaHD.Text.Trim();

            Form_InHD f = new Form_InHD();
            f.LoadReport(soHD);
            f.ShowDialog();
        }
    }
}
