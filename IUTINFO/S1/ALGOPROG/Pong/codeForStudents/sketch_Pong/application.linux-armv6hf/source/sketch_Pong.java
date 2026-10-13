import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_Pong extends PApplet {

// Constantes - Couleurs

final int NOIR = color(0);
final int BLANC = color(255);
final int ROUGE = color(255, 0, 0);
final int VERT = color(0, 255, 0);
final int BLEU = color(0, 0, 255);

// Etat du jeu

/** Gestion de la pause */
boolean enPause = false;

/** La balle */
Ball ball;

/**
 * Fonction d'initialisation Processing.
 */
public void setup()
{
  

  // on initialise nos objets
  ball = initBall();
  
}

/**
 * Fonction de rafraichissement Processing.
 */
public void draw()
{
  background(NOIR);
  showBall(ball); 
  moveBall(ball);
}
/** largeur (ou diamètre) de la balle */
final int BALL_WIDTH = 50;
/** vitesse de déplacement de la balle */
final int BALL_SPEED = 3;
/** couleur de la balle */
final int BALL_COLOR = BLANC; 

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
public Ball initBall() {
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
public void showBall(Ball b)
{
  fill(BALL_COLOR);
  ellipse(b.x, b.y, BALL_WIDTH, BALL_WIDTH);
}

/**
 * Déplacement de la balle
 */
public void moveBall(Ball b)
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
public boolean collisionHorizontale(Ball b)
{
  return (b.x+(BALL_WIDTH/2) > width) || (b.x-(BALL_WIDTH/2) < 0);  
}

/**
 * Retourne vrai si la balle ...
 */
public boolean collisionVerticale(Ball b)
{
  return (b.y+(BALL_WIDTH/2) > height) || (b.y-(BALL_WIDTH/2) < 0);
}
/** largeur d'une raquette */
final int RACKET_WIDTH  = 10;
/** hauteur d'une raquette */
final int RACKET_HEIGHT = 40;
/** vitesse de déplacement vertical d'une raquette */
final int RACKET_SPEED  = 7;
/** distance du bord de la fenêtre pour la raquette */
final int BORDER_SPACE  = 20;


/**
 * Une raquette.
 */
class Racket {
  
 
}
/**
 * Détection de collision entre 2 rectangles a et b
 *
 * @param ax rectangle 1 : abscisse du coin haut/gauche
 * @param ay rectangle 1 : ordonnée du coin haut/gauche
 * @param aw rectangle 1 : largeur
 * @param ah rectangle 1 : hauteur
 * @param bx rectangle 2 : abscisse du coin haut/gauche
 * @param by rectangle 2 : ordonnée du coin haut/gauche
 * @param bw rectangle 2 : largeur
 * @param bh rectangle 2 : hauteur
 * @return true si il y a collision entre les deux rectangles, false sinon
 */
public boolean collision( int ax, int ay, int aw, int ah,
                   int bx, int by, int bw, int bh)
{
  // il y a collision si les abscisses se chevauchent, ainsi que les ordonnées
  return chevauchementIntervalles(ax, ax+aw, bx, bx+bw)
      && chevauchementIntervalles(ay, ay+ah, by, by+bh);
}

/**
 * Détermine si deux intervalles se chevauchent (s'intersectent).
 *
 * @param a_min borne inférieure du premier intervalle
 * @param a_max borne supérieure du premier intervalle
 * @param b_min borne inférieure du deuxième intervalle
 * @param b_max borne supérieure du deuxième intervalle
 */
public boolean chevauchementIntervalles(int a_min, int a_max, int b_min, int b_max)
{
    int plus_grand_min = max(a_min, b_min);
    int plus_petit_max = min(a_max, b_max);
    return plus_grand_min <= plus_petit_max;
}
  public void settings() {  size(640, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_Pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
