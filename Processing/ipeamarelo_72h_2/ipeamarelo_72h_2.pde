// 72 h vida 4 de morte
final float INTERVALO = 1;
final float FATORVELOCIDADE = 6;


boolean active = false;
int folhax = 33 ;
int folhay = 33 ;
int contador = 0;
int numEstado = 0;
int num;
color amarelo = color(240, 230, 50);
static int count;


// SETUP
void setup() {
  size(800, 600);

  frameRate(10);
  background(255);
  ellipseMode(CENTER);
  stroke(141, 69, 18); //cor caule
  smooth();
  num = 2;
  count = 0;
  pathArray = new ArrayList<pathfinder>(num);
  paths = new pathfinder[num];
  for (int i = 0; i < num; i++) paths[i] = new pathfinder();
  for (int i = 0; i < num; i++) pathArray.add(new pathfinder());
  contador=0;
}

void draw() {
  fill(253, 184, 19);
  ellipse(100, 100, 69, 69);
  if (contador < 80*FATORVELOCIDADE) {
    //delay(2925000); ///Valor do tempo de duração em milissegundos dividio por 80
    //Caso seja o a funcao arvore resulta true ocorreu uma reproducao de caules 
    if (arvore())
      contador = contador + 1 ;
  } else {
    //delay(1080000);
    morte();
    println("parou");
    //}
  }
}

/* 
 COMENTEI PARA Nao ter acidentes de restartar no meio da exposicao porcausa de um mouseclick 
 void mousePressed() {
 background(250);
 contador = 0;
 count = 0;
 paths = new pathfinder[num];
 for(int i = 0; i < num; i++) paths[i] = new pathfinder();
 
 }
 */
