namespace _05_2321003989_DangNguyenHoang_8802
{
    partial class Form_BaoCao
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
            this.lblLoaiBaoCao = new System.Windows.Forms.Label();
            this.cboLoaiBaoCao = new System.Windows.Forms.ComboBox();
            this.lblTuNgay = new System.Windows.Forms.Label();
            this.dtpTuNgay = new System.Windows.Forms.DateTimePicker();
            this.lblDenNgay = new System.Windows.Forms.Label();
            this.dtpDenNgay = new System.Windows.Forms.DateTimePicker();
            this.btnXemBaoCao = new System.Windows.Forms.Button();
            this.lblMoTa = new System.Windows.Forms.Label();
            this.dgvBaoCao = new System.Windows.Forms.DataGridView();
            this.panelTongHop = new System.Windows.Forms.Panel();
            this.lblTongTienValueTitle = new System.Windows.Forms.Label();
            this.lblTongTien = new System.Windows.Forms.Label();
            this.lblSoDongTitle = new System.Windows.Forms.Label();
            this.lblSoDong = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.btnIn = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvBaoCao)).BeginInit();
            this.panelTongHop.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // lblTieuDe
            // 
            this.lblTieuDe.AutoSize = true;
            this.lblTieuDe.Font = new System.Drawing.Font("Times New Roman", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTieuDe.Location = new System.Drawing.Point(746, 23);
            this.lblTieuDe.Name = "lblTieuDe";
            this.lblTieuDe.Size = new System.Drawing.Size(591, 55);
            this.lblTieuDe.TabIndex = 0;
            this.lblTieuDe.Text = "BÁO CÁO HẰNG THÁNG";
            // 
            // lblLoaiBaoCao
            // 
            this.lblLoaiBaoCao.AutoSize = true;
            this.lblLoaiBaoCao.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblLoaiBaoCao.Location = new System.Drawing.Point(548, 103);
            this.lblLoaiBaoCao.Name = "lblLoaiBaoCao";
            this.lblLoaiBaoCao.Size = new System.Drawing.Size(189, 36);
            this.lblLoaiBaoCao.TabIndex = 1;
            this.lblLoaiBaoCao.Text = "Loại báo cáo";
            // 
            // cboLoaiBaoCao
            // 
            this.cboLoaiBaoCao.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboLoaiBaoCao.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cboLoaiBaoCao.FormattingEnabled = true;
            this.cboLoaiBaoCao.Items.AddRange(new object[] {
            "Báo cáo kho",
            "Báo cáo doanh thu"});
            this.cboLoaiBaoCao.Location = new System.Drawing.Point(554, 152);
            this.cboLoaiBaoCao.Name = "cboLoaiBaoCao";
            this.cboLoaiBaoCao.Size = new System.Drawing.Size(291, 44);
            this.cboLoaiBaoCao.TabIndex = 2;
            this.cboLoaiBaoCao.SelectedIndexChanged += new System.EventHandler(this.cboLoaiBaoCao_SelectedIndexChanged);
            // 
            // lblTuNgay
            // 
            this.lblTuNgay.AutoSize = true;
            this.lblTuNgay.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTuNgay.Location = new System.Drawing.Point(902, 103);
            this.lblTuNgay.Name = "lblTuNgay";
            this.lblTuNgay.Size = new System.Drawing.Size(128, 36);
            this.lblTuNgay.TabIndex = 3;
            this.lblTuNgay.Text = "Từ ngày";
            // 
            // dtpTuNgay
            // 
            this.dtpTuNgay.CustomFormat = "dd/MM/yyyy";
            this.dtpTuNgay.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpTuNgay.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpTuNgay.Location = new System.Drawing.Point(908, 152);
            this.dtpTuNgay.Name = "dtpTuNgay";
            this.dtpTuNgay.Size = new System.Drawing.Size(244, 44);
            this.dtpTuNgay.TabIndex = 4;
            // 
            // lblDenNgay
            // 
            this.lblDenNgay.AutoSize = true;
            this.lblDenNgay.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDenNgay.Location = new System.Drawing.Point(1204, 103);
            this.lblDenNgay.Name = "lblDenNgay";
            this.lblDenNgay.Size = new System.Drawing.Size(143, 36);
            this.lblDenNgay.TabIndex = 5;
            this.lblDenNgay.Text = "Đến ngày";
            // 
            // dtpDenNgay
            // 
            this.dtpDenNgay.CustomFormat = "dd/MM/yyyy";
            this.dtpDenNgay.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpDenNgay.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpDenNgay.Location = new System.Drawing.Point(1210, 152);
            this.dtpDenNgay.Name = "dtpDenNgay";
            this.dtpDenNgay.Size = new System.Drawing.Size(244, 44);
            this.dtpDenNgay.TabIndex = 6;
            // 
            // btnXemBaoCao
            // 
            this.btnXemBaoCao.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.btnXemBaoCao.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnXemBaoCao.Location = new System.Drawing.Point(1504, 141);
            this.btnXemBaoCao.Name = "btnXemBaoCao";
            this.btnXemBaoCao.Size = new System.Drawing.Size(216, 68);
            this.btnXemBaoCao.TabIndex = 7;
            this.btnXemBaoCao.Text = "Xuất báo cáo";
            this.btnXemBaoCao.UseVisualStyleBackColor = false;
            this.btnXemBaoCao.Click += new System.EventHandler(this.btnXemBaoCao_Click);
            // 
            // lblMoTa
            // 
            this.lblMoTa.AutoSize = true;
            this.lblMoTa.Font = new System.Drawing.Font("Times New Roman", 10.875F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblMoTa.Location = new System.Drawing.Point(40, 216);
            this.lblMoTa.Name = "lblMoTa";
            this.lblMoTa.Size = new System.Drawing.Size(0, 34);
            this.lblMoTa.TabIndex = 8;
            // 
            // dgvBaoCao
            // 
            this.dgvBaoCao.BackgroundColor = System.Drawing.Color.White;
            this.dgvBaoCao.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvBaoCao.Location = new System.Drawing.Point(45, 263);
            this.dgvBaoCao.Name = "dgvBaoCao";
            this.dgvBaoCao.RowHeadersWidth = 82;
            this.dgvBaoCao.RowTemplate.Height = 33;
            this.dgvBaoCao.Size = new System.Drawing.Size(2220, 404);
            this.dgvBaoCao.TabIndex = 9;
            // 
            // panelTongHop
            // 
            this.panelTongHop.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.panelTongHop.Controls.Add(this.lblTongTienValueTitle);
            this.panelTongHop.Controls.Add(this.lblTongTien);
            this.panelTongHop.Controls.Add(this.lblSoDongTitle);
            this.panelTongHop.Controls.Add(this.lblSoDong);
            this.panelTongHop.Location = new System.Drawing.Point(554, 694);
            this.panelTongHop.Name = "panelTongHop";
            this.panelTongHop.Size = new System.Drawing.Size(1166, 113);
            this.panelTongHop.TabIndex = 10;
            // 
            // lblTongTienValueTitle
            // 
            this.lblTongTienValueTitle.AutoSize = true;
            this.lblTongTienValueTitle.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTongTienValueTitle.Location = new System.Drawing.Point(528, 37);
            this.lblTongTienValueTitle.Name = "lblTongTienValueTitle";
            this.lblTongTienValueTitle.Size = new System.Drawing.Size(146, 36);
            this.lblTongTienValueTitle.TabIndex = 3;
            this.lblTongTienValueTitle.Text = "Tổng tiền";
            // 
            // lblTongTien
            // 
            this.lblTongTien.AutoSize = true;
            this.lblTongTien.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTongTien.Location = new System.Drawing.Point(686, 37);
            this.lblTongTien.Name = "lblTongTien";
            this.lblTongTien.Size = new System.Drawing.Size(31, 36);
            this.lblTongTien.TabIndex = 2;
            this.lblTongTien.Text = "0";
            // 
            // lblSoDongTitle
            // 
            this.lblSoDongTitle.AutoSize = true;
            this.lblSoDongTitle.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSoDongTitle.Location = new System.Drawing.Point(40, 37);
            this.lblSoDongTitle.Name = "lblSoDongTitle";
            this.lblSoDongTitle.Size = new System.Drawing.Size(125, 36);
            this.lblSoDongTitle.TabIndex = 1;
            this.lblSoDongTitle.Text = "Số dòng";
            // 
            // lblSoDong
            // 
            this.lblSoDong.AutoSize = true;
            this.lblSoDong.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSoDong.Location = new System.Drawing.Point(171, 37);
            this.lblSoDong.Name = "lblSoDong";
            this.lblSoDong.Size = new System.Drawing.Size(31, 36);
            this.lblSoDong.TabIndex = 0;
            this.lblSoDong.Text = "0";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::_05_2321003989_DangNguyenHoang_8802.Properties.Resources._6f50559af270483df0e6e0ee6139be1c;
            this.pictureBox1.Location = new System.Drawing.Point(2, -3);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(190, 165);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 11;
            this.pictureBox1.TabStop = false;
            // 
            // btnIn
            // 
            this.btnIn.BackColor = System.Drawing.Color.IndianRed;
            this.btnIn.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnIn.Location = new System.Drawing.Point(1504, 47);
            this.btnIn.Name = "btnIn";
            this.btnIn.Size = new System.Drawing.Size(216, 68);
            this.btnIn.TabIndex = 12;
            this.btnIn.Text = "In báo cáo";
            this.btnIn.UseVisualStyleBackColor = false;
            this.btnIn.Click += new System.EventHandler(this.btnIn_Click);
            // 
            // Form_BaoCao
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(2277, 839);
            this.Controls.Add(this.btnIn);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.panelTongHop);
            this.Controls.Add(this.dgvBaoCao);
            this.Controls.Add(this.lblMoTa);
            this.Controls.Add(this.btnXemBaoCao);
            this.Controls.Add(this.dtpDenNgay);
            this.Controls.Add(this.lblDenNgay);
            this.Controls.Add(this.dtpTuNgay);
            this.Controls.Add(this.lblTuNgay);
            this.Controls.Add(this.cboLoaiBaoCao);
            this.Controls.Add(this.lblLoaiBaoCao);
            this.Controls.Add(this.lblTieuDe);
            this.Name = "Form_BaoCao";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form_BaoCao";
            this.Load += new System.EventHandler(this.Form_BaoCao_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvBaoCao)).EndInit();
            this.panelTongHop.ResumeLayout(false);
            this.panelTongHop.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTieuDe;
        private System.Windows.Forms.Label lblLoaiBaoCao;
        private System.Windows.Forms.ComboBox cboLoaiBaoCao;
        private System.Windows.Forms.Label lblTuNgay;
        private System.Windows.Forms.DateTimePicker dtpTuNgay;
        private System.Windows.Forms.Label lblDenNgay;
        private System.Windows.Forms.DateTimePicker dtpDenNgay;
        private System.Windows.Forms.Button btnXemBaoCao;
        private System.Windows.Forms.Label lblMoTa;
        private System.Windows.Forms.DataGridView dgvBaoCao;
        private System.Windows.Forms.Panel panelTongHop;
        private System.Windows.Forms.Label lblTongTienValueTitle;
        private System.Windows.Forms.Label lblTongTien;
        private System.Windows.Forms.Label lblSoDongTitle;
        private System.Windows.Forms.Label lblSoDong;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button btnIn;
    }
}
