float angle = - HALF_PI;
int cols = 0;
int rows = 0;

int w = 60;
float d = w - 10;
float r = d/2;

Curve[][] curves;

void setup() {
  fullScreen(P2D);
  cols = width / w - 1;
  rows = height / w - 1;
  curves = new Curve[rows][cols];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      curves[j][i] = new Curve();
    }
  }
}

void draw() {
  background(0);

  drawCircles(cols, "cols");
  drawCircles(rows, "rows");
  angle -= 0.01;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      curves[j][i].addPoint();
      curves[j][i].show ();
    }
  }
  
  if(angle < -TWO_PI){
   for ( int j = 0; j < rows; j ++){
      for(int i = 0; i < cols; i++){
        curves[j][i].reset();
      }
   }
   saveFrame("lissajous###.png");
   angle = 0;
  }
}

void drawCircles(int quantity, String type) {
  noFill();
  for (int i = 0; i < quantity; i++) {
    float centerX = 0, centerY = 0;
    float x = r * cos(angle * (i+1));
    float y = r * sin(angle * (i+1));

    stroke(255, 50);
    strokeWeight(1);
    if (type == "rows") {
      centerX = w/2;
      centerY = w + i * w + w /2;
      line(0, centerY + y, width, centerY + y);
      for (int j = 0; j < cols; j++) {
        curves[i][j].setY(centerY + y);
      }
    } else if (type == "cols") {
      centerX = w + i * w + w /2;
      centerY = w/2;
      line(centerX + x, 0, centerX + x, height);

      for (int j = 0; j < rows; j++) {
        curves[j][i].setX(centerX + x);
      }
    }

    stroke(255, 0, 255);
    strokeWeight(1);
    ellipse(centerX, centerY, d, d);
    strokeWeight(8);
    point(centerX + x, centerY + y);
  }
}
