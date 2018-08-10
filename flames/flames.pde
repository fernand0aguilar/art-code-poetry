PGraphics buffer1;
PGraphics buffer2;
PImage cooling;

int w = 600;
int h = 400;
float ystart = 0.0;

void setup() {
  size(1200, 400);
  buffer1 = createGraphics(w, h);
  buffer2 = createGraphics(w, h);
  cooling = createImage(w, h, RGB);
}

void cool() {
  cooling.loadPixels();
  float xoff = 0.0;
  float increment = 0.02;

  for (int x = 0; x < w; x++) {
    xoff += increment;
    float yoff = ystart;
    for (int y = 0; y < h; y++) {
      yoff += increment;


      float n = noise(xoff, yoff);
      float bright = pow(n, 3) * 255;
      //OR use this line instead
      //float bright = random(0, 255);


      cooling.pixels[x+y*w] = color(bright);
    }
  }

  cooling.updatePixels();
  ystart += increment;
}



void fire(int rows) {
  buffer1.beginDraw();
  buffer1.loadPixels();

  for (int x = 0; x < w; x++) {
    for (int j = 0; j < rows; j++) {
      int y = h - (j + 1);
      int index = x + y * w;
      buffer1.pixels[index] = color(255);
    }
  }

  buffer1.updatePixels();
  buffer1.endDraw();
}

void draw() {
  fire(2);

  if (mousePressed) {
    buffer1.beginDraw();
    buffer1.fill(255);
    buffer1.noStroke();
    buffer1.ellipse(mouseX, mouseY, 60, 60);
    buffer1.endDraw();
  }

  cool();
  background(0);

  buffer2.beginDraw();
  buffer1.loadPixels();
  buffer2.loadPixels();

  for (int x = 1; x < w-1; x++) {
    for (int y = 1; y < h-1; y++) {
      int index0 = (x) + (y) * w;
      int index1 = (x+1) + (y) * w;
      int index2 = (x-1) + (y) * w;
      int index3 = (x) + (y+1) * w;
      int index4 = (x) + (y-1) * w;


      color c1 = buffer1.pixels[index1];
      color c2 = buffer1.pixels[index2];
      color c3 = buffer1.pixels[index3];
      color c4 = buffer1.pixels[index4];
      color c5 = cooling.pixels[index0];
      
      float newC = brightness(c1) + brightness(c2)+ brightness(c3) + brightness(c4);
      newC = newC * 0.25 - brightness(c5);

      buffer2.pixels[index4] = color(newC);
    }
  }
  buffer2.updatePixels();
  buffer2.endDraw();

  PGraphics temp = buffer1;
  buffer1 = buffer2;
  buffer2 = temp;

  image(buffer2, 0, 0);
  image(cooling, w, 0);
}
