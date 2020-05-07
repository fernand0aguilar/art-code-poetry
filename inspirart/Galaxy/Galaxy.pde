float[] xs;
float[] rs;
float[] ss;
float[] zs;

int n = 10000;

float speed = 0.001;

void setup() {  
  fullScreen();

  noStroke();
  background(0);
  fill(255);
  text("Loading. Please wait.", width/2, height/2);
}

float tilt = 0.2;
float mx = mouseX;
float my = mouseY;

int first = 0;
void draw() {
  if (first==0) {
    first = 1;
  } else if (first ==1) {
    xs = new float[n];
    rs = new float[n];
    ss = new float[n];
    zs = new float[n];
    int m = 2;
    for (int i = 0; i<n; i++) {
      xs[i] = sq(random(1.4))+random(0.05);
      rs[i] = ((sqrt(sin(random(PI/2))))+(int)random(m)+random(0.01))/m*TWO_PI
        -(9*sqrt(xs[i]));
      ss[i]=  random(1, 4);
      zs[i] = sq((random(0.1)))*(random(1)>.5?-1:1)*xs[i]*10;
    }
    first = 2;
  } else {

    mx+=(mouseX-mx)/4;
    my+=(mouseY-my)/4;
    background(0);

    translate(width/2, height/2);
    fill(255, 150);

    rotate(tilt);

    for (int i = 0; i<n; i++) {
      pushMatrix();

      float r = rs[i]-(float)mx/1000;
      float x = xs[i];

      float close = 1+sin(r-0.5)*sqrt(x);


      translate(0, zs[i]*width);

      scale(1/pow(2, 1-close));

      ellipse(x*width*(cos(r)+sin(r)), 
        x*width*(sin(r)-cos(r))*map(my, 0, height, -0.3, 0.3), ss[i], ss[i]);

      rs[i]+=(x/(x+1)+0*close/4)*speed/xs[i]*(20/frameRate);

      popMatrix();
    }
  }
}