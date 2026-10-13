using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;


namespace Serveur
{
    class Serveur
    {
        private static int portEcoute = 4321;

        private TcpListener socketServeur;
        private TcpClient socketCommunication;

        private StreamReader sr;
        private StreamWriter sw;

        public Serveur()
        {
            Console.WriteLine("Début Serveur BigBen - Version 2021");

            // Initialisation de la socket d'écoute du serveur
            IPAddress adresse = IPAddress.Parse("127.0.0.1");
            socketServeur = new TcpListener(adresse, portEcoute);  // équivaut aux primitives Socket (avec mode TCP) + Bind
            socketServeur.Start();                                 // + Listen
            Console.WriteLine("Le serveur est à l'écoute sur le port " + portEcoute.ToString());

            // Boucle infinie de gestion de clients
            while (true)
            {
                // Acceptation de la demande de connexion d'un client
                socketCommunication = socketServeur.AcceptTcpClient();

                // Mise en place des Streams pour lecture et écriture par ligne sur la socket
                sr = new StreamReader(socketCommunication.GetStream(), Encoding.Default);
                sw = new StreamWriter(socketCommunication.GetStream(), Encoding.Default)
                {
                    AutoFlush = true
                };

                // Communication avec le client
                CommunicationAvecClient();

                // Fin de la Communication avec le client
                socketCommunication.Close();
                
            }
        }

        private void CommunicationAvecClient()
        {
            String messageRecuClient = "";
            Console.WriteLine("Message recu : ");
            messageRecuClient = sr.ReadLine();
            Console.WriteLine(messageRecuClient);
            sw.WriteLine(messageRecuClient);
           /* // Envoi des heures/minutes/secondes vers le client
            string HH, MM, SS;
            HH = DateTime.Now.Hour.ToString("D2");
            MM = DateTime.Now.Minute.ToString("D2");
            SS = DateTime.Now.Second.ToString("D2");

            sw.WriteLine(HH);
            sw.WriteLine(MM);
            sw.WriteLine(SS);

            // Affichage sur la console du serveur d'une notification d'envoi
            Console.WriteLine("Envoi de " + HH + ':' + MM + ':' + SS);*/
        }

        static void Main(string[] args)
        {
            new Serveur();
        }

    }
}
