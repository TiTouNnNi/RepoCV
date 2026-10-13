int xShip; //<>//
int vitesse;
float yShip =100;
void setup(){
  size(300,200);
  noStroke();
  vitesse=1;
  xShip=30;
}
void draw(){
  background(0);
  ellipse(xShip,yShip,50,15);
  xShip+=vitesse;
} //<>//
void mousePressed(){
  vitesse=-vitesse;
}
void mouseDragged(){
   xShip=mouseX;
   yShip=mouseY;
   
}
