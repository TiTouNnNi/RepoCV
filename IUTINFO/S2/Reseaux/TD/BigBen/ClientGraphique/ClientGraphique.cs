using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClientGraphique
{
    public partial class ClientGraphique : Form
    {
        private static string nomServeur = "localhost"; // "<nom_machine>"
        private static int port = 4321;

        private TcpClient socketClient;

        private StreamReader sr;
        private StreamWriter sw;

        public ClientGraphique()
        {
            InitializeComponent();

            WriteAffichage("Démarrage du Client BigBen Graphique - Version 2021");

            // Connexion au serveur
            socketClient = new TcpClient();   // équivaut à la primitive Socket (avec mode TCP)
            socketClient.Connect(nomServeur, port);

            // Mise en place des Streams pour lecture et écriture par ligne sur la socket
            sr = new StreamReader(socketClient.GetStream(), Encoding.Default);
            sw = new StreamWriter(socketClient.GetStream(), Encoding.Default)
            {
                AutoFlush = true
            };
        }

        private void CommunicationAvecServeur()
        {
            // Récupération des heures/minutes/secondes arrivant du serveur
            string HH, MM, SS;
            HH = sr.ReadLine();
            MM = sr.ReadLine();
            SS = sr.ReadLine();

            // Affichage sur la console du client
            WriteAffichage("Il est " + HH + ":" + MM + ":" + SS + " sur le serveur.");
        }

        private void WriteAffichage(string texte)
        {
            listBoxAffichage.Items.Add(texte);
        }

        private void buttonBigBen_Click(object sender, EventArgs e)
        {
            // Communication avec le serveur
            CommunicationAvecServeur();

            // Fin
            socketClient.Close();
            WriteAffichage("Fin du client");
            buttonBigBen.Enabled = false;
        }
    }
}
