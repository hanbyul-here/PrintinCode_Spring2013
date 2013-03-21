import processing.pdf.*;

// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// Basic example of falling rectangles

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;




// A reference to our box2d world
PBox2D box2d;
Grid grid;
PFont font;
float size;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

boolean stepStart;
boolean rec;

void setup() {
  size(floor(8.5*50), 11*50);
  smooth();
  grid = new Grid(10, 10, 0.f, 10.f);

  size = grid.getSW();
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  font = createFont("Futura", 50);

  stepStart = false;
  rec = false;

  //   boundaries.add(new Boundary(grid.getW(0.5),grid.getH(4),grid.getSW()*1,0,false));
  //   boundaries.add(new Boundary(grid.getW(3),grid.getH(4),grid.getSW()*1,0,false));
  //   boundaries.add(new Boundary(grid.getW(5.1),grid.getH(4),grid.getSW()*0.5,0,false));
  //    boundaries.add(new Boundary(grid.getW(6.5),grid.getH(4),grid.getSW()*0.3,0,false));
  //    
  //    
  //     boundaries.add(new Boundary(grid.getW(4.9),grid.getH(4.3),0,grid.getSH()*0.4,false));
  //     boundaries.add(new Boundary(grid.getW(5.5),grid.getH(4.3),0,grid.getSH()*0.4,false));
  //      boundaries.add(new Boundary(grid.getW(6.3),grid.getH(4.3),0,grid.getSH()*0.5,false));
  //   
  //   boundaries.add(new Boundary(grid.getW(1.5),grid.getH(4.3),grid.getSW()*1.3,0,false));
  //   boundaries.add(new Boundary(grid.getW(4.3),grid.getH(4.3),grid.getSW()*1.5,0,false));
  //  boundaries.add(new Boundary(grid.getW(6),grid.getH(4.3),grid.getSW()*1,0,false));


  //boundaries.add(new Boundary(grid.getW(6.5), grid.getH(3), grid.getSW()*3, 0, false));

  boundaries.add(new Boundary(grid.getW(5), grid.getH(4.7), grid.getSW()*8, 0, false));
  boundaries.add(new Boundary(grid.getW(1), grid.getH(4.5), 0, grid.getSH()-30, false));
boundaries.add(new Boundary(grid.getW(9), grid.getH(4.5), 0, grid.getSH()-30, false));
  //  boundaries.add(new Boundary(grid.getW(5.7),grid.getH(9)-30,grid.getSW()*3.5,0,true));
}


void draw() {


  if (rec) beginRecord(PDF, millis()+".pdf");
  background(250, 210, 60);

  // We must always step through time!
  box2d.step();

  // Boxes fall from the top every so often

  if (stepStart) {
    //if (random(1) < 0.2) {
    Box p = new Box(mouseX, mouseY);
    boxes.add(p);
    //}
  }
  rectMode(CORNER);
  //grid.display();

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  textFont(font);
  textSize(65);
  fill(0);
  textAlign(CENTER);
  text("The Capital", grid.getW(5), grid.getH(6));
  textSize(25.5);
  text("Critique of Political Economy", grid.getW(5), grid.getH(7)-10);

  textSize(37);
  text("Karl Marx", grid.getW(5), grid.getH(9));
  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }

  if (rec) endRecord();
}



void keyPressed() {

  if (key =='r') {

    rec = !rec;
  } 

  if (key == 's') {

    stepStart = !stepStart;
  }
}


void mousePressed() {
  stepStart = true;
}

void mouseReleased() {

  stepStart = false;
}

