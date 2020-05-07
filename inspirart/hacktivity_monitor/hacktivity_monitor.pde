color bg = color(0);
color fg = color(100, 255, 50);
int textS = 6;
int resetDelay = 400;
int cursor = 10;

void setup() {
  fullScreen();
  //size(500, 500);
  noCursor();
  background(bg);
}

float t = 0;
Item i = new HorizSplit(1);
void draw() {
  fill(bg, 100);
  rect(0, 0, width, height);
  //background(bg);
  t+=0.01;
  i.make(width, height);
  
  stroke(fg);
  line(mouseX, mouseY-cursor, mouseX, mouseY+cursor);
  line(mouseX-cursor, mouseY, mouseX+cursor, mouseY);
}

String[] garbage = {"bilinear momentum", "brute force", "fruit morse", "computing inverse", "quanta", "hex dump", "cpu", "triangulation", "recursive backtrace", "parallell complexification"};
String filler(int i) {
  return garbage[i%garbage.length];
}

void label(String t) {
  textSize(textS);
  fill(fg);
  noStroke();
  //rect(0, 0, textWidth(text)+8, textS+8); // doesn't work for some reason
	rect(0, 0, 80, textS+8);

  fill(bg);
  text(t, 4, textS+4);
}

abstract class Item {
  abstract void make(float w, float h);
}

Item generateItem(int level) {
  return generateItem(level, random(1)<0.5);
}

Item generateItem(int level, boolean horizontal) {
  if (random(1)<0.9 && level<5) {
    if (random(1)<0.4) {
      return new StackItem(level);
    }
    if (horizontal) {
      return new HorizSplit(level);
    } else {
      return new VertSplit(level);
    }
  } else {
    switch((int)random(7)) {
    case 0:
      return new Code();
    case 1:
      return new Web();
    case 2:
      return new Bar();
    case 3:
      return new Line();
    case 4:
      return new Pie();
    case 5:
      return new Data();
    case 6:
      return new Progress();
    }
  }
  return null;
}

class StackItem extends Item {
  Item a;
  Item b;

  int l;

  public StackItem(int level) {
    l = level;
    reset();
  }

  int frame = (int)random(resetDelay);
  void make(float w, float h) {
    frame++;
    if (frame%resetDelay==0) {
      reset();
    }

    a.make(w, h);
    fill(bg, 100);
    noStroke();
    rect(0, 0, w, h);
    b.make(w, h);
  }

  void reset() {
    if (random(1)>0.5||a==null) {
      a = generateItem(l+1);
    }
    if (random(1)>0.5||b==null) {
      b = generateItem(l+1);
    }
  }
}

class HorizSplit extends Item {
  float split = random(0.25, 0.75);
  Item a;
  Item b;

  int l;

  public HorizSplit(int level) {
    l = level;
    reset();
  }

  int frame = (int)random(resetDelay);
  void make(float w, float h) {
    frame++;
    if (frame%resetDelay==0) {
      reset();
    }

    a.make(w*split, h);
    pushMatrix();
    translate(w*split, 0);
    b.make(w*(1-split), h);
    popMatrix();

    stroke(fg);
    strokeWeight(1);
    line(w*split, 0, w*split, h);
  }

  void reset() {
    split = random(0.25, 0.75);

    boolean horizontal = height<min(split, 1-split)*width;
    if (random(1)>0.5||a==null) {
      a = generateItem(l+1, horizontal);
    }
    if (random(1)>0.5||b==null) {
      b = generateItem(l+1, horizontal);
    }
  }
}

class VertSplit extends Item {
  float split = random(0.25, 0.75);
  Item a;
  Item b;
  int frame = (int)random(resetDelay);

  int l;

  public VertSplit(int level) {
    l = level;
    reset();
  }
  void make(float w, float h) {
    frame++;
    if (frame%resetDelay==0) {
      reset();
    }

    a.make(w, h*split);
    pushMatrix();
    translate(0, h*split);
    b.make(w, h*(1-split));
    popMatrix();

    stroke(fg);
    strokeWeight(1);
    line(0, h*split, w, h*split);
  }

  void reset() {
    split = random(0.25, 0.75);
    boolean horizontal = min(split, 1-split)*height<width;
    if (random(1)>0.5||a==null) {
      a = generateItem(l+1, horizontal);
    }
    if (random(1)>0.5||b==null) {
      b = generateItem(l+1, horizontal);
    }
  }
}

abstract class Text extends Item {
  String code = "";
  int frame = 0;
  void make(float w, float h) {
    textSize(textS);

    frame ++;
    if (frame%2 == 0) {
      addCode();
    }
    int lines = code.split("\\n").length;
    if (lines*textS*2>h) {
      code = code.replaceFirst("([^\\n]+\\n)", "");
      lines--;
    }

    fill(fg);
    text(code, 0, 0, w, h);
  }

  abstract void addCode();
}

