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
    public partial class Form_InBCDT : Form
    {
        public Form_InBCDT()
        {
            InitializeComponent();
        }
        public void LoadReport(DateTime tuNgay, DateTime denNgay)
        {
            ReportDoanhThu rpt = new ReportDoanhThu();   // hoặc ReportTonKho

            rpt.SetParameterValue("TuNgay", tuNgay);
            rpt.SetParameterValue("DenNgay", denNgay);

            crvDoanhThu.ReportSource = rpt;
            crvDoanhThu.Refresh();
        }
    }
}
