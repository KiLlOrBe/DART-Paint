import 'dart:core';
import 'dart:html';
import 'dart:math';

class Controller {
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  var clientRect;
  int x;
  int y;
  int canvasWidth;
  int canvasHeight;
  var canvasData;


  Controller() {
    this.canvas = querySelector("#paintArea");
    this.ctx = canvas.context2D;
    this.clientRect = ctx.canvas.getBoundingClientRect();
    this.canvasWidth = canvas.width;
    this.canvasHeight = canvas.height;
    this.canvasData = ctx.getImageData(0, 0, this.canvasWidth, this.canvasHeight);
    ctx.canvas.onMouseMove.listen((e){
      getPos(e);
    });
    ctx.canvas.onClick.listen((e){
      draw(this.x, this.y, 1, 1, 1, 5);
    });
   
  }
  getPos(e){
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
    querySelector("#db_xPos").text = this.x.toString();
    querySelector("#db_yPos").text = this.y.toString();
  }
  draw (x, y, r, g, b, s) {
    this.ctx.fillStyle = "#c82124";
    this.ctx.beginPath();
    this.ctx.arc(x, y, s, 0, PI*2, true); 
    this.ctx.closePath();
    this.ctx.fill();
  }
}