namespace _05_2321003989_DangNguyenHoang_8802
{
    partial class Form_DonHang
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
        /// Required method for Designer support.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblTieuDe = new System.Windows.Forms.Label();
            this.dgvDonHang = new System.Windows.Forms.DataGridView();
            this.panelTongHop = new System.Windows.Forms.Panel();
            this.lblSoDonValue = new System.Windows.Forms.Label();
            this.lblSoDon = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDonHang)).BeginInit();
            this.panelTongHop.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblTieuDe
            // 
            this.lblTieuDe.AutoSize = true;
            this.lblTieuDe.Font = new System.Drawing.Font("Times New Roman", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTieuDe.Location = new System.Drawing.Point(31, 24);
            this.lblTieuDe.Name = "lblTieuDe";
            this.lblTieuDe.Size = new System.Drawing.Size(287, 55);
            this.lblTieuDe.TabIndex = 0;
            this.lblTieuDe.Text = "Đơn hàng của tôi";
            // 
            // dgvDonHang
            // 
            this.dgvDonHang.BackgroundColor = System.Drawing.Color.White;
            this.dgvDonHang.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDonHang.Location = new System.Drawing.Point(36, 102);
            this.dgvDonHang.Name = "dgvDonHang";
            this.dgvDonHang.RowHeadersWidth = 82;
            this.dgvDonHang.RowTemplate.Height = 33;
            this.dgvDonHang.Size = new System.Drawing.Size(1024, 485);
            this.dgvDonHang.TabIndex = 1;
            // 
            // panelTongHop
            // 
            this.panelTongHop.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.panelTongHop.Controls.Add(this.lblSoDonValue);
            this.panelTongHop.Controls.Add(this.lblSoDon);
            this.panelTongHop.Location = new System.Drawing.Point(36, 609);
            this.panelTongHop.Name = "panelTongHop";
            this.panelTongHop.Size = new System.Drawing.Size(1024, 73);
            this.panelTongHop.TabIndex = 2;
            // 
            // lblSoDonValue
            // 
            this.lblSoDonValue.AutoSize = true;
            this.lblSoDonValue.Font = new System.Drawing.Font("Times New Roman", 12F);
            this.lblSoDonValue.Location = new System.Drawing.Point(172, 19);
            this.lblSoDonValue.Name = "lblSoDonValue";
            this.lblSoDonValue.Size = new System.Drawing.Size(31, 36);
            this.lblSoDonValue.TabIndex = 1;
            this.lblSoDonValue.Text = "0";
            // 
            // lblSoDon
            // 
            this.lblSoDon.AutoSize = true;
            this.lblSoDon.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold);
            this.lblSoDon.Location = new System.Drawing.Point(29, 19);
            this.lblSoDon.Name = "lblSoDon";
            this.lblSoDon.Size = new System.Drawing.Size(118, 36);
            this.lblSoDon.TabIndex = 0;
            this.lblSoDon.Text = "Số đơn:";
            // 
            // Form_DonHang
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1099, 705);
            this.Controls.Add(this.panelTongHop);
            this.Controls.Add(this.dgvDonHang);
            this.Controls.Add(this.lblTieuDe);
            this.Name = "Form_DonHang";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form_DonHang";
            this.Load += new System.EventHandler(this.Form_DonHang_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDonHang)).EndInit();
            this.panelTongHop.ResumeLayout(false);
            this.panelTongHop.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTieuDe;
        private System.Windows.Forms.DataGridView dgvDonHang;
        private System.Windows.Forms.Panel panelTongHop;
        private System.Windows.Forms.Label lblSoDonValue;
        private System.Windows.Forms.Label lblSoDon;
    }
}
