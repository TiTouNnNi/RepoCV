// caracteristiques du dessin de chaque pastille (en pixels) //<>//
int DIAMETRE    = 12;
int DEPLACEMENT = 10;

// couleurs
color BLANC = color(255);
color ROUGE = color(255, 0, 0);

// position et direction de dessin
int posX, posY;
char direction;

// initialisation de la forme
// x,y : position
// dir : direction de départ (points cardinaux) : W, E, N, S
void initForm(int x, int y, char dir)
{
  // dessine une pastille rouge aux coordonnées choisies
  posX = x;
  posY = y;
  direction = dir;
  display(ROUGE);
} 

// Dessin d'une pastille
void display(color couleur)
{
  fill(couleur);
  ellipse(posX, posY, DIAMETRE, DIAMETRE);
}

// Déplacement puis Dessin d'une pastille
void goDisplay()
{
  move();
  display(BLANC);
}

/////////////////////////////////////////
// Fonctions de changement de direction
/////////////////////////////////////////

// tourner vers la gauche
void turnLeft()
{
  switch (direction) {
    case 'N' :
      direction = 'W';
      break;
    case 'E':
      direction = 'N';
      break;
    case 'S':
      direction = 'E';
      break;
    case 'W':
      direction = 'S';
      break;
    default:
      println("erreur");
  }
}

// tourner vers la droite
void turnRight()
{
  switch (direction) {
    case 'N' :
      direction = 'E';
      break;
    case 'E':
      direction = 'S';
      break;
    case 'S':
      direction = 'W';
      break;
    case 'W':
      direction = 'N';
      break;
    default:
      println("erreur");
  }
}

// se déplacer en fonction de la direction
void move() 
{
  switch(direction){
    case'N':
    posY-=DEPLACEMENT;
    break;
    case'E':
    posX+=DEPLACEMENT;
    break;
    case'S':
    posY+=DEPLACEMENT;
    break;
    case'W':
    posX-=DEPLACEMENT;
    break;
    default:
    println("erreur");
  }
}
