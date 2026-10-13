color NOIR = color(0); //<>//

void setup()
{
  size(600, 600);
  background(NOIR);
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
    goDisplay();
  }
}
/*void escalier(int x, int y, int n,int nbMarches){
  initForm(x,y,'N');
  for(int i=0;i<nbMarches;i++){
    ligne(n);
    if(i%2==0){
      turnLeft();
    }
    else {
    turnRight();
    }
   }
  }    
*/

/* void escargot(int x, int y, int m){
  initForm(x,y,'N');
  for(int i=0;i<m;i++){
    ligne(i);
  if(m%2==0){
    turnLeft();
  }
  if(m%2==1){
  turnLeft();
  }
  }
} 
 */
 void randTurn(){
   int turn=(int)random(0,2);
   switch(turn){
     case 0:
     turnLeft();
     break;
     case 1:
     turnRight();
     break;
     default:
     println("Erreur");
   }
 }   
/*void zigzag1(int x, int y ,int n){
  initForm(x,y,'W');
  for(int i=0;i<n;i++){
    goDisplay();
    if(i%4==0){
    randTurn();    
    }
  }
} */

 boolean touchBorder(){
   if(posX>600 || posX<0 || posY<0 || posY>600){
     println("Perdu");
     return true;
   }
   else{
     println("Gagné");
     return false;
     
   }
 }  
/*void zigzag2(int x, int y, int n){
  initForm(x,y,'W');
  int i=0;
  while(i<n && !touchBorder())
   {
      if(i%10==0)
        randTurn();
        goDisplay();
        i++;
   }
}*/

void draw(){

  initForm(250,250,'W');
  int i=0;
  while(i<100 && !touchBorder())
   {
      if(i%10==0)
        randTurn();
        goDisplay();
        i++;
   }
   noLoop();
}  

  

  
