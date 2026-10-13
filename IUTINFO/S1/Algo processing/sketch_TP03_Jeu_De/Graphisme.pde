// NE RIEN MODIFIER DANS CET ONGLET

// constantes pour le graphisme
int Y_DES = 56;
int MARGE_GAUCHE = 46;
int TAILLE_DES = 85;
int INTER_DES = 5;

// affiche le fond et les dés
void afficherDes() {
  background(19, 89, 3);
  // afficher les faces
  PImage img = loadImage("pi5oBoByT.png");
  image(img, 0, 0, width, height);  
}

// calcule l'abscisse d'une face, étant donné son nombre de points
int nbPointsVersAbscisse(int nbPoints) {
  return MARGE_GAUCHE + nbPoints * (TAILLE_DES + INTER_DES);
}

// précise à quelle face appartient le point (x,y) en paramètre, et renvoie 0 s'il n'est dans aucune face.
int calculerFace(int x, int y) {
  int face = -1;
  // si on se trouve dans le rectangle englobant des faces
  if (y > Y_DES && y < Y_DES+TAILLE_DES && x > MARGE_GAUCHE && x < nbPointsVersAbscisse(5) + TAILLE_DES) {
    int faceCalculee = (x - MARGE_GAUCHE) / (TAILLE_DES + INTER_DES);
    // si on ne se trouve pas entre deux faces
    if (x - MARGE_GAUCHE - faceCalculee * (TAILLE_DES + INTER_DES) < TAILLE_DES) {
      face = faceCalculee;
    }
  }
  return face + 1;
}
