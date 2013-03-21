class Pencil{
 
  float x,y;
  
  float d;
  float speed;
  float angle;
  float len;  
  PVector dir;
  PVector ang;
  int hueValue;
  
  ArrayList<PVector> pos;
  ArrayList<PVector> spos;
  
  float sx,sy;
  float sl;
  float sd;
  
  Pencil(PVector p, PVector ang,float l,int hueValue,PVector sp){
    
    this.x = p.x;
    this.y = p.y;
    this.sx = sp.x;
    this.sy = sp.y;
    this.hueValue = hueValue;
    this.dir = ang;
    this.len = l+random(-l/3.f,l/3.f);
    this.sl= len/4.f;
    //if(l==0) this.d = l/16.f;
    this.d = 2.f;
    this.sd = d*5;
    this.speed = 0.0;
    this.angle = 0;
    
    pos = new ArrayList();
    spos = new ArrayList();
   
  }
 
 
 void display(){

   x += speed*cos(angle);
   y += speed*sin(angle);

   sx += speed*cos(angle);
   sy += speed*sin(angle);
 // fill(255);
  
 // ellipse(x,y,d,d);
  
  fill(hueValue,80,80);
  noStroke();
  
  for(int i = 0; i<pos.size();i++){
   
    ellipse(pos.get(i).x,pos.get(i).y,d,d);
    
  }
   for(int i = 0; i<spos.size();i++){
   
    ellipse(spos.get(i).x,spos.get(i).y,sd,sd);
    
  }
 }
 
 
 
 
 
 void getAngle(){
  
   float temp = (angle% TWO_PI)*57.2957795;
   
 }

  void keyPressed() {

    if (keyCode == LEFT) {
      angle+=0.05;
      speed = 0;
      spos.add(new PVector(sx+cos(angle+dir.x)*sl,sy+sin(angle+dir.y)*sl));

    } 
    else if (keyCode == RIGHT) {
      angle-=0.05;
      speed = 0;
        spos.add(new PVector(sx+cos(angle+dir.x)*sl,sy+sin(angle+dir.y)*sl));

    }
    else if (keyCode ==UP) {     
      speed = 0.5;
        spos.add(new PVector(sx+cos(angle+dir.x)*sl,sy+sin(angle+dir.y)*sl));

    } 
    else if (keyCode ==DOWN) {     
      speed = -0.5;
        spos.add(new PVector(sx+cos(angle+dir.x)*sl,sy+sin(angle+dir.y)*sl));

    }
  }

  void keyReleased() {
    speed = 0;
  }
   
}
