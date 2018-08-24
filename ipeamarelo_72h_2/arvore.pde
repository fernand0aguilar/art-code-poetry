
import java.util.ArrayList;
// CONSTANTES DA CLASSE PATHFINDER(?)
// CONTADOR2 = ?
// NUM = ?
// LUZSOL eh um vetor que eh somado a cada caule que nasce para que ele tenha uma tendencia linear em direcao do sol( para cima)
// vector = ?
int contador2 = 0;
final short NUM = 10000;
final PVector LUZSOL = new PVector(0, -0.033);
PVector[] vectors = new PVector[NUM];


//
class pathfinder {
  PVector lastLocation;
  PVector location;
  PVector velocity;
  float diameter;
  boolean isFinished;

  //Construtor path Finder inicial onde cria o primeiro noh na parte de baixo da tela no meio
  pathfinder() {
    location = new PVector(width/2, height);
    lastLocation = new PVector(location.x, location.y);
    velocity = new PVector(0, -10);
    diameter = random(10, 20);
    isFinished = false;
  }

  //Criacao de outro pathfinder filho a partir de um path finder pai
  pathfinder(pathfinder parent) {
    location = parent.location.get();
    lastLocation = parent.lastLocation.get();
    velocity = parent.velocity.get();
    diameter = parent.diameter * 0.62;
    isFinished = parent.isFinished;
    parent.diameter = diameter;
  }

  //
  boolean update() {
    //Se esta nos limites da tela
    // lastlocation = location atual
    // se o diametro for menor que um threshold
    // vetor bump aleatorio([-1,1], [-1,1])]]
    // adiciona-se a influencia do vetor sol para se direcionar um pouco mais pra cima
    // velocidade vira vetor unitario e multiplica por 1 que eu acho que n faz diferenca
    // multiplica por um escalar aleatório para dar o tamanho do caule
    // senao termina e adiciona o contador2++
    boolean resultado = false;
    if (location.x > -10 & location.x < width + 10 & location.y > -10 & location.y < height + 10) {
      lastLocation.set(location.x, location.y);
      if (diameter > 0.1) {
        count ++;
        PVector bump = new PVector(random(-1, 1)/FATORVELOCIDADE, random(-1, 1)/FATORVELOCIDADE);
        bump.add(LUZSOL);
        velocity.normalize();
        bump.mult(0.90*FATORVELOCIDADE);
        velocity.mult(1); //altura caule
        velocity.add(bump);
        velocity.mult(random(8/FATORVELOCIDADE, 16/FATORVELOCIDADE));
        location.add(velocity);
        resultado = true;
      } else {
        //if(!isFinished) {
        isFinished = true;
        contador2 = contador2 + 1;
        noStroke();
        fill (amarelo);
        ellipse(location.x, location.y, folhax/FATORVELOCIDADE, folhay/FATORVELOCIDADE); //tamanho folhas
        stroke(141, 81, 33); //cor galhos
        resultado = false;
        //vectors[contador2] = new PVector(location.x, location.y, 7);
        //}
      }
    }
    return resultado;
  }
}



//ANEXO  PARA O METODO O ARVORE
pathfinder[] paths;
ArrayList<pathfinder> pathArray;

boolean arvore() {
  boolean result = false;
  // Funcao que pega um noh de uma arvore, teste eh numero de segundo >= passou do intervalo vs numeroVezes
  // Varredura sequencial
  // Configura novo filho 
  // Chama a funcao update caso boolean responda com false eh hora de construir uma folha  e caso seja hora de construir uma folha tira se do array.
  if ((frameCount/frameRate) >= (numEstado)*(INTERVALO/FATORVELOCIDADE)) {
    for (int i = 0; i < paths.length; i++) {
      PVector loc = paths[i].location;
      PVector lastLoc = paths[i].lastLocation;
      strokeWeight(paths[i].diameter);
      //PVector loc2 = pathArray.get(i).location;
      //PVector lastLoc2 = pathArray.get(i).location;
      line(lastLoc.x, lastLoc.y, loc.x, loc.y);
      if (paths[i].update()) {
        //if(pathArray.get(i).update()){
        if (random(0, 1) < 0.2/FATORVELOCIDADE) { // controla  a quantidade de flores
          paths = (pathfinder[]) append(paths, new pathfinder(paths[i]));
          pathArray.add(new pathfinder(pathArray.get(i)));
        }
      } else {
        //pathArray.remove(i);
        //paths = (pathfinder[])shorten(paths);
      }
      if ( i > paths.length) {
        print("stop");
      }
    }
    numEstado++;
    println("foi o tempo " + contador+"\t num Estado ="+numEstado+"\tsegundos = "+(frameCount/frameRate)+" estado = "+(numEstado)*INTERVALO/FATORVELOCIDADE+"\n");   
    result = true;
  }
  return result;
}

//contador = 0;  
