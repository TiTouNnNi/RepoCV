// constantes
const int TAILLE_SEQUENCE = 4;
const int PIN_SON = 8; // constante pour le pin du buzzer
const int PIN_LED[4] = {2, 3, 4, 5}; // pins des LED 0 à 3
const int FREQ_SON[4] = {261, 329, 392, 523}; // tableau des fréquences de son
const int DUREE = 250; // temps pour l'allumage des LED

// valeurs des boutons calculées en fonction
// du cablage (car toutes cablées sur A0)
const int BOUTON1=1023;
const int BOUTON2=1001;
const int BOUTON3=980;
const int BOUTON4=960;

// les différents modes
const int DEBUT = 0;
const int AUGM_SEQ_SIMON = 1;
const int JOUE_SEQ_SIMON = 2;
const int SAISIE_JOUEUR = 3;
const int VICTOIRE = 4;
const int ECHEC = 5;

// variables
int reponse;
int mode = DEBUT; // mode dans le programme
int tailleSeqSimon = 0; // taille de la séquence à deviner
int tailleSeqJoueur = 0; // taille de la réponse du joueur
int sequenceSimon[TAILLE_SEQUENCE]; // tableau de la séquence à deviner
int sequenceJoueur[TAILLE_SEQUENCE]; // tableau de la séquence de réponse du joueur

void setup() {
  Serial.begin(9600);
  // rédaction de vos tests unitaires
  Serial.println("tests : debut");
  // ...
  Serial.println("tests : fin");
  randomSeed(analogRead(1)); // initialisation des nombres aleatoires
  /*
     passages des pins en mode OUTPUT
  */
  for (int i = 2; i < 6; i++) {
    pinMode(i, OUTPUT);
  }
  pinMode(PIN_SON, OUTPUT);
}

void loop() {
  // les actions sont réalisées en fonction du mode en cours
  switch (mode) { 
    case DEBUT: // mode de démarrage (séquence lumineuse pré-enregistrée)
      start(); 
      tailleSeqSimon = 0; // on met la séquence à 0
      mode = AUGM_SEQ_SIMON; // on peut passer au mode suivant
      break;
    case AUGM_SEQ_SIMON: // mode de tirage d'une nouvelle séquence
      augmenteSequenceSimon(); //appel de la fonction pour allonger la séquence aléatoirement
      if (tailleSeqSimon < TAILLE_SEQUENCE)
      	mode = JOUE_SEQ_SIMON; // on peut passer au mode suivant
      else
        mode = VICTOIRE; // on a gagné car on est arrivé à reproduire TAILLE_SEQUENCE sans se tromper
      break;
    case JOUE_SEQ_SIMON: // mode d'écoute de la séquence
      joueSequenceSimon(); // on joue la séquence en cours
      tailleSeqJoueur = 0; // on initialise la position de réponse à chaque tour (il faut refaire toutes les notes)
      mode = SAISIE_JOUEUR; // on peut passer au mode suivant
      break;
    case SAISIE_JOUEUR: // mode de réponse du joueur
      reponse = testBouton(); // on appelle la fonction de lecture des boutons
      ajouteReponse(reponse);
      if (!perdu()){ // si le son qui vient d'être tapé est le bon
        if (tailleSeqJoueur == tailleSeqSimon) { // si c'était le dernier
          mode = AUGM_SEQ_SIMON; // on revient en sequence 1 car toute la séance est ok et donc ajout d'un son en plus  
        }
      } else {
        mode = ECHEC;
      }
      break;
    case VICTOIRE: // jeu gagné on fait une petite séquence de victoire
    	valide();
    	mode = DEBUT;
    	break;
    case ECHEC: // jeu perdu on fait une petite séquence de défaite
	    lost();
	    mode = DEBUT;
    	break;
  }
}


// ajoute une réponse dans le tableau sequenceJoueur
void ajouteReponse(int reponse){
  sequenceJoueur[tailleSeqJoueur]=reponse;
  tailleSeqJoueur++;
}

// son et lumière pour le démarrage d'une nouvelle séquence
void start() {
  for(int i=0;i<4;i++){
    sonLum(i,300);
  }
}

// son et lumière pour valider une suite de réponses
void valide() {
  for(int i=0;i<12;i++){
    int rd = random(0,4);
    digitalWrite(PIN_LED[rd],HIGH);
    tone(PIN_SON,FREQ_SON[rd],DUREE);
    delay(300);
    digitalWrite(PIN_LED[rd],LOW);
  }
}

// son et lumière pour signaler la défaite 
void lost() {
  digitalWrite(PIN_LED[0],HIGH);
  digitalWrite(PIN_LED[1],HIGH);
  digitalWrite(PIN_LED[2],HIGH);
  digitalWrite(PIN_LED[3],HIGH);
  tone(PIN_SON,FREQ_SON[2],DUREE);
  delay(300);
  digitalWrite(PIN_LED[0],LOW);
  digitalWrite(PIN_LED[1],LOW);
  digitalWrite(PIN_LED[2],LOW);
  digitalWrite(PIN_LED[3],LOW);
}

// fonction qui compare la réponse avec la séquence en cours et retourne vrai si perdu
bool perdu () {
  int pos=0;
  bool lost=true;
  while(pos<tailleSeqJoueur && !lost)
  {
  lost =( sequenceSimon[pos]!= sequenceJoueur[pos]);
  pos++;
   }
return lost;
}

// fonction qui allume une LED (l) en jouant le son associé pendant une durée (d)
void sonLum(int l, int d) {
  digitalWrite(PIN_LED[l],HIGH);
  tone(PIN_SON,FREQ_SON[l],DUREE);
  delay(d);
  digitalWrite(PIN_LED[l],LOW);
  delay(d);
}

// fonction de tirage aléatoire d'un nouvel élément
void augmenteSequenceSimon() {
  if(tailleSeqSimon<TAILLE_SEQUENCE){
    sequenceSimon[tailleSeqSimon]=random(0,3);
  }
  tailleSeqSimon++;
}

// fonction qui joue la séquence en cours
void joueSequenceSimon() {
  for(int i =0;i<tailleSeqSimon;i++){
    sonLum(sequenceSimon[i],500);
  }
}

// fonction qui attend l'appuie sur un des boutons, l'allume+son et retourne le numéro de bouton
int testBouton() {
  bool end=false;
  int bouton;
  while(!end){
  	
    bouton = analogRead(A0); // on lit la valeur de A0.
  
    switch (bouton) {
      case BOUTON1:
      end = true;
      bouton =0;
      break;
      case BOUTON2:
      end=true;
      bouton=1;
      break;
      case BOUTON3:
      end =true;
      bouton=2;
      break;
      case BOUTON4:
      end=true;
      bouton=3;
      break;
      default:
      break;
    	
    }
   
  }
  sonLum(bouton,DUREE);
  return bouton;
}


