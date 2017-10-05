int contador2 = 0;
final short NUM = 10000;
PVector[] vectors = new PVector[NUM];

class pathfinder {
  PVector lastLocation;
  PVector location;
  PVector velocity;
  float diameter;
  boolean isFinished;
  
  pathfinder() {
    location = new PVector(width/2, height);
    lastLocation = new PVector(location.x, location.y);
    velocity = new PVector(0, -10);
    diameter = random(10, 20);
    isFinished = false;
  }
  
  pathfinder(pathfinder parent) {
    location = parent.location.get();
    lastLocation = parent.lastLocation.get();
    velocity = parent.velocity.get();
    diameter = parent.diameter * 0.62;
    isFinished = parent.isFinished;
    parent.diameter = diameter;
  }
  
  void update() {
    if(location.x > -10 & location.x < width + 10 & location.y > -10 & location.y < height + 10) {
      lastLocation.set(location.x, location.y);
      if (diameter > 0.1) {
        count ++;
        PVector bump = new PVector(random(-1, 1), random(-1, 1));
        velocity.normalize();
        bump.mult(0.7);
        velocity.mult(1); //altura caule
        velocity.add(bump);
        velocity.mult(random(8, 16));
        location.add(velocity);
        if (random(0, 1) < 0.2) { // controla  a quantidade de flores
          paths = (pathfinder[]) append(paths, new pathfinder(this));
        }
      } 
      else {
        if(!isFinished) {
          isFinished = true;
          contador2 = contador2 + 1;
          noStroke();
          fill (amarelo);
          ellipse(location.x, location.y, folhax, folhay); //tamanho folhas
          stroke(0); //cor galhos
         vectors[contador2] = new PVector(location.x, location.y, 7);
        }
      }
    }
  }
}
pathfinder[] paths;

void arvore() {
  
  for (int i = 0; i < paths.length; i++) {
    PVector loc = paths[i].location;
    PVector lastLoc = paths[i].lastLocation;
    strokeWeight(paths[i].diameter);
    line(lastLoc.x, lastLoc.y, loc.x, loc.y);
    println("foi o tempo " + contador);
    
    paths[i].update();
  
    if ( i > paths.length) {
      print("stop");
    }  
  }
//contador = 0;  
}