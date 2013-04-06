import toxi.geom.*;
import toxi.processing.*;
import org.processing.wiki.triangulate.*;

ToxiclibsSupport gfx;

ArrayList<Polygon2D> polygons = new ArrayList<Polygon2D>();

ArrayList< ArrayList <PVector> > pointsList = new ArrayList< ArrayList <PVector> >();

ArrayList<PVector> fPoints0 = new ArrayList<PVector>();
ArrayList<PVector> fPoints1 = new ArrayList<PVector>();
ArrayList<PVector> fPoints2 = new ArrayList<PVector>();
ArrayList<PVector> fPoints3 = new ArrayList<PVector>();
ArrayList<PVector> fPoints4 = new ArrayList<PVector>();

ArrayList<ArrayList> traingleList = new ArrayList< ArrayList>();

ArrayList triangles0 = new ArrayList();
ArrayList triangles1 = new ArrayList();
ArrayList triangles2 = new ArrayList();
ArrayList triangles3 = new ArrayList();
ArrayList triangles4 = new ArrayList();


PVector center;
float rad;
float z;

ArrayList<PVector> points;
ArrayList<PVector> sPoints;


void setup() {

  size(500, 500,OPENGL);
  background(255);
  gfx = new ToxiclibsSupport(this);

  center = new PVector(width/2, height/2);
  rad = 300;
  z = 10;
  points = new ArrayList<PVector>();
  sPoints = new ArrayList<PVector>();


pointsList.add(fPoints0);
pointsList.add(fPoints1);
pointsList.add(fPoints2);
pointsList.add(fPoints3);
pointsList.add(fPoints4);


  //  ellipse(center.x, center.y, rad, rad);
  translate(center.x, center.y);
  ellipse(0, 0, 5, 5);
  rotate(-PI/2);
  for (int i=0; i<5; i++) {
    points.add(new PVector(cos(i*2*PI/5.f)*rad/2, sin(i*2*PI/5.f) *rad/2));
    sPoints.add(new PVector(cos((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2, sin((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2));
  }


  for (PVector p : points) {

    fill(0);
    ellipse(p.x, p.y, 5, 5);
  }

  for (PVector p : sPoints) {

    fill(0);
    //    ellipse(p.x, p.y, 5, 5);
  }


  for (int i=0; i< points.size(); i++) {

    int j = (i+1)%points.size();
    //   int k = (i+2)%points.size();

    PVector pi = points.get(i);
    PVector pj = points.get(j);

    PVector spi = sPoints.get(i);
    PVector spj = sPoints.get(j);

    //    beginShape();
    //    vertex(pi.x, pi.y);
    //    vertex(spi.x, spi.y);
    //    vertex(pj.x, pj.y);
    //    endShape();
    //    
    Vec2D v0 = new Vec2D(pi.x, pi.y);
    Vec2D v1 = new Vec2D(spi.x, spi.y);
    Vec2D v2 = new Vec2D(pj.x, pj.y);

    ArrayList temp = new ArrayList();
    temp.add(v0);
    temp.add(v1);
    temp.add(v2);

    polygons.add(new Polygon2D(temp));
  }





  int count = 0;

  for (int i=0; i<polygons.size(); i++) {
    Polygon2D p = polygons.get(i);

   // pointsList.get(i).add(sPoints.get(i));
    for (;;) {

      Vec2D pv = new Vec2D(random(-width/2, width/2), random(-height/2, height/2));

      if (p.containsPoint(pv)) {
        PVector tempP = new PVector(pv.x, pv.y);
        pointsList.get(i).add(tempP);
        if (pointsList.get(i).size()>50) break;
      }
    }
  }
  
  println("done");

  triangles0 = Triangulate.triangulate(pointsList.get(0));
  triangles1 = Triangulate.triangulate(pointsList.get(1));
  triangles2 = Triangulate.triangulate(pointsList.get(2));  
  triangles3 = Triangulate.triangulate(pointsList.get(3));
  triangles4 = Triangulate.triangulate(pointsList.get(4));
  
 // noFill();
  noStroke();

  beginShape(TRIANGLES);
  
  for (int i = 0; i < triangles0.size(); i++) {
      fill(random(100,205));
    Triangle t = (Triangle)triangles0.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
    endShape();
    beginShape(TRIANGLES);
  for (int i = 0; i < triangles1.size(); i++) {
    fill(random(100,205));
    Triangle t = (Triangle)triangles1.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles2.size(); i++) {
    fill(random(100,205));
    Triangle t = (Triangle)triangles2.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  beginShape(TRIANGLES);
  
  for (int i = 0; i < triangles3.size(); i++) {
    fill(random(100,205));
    Triangle t = (Triangle)triangles3.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  beginShape(TRIANGLES);
  
  
  for (int i = 0; i < triangles4.size(); i++) {
    fill(random(100,205));
    Triangle t = (Triangle)triangles4.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }

  endShape();
  noFill();
}

