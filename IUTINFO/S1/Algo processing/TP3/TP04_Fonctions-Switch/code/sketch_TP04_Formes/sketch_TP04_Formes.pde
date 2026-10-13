color NOIR = color(0); //<>//

void setup()
{
  size(600, 600);
  background(NOIR);
  initForm(0,0,'N');
  //premierchemin();
 // deuxiemechemin();
}
  // Premier chemin
/*void premierchemin(){
  initForm(width / 3, height / 2, 'W');
  goDisplay();
  goDisplay();
  goDisplay();

  turnRight();
  goDisplay();
  goDisplay();

  turnLeft();
  for (int i = 0; i < 5; i++) {
    goDisplay();
  }
}
  // Deuxième chemin
void  deuxiemechemin(){
  initForm(2 * width / 3, height / 2, 'S');
  for (int i = 0; i < 10; i++) {
    goDisplay();
  }

  turnLeft();
  goDisplay();
  turnLeft();
  goDisplay();
  
}*/
 
    
    

void ligne(int n){
  for(int i=0; i<n;i++){
    display(BLANC);
  }
}
void escalier(int x, int y, int n,int nbMarches){
  x=posX;
  y=posY;
  for(int i=0;i<nbMarches;i++){
    fill(255);
    ellipse(posX,posY,DIAMETRE,DIAMETRE);
    posY-=10;
    if(posY%40==0){
      posX-=10;
    }
  }
    
    
    
    
