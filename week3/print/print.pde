import processing.pdf.*;
ArrayList<PVector> first;
ArrayList<PVector> second;
ArrayList<PVector> third;
ArrayList<PVector> fourth;

ArrayList<PVector> five;

ArrayList < ArrayList<PVector> > list;

void setup() {

  size(1000, 600);
  beginRecord(PDF, "inEye__.pdf"); 
  colorMode(HSB);



  background(0);


  int randomGap; 
  float startPoint = 17*PI/16;
  float endingPoint = 31*PI/16;

  float length = endingPoint-startPoint;
  float d = 0.2;

  list = new ArrayList();
  first = new ArrayList();
  second = new ArrayList();
  third = new ArrayList();
  fourth = new ArrayList();

  five = new ArrayList();


  float inSP = 16*PI/16;
  float inEP = 32*PI/16;
  
  float inLength = inEP-inSP;
  float inD = 0.2;
  float inP = width/inLength;
  
  for(float i=0;i<=inLength; i+=inD){
  
    five.add(new PVector(inP*i+random(-5,5), sin(i+inSP)*180+300+random(10,15)));
  
  }
    for(float i=inLength;i>=0; i-=inD){
  
    five.add(new PVector(inP*i+random(-5,5), sin(PI+i+ inSP)*180+300+random(-15,-10)));
  
  }



  float p = width/length;
  for (float i = 0; i<= length+3*d; i+=d) {

    if (i==0) {

      first.add(new PVector(p*i, 0));
      second.add(new PVector(p*i, sin(i+ startPoint)*200+300));
      third.add(new PVector(p*i, sin(i+ startPoint+PI)*200+300));
      fourth.add(new PVector(p*i, height));
    }

    else if (i>0 && i<length+1) {


      float rx1 = random(-20, 20);

      first.add(new PVector(p*i+rx1, 0)); 
      first.add(new PVector(p*i+rx1+8, 0));

      float rx2 = random(-5, 5);
      float ry2 = random(-5, 5);
      second.add(new PVector(p*i+rx2, sin(i+ startPoint)*200+300+ry2));

      PVector temp = new PVector(second.get(second.size()-1).x, second.get(second.size()-1).y, second.get(second.size()-1).z);
      temp.sub(second.get(second.size()-2));
      temp.div(5);
      temp.add(new PVector(second.get(second.size()-1).x, second.get(second.size()-1).y, second.get(second.size()-1).z));
      second.add(temp);


      float rx3 = random(-5, 5);
      float ry3 = random(-5, 5);

      third.add(new PVector(p*i+rx3, sin(i+ startPoint+PI)*200+300+ry3));

      PVector temp0 = new PVector(third.get(third.size()-1).x, third.get(third.size()-1).y, third.get(third.size()-1).z);
      temp0.sub(third.get(third.size()-2));
      temp0.div(5);
      temp0.add(new PVector(third.get(third.size()-1).x, third.get(third.size()-1).y, third.get(third.size()-1).z));
      third.add(temp0);



      float rx4 = random(-20, 20);


      fourth.add(new PVector(p*i+rx4, height));
      fourth.add(new PVector(p*i+rx4+8, height));
    }
    else {
      println("here");
      first.add(new PVector(p*i, 0));
      second.add(new PVector(p*i, sin(i+ startPoint)*200+300));
      third.add(new PVector(p*i, sin(i+ startPoint+PI)*200+300));
      fourth.add(new PVector(p*i, height));

      println(p*i);
    }
  }


  noStroke();

  //noFill();
  for (int i=0; i<first.size()-1;i+=2) {


    fill(random(0, 20), 200, 200);
    beginShape();
    vertex(first.get(i).x, first.get(i).y);
    vertex(second.get(i).x, second.get(i).y);
    vertex(second.get(i+1).x, second.get(i+1).y);
    vertex(first.get(i+1).x, first.get(i+1).y);
    endShape(CLOSE);

    fill(random(90, 110), 150, 200);
    beginShape();
    vertex(third.get(i).x, third.get(i).y);
    vertex(fourth.get(i).x, fourth.get(i).y);
    vertex(fourth.get(i+1).x, fourth.get(i+1).y);
    vertex(third.get(i+1).x, third.get(i+1).y);

    endShape(CLOSE);
  }
  
  
   fill(255);
   beginShape();

  for (int i=0; i<five.size()-1;i+=2) {


 
    vertex(five.get(i).x,five.get(i).y);
   
  }
 endShape(CLOSE);


  //debug
  list.add(first);
  list.add(second);
  list.add(third);
  list.add(fourth);





 // triangle(width/2, height/2-40, width/2+20, height/2, width/2-20, height/2);



  //println( first.size());
 // println( second.size());
 // println( third.size());
 // println( fourth.size());
  endRecord();
}