class Progress extends Item {
  float time = 0;
  int seed = (int)random(300);
  float[] progress = new float[5];
  void make(float w, float h) {
    time+=0.1;
    float rowHeight = h/(progress.length*2+1);
    for (int i = 0; i<progress.length; i++) {
      progress[i]+=noise(i, time)/500;

      pushMatrix();
      translate(10, rowHeight*(i*2+1));

      fill(lerpColor(bg, fg, progress[i]<1?0.5:(sin((float)time*3)/8+0.5)));
      noStroke();
      rect(0, 0, (w-20)*min(progress[i], 1), rowHeight);

      noFill();
      stroke(fg);
      strokeWeight(1);
      rect(0, 0, w-20, rowHeight);

      label(filler(i+seed));
      popMatrix();
    }
  }
}

class Code extends Text {
  float seed = random(200);

  int indentation = 0;
  String[] control = {"for(Complex root: crack.generate())", "if(confirmPassword(input))", "while(forger.hasNext())", "private class Identifier"};
  void addCode() {
    switch((int)random(4)) {
    case 0:
      code+=spaces()+filler((int)(seed+random(100))).replaceAll(" ", ".")+"();\n";
      break;
    case 1:
      code+=spaces()+control[(int)(random(control.length))]+"  {\n";
      indentation++;
      break;
    case 2:
      if (indentation>0) {
        indentation--;
        code+=spaces()+"}\n";
      }
      break;
    case 3: // do nothing
      break;
    }
  }

  String spaces() {
    String answer = "";
    for (int i = 0; i<indentation; i++) {
      answer+="   ";
    }
    return answer;
  }
}

class Data extends Text {
  float seed = random(200);

  void addCode() {
    for (int i = 0; i<8; i++) {
      code+=sq(random(42))+"    ";
    }
    code+="\n";
  }
}

class Web extends Item {
  float seed = random(200);
  void make(float w, float h) {
    float angle = noise(seed, t/10)*2;
    float[][] points = new float[4][2];
    pushMatrix();
    translate(w/2, h/2);

    for (int i = 0; i<16; i++) {
      angle+=1;
      pushMatrix();
      float x = cos(angle*i)*w/3;
      float y = sin(angle*(i+1))*h/3;

      stroke(fg, 140);
      for (int j = 0; j<4; j++) {
        float[] point = points[(int)(noise(seed+j, i, t)*points.length)];
        line(x, y, point[0], point[1]);
      }
      points[(int)(noise(seed+1, i, t)*points.length)] = new float[]{x, y};


      translate(x, y);
      label(filler(i+(int)seed));
      popMatrix();
    }
    popMatrix();
  }
}

class Bar extends Item {
  float seed = random(200);
  void make(float w, float h) {
    int num = (int)(w/25);
    float con = w/(num+1);
    for (int i = 0; i<num; i++) {
      //fill(fg);
      //noStroke();
      stroke(fg);
      noFill();
      float value = h*(1- noise(seed, t+0.23*i, i)*0.8);
      float x = con*(2.0/3+i);
      rect(x, h, con/3*2, -value);

      if (i%3==0) {
        pushMatrix();
        translate(x, h-value-20);
        label(filler(i+(int)seed));
        popMatrix();
      }
    }
  }
}

class Line extends Item {
  int num = 42;
  float seed = random(200);
  void make(float w, float h) {

    // draw ticks
    int step = 7;
    stroke(lerpColor(bg, fg, 0.5));
    for (int x = 0; x<w; x+=step) {
      line(x, h, x, h-10);
    }
    for (int y = 0; y<h; y+=step) {
      line(0, y, 10, y);
    }

    // draw the graph
    float con = w/(num+1);
    for (int i = 0; i<num-1; i++) {
      for (int j = 0; j<3; j++) {
        stroke(fg);
        strokeWeight(2);
        line(con*(0.5+i), h*noise(seed, t+0.23*i, j), 
          con*(1.5+i), h*noise(seed, t+0.23*(i+1), j));
        if (i==5) {
          pushMatrix();
          translate(con*(0.5+i), h*noise(seed, t+0.23*i, j)-20);
          label(filler(j+(int)seed));
          popMatrix();
        }
      }
    }
  }
}

class Pie extends Item {
  float seed = random(200);
  void make(float w, float h) {
    pushMatrix();
    translate(w/2, h/2);
    stroke(fg);
    strokeWeight(2);
    float diameter = min(w, h)*0.6;

    float angle = noise(seed, t)*2;
    for (int i = 0; i<16; i++) {
      fill(lerpColor(bg, fg, noise(seed, i+100)));
      float da = sq(noise(seed, i, t))*3;
      arc(0, 0, diameter, diameter, angle, angle+da);
      angle+=da;
    }

    angle = noise(seed, t)*2;
    for (int i = 0; i<16; i++) {
      angle+=sq(noise(seed, i, t))*3;
      pushMatrix();
      translate(cos(angle)*diameter/1.6, sin(angle)*diameter/1.6);
      label(filler(i+(int)seed));
      popMatrix();
    }
    popMatrix();
  }
}