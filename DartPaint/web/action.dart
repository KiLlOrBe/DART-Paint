part of paint;

abstract class Action {
  void perform(Surface s, DrawContext a);
}

class SetColor extends Action {
  Color color;
  
  SetColor (this.color);
  
  perform(Surface s, DrawContext a) {
    a.color = this.color;
  }
  
}

class DrawLine extends Action {
  Point p1, p2;
  
  DrawLine(this.p1, this.p2);
  
  perform(Surface s, DrawContext a) {
    s.drawLine(p1, p2);
  }
  
}