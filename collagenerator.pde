/*Realizado por Jpupper.
 facebook/Jpupper
 
 METER LAS IMAGENES EN LA CARPETA DATA/IMGS 
 
 //TECLAS :
 B: isbg on;
 a,s: elegir imagen
 c : borrar ultimaimagenpuesta 
 g : show/hide gui
 f : selecionar filtro
 i : mover/parar imagenes
 h : guardarimagen
 r : borrar todas las imagenes
 1-8 : filtros.
 0 : cancelar filtros
 cllick izquierdo : una sola foto;
 click derecho : click de fotos */

import java.io.File;
import java.util.Date;

Boton cargar;
ArrayList<Jpimg> imgs;
PImage [] images;


int Nimgs;

PImage fondo;



int imageselect;
int activefilter;

boolean isbg ;
boolean showgui;
boolean ismoving;
String [] filtros = {"NONE", "THRESHOLD", "GRAY", "OPAQUE", "OPAQUE", "POSTERIZE", "BLUR", "ERODE", "DILATE"};
float activealpha;
void settings() {

  fullScreen(P3D);
  //size(600, 600);
}

void setup() {
  hint(DISABLE_OPTIMIZED_STROKE);
  imageMode(CENTER);
  rectMode(CENTER);
  String path = sketchPath()+ "/data/imgs";
  activefilter = 0;
  imgs = new ArrayList<Jpimg>();
  String[] filenames = listFileNames(path);
  printArray(filenames);

  images = new PImage[filenames.length];
  for (int x=0; x<filenames.length; x++) {

    //String auxpath = filenames[x].substring(filenames[x].length()-4, filenames[x].length());

    images[x] = loadImage("imgs/"+filenames[x]);
  }
  imageselect = 0 ;


  cargar = new Boton(70, 40, 120, 40, "Cargar..");
  Nimgs = 0;
  fondo = loadImage("fondo.png");
  fondo.resize(width, height);
  background(0);
  activealpha = 255;
}

void draw() {
  if (activefilter > 0) {
    if (filternum(activefilter) == POSTERIZE) {
      filter(filternum(activefilter), 200);
    } else {
      filter(filternum(activefilter));
    }
  }

  if (isbg) {
    background(0);
    // background(fondo);
  }


  if (cargar.click()) {
    println("CLICK");
  }
  // println("CARGAR :", cargar.click);
  for (Jpimg p : imgs) {
    p.display();
    if (ismoving) {
      p.update();
    }
  }
  if (mousePressed && mouseButton == RIGHT) {
    imgs.add(new Jpimg(images[imageselect], mouseX, mouseY, 50, 200, activefilter, activealpha));
  }
  if (showgui) {
    gui();
  }
}

int filternum(int _filtro) {

  if (_filtro == 1) {
    return  THRESHOLD;
  }
  if (_filtro == 2) {
    return  GRAY;
  }
  if (_filtro == 3) {
    return  OPAQUE;
  }
  if (_filtro == 4) {
    return  INVERT;
  }
  if (_filtro == 5) {
    return  POSTERIZE;
  }
  if (_filtro == 6) {
    return  BLUR;
  }
  if (_filtro == 7) {
    return  ERODE;
  }
  if (_filtro == 8) {
    return  DILATE;
  }
  return 0;
}
void mousePressed() {
  imgs.add(new Jpimg(images[imageselect], mouseX, mouseY, 50, 200, activefilter, activealpha));
}


void keyPressed() {
  if (key == 'a') {
    println("imageselect", imageselect);
    if (imageselect == images.length-1) {
      imageselect = 0;
    } else {
      imageselect++;
    }
  }
  if (key == 's') {
    println("imageselect", imageselect);
    if (imageselect == 0) {
      imageselect = images.length-1;
    } else {
      imageselect--;
    }
  }
  if (key =='c' && imgs.size() > 0) {
    imgs.remove(imgs.get(imgs.size()-1));
  }
  if (key == 'b') {
    isbg =!isbg;
  }
  if (key == 'g') {
    showgui = !showgui;
  }
  if (key == 'i') {
    ismoving = ! ismoving;
  }
  /*if (key == 'f') {
   activefilter++;
   if (activefilter > filtros.length-1) {
   activefilter=0;
   }
   }*/
  if (key == 'r') {
    imgs.clear();
  }

  if (key == '1') {
    activefilter =1;
  }
  if (key == '2') {

    activefilter =2;
  }
  if (key == '3') {

    activefilter =3;
  }
  if (key == '4') {

    activefilter =4;
  }
  if (key == '5') {

    activefilter =5;
  }
  if (key == '6') {

    activefilter =6;
  }
  if (key == '7') {

    activefilter =7;
  }
  if (key == '8') {

    activefilter =8;
  }
  if (key == '0') {

    activefilter =0;
  }
  if (key == 'h') {
    saveFrame("recordimg/####-collagenerator.jpg");
    println("SAVEFRAME");
  }

  if (key == 'n') {
    activealpha-=10;
  }

  if (key == 'm') {
    activealpha+=10;
  }
  activealpha = constrain(activealpha,0,255);
}

void gui() {

  float guiimagesize = 100;
  float marginx = 40;
  float marginy = 10;
  float marginttext = 25; 
  float x =guiimagesize-guiimagesize/2+marginx;
  float y =guiimagesize-guiimagesize/2+marginy;
  fill(0);
  strokeWeight(2);
  stroke(255, 0, 0);
  rectMode(CENTER);
  rect(x, y, guiimagesize, guiimagesize);
  tint(255,255);
  image(images[imageselect], x, y, guiimagesize, guiimagesize);
  textSize(14);
  textAlign(LEFT);
  fill(255);

  //rect(x-marginttext, y+30, 100, 20);

  rectMode(CORNER);
  fill(0);
  noStroke();
  String filtro = "Filtro :"+filtros[activefilter];
  rect(x+marginttext, y-guiimagesize/2, filtro.length()*10, 20);
  fill(255);
  text(filtro, x+marginttext, y-guiimagesize/2+15);
}


void imagenseleccionada(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    /*img = loadImage(selection.getAbsolutePath());
     img.resize(640, 480);
     imgmuestra = img.copy();*/
    //PImage img;
    //activeimage = loadImage(selection.getAbsolutePath());

    // delay(1500);
    //imgs.add(new Jpimg(activeimage, random(width), random(height), 100, 400));


    // println("Listing all filenames in a directory: ");
  }
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String[] filenames = listFileNames(selection.getAbsolutePath());
    printArray(filenames);
    for (int x=0; x<filenames.length; x++) {
      PImage img;
      img = loadImage(filenames[x]);
      imgs.add(new Jpimg(img, random(width), random(height), 100, 400, activefilter,activealpha));
    }
  }
}