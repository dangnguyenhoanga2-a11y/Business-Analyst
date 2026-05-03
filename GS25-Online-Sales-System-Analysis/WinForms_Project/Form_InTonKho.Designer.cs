namespace _05_2321003989_DangNguyenHoang_8802
{
    partial class Form_InTonKho
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
            this.crvTonKho = new CrystalDecisions.Windows.Forms.CrystalReportViewer();
            this.SuspendLayout();
            // 
            // crvTonKho
            // 
            this.crvTonKho.ActiveViewIndex = -1;
            this.crvTonKho.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.crvTonKho.Cursor = System.Windows.Forms.Cursors.Default;
            this.crvTonKho.Dock = System.Windows.Forms.DockStyle.Fill;
            this.crvTonKho.Location = new System.Drawing.Point(0, 0);
            this.crvTonKho.Name = "crvTonKho";
            this.crvTonKho.Size = new System.Drawing.Size(800, 450);
            this.crvTonKho.TabIndex = 0;
            // 
            // Form_InTonKho
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.crvTonKho);
            this.Name = "Form_InTonKho";
            this.Text = "Form_InTonKho";
            this.ResumeLayout(false);

        }

        #endregion

        private CrystalDecisions.Windows.Forms.CrystalReportViewer crvTonKho;
    }
}
