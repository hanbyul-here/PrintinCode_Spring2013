//minim is just for fun :} 
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioSnippet breaking;

import toxi.geom.*;
import toxi.processing.*;
import org.processing.wiki.triangulate.*;
import processing.pdf.*;




ToxiclibsSupport gfx;
// PImage me;   : I tried coloring but not very successful


//to make star-like shape
ArrayList<PVector> outerPoints = new ArrayList<PVector>();
ArrayList<PVector> innerPoints = new ArrayList<PVector>();

//make points to shape (to filter random position)
ArrayList polygonPoints = new ArrayList();


//convert all triangles to polygons
ArrayList triangle = new ArrayList();
ArrayList<Polygon2D>   breakParts = new ArrayList<Polygon2D>();


Vec2D p;

//basic elements for shape
PVector center; 
float rad;

//movement? or not
boolean br = false;

//recording
boolean rec = false;

//for text
PFont font;





void setup() {
  size(500, 500, P2D);

  minim = new Minim(this);
  breaking = minim.loadSnippet("breaking.wav");

  gfx = new ToxiclibsSupport(this);
  font = createFont("Courier", 40);

  center = new PVector(width/2, height/2);
  rad = 300.f;

  //me = loadImage("me.jpg");  ->colring try

  translate(center.x, center.y);
  rotate(-PI/2);

  //for double pentagon

  for (int i=0; i<5; i++) {
    outerPoints.add(new PVector(cos(i*2*PI/5.f)*rad/2, sin(i*2*PI/5.f) *rad/2, random(50, 100)));
    innerPoints.add(new PVector(cos((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2, sin((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2));
  }


  for (int i = 0; i<outerPoints.size();i++) {
    PVector p = outerPoints.get(i);
    PVector sp = innerPoints.get(i); 
    fill(0);

    //first step : make sure this is pentagon
    ellipse(p.x, p.y, 5, 5);
    ellipse(sp.x, sp.y, 5, 5);

    Vec2D stemp = new Vec2D(sp.x, sp.y);

    polygonPoints.add(stemp);
  }

  //make polygon to filter random vector
  Polygon2D polygon = new Polygon2D(polygonPoints);

  //add some points to break _ make triangles


    for (;;) {

    p = new Vec2D(random(-width/2, width/2), random(-height/2, height/2));

    if (polygon.containsPoint(p)) {
      break;
    }
  }

  fill(255, 0, 0);
  ellipse(p.x, p.y, 5, 5);


  //add 5 more points based on first point.
  for (int i=0; i<1; i++) {
    outerPoints.add(new PVector(p.x+random(-30, 30), p.y+random(-30, 30)));
  }

  ///this is rectangle part  : tried with rectangle 
  /*
   outerPoints.add(new PVector(-rad/2,-rad/2));
   outerPoints.add(new PVector(-rad/2,rad/2));
   outerPoints.add(new PVector(rad/2,rad/2));
   outerPoints.add(new PVector(rad/2,-rad/2));
   */


  triangle = Triangulate.triangulate(outerPoints);


  for (int i = 0; i <triangle.size(); i++) {


    // make delanay triangles automatically

    Triangle t = (Triangle)triangle.get(i);

    ArrayList tempV = new ArrayList();
    Vec2D vp1 = new Vec2D(t.p1.x, t.p1.y);
    Vec2D vp2 = new Vec2D(t.p2.x, t.p2.y);
    Vec2D vp3 = new Vec2D(t.p3.x, t.p3.y);


    tempV.add(vp1);
    tempV.add(vp2);
    tempV.add(vp3);


    //save all the triangles as polygon

    breakParts.add(new Polygon2D(tempV));
  }
}


void draw() {

  //due to toxi, it needs this process for recording
  if ( rec ) 
  {
    PGraphics pdf=beginRecord(PDF, millis()+"fourshot.pdf");
    gfx.setGraphics(pdf);
  }


  background(255);

  fill(0);
  textFont(font, 20);
  textAlign(CENTER);


  translate(center.x, center.y);
  //not to rotate text
  text("HAN BYUL CREW", 0, height*0.9/3);

  rotate(-PI/2);

  for (Polygon2D pp : breakParts) {

    stroke(255);
    strokeWeight(3);
    fill(0);


    Vec2D centerV = pp.getCentroid();
    if (br) {

      // to give some breaking effect, 
      //compares each triangle's center with first hitting point (p) 
      //so if it is far from hitting point, it doesn't move that much

      Vec2D ccv = new Vec2D(p.x, p.y);
      Vec2D targetDir = centerV.sub(ccv).normalize();
      targetDir.scaleSelf(1500.f/(dist(centerV.x, centerV.y, ccv.x, ccv.y)));

      //move all the points in polygon 
      for (Vec2D v: pp.vertices) {
        v.set(v.addSelf(targetDir));
      }
    }
    //tried breaking effect with stroke width, but failed
    //strokeWeight((1000/dist(centerV.x,centerV.y,ccv.x,ccv.y)/10.f)+1);

    gfx.polygon2D(pp);
  }


  if ( rec )
  {
    endRecord();
    rec=false;
  }

  //if I don't want it to move
  // noLoop();
}

void mouseReleased() {

  br = true; 

  //breaking sound for fun
  if (!breaking.isPlaying()) {
    breaking.rewind(); 
    breaking.play();
  }
}

void keyPressed() {

  if (key=='a') {
    
    println("a");
    rec = true;
  }
}

void keyReleased() {
  //rec = false;
}


