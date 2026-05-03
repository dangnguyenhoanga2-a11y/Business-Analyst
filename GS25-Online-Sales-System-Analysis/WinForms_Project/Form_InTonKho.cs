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
    public partial class Form_InTonKho : Form
    {
        public Form_InTonKho()
        {
            InitializeComponent();
        }
        public void LoadReport(DateTime tuNgay, DateTime denNgay)
        {
            ReportTonKho rpt = new ReportTonKho();   // hoặc ReportTonKho

            rpt.SetParameterValue("TuNgay", tuNgay);
            rpt.SetParameterValue("DenNgay", denNgay);

            crvTonKho.ReportSource = rpt;
            crvTonKho.Refresh();
        }
    }
}
