// Constantes - Couleurs //<>//

final color NOIR = color(0);
final color BLANC = color(255);
final color ROUGE = color(255, 0, 0);
final color VERT = color(0, 255, 0);
final color BLEU = color(0, 0, 255);

// Etat du jeu

/** Gestion de la pause */
boolean enPause = false;
int scoreJ1 =0;
int scoreJ2=0;
/** La balle */
Ball ball;
Racket r;
Racket r2;
/**
 * Fonction d'initialisation Processing.
 */
void setup()
{
  size(640, 400);
  r = initRacket(width-BORDER_SPACE-RACKET_WIDTH,BLEU);
  r2 = initRacket(BORDER_SPACE,VERT);
  // on initialise nos objets
  ball = initBall();
  
}

void point(){
  if(ball.x+BALL_WIDTH>=width){
    scoreJ1+=1;
    ball.x=0;
  }
}
void keyPressed(){
  final int pause =keyCode;
  if (pause==' '){
    if(looping)
      noLoop();
    else
      loop();
  }
}      

void gestionClavierDepuisDraw(){
  if (keyPressed){
    switch(key){
      case 'z':
        moveRacketUp(r2);
        break;
      case 's':
        moveRacketDown(r2);
        break;
      case 'p':
        moveRacketUp(r);
        break;
      case 'm':
        moveRacketDown(r);
        break;
      default :
      break;
    }
  } 
 }
/**
 * Fonction de rafraichissement Processing.
 */
void draw()
{
  gestionClavierDepuisDraw();
  background(NOIR);
  showBall(ball); 
  showRacket(r);
  moveBall(ball);
  showRacket(r2);
}
