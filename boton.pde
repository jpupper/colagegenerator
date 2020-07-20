class Boton {

  color mouseover;
  color mouseclick;
  color standart;

  float x, y;
  float w, h;

  String text;

  Boolean click;
  Boton(float _x, float _y, float _w, float _h, String _text) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    standart = color(0, 100, 0);
    mouseover= color(150, 200, 150);
    mouseclick = color(200, 255, 200);

    text = _text;
    click = false;
  }
  void display() {
       
    cargar.click = false;
    rectMode(CENTER);
   
    if (isMouseOver()) {
      if (mousePressed) {
        fill(mouseclick);
      } else {
        fill(mouseover);
      }
    } else {
      fill(standart);
    }

    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    textSize(18);
    fill(255);
    text(text, x, y);
 
  }

  boolean isMouseOver() {
    if (mouseX > x-w/2 && mouseX < x + w/2 && mouseY > y -h/2 && mouseY < y +h/2) {
      return true;
    } else {
      return false;
    }
  }
  boolean click() {
    if (!click && mousePressed && isMouseOver()) {
      click = true;
      return true;
    } else {
      return false;
    }
  }
}