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
    public partial class Form_DangNhap : Form
    {
        public Form_DangNhap()
        {
            InitializeComponent();
            this.AcceptButton = btnDangNhap;
        }

        KetNoi data = new KetNoi();

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            // 1. Kiểm tra dữ liệu nhập
            if (string.IsNullOrWhiteSpace(txtTen.Text) ||
                string.IsNullOrWhiteSpace(txtMK.Text))
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin");
                return;
            }

            // 2. Câu lệnh SQL
            string sql = @"SELECT tk.MaNguoiDung, tk.MaVaiTro, vt.TenVaiTro
                           FROM TaiKhoan tk
                           INNER JOIN VaiTro vt ON tk.MaVaiTro = vt.MaVaiTro
                           WHERE tk.TenTaiKhoan = @user 
                           AND tk.MatKhau = @pass";

            try
            {
                using (SqlConnection conn = data.GetConnection()) // đã OPEN sẵn
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    // 3. Gán tham số
                    cmd.Parameters.AddWithValue("@user", txtTen.Text.Trim());
                    cmd.Parameters.AddWithValue("@pass", txtMK.Text.Trim());

                    // ❌ KHÔNG gọi conn.Open() nữa

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // 4. Lấy thông tin user
                        string maNguoiDung = reader["MaNguoiDung"].ToString().Trim();
                        string maVaiTro = reader["MaVaiTro"].ToString().Trim();
                        string tenVaiTro = reader["TenVaiTro"].ToString().Trim();

                        reader.Close();

                        // 5. Lưu session
                        Session.MaNguoiDung = maNguoiDung;
                        Session.MaVaiTro = maVaiTro;
                        Session.TenVaiTro = tenVaiTro;

                        // 6. Mở form chính
                        Form_TrangChu f = new Form_TrangChu();
                        f.Show();
                        this.Hide();
                    }
                    else
                    {
                        MessageBox.Show("Sai tài khoản hoặc mật khẩu");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
        public static class Session
        {
            public static string MaNguoiDung;
            public static string MaVaiTro;
            public static string TenVaiTro;
        }

    }
}
