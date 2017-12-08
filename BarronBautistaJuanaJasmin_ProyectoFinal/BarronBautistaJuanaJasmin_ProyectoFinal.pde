int filas = 20;
int columnas = 20;
int snake = 20;
int estado = 1;
int score=0;
ArrayList <Integer> posX = new ArrayList<Integer>();
ArrayList <Integer> posY = new ArrayList<Integer>();
ArrayList <Figura> figuras;
float lado = 15;
float altura = sqrt(sq(lado) - sq(lado/2f));
float apotema = lado/ 2*tan(PI/6f);
float radio = altura - apotema;
float delta = 0;
PImage photo;
int dir=3;  //0=arriba, 1=abajo, 2= izq., 3=derecha
int [] dx = {0,0,-1,1};
int [] dy = {-1,1,0,0};

int appleX;
int appleY;

//boolean gameOver=true;

void setup () {
  size (400,400,P3D);
  frameRate(10); //velocidad
  posX.add(10);
  posY.add(10);
  appleX = (int) random (0,20);
  appleY = (int) random (0,20);
  //gameOver=true;
  estado=1;
  score=0;
  figuras = new ArrayList<Figura>();
for (float j = radio; j<=height; j+= altura){
int paso = (round((j - radio)/altura));
float offset =0;
if (paso%2 == 0){
offset = lado/2f;
}
for (float i =-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j,lado,0));
}
for (float i =lado/2f-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j-apotema,lado,PI));
}
}
  
}

void draw (){
  switch(estado){
    case 1:
    {
background(255,30);


noStroke();
fill(0);
for (Figura f: figuras){
f.display();
}
textSize(50);
fill(255,0,255);
textAlign(CENTER, BOTTOM);
text("SNAKE",200,70);

textSize(20);
fill(#ea62d0);
textAlign(CENTER, BOTTOM);
text("Instrucción:",200,150);

textSize(20);
fill(#ea62d0);
textAlign(CENTER, BOTTOM);
text("Movimiento: con flechas",200,200);

    textSize(20);
    fill (random(255),120,200);
    textAlign(LEFT, BOTTOM);
    text ("Presiona una tecla para iniciar...",45,350);
    if(keyPressed==true)
    estado++;
    break;
  }
    //}
    case 2:
  {
  //else
  fill (0);
  background(0);
  for (int i = 0; i < filas; i++) {
    line (0,i*snake,width,i*snake);
  }
  for (int j = 0; j < columnas; j++) {
    line (j*snake,0,j*snake,height);
  }
  posX.add(0,posX.get(0)+dx[dir]);
  posY.add(0,posY.get(0)+dy[dir]);
  posX.remove(posX.size()-1);
  posY.remove(posY.size()-1);
  
  if ( ( posX.get(0)<0 )||( posX.get(0)>filas-1 )||
  ( posY.get(0)<0 )||( posY.get(0)>columnas-1 ) ) {
    //gameOver=false;
    estado++;
  }
  //comer
  if ((posX.get(0)==appleX)&&(posY.get(0)==appleY)){
  appleX = (int) random (0,20);
  appleY = (int) random (0,20);
  posX.add(posX.get(posX.size()-1));
  posY.add(posY.get(posY.size()-1));
  score++;
  }
  fill (#f4adb1);
  rect (appleX*snake,appleY*snake,snake,snake);
  fill(#ea62d0);
  for (int i = 0; i < posX.size(); i++) {
  rect (posX.get(i)*snake,posY.get(i)*snake,snake,snake);
  }


 keyPressed();
  if(key==CODED){
  /*if (key=='w')dir=0; //direcciones
  if (key=='s')dir=1;
  if (key=='a')dir=2;
  if (key=='d')dir=3;*/
    if (keyCode==UP)dir=0; //direcciones
  if (keyCode==DOWN)dir=1;
  if (keyCode==LEFT)dir=2;
  if (keyCode==RIGHT)dir=3;
  }
break;
  }
case 3:
    {
   // gameOver=false;
  posX.clear();
  posY.clear();
  posX.add(10);
  posY.add(10);
  appleX = (int) random (0,20);
  appleY = (int) random (0,20);
  text ("JUEGO TERMINADO SCORE=",50,height/2);
  text(score,200,230);
  text("Presione una tecla para volver al inicio",20,250);
    if(keyPressed==true)
estado=1;
break;
  }
}
}

interface Figura
{
float perimetro ();
float area ();
void display();
}
class Triangulo implements Figura
{
float x,y,l,rc,ri,a,a1,deltax,deltay,h,b,rota;
Triangulo (float x_,float y_,float l_, float rota_)
{
x=x_;
y=y_;
l=l_;
rc=(l*sqrt(3))/3f;
b=l;
a1=TWO_PI/3;
rota = rota_;
}
float perimetro ()
{
return l*3;
}
float area ()
{
return ((l*l)*(sqrt(3)))/4; //4
}
void display()
{
fill (random(150,240)); //100,240
pushMatrix();
translate(x,y);
rotate(HALF_PI - PI/5 + rota); //3
beginShape();
for(float a = 0;a<TWO_PI;a+=a1)
{
deltax=cos(a)*rc;
deltay=sin(a)*rc;
vertex(deltax,deltay);
}
endShape(CLOSE);
popMatrix();
}
}