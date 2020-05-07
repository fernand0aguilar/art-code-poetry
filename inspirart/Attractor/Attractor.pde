void setup() {

  size(800, 800);
  // fullScreen();
  // colorMode(HSB);
  c = new float[3];
  d = new float[3];
  
  mouseClicked();
}

float[] c;
float[] d;
void mouseClicked() {

  background(#191919);
  for (int i = 0; i<c.length; i++) {
    d[i]=  random(-1, 1);
  }
}

boolean paused = true;
void keyPressed()  {
  paused=!paused;
}

float t = 0.5;
void draw() {
  
  if(!paused)  {
  t+=0.003;
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);
  }

  //translate(width/2, height/2);
  //scale(0.5);

  for (int i = 0; i<c.length; i++) {
    c[i]=  random(-1, 1);
  }

  for (int i = 0; i< 10000; i++) {

    int x = (int)((c[0]+1)*width/2);
    int y = (int)((c[1]+1)*height/2);
    int hue = (int)(100*c[2]);
    set(x, y, lerpColor(color(197, 200+hue, 255), get(x, y), 0.9));

    for (int j = 0; j<c.length; j++) {
      c[j]=(sin(c[cl(j)]*PI)+d[j]*sq(sin(t)))*(sin(c[cl(j+1)]*PI)+d[j]*sq(cos(t)))+random(0.002);
    }
  }
}

int cl(int i) {
  return i%c.length;
}