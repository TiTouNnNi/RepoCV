namespace ClientGraphique
{
    partial class ClientGraphique
    {
        /// <summary>
        /// Variable nécessaire au concepteur.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Nettoyage des ressources utilisées.
        /// </summary>
        /// <param name="disposing">true si les ressources managées doivent être supprimées ; sinon, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Code généré par le Concepteur Windows Form

        /// <summary>
        /// Méthode requise pour la prise en charge du concepteur - ne modifiez pas
        /// le contenu de cette méthode avec l'éditeur de code.
        /// </summary>
        private void InitializeComponent()
        {
            this.listBoxAffichage = new System.Windows.Forms.ListBox();
            this.labelAffichage = new System.Windows.Forms.Label();
            this.buttonBigBen = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // listBoxAffichage
            // 
            this.listBoxAffichage.FormattingEnabled = true;
            this.listBoxAffichage.Location = new System.Drawing.Point(31, 58);
            this.listBoxAffichage.Name = "listBoxAffichage";
            this.listBoxAffichage.Size = new System.Drawing.Size(329, 121);
            this.listBoxAffichage.TabIndex = 0;
            // 
            // labelAffichage
            // 
            this.labelAffichage.AutoSize = true;
            this.labelAffichage.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelAffichage.Location = new System.Drawing.Point(31, 24);
            this.labelAffichage.Name = "labelAffichage";
            this.labelAffichage.Size = new System.Drawing.Size(155, 13);
            this.labelAffichage.TabIndex = 1;
            this.labelAffichage.Text = "Affichage pour l\'utilisateur";
            // 
            // buttonBigBen
            // 
            this.buttonBigBen.Location = new System.Drawing.Point(375, 212);
            this.buttonBigBen.Name = "buttonBigBen";
            this.buttonBigBen.Size = new System.Drawing.Size(75, 23);
            this.buttonBigBen.TabIndex = 2;
            this.buttonBigBen.Text = "BigBen";
            this.buttonBigBen.UseVisualStyleBackColor = true;
            this.buttonBigBen.Click += new System.EventHandler(this.buttonBigBen_Click);
            // 
            // ClientGraphique
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(539, 282);
            this.Controls.Add(this.buttonBigBen);
            this.Controls.Add(this.labelAffichage);
            this.Controls.Add(this.listBoxAffichage);
            this.Name = "ClientGraphique";
            this.Text = "ClientGraphique";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox listBoxAffichage;
        private System.Windows.Forms.Label labelAffichage;
        private System.Windows.Forms.Button buttonBigBen;
    }
}

