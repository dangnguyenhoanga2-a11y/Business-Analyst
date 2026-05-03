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
    public partial class Form_TrangChu : Form
    {
        private bool laKhachHang;

        public Form_TrangChu()
        {
            InitializeComponent();
        }
        KetNoi data = new KetNoi();
        private void LoadSanPham()
        {
            string sql = "SELECT * FROM SanPham";
            DataTable dt = data.GetDataTable(sql);

            flowSanPham.Controls.Clear();

            foreach (DataRow row in dt.Rows)
            {
                string ma = row["MaSanPham"].ToString();
                string ten = row["TenSanPham"].ToString();
                double gia = Convert.ToDouble(row["GiaBan"]);
                string hinh = row["HinhAnh"].ToString();

                Panel p = TaoCardSanPham(ma, ten, gia, hinh);
                flowSanPham.Controls.Add(p);
            }
        }
        private Panel TaoCardSanPham(string ma, string ten, double gia, string hinh)
        {
            Panel p = new Panel();
            p.Width = 150;
            p.Height = 200;
            p.BorderStyle = BorderStyle.FixedSingle;

            // 📷 Hình
            PictureBox pic = new PictureBox();
            pic.Width = 140;
            pic.Height = 80;
            pic.Top = 5;
            pic.Left = 5;
            pic.SizeMode = PictureBoxSizeMode.StretchImage;

            try
            {
                string path = Application.StartupPath + "\\" + hinh;

                if (System.IO.File.Exists(path))
                    pic.Image = Image.FromFile(path);
                else
                    pic.Image = Image.FromFile(Application.StartupPath + "\\images\\no-image.jpg");
            }
            catch
            {
                pic.Image = null;
            }

            // 📝 Tên
            Label lblTen = new Label();
            lblTen.Text = ten;
            lblTen.Top = 90;
            lblTen.Width = 140;

            // 💰 Giá
            Label lblGia = new Label();
            lblGia.Text = gia.ToString("N0") + " VND";
            lblGia.Top = 120;

            // 🔘 Button
            Button btn = new Button();
            btn.Text = laKhachHang ? "Thêm" : "Xem";
            btn.Top = 150;
            btn.Width = 120;
            btn.Enabled = laKhachHang;

            // 🔥 QUAN TRỌNG NHẤT
            btn.Click += (s, e) =>
            {
                ThemVaoGio(ma, ten, gia);
            };

            p.Controls.Add(pic);
            p.Controls.Add(lblTen);
            p.Controls.Add(lblGia);
            p.Controls.Add(btn);

            return p;
        }

        private void Form_TrangChu_Load(object sender, EventArgs e)
        {
            laKhachHang = KiemTraTaiKhoanKhachHang();
            ApDungGiaoDienTheoVaiTro();
            LoadSanPham();

            if (laKhachHang)
            {
                LoadKhachHang();
            }
        }
        class GioHangItem
        {
            public string MaSP { get; set; }
            public string TenSP { get; set; }
            public int SoLuong { get; set; }
            public double DonGia { get; set; }
            public double ThanhTien => SoLuong * DonGia;
        }
        List<GioHangItem> gioHang = new List<GioHangItem>();
        private void LoadGioHang()
        {
            dgvGioHang.DataSource = null;
            dgvGioHang.DataSource = gioHang;

            lblTongtien.Text = gioHang.Sum(x => x.ThanhTien).ToString("N0");
        }

        private void ThemVaoGio(string ma, string ten, double gia)
        {
            if (!laKhachHang)
            {
                MessageBox.Show("Tài khoản nhân viên không sử dụng giỏ hàng.");
                return;
            }

            var item = gioHang.FirstOrDefault(x => x.MaSP == ma);

            if (item != null)
            {
                item.SoLuong++;
            }
            else
            {
                gioHang.Add(new GioHangItem
                {
                    MaSP = ma,
                    TenSP = ten,
                    SoLuong = 1,
                    DonGia = gia
                });
            }

            LoadGioHang();
        }
        private bool KiemTraTaiKhoanKhachHang()
        {
            string maND = Form_DangNhap.Session.MaNguoiDung;
            string sql = "SELECT COUNT(*) FROM KhachHangUser WHERE MaNguoiDung = '" + maND + "'";
            object result = data.ExecuteScalar(sql);

            return result != null && Convert.ToInt32(result) > 0;
        }

        private void ApDungGiaoDienTheoVaiTro()
        {
            if (laKhachHang)
            {
                muaHàngToolStripMenuItem.Visible = true;
                splitMain.Panel2Collapsed = false;
                return;
            }

            txtMaKH.Clear();
            txtTen.Clear();
            txtSDT.Clear();
            txtDiaChi.Clear();
            dgvGioHang.DataSource = null;
            lblTongtien.Text = "0";

            muaHàngToolStripMenuItem.Visible = false;
            splitMain.Panel2Collapsed = true;
            bánHàngToolStripMenuItem.Visible = true;
            this.Text = "Trang chủ nhân viên";
        }

        private void LoadKhachHang()
        {
            string maND = Form_DangNhap.Session.MaNguoiDung;

            string sql = $@"
    SELECT KH.*
    FROM KhachHang KH
    JOIN KhachHangUser KHU ON KH.MaKhachHang = KHU.MaKhachHang
    WHERE KHU.MaNguoiDung = '{maND}'
    ";

            DataTable dt = data.GetDataTable(sql);

            if (dt.Rows.Count > 0)
            {
                txtMaKH.Text = dt.Rows[0]["MaKhachHang"].ToString();
                txtTen.Text = dt.Rows[0]["TenKhachHang"].ToString();
                txtSDT.Text = dt.Rows[0]["SdtKhachHang"].ToString();      
                txtDiaChi.Text = dt.Rows[0]["DiaChiKhachHang"].ToString(); 
            }
            else if (laKhachHang)
            {
                MessageBox.Show("Không tìm thấy khách hàng!");
            }
        }

        private void dgvGioHang_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            foreach (var item in gioHang)
            {
                if (item.SoLuong <= 0)
                    item.SoLuong = 1;
            }

            LoadGioHang();
        }

        private string TaoMaDonHang()
        {
            string sql = "SELECT TOP 1 MaDonHang FROM DonHang ORDER BY MaDonHang DESC";
            object result = data.ExecuteScalar(sql);

            if (result == null)
                return "DH001";

            string ma = result.ToString(); // VD: DH005
            int so = int.Parse(ma.Substring(2)) + 1;

            return "DH" + so.ToString("D3");
        }

        private void btnDatHang_Click(object sender, EventArgs e)
        {
            if (!laKhachHang)
            {
                MessageBox.Show("Chỉ tài khoản khách hàng mới có thể đặt hàng.");
                return;
            }

            if (gioHang.Count == 0)
            {
                MessageBox.Show("Giỏ hàng trống");
                return;
            }

            string maDH = TaoMaDonHang();
            string maKH = txtMaKH.Text;
            double tongTien = gioHang.Sum(x => x.ThanhTien);
            string pttt = cboMoney.Text;

            // 🔹 Insert DonHang
            string sqlDH = $@"
    INSERT INTO DonHang
    VALUES ('{maDH}', GETDATE(), GETDATE(), {tongTien},
    N'{pttt}', N'Chờ xử lý', '{maKH}')
    ";

            data.ExecuteNonQuery(sqlDH);

            // 🔹 Insert ChiTietDonHang
            foreach (var item in gioHang)
            {
                string sqlCT = $@"
        INSERT INTO ChiTietDonHang
        VALUES ({item.DonGia}, {item.SoLuong}, {item.ThanhTien},
        '{maDH}', '{item.MaSP}')
        ";

                data.ExecuteNonQuery(sqlCT);
            }

            MessageBox.Show("Đặt hàng thành công!");

            // Reset
            gioHang.Clear();
            LoadGioHang();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            if (dgvGioHang.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn sản phẩm cần xóa");
                return;
            }

            string maSP = dgvGioHang.CurrentRow.Cells["MaSP"].Value.ToString();

            var item = gioHang.FirstOrDefault(x => x.MaSP == maSP);

            if (item != null)
            {
                gioHang.Remove(item);
                LoadGioHang();
            }
        }

        private void báoCáoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form_BaoCao formBaoCao = new Form_BaoCao();
            formBaoCao.ShowDialog();
        }

        private void bánHàngToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            Form_BanHang formBanHang = new Form_BanHang();
            formBanHang.ShowDialog();
        }

        private void nhậpKhoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form_NhapKho formNhapKho = new Form_NhapKho();
            formNhapKho.ShowDialog();
        }

        private void thẻThànhViênToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!laKhachHang)
            {
                MessageBox.Show("Chỉ khách hàng mới có thể xem thẻ thành viên.");
                return;
            }

            Form_TheThanhVien formTheThanhVien = new Form_TheThanhVien();
            formTheThanhVien.ShowDialog();
        }

        private void đơnHàngToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!laKhachHang)
            {
                MessageBox.Show("Chỉ khách hàng mới có thể xem danh sách đơn hàng.");
                return;
            }

            Form_DonHang formDonHang = new Form_DonHang();
            formDonHang.ShowDialog();
        }
    }
}
