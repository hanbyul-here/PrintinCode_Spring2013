import toxi.geom.*;
import toxi.processing.*;
import org.processing.wiki.triangulate.*;


ToxiclibsSupport gfx;

ArrayList<PVector> outerPoints;
ArrayList<PVector> innerPoints;

ArrayList<Vec2D> centerPoints;
ArrayList<Polygon2D> breakParts = new ArrayList<Polygon2D>();

ArrayList polygonPoints;
ArrayList triangle;

PVector center; 
float rad;

void setup() {
  size(500, 500, P3D);
  gfx = new ToxiclibsSupport(this);

  center = new PVector(width/2, height/2);
  rad = 300.f;

  outerPoints = new ArrayList<PVector>();
  innerPoints = new ArrayList<PVector>();
  centerPoints = new ArrayList();
  polygonPoints = new ArrayList();
  triangle = new ArrayList();
  background(255);
  translate(center.x, center.y);
  ellipse(0, 0, 5, 5);
  rotate(-PI/2);
  for (int i=0; i<5; i++) {
    outerPoints.add(new PVector(cos(i*2*PI/5.f)*rad/2, sin(i*2*PI/5.f) *rad/2, random(50, 100)));
    innerPoints.add(new PVector(cos((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2, sin((i*2*PI/5.f)+PI/5.f)*cos(2.f*PI/5.f)/sin(3.f*PI/10)*rad/2));
  }


  for (int i = 0; i<outerPoints.size();i++) {
    PVector p = outerPoints.get(i);
    PVector sp = innerPoints.get(i); 
    fill(0);
    ellipse(p.x, p.y, 5, 5);

    Vec2D temp = new Vec2D(p.x, p.y);
    Vec2D stemp = new Vec2D(sp.x, sp.y);

    //  polygonPoints.add(p);
    //   polygonPoints.add(temp);
    polygonPoints.add(stemp);
  }
  smooth();
  Polygon2D polygon = new Polygon2D(polygonPoints);
  //Polygon2D polygon = new Polygon2D(polygonPoints);
  // Polygon2D polygon = new Polygon2D(polygonPoints);
  // gfx.polygon2D(polygon);
  int temp = 0;
  Vec2D p;
  for (;;) {

    p = new Vec2D(random(-width/2, width/2), random(-height/2, height/2));

    if (polygon.containsPoint(p)) {
      // outerPoints.add(new PVector(p.x,p.y,random(50,100)));
      temp++;
    }
    if (temp>0) break;
  }

  for (int i=0; i<10; i++) {
    outerPoints.add(new PVector(p.x+random(-70, 70), p.y+random(-70, 70)));
  }
  for (Vec2D v:centerPoints) {
    fill(0, 255, 0);
    ellipse(v.x, v.y, 5, 5);
  }
  /*  
   ArrayList<Vec2D> vecLists = new ArrayList<Vec2D>();
   
   for (int i=0; i<outerPoints.size(); i++) {
   Vec2D ov = new Vec2D(outerPoints.get(i).x, outerPoints.get(i).y);
   // Vec2D cv = centerPoints.get(i);
   //  move(cv,ov);
   
   Vec2D targetDir = ov.sub(centerPoints.get(i)).normalize();
   targetDir.scaleSelf(random(30,60));
   centerPoints.get(i).set(centerPoints.get(i).addSelf(targetDir));
   fill(255,0,0);
   
   
   //  ellipse(cv.x,cv.y,5,5);
   println(centerPoints.get(i));
   Vec2D vec_ = new Vec2D(centerPoints.get(i).x,centerPoints.get(i).y);
   vecLists.add(new Vec2D(vec_.x,vec_.y));
   vec_= null;
   }
   
   
   println(vecLists.get(2));
   
   
   
   for (int i=0; i<vecLists.size();i++) {
   Vec2D v = vecLists.get(i);
   fill(0,0,255);
   println(v);
   ellipse(v.x, v.y, 5, 5);
   }
   
   
   
   for(int i = 0; i<outerPoints.size();i++){
   
   PVector oi = outerPoints.get(i);
   Vec2D vi = vecLists.get((i+1)%outerPoints.size());
   PVector oj = outerPoints.get((i+1)%outerPoints.size());
   beginShape();
   vertex(oi.x,oi.y);
   vertex(vi.x,vi.y);
   vertex(oj.x,oj.y);
   endShape();
   }
   */

  triangle = Triangulate.triangulate(outerPoints);


  //  beginShape(TRIANGLES);

  for (int i = 0; i <triangle.size(); i++) {
    // fill(random(100, 205));
    noFill();

    Triangle t = (Triangle)triangle.get(i);

    ArrayList tempV = new ArrayList();
    Vec2D vp1 = new Vec2D(t.p1.x, t.p1.y);
    Vec2D vp2 = new Vec2D(t.p2.x, t.p2.y);
    Vec2D vp3 = new Vec2D(t.p3.x, t.p3.y);

    tempV.add(vp1);
    tempV.add(vp2);
    tempV.add(vp3);

    breakParts.add(new Polygon2D(tempV));
    // 
    //    Vec2D targetDir = ov.sub(centerPoints.get(i)).normalize();
    //    targetDir.scaleSelf(random(30,60));
    //    centerPoints.get(i).set(centerPoints.get(i).addSelf(targetDir));

    //    vertex(t.p1.x, t.p1.y, t.p1.z);

    //  vertex(t.p2.x, t.p2.y, t.p2.z);

    //    vertex(t.p3.x, t.p3.y, t.p3.z);
  }


  for (Polygon2D pp : breakParts) {
    noStroke();
    fill(0);


    Vec2D centerV = pp.getCentroid();
    Vec2D ccv = new Vec2D(0, 0);
    Vec2D targetDir = centerV.sub(ccv).normalize();
    targetDir.scaleSelf(dist(centerV.x,centerV.y,ccv.x,ccv.y)/random(4,5));

    for (Vec2D v: pp.vertices) {

      v.set(v.addSelf(targetDir));
    }


    gfx.polygon2D(pp);
  }
}

//
//void move(Vec2D vec,Vec2D dir){
//  
//  Vec2D centerV = new Vec2D(dir.x,dir.y);
//  Vec2D targetDir = centerV.sub(vec).normalize();
//  targetDir.scaleSelf(100);
//  vec.set(vec.addSelf(targetDir));
//  println(vec);
//  
//}

void draw() {
  // background(255);
  // translate(center.x,center.y);
  // rotate(-PI/2);
}

