import processing.pdf.*;

Robot r;
boolean record;

void setup() {


  size(17*50, 22*50);

  colorMode(HSB,360,100,100);

  r = new Robot(new PVector(width*2/6, height*4/6));
  ellipseMode(CENTER);
  noStroke(); 

  record = false;
}


void draw() {

if(record) { beginRecord(PDF, millis()+"font.pdf"); colorMode(HSB,360,100,100);;}
   background(255,0,100);
   r.display();
if(record) {endRecord(); record = false;
   }
}

void keyPressed() {
  r.getAngle();
  r.keyPressed();
}

void keyReleased() {

  r.keyReleased();
}

void mouseReleased() {

  record = true;
  save("diagonal"+millis()+".tif");
}

