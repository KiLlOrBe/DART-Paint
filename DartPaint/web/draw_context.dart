part of paint;

class DrawContext {
  Color color;
  
  init() => this.color = new Color(0, 0, 0);
  
}

class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);
  
  String getRGBString() => '#$red$green$blue';
}

class Point {
  num x;
  num y;
  
  Point(this.x, this.y);
}