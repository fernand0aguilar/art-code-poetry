// 72 h vida 4 de morte

boolean active = false;
int folhax = 30 ;
int folhay = 20 ;
int contador = 0;
int num;
color amarelo = color(240, 230, 50);
static int count;
void setup() {
  size(800, 600);
  frameRate(10);
  background(250);
  ellipseMode(CENTER);
  stroke(0); //cor caule
  smooth();
  num = 2;
  count = 0;
  paths = new pathfinder[num];
  for(int i = 0; i < num; i++) paths[i] = new pathfinder();
  contador=0;
}

void draw() {
  if (contador < 80) {
    delay(2925); ///Valor do tempo de duração em milissegundos dividio por 80
    arvore();
    contador = contador + 1 ;

  }
 else {
  delay(1080000);
   morte();
   println("parou");
 //}
 }

}
void mousePressed() {
  background(250);
  contador = 0;
  count = 0;
  paths = new pathfinder[num];
  for(int i = 0; i < num; i++) paths[i] = new pathfinder();

}