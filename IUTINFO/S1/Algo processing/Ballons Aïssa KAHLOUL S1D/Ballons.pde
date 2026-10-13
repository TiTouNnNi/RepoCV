int oriX; //<>//
int oriY;

void setup(){
  size(300,200);
  background(180,234,234);
  oriX=width/2;
  oriY=height;
}

void draw(){
  }

void mousePressed(){
  line(oriX,oriY,mouseX,mouseY);
  fill(random(255),random(255),random(255));
  ellipse(mouseX,mouseY,30,30);
}
  
  
  
