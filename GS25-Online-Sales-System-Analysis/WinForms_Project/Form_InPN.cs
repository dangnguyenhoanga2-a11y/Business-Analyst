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
    public partial class Form_InPN : Form
    {
        public Form_InPN()
        {
            InitializeComponent();
        }

        public void LoadReport(string soHD)
        {
            Report_PhieuNhap rpt = new Report_PhieuNhap(); // rptHoaDon là file .rpt bạn tạo
            rpt.SetParameterValue("paraSoPN", soHD); // gán tham số

            crvHoaDon.ReportSource = rpt; // hiển thị report
        }
    }
}
