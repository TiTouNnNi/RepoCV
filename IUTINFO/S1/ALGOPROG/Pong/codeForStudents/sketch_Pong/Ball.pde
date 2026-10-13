/** largeur (ou diamètre) de la balle */
final int BALL_WIDTH = 10;
/** vitesse de déplacement de la balle */
final int BALL_SPEED = 3;
/** couleur de la balle */
final color BALL_COLOR = BLANC; 

/**
 * Une balle.
 */
class Ball {

  /** abscisse du centre de la balle */
  int x;

  /** ordonnée du centre de la balle */
  int y;

  /** mouvement sur l'axe des abscisses */
  int mvt_x;

  /** mouvement sur l'axe des ordonnées */
  int mvt_y;
}

/**
 * Initialisation d'une balle : tous les attributs prennent des valeurs par défaut.
 */
Ball initBall() {
  Ball ball = new Ball();
  ball.x = width/2;
  ball.y = height/2;
  ball.mvt_x = BALL_SPEED;
  ball.mvt_y = BALL_SPEED;
  return ball;
}

/**
 * Affichage de la balle
 */
void showBall(Ball b)
{
  fill(BALL_COLOR);
  ellipse(b.x, b.y, BALL_WIDTH, BALL_WIDTH);
}

/**
 * Déplacement de la balle
 */
void moveBall(Ball b)
{
  // Mouvement Horizontal
  b.x += b.mvt_x;
  if (collisionHorizontale(b))
  {
    b.x -= b.mvt_x; // mouvement annulé
    b.mvt_x *= -1; // changement de direction
  }

  // Mouvement Vertical
  b.y += b.mvt_y;
  if (collisionVerticale(b))
  {
    b.y -= b.mvt_y; // mouvement annulé
    b.mvt_y *= -1; // changement de direction
  }
}

/**
 * Retourne vrai si la balle ....
 */
boolean collisionHorizontale(Ball b)
{
  return (b.x+(BALL_WIDTH/2) > width) || (b.x-(BALL_WIDTH/2) < 0 || collision(r.x, r.y, r.largeur,r.hauteur,b.x,b.y,BALL_WIDTH/2,BALL_WIDTH/2) || collision(r2.x, r2.y, r2.largeur,r2.hauteur,b.x,b.y,BALL_WIDTH/2,BALL_WIDTH/2 ));  
}

/**
 * Retourne vrai si la balle ...
 */
boolean collisionVerticale(Ball b)
{
  return (b.y+(BALL_WIDTH/2) > height) || (b.y-(BALL_WIDTH/2) < 0);
}
