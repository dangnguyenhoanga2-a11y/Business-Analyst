using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _05_2321003989_DangNguyenHoang_8802
{
    public partial class Form_NhapKho : Form
    {
        public Form_NhapKho()
        {
            InitializeComponent();
        }

        KetNoi data = new KetNoi();

        private void txtMaNV_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                string sql = "SELECT TenNhanVien FROM NhanVien WHERE MaNhanVien = N'" + txtMaNV.Text.Trim() + "'";
                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                    txtTenNV.Text = dt.Rows[0]["TenNhanVien"].ToString();
                else
                {
                    MessageBox.Show("Không tìm thấy nhân viên");
                    txtTenNV.Clear();
                }

                e.SuppressKeyPress = true;
            }
        }
        // ========================= TẠO MÃ PN =========================
        private string TaoMaPN()
        {
            string sql = "SELECT TOP 1 SoPhieuNhap FROM PhieuNhap ORDER BY SoPhieuNhap DESC";
            object result = data.ExecuteScalar(sql);

            if (result == null || result.ToString().Trim() == "")
                return "PN00000001";

            string last = result.ToString().Trim();
            int number = int.Parse(last.Substring(2)) + 1;

            return "PN" + number.ToString("D8");
        }

        private void txtMaSP_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                string sql = "SELECT TenSanPham FROM SanPham WHERE MaSanPham = N'" + txtMaSP.Text.Trim() + "'";
                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                    txtTenSP.Text = dt.Rows[0]["TenSanPham"].ToString();
                else
                {
                    MessageBox.Show("Không tìm thấy sản phẩm");
                    txtTenSP.Clear();
                }

                e.SuppressKeyPress = true;
            }
        }

        private void btnTao_Click(object sender, EventArgs e)
        {
            string sql = "INSERT INTO PhieuNhap " +
                "(SoPhieuNhap, NgayNhap, LyDoNhap, TriGiaPhieuNhap, TrangThaiPN, MaNhanVien) VALUES ('" +
                txtMaPN.Text + "', '" +
                dtpChungtu.Value.ToString("yyyy-MM-dd") + "', " +
                "N'Nhập hàng', 0, N'Đã tạo', '" +
                txtMaNV.Text + "')";

            try
            {
                data.ExecuteNonQuery(sql);
                MessageBox.Show("Tạo phiếu nhập thành công");

                daTaoPhieuNhap = true;
                btnTao.Enabled = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            // kiểm tra dữ liệu
            if (!double.TryParse(txtGiaNhap.Text.Replace(",", ""), out double gia))
            {
                MessageBox.Show("Giá nhập không hợp lệ");
                return;
            }

            if (!int.TryParse(txtSoLuong.Text, out int soluong))
            {
                MessageBox.Show("Số lượng không hợp lệ");
                return;
            }

            double thanhtien = gia * soluong;

            string sql = "INSERT INTO ChiTietPhieuNhap " +
                "(DonGiaPN, SoLuongPN, ThanhTienPN, SoPhieuNhap, MaSanPham) VALUES (" +
                gia.ToString().Replace(",", ".") + ", " +
                soluong + ", " +
                thanhtien.ToString().Replace(",", ".") + ", '" +
                txtMaPN.Text + "', '" +
                txtMaSP.Text + "')";

            try
            {
                data.ExecuteNonQuery(sql);

                LoadChiTietPN();
                LoadTriGiaPN();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void LoadChiTietPN()
        {
            string sql = "SELECT c.MaSanPham AS N'Mã SP', " +
                         "s.TenSanPham AS N'Tên SP', " +
                         "c.DonGiaPN AS N'Giá nhập', " +
                         "c.SoLuongPN AS N'Số lượng', " +
                         "c.ThanhTienPN AS N'Thành tiền' " +
                         "FROM ChiTietPhieuNhap c " +
                         "JOIN SanPham s ON c.MaSanPham = s.MaSanPham " +
                         "WHERE c.SoPhieuNhap = '" + txtMaPN.Text + "'";

            dgvChitietHD.DataSource = data.ExecuteQuery(sql);
        }

        private void LoadTriGiaPN()
        {
            string sql = "SELECT SUM(ThanhTienPN) FROM ChiTietPhieuNhap WHERE SoPhieuNhap = '" + txtMaPN.Text + "'";
            object result = data.ExecuteScalar(sql);

            double tong = 0;

            if (result != DBNull.Value && result != null)
                tong = Convert.ToDouble(result);

            lblTriGia.Text = tong.ToString("N0");

            // update lại phiếu nhập
            string update = "UPDATE PhieuNhap SET TriGiaPhieuNhap = " +
                tong.ToString().Replace(",", ".") +
                " WHERE SoPhieuNhap = '" + txtMaPN.Text + "'";

            data.ExecuteNonQuery(update);
        }

        private void Form_NhapKho_Load(object sender, EventArgs e)
        {
            string maPN = TaoMaPN();
            txtMaPN.Text = maPN;
            lblSoChungTu.Text = maPN;
        }

        private void txtMaKho_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                string sql = "SELECT DiaChiKho FROM Kho WHERE MaKho = N'" + txtMaKho.Text.Trim() + "'";
                DataTable dt = data.ExecuteQuery(sql);

                if (dt.Rows.Count > 0)
                    TXTDiachi.Text = dt.Rows[0]["DiaChiKho"].ToString();
                else
                {
                    MessageBox.Show("Không tìm thấy kho");
                    TXTDiachi.Clear();
                }

                e.SuppressKeyPress = true;
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

            string sql = "DELETE FROM ChiTietPhieuNhap " +
                         "WHERE SoPhieuNhap = '" + txtMaPN.Text + "' " +
                         "AND MaSanPham = '" + maSP + "'";

            try
            {
                data.ExecuteNonQuery(sql);

                LoadChiTietPN();   // load lại grid
                LoadTriGiaPN();    // cập nhật lại tổng tiền

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

            // Lấy dữ liệu từ grid
            string donGia = dgvChitietHD.CurrentRow.Cells[2].Value.ToString().Replace(",", "");
            string soLuong = dgvChitietHD.CurrentRow.Cells[3].Value.ToString();

            double thanhTien = double.Parse(donGia) * int.Parse(soLuong);

            string sql = "UPDATE ChiTietPhieuNhap SET " +
                         "DonGiaPN = " + donGia + ", " +
                         "SoLuongPN = " + soLuong + ", " +
                         "ThanhTienPN = " + thanhTien.ToString().Replace(",", ".") + " " +
                         "WHERE SoPhieuNhap = '" + txtMaPN.Text + "' " +
                         "AND MaSanPham = '" + maSP + "'";

            try
            {
                data.ExecuteNonQuery(sql);

                LoadChiTietPN();   // load lại grid
                LoadTriGiaPN();    // cập nhật lại tổng tiền

                MessageBox.Show("Cập nhật thành công");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        bool daTaoPhieuNhap = false;
        private void btnIn_Click(object sender, EventArgs e)
        {
            if (!daTaoPhieuNhap)
            {
                MessageBox.Show("Phiếu nhập chưa được tạo nên không thể in!");
                return;
            }

            string soHD = txtMaPN.Text.Trim();

            Form_InPN f = new Form_InPN();
            f.LoadReport(soHD);
            f.ShowDialog();
        }
    }
}
