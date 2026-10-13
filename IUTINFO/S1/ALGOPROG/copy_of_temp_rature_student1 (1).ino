int tempSensor = A0; // Indiquer le numéro de broche sur laquelle est branché le capteur de température (chiffre entre 0 et 5)

void setup() {
  Serial.begin(9600);

  // Indiquer que les broches des diodes sont en mode OUTPUT
  pinMode(5,OUTPUT);
  pinMode(3,OUTPUT);
  Serial.println("process start");
}

// conversion de la mesure reçue par le capteur vers une température
// cette fonction prend en paramètre un entier (une tension) 
// et retourne une température de type réel
float capteurToTemperature(int valeur)
{
  return (((valeur * 5.0 / 1024) - 0.5) * 100.0);
}

void loop() {
  delay(100); // juste pour avoir le temps de cliquer sur le thermomètre
  //en fonction de l'ordinateur sur lequel vous exécutez ce code 
  //il est possible que vous ayez à aller jusqu'à la valeur 1000.

  //Comme montré sur la vidéo, lors de l'exécution, 
  //cliquez sur le thermomètre pour faire varier la température.

  // À chaque passage dans loop il faut récupérer la température  
  int readTemp = analogRead(tempSensor);
  // il faut convertir cette tension en température
  
  // Allumer la diode en fonction de cette valeur 
    if (capteurToTemperature(readTemp)>25)
    {
       digitalWrite(5,HIGH);
       digitalWrite(3,LOW);
    }
    else {
       digitalWrite(3,HIGH);
       digitalWrite(5,LOW);
    }
    
  }