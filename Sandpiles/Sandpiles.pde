int [][] sandpiles;

void setup() {
  size(800, 600, P2D);
  sandpiles = new int[width][height];
  sandpiles[width/2][height/2] = 4000000;
}

void draw() {
  render();
  for(int i = 0; i < 1000; i++)
    tupple();
}

void tupple() {
  int [][] nextpiles = new int[width][height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int num = sandpiles[x][y];
      if (num < 4) {
        nextpiles[x][y] = sandpiles[x][y];
      }
    }
  }
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      if(sandpiles[x][y] >= 4){
       nextpiles[x][y] += (sandpiles[x][y] - 4);
       if(x + 1 < width)
       nextpiles[x+1][y] += 1;
       if(x-1 >= 0)
         nextpiles[x-1][y] += 1;
       if(y+1 < height)
         nextpiles[x][y+1] += 1;
       if(y-1 >= 0)
         nextpiles[x][y-1] += 1;
      }
    }
  }
  sandpiles = nextpiles;
}

void render() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int num = sandpiles[x][y]; 
      color col = color(0, 0, 0);

      switch(num) {
      case 0:
        col = color(255, 255, 0);
        break;
      case 1:
        col = color(0, 185, 63);
        break;
      case 2:
        col = color(0, 104, 255);
        break;
      case 3:
        col = color(122, 0, 229);
        break;
      }

      pixels[x+y*width] = col;
    }
  }
  updatePixels();
}
