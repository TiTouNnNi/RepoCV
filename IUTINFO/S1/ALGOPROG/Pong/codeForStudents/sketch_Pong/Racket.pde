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
  int x;
  int y;
  int largeur;
  int hauteur;
  color couleur;
 
}

Racket initRacket(int x,color clr){
  Racket raquette =new Racket();
  raquette.x = x;
  raquette.y=height/2;
  raquette.largeur=RACKET_WIDTH;
  raquette.hauteur=RACKET_HEIGHT;
  raquette.couleur = clr ;
  return raquette;
}


void showRacket(Racket raquette)
{
  fill(raquette.couleur);
  rect(raquette.x, raquette.y, raquette.largeur,raquette.hauteur);
}

void moveRacketUp(Racket raquette){
  raquette.y-=RACKET_SPEED;
}

void moveRacketDown(Racket raquette){
  raquette.y+=RACKET_SPEED;
}
