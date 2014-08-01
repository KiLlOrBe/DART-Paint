import 'dart:core';
import 'dart:html';
import 'dart:math';

void main() {
  Controller controller = new Controller();
}
class Controller {
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  var clientRect;
  int x;
  int y;
  int canvasWidth;
  int canvasHeight;
  var canvasData;
  bool isHolding;
  bool isErasing;
  String color;
  InputElement colorInput;
  InputElement lineWidthInput;


  Controller() {
    this.colorInput = querySelector("#tb2_color");
    this.lineWidthInput = querySelector("#tb2_lineWidth");
    newDraw(800,800);
    this.isHolding = false;
    this.isErasing = false;
    querySelector("#tb1_new").onClick.listen((e){newDraw(800,800);});
    querySelector("#tb1_save").onClick.listen((e){saveDraw();});
    ctx.canvas.onMouseMove.listen((e){
      update(e);
    });
    document.onMouseDown.listen((e){startHolding();});
    document.onMouseUp.listen((e){stopHolding();});
   
  }
  startHolding(){
    this.isHolding=true;
  }
  stopHolding(){
    this.isHolding=false;
  }
  update(e){
    this.clientRect = ctx.canvas.getBoundingClientRect();
    this.x = (e.clientX - clientRect.left).round();
    this.y = (e.clientY - clientRect.top).round();
    if(this.x<1){
      this.x = 1;
    }
    if(this.x>this.canvasWidth){
      this.x = this.canvasWidth;
    }
    if(this.y<1){
      this.y = 1;
    }
    if(this.y>this.canvasHeight){
      this.y = this.canvasHeight;
    }
    if(this.isHolding){
      if(this.isErasing){
        
      }
      else{
        draw(this.x, this.y);
      }
    }
    querySelector("#db_xPos").text = this.x.toString();
    querySelector("#db_yPos").text = this.y.toString();
  }
  draw (x, y) {
    if(this.isHolding){
      this.ctx.fillStyle = this.colorInput.value;
      this.ctx.beginPath();
      this.ctx.arc(x, y, this.lineWidthInput.valueAsNumber, 0, PI*2, true); 
      this.ctx.closePath();
      this.ctx.fill();
    }
    else{
    }
  }
  newDraw(x,y){
    this.canvas = querySelector("#paintArea");
    this.ctx = canvas.context2D;
    this.ctx.clearRect(0,0,x,y);
    this.canvasWidth = canvas.width;
    this.canvasHeight = canvas.height;
    this.canvasData = ctx.getImageData(0, 0, this.canvasWidth, this.canvasHeight);
  }
  saveDraw(){
    window.location.href = canvas.toDataUrl("image/png").replaceFirst("image/png", "image/octet-stream");
  }
}