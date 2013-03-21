class Robot {

  PVector center;
  float w, h;

  Pencil pencil0;
  Pencil pencil1;
  Pencil pencil2;
  Pencil pencil3; 
  Pencil pencil4;
  Pencil pencil5;
  Pencil pencil6;
  Pencil pencil7;
  Pencil pencil8;

  ArrayList<Pencil> pencils;

  Robot(PVector center) {

    this.w = width/(17.f*4.f);
    this.h = height/(17.f*2.f);
    this.center = center;
    pencils = new ArrayList<Pencil>();

    // w/sqrt(w*w + h*h)



    pencil0 = new Pencil(center, new PVector(atan2(-h, -w), atan2(-h, -w)), sqrt(w*w + h*h), 142, new PVector(width/8.f, height*2/12.f));
    pencils.add(pencil0);
    pencil1 = new Pencil(center, new PVector(atan2(-h, w), atan2(-h, w)), sqrt(w*w + h*h), 145, new PVector(width*13/16.f, height*2/12.f));
    pencils.add(pencil1);
    pencil2 = new Pencil(center, new PVector(atan2(h, -w), atan2(h, -w)), sqrt(w*w + h*h), 148, new PVector(width/8.f, height*11/12.f));
    pencils.add(pencil2);
    pencil3 = new Pencil(center, new PVector(atan2(h, w), atan2(h, w)), sqrt(w*w + h*h), 150, new PVector(width*13/16.f, height*11/12.f));
    pencils.add(pencil3);


    pencil4 = new Pencil(center, new PVector(3*PI/2, 3*PI/2), h, 252, new PVector(width*15/32.f, height*2/12.f));
    pencils.add(pencil4);
    pencil5 = new Pencil(center, new PVector(PI/2, PI/2), h, 254, new PVector(width*15/32.f, height*11/12.f));
    pencils.add(pencil5);
    pencil6 = new Pencil(center, new PVector(PI, PI), w, 256, new PVector(width/8.f, height*13/24.f));
    pencils.add(pencil6);
    pencil7 = new Pencil(center, new PVector(0, 0), w, 260, new PVector(width*13/16.f, height*13/24.f));
    pencils.add(pencil7);
    //    ////
     pencil8 = new Pencil(center, new PVector(0,0), 0,140,new PVector(width*15/32.f, height*13/24.f));
     pencils.add(pencil8);
  }


  void getAngle(){
   
   pencils.get(5).getAngle(); 
    
  }

  void display() {

    for (int i=0; i<pencils.size(); i++) {

      pencils.get(i).display();
    }
  }

  void keyPressed() {

    for (int i=0; i<pencils.size(); i++) {

      pencils.get(i).keyPressed();
    }
  }

  void keyReleased() {
    for (int i=0; i<pencils.size(); i++) {

      pencils.get(i).keyReleased();
    }
  }
}



