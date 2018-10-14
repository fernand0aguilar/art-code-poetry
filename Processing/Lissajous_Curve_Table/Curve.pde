class Curve {
  ArrayList<PVector> path;
  PVector current;

  Curve() {
    path = new ArrayList<PVector>();
    current = new PVector();
  }

  void setX(float x) {
    current.x = x;
  }
  void setY(float y) {
    current.y = y;
  }

  void addPoint() {
    path.add(current);
  }

  void show() {
    stroke(0, 255, 0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : path) {
      vertex(v.x, v.y);
    }
    endShape();
  }
}
