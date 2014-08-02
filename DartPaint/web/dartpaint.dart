import 'dart:core';
import 'dart:html';
import 'dart:js';

void main() {
  Controller controller = new Controller();
}
class Controller {
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  var clientRect;
  int x;
  int y;
  int lx;
  int ly;
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
    newDraw();
    this.isHolding = false;
    this.isErasing = false;
    querySelector("#tb1_new").onClick.listen((e){newDraw();});
    querySelector("#tb1_save").onClick.listen((e){saveDraw();});
    ctx.canvas.onMouseMove.listen((e){
      update(e);
    });
    document.onMouseDown.listen((e){startHolding();});
    document.onMouseUp.listen((e){stopHolding();});
   
  }
  startHolding(){
    this.isHolding=true;
    this.lx = this.x;
    this.ly = this.y;
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
      this.ctx.strokeStyle= this.colorInput.value;
      this.ctx.lineWidth= this.lineWidthInput.valueAsNumber;
      this.ctx.lineCap='round';
      this.ctx.beginPath();
      this.ctx.moveTo((this.lx).toDouble(),(this.ly).toDouble());
      this.ctx.lineTo((this.x).toDouble(),(this.y).toDouble());
      this.ctx.stroke();
      this.ctx.closePath();
      this.lx = this.x;
      this.ly = this.y;
    }
    else{
    }
  }
  newDraw(){
    x = 800;
    y = 800;
    this.canvas = querySelector("#paintArea");
    querySelector("#pictureSize").value = x.toString()+"x"+y.toString();
    this.canvas.width = x;
    this.canvas.height = y;
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