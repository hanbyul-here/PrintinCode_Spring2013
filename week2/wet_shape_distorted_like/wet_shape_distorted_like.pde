import processing.pdf.*;

int smallR = 170*2;
int mediumR = 200*2;
int largeR = 280*2; 


float randomS = 0.0f;

float angle = PI/12;
int pointsNum = (int)(TWO_PI/angle);

PVector center;



PVector[] smallPoints;
PVector[] mediumPoints;
PVector[] largePoints;

void setup() {

  size(700, 900); 
  center = new PVector(width/2-135, height/2+200);

  smallPoints = new PVector[pointsNum];
  mediumPoints = new PVector[pointsNum];
  largePoints = new PVector[pointsNum];

  for (int i=0; i< pointsNum; i++) {

    smallPoints[i] = new PVector(center.x + random(4*smallR/5, smallR) * cos(i*angle), center.y+random(4*smallR/5, smallR) * sin(i*angle));
    mediumPoints[i] = new PVector(center.x + mediumR * cos (i*angle), center.y + mediumR * sin(i*angle));
    largePoints[i] = new PVector(center.x +random(6*largeR/7, largeR) * cos (i*angle), center.y + random(6*largeR/7, largeR) * sin(i*angle));

   // smallPoints[i] = new PVector(center.x + random(130, smallR) * cos(i*angle), center.y+random(120, smallR) * sin(i*angle));
  //  mediumPoints[i] = new PVector(center.x + mediumR * cos (i*angle), center.y + mediumR * sin(i*angle));
  //  largePoints[i] = new PVector(center.x +(noise(randomS)+0.7)* largeR * cos (i*angle), center.y + (noise(randomS)+0.7)*largeR * sin(i*angle));
  //  randomS+=0.1;
  }
  background(255);
  smooth();
  noLoop(); 
}

void draw() {

beginRecord(PDF, "filename.pdf"); 

  fill(0);

  beginShape();
  for (int i=0; i< pointsNum; i++) {  

    int j = i+1; 
    if (j >= pointsNum) j%=pointsNum;

    if (i%2 ==0) {
      //bezier(smallPoints[i].x, smallPoints[i].y, mediumPoints[i].x, mediumPoints[i].y, mediumPoints[i+1].x, mediumPoints[i+1].y, smallPoints[i+1].x, smallPoints[i+1].y );

      vertex(mediumPoints[i].x, mediumPoints[i].y);
      bezierVertex(smallPoints[i].x, smallPoints[i].y, smallPoints[j].x, smallPoints[j].y, mediumPoints[j].x, mediumPoints[j].y );
    }
    else {

      vertex(mediumPoints[i].x, mediumPoints[i].y);
      bezierVertex(largePoints[i].x, largePoints[i].y, largePoints[j].x, largePoints[j].y, mediumPoints[j].x, mediumPoints[j].y);

      // bezier(mediumPoints[i].x, mediumPoints[i].y, largePoints[i].x, largePoints[i].y, largePoints[i+1].x, largePoints[i+1].y, mediumPoints[i+1].x, mediumPoints[i+1].y);
    }
  }
  endShape();

  for (int i=0; i< pointsNum; i++) {
        int j = i+1; 
    if (j >= pointsNum) j%=pointsNum;
    
    PVector temp = new PVector(center.x+cos(angle*i+(angle/2))*mediumR,center.y+sin(angle*i+(angle/2))*mediumR);    

    strokeWeight(1);
    if(i%2 ==0) stroke(255,0,0);
    else    stroke(255);
    
 //   point(temp.x,temp.y);

//   point(smallPoints[i].x,smallPoints[i].y);
 //  float tempAA = atan2(largePoints[i].y-temp.y,largePoints[i].x-temp.x);
 //  float tempAB = atan2(largePoints[j].y-temp.y,largePoints[j].x-temp.x);
 
   float tempAA = atan2(temp.y-smallPoints[i].y,temp.x-smallPoints[i].x);
   float tempAB= atan2(temp.y-smallPoints[j].y,temp.x-smallPoints[j].x);
   
   
   if(i ==6){
     noStroke();
   PVector triS0 = new PVector(temp.x+cos(tempAA)*(smallR+mediumR+largeR),temp.y+sin(tempAA)*(smallR+mediumR+largeR));
   PVector triS1 = new PVector(temp.x+cos(tempAB)*(mediumR+largeR+largeR),temp.y+sin(tempAB)*(mediumR+largeR+largeR));
   //line(temp.x,temp.y,triS0.x,triS0.y);
   //line(temp.x,temp.y,triS1.x,triS1.y);
   //line(temp.x+cos(tempAA)*smallR,temp.y+sin(tempAA)*smallR,temp.x+cos(tempAB)*mediumR,temp.y+sin(tempAB)*mediumR);  
//  triangle(temp.x,temp.y,triS0.x,triS0.y,triS1.x,triS1.y); 
   }
   
//      
   if(i==20){
     noStroke();
     
   PVector triB0 = new PVector(temp.x+cos(tempAA)*(smallR*4/5),temp.y+sin(tempAA)*(smallR*4/5));
   PVector triB1 = new PVector(temp.x+cos(tempAB)*(smallR*4/5),temp.y+sin(tempAB)*(smallR)*4/5);
   
   //line(temp.x,temp.y,temp.x+cos(tempAA)*smallR,temp.y+sin(tempAA)*smallR);
   //line(temp.x,temp.y,temp.x+cos(tempAB)*mediumR,temp.y+sin(tempAB)*mediumR);
   //line(temp.x+cos(tempAA)*smallR,temp.y+sin(tempAA)*smallR,temp.x+cos(tempAB)*mediumR,temp.y+sin(tempAB)*mediumR);   
   
     triangle(temp.x,temp.y,triB0.x,triB0.y,triB1.x,triB1.y); 
   }
    
  }
  save("diagonal.tif");
    endRecord();
}

