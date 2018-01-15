// The planetarium library is designed to create real-time projections on 
import codeanticode.planetarium.*;

DomeCamera dc;
int gridMode = Dome.NORMAL;
PImage img;
float cubeX, cubeY, cubeZ;


void setup() {
  size(1024, 1024, Dome.RENDERER);
  dc = new DomeCamera(this);
  dc.setDomeAperture(1f);

  img = createImage(66, 66, ARGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(0, 90, 102, i % img.width * 2);
  }
  img.updatePixels();
}

// Called one time per frame.
void pre() {
  // The dome projection is centered at (0, 0), so the mouse coordinates
  // need to be offset by (width/2, height/2)
  cubeX += ((mouseX - width * 0.5) - cubeX) * 0.2;
  cubeY += ((mouseY - height * 0.5) - cubeY) * 0.2;
  dc.drawIntoBackground(img);
}

// Called five times per frame.
void draw() {
  background(0, 0, 0, 0);

  pushMatrix();

  translate(width/2, height/2, -300);
  lights();

  stroke(0);  
  fill(150);
  pushMatrix();
  translate(cubeX, cubeY, cubeZ);  
  box(50);
  popMatrix();

  stroke(255);
  int linesAmount = 10;
  for (int i = 0; i < linesAmount; i++) {
    float ratio = (float)i/(linesAmount-1);
    line(0, 0, cos(ratio*TWO_PI) * 50, sin(ratio*TWO_PI) * 50);
  }
  popMatrix();
  color(255);
  textSize(100);
  rotateZ(HALF_PI * frameCount / 100f);
  text("södlfsdölfksödlkf", 0, 0, 100);
}

void mouseDragged() {
  //exaggerating dome aperture. 1f <=> 180°
  dc.setDomeAperture(map(mouseY, 0, height, 0.1f, 2f));
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) cubeZ -= 5;
    else if (keyCode == DOWN) cubeZ += 5;
  }
  switch(key) {
  case ' ':
    gridMode = gridMode == Dome.GRID ? Dome.NORMAL : Dome.GRID;
    //enables rendering of a reference grid (happens inside the shader)
    dc.setMode(gridMode);
    break;
  case 'e':
    //fulldome-conform rendering
    dc.enable();
    break;
  case 'd':
    //rendering only into a single, conventional camera
    dc.disable();
    break;
  case '0':
    //toggles rendering into the X+ side of the cubemap
    dc.toggleFaceDraw(0);
    break;
  case '1':
    //toggles rendering into the X- side of the cubemap
    dc.toggleFaceDraw(1);
    break;
  case '2':
    //toggles rendering into the Y+ side of the cubemap
    dc.toggleFaceDraw(2);
    break;
  case '3':
    //toggles rendering into the Y- side of the cubemap
    dc.toggleFaceDraw(3);
    break;
  case '4':
    //toggles rendering into the Z+ side of the cubemap
    dc.toggleFaceDraw(4);
    break;
  case '5':
    //toggles rendering into the Z- side of the cubemap
    dc.toggleFaceDraw(5);
    break;
  }
}