class Jpimg {
  PImage img;

  PVector speed;
  PVector pos;
  int activefilter;
  float alpha;
  Jpimg(PImage _img, float _x, float _y,float _minsize, float _maxsize, int _filtro,float _alpha) {
    activefilter = _filtro;
    img = _img.copy();
    pos = new PVector(_x, _y,0);
    speed = new PVector(random(-5, 5), random(-5, 5),random(-5,5));
    int _w = int(random(_minsize, _maxsize));
    int _h = int(_img.height*_w / _img.width);
    //  _img.width;
    //_img.height;
    img.resize(_w, _h);
    alpha = _alpha;
    // w = _w;
    //h = _h;
    // img.resize(int(w),int(h));


    switch (_filtro) {
    case 0:

      break;
    case 1:
      activefilter = THRESHOLD;
      break;
    case 2:
      activefilter = GRAY;
      break;
    case 3 :

      activefilter = OPAQUE;
      break;
    case 4:
      activefilter = INVERT;
      break;
    case 5:
      activefilter = POSTERIZE;
      break;
    case 6:
      activefilter = BLUR;
      break;
    case 7:
      activefilter = ERODE;
      break;
    case 8:
      activefilter = DILATE;
      break;
    }
  }

  void display() {

    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(speed.heading());
   /* if (activefilter > 0) {
      if (activefilter == POSTERIZE) {
        filter(activefilter, 255);
      } else {
        filter(activefilter);
      }
    }*/
    tint(255,alpha);
    image(img, 0, 0);
    popMatrix();
  }
  void update() {
    pos.add(speed);
    checkedges();
  }

  void checkedges() {
    if (pos.x > width ) {
      pos.x = width;
      speed.x *= -1;
    }
    if (pos.x < 0 ) {
      pos.x = 0;
      speed.x *= -1;
    }
    if (pos.y > height ) {
      pos.y = height;
      speed.y *= -1;
    }
    if (pos.y < 0 ) {
      pos.y = 0;
      speed.y *= -1;
    }
  }
}