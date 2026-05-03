namespace _05_2321003989_DangNguyenHoang_8802
{
    partial class Form_InBCDT
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.crvDoanhThu = new CrystalDecisions.Windows.Forms.CrystalReportViewer();
            this.SuspendLayout();
            // 
            // crvDoanhThu
            // 
            this.crvDoanhThu.ActiveViewIndex = -1;
            this.crvDoanhThu.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.crvDoanhThu.Cursor = System.Windows.Forms.Cursors.Default;
            this.crvDoanhThu.Dock = System.Windows.Forms.DockStyle.Fill;
            this.crvDoanhThu.Location = new System.Drawing.Point(0, 0);
            this.crvDoanhThu.Name = "crvDoanhThu";
            this.crvDoanhThu.Size = new System.Drawing.Size(800, 450);
            this.crvDoanhThu.TabIndex = 0;
            // 
            // Form_InBCDT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.crvDoanhThu);
            this.Name = "Form_InBCDT";
            this.Text = "Form_InBCDT";
            this.ResumeLayout(false);

        }

        #endregion

        private CrystalDecisions.Windows.Forms.CrystalReportViewer crvDoanhThu;
    }
}
