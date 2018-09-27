float x = 0, y = 0;
final int INTERACTIONS = 300;

void setup() {
  size(640, 640); 
  background(51);
}

void draw() {
  for (int i = 0; i < INTERACTIONS; i++) {
    drawPoint();
    nextPoint();
  }
}

void drawPoint() {
  stroke(random(180), random(255), random(100));
  strokeWeight(1);
  float px = map(x, -2.1820, 2.6558, 0, width);
  float py = map(y, 0, 9.9983, height, 0);
  point(px, py);
}

void nextPoint() {
  float nextX;
  float nextY;

  float ran = random(1);

  if (ran < 0.01) {
    //1
    nextX = 0;
    nextY = 0.16 * y;
  } else if (ran < 0.86) { 
    //2
    nextX = 0.85 * x + 0.04 * y;
    nextY = -0.04 * x + 0.85 * y + 1.6;
  } else if (ran < 0.93) {
    //3
    nextX = 0.20 * x + -0.26 * y;
    nextY = 0.23 * x + 0.22 * y + 1.6;
  } else {
    //4
    nextX = -0.15 * x + 0.28 * y;
    nextY = 0.26 * x +  0.24 * y + 0.44;
  }

  x = nextX;
  y = nextY;
}
