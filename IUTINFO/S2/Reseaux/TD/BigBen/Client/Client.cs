using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Client
{
    class Client
    {
        private static string nomServeur = "localhost"; // "<nom_machine>"
        private static int port = 4321;

        private TcpClient socketClient;

        private StreamReader sr;
        private StreamWriter sw;
        public String message;

        public Client()
        {
            Console.WriteLine("Démarrage du Client BigBen - Version 2021");

            // Connexion au serveur
            socketClient = new TcpClient();   // équivaut à la primitive Socket (avec mode TCP)
            socketClient.Connect(nomServeur, port);

            // Mise en place des Streams pour lecture et écriture par ligne sur la socket
            sr = new StreamReader(socketClient.GetStream(), Encoding.Default);
            sw = new StreamWriter(socketClient.GetStream(), Encoding.Default)
            
            {
                AutoFlush = true
            };

            // Communication avec le serveur
            CommunicationAvecServeur();
            
            // Fin
            socketClient.Close();

            Console.WriteLine("Fin du client -> Tapez une touche pour terminer");
            Console.ReadLine();
        }

        private void CommunicationAvecServeur()
        {
           Console.WriteLine("Saissisez le message à envoyer");
           message = Console.ReadLine();
           sw.WriteLine(message);
            Console.WriteLine(sr.ReadLine());
          /* // Récupération des heures/minutes/secondes arrivant du serveur
            string HH, MM, SS;
            HH = sr.ReadLine();
            MM = sr.ReadLine();
            SS = sr.ReadLine();

            // Affichage sur la console du client
            Console.WriteLine("Il est " + HH + ":" + MM + ":" + SS + " sur le serveur.");*/
        }

        static void Main(string[] args)
        {
            new Client();
        }

    }
}
