// Constantes - Couleurs

final color NOIR = color(0);
final color BLANC = color(255);
final color ROUGE = color(255, 0, 0);
final color VERT = color(0, 255, 0);
final color BLEU = color(0, 0, 255);

// Etat du jeu

/** Gestion de la pause */
boolean enPause = false;

/** La balle */
Ball ball;

/**
 * Fonction d'initialisation Processing.
 */
void setup()
{
  size(640, 400);

  // on initialise nos objets
  ball = initBall();
  
}

/**
 * Fonction de rafraichissement Processing.
 */
void draw()
{
  background(NOIR);
  showBall(ball); 
  moveBall(ball);
}
