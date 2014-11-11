import "dart:html";
import "dart:math" as math;

CanvasElement subCanvas, mainCanvas;
CanvasRenderingContext2D subCtx, mainCtx;
int subset, mainset;

void main() {
  DivElement div = querySelector("#app");
  
  subCanvas = new CanvasElement();
  subCanvas..width = 800
           ..height = 130;
  div.append(subCanvas);
  subCtx = subCanvas.context2D;
  
  mainCanvas = new CanvasElement();
  mainCanvas..width = 800
            ..height = 470;
  div.append(mainCanvas);
  mainCtx = mainCanvas.context2D;
  
  
  subset = 5;
  drawSubSlide("compiler_01");
  
  mainset = 10;
  drawMainCanvas("compiler_01");
  
  subCanvas.onClick.listen(clickCanvas);
  subCanvas.onMouseWheel.listen(wheelSubCanvas);
}

void drawSubSlide(String path){
  if(subset > 5) subset = 5;
  if(subset < -1000) subset = -1000;
  drawRect(subCtx, 0, 0, 800, 130);
  for(int i = 0; i < 9; i++){
    ImageElement image = new ImageElement();
    image.src = path + "/${i}.png";
    image.onLoad.listen((e){subCtx.drawImageScaled(image, subset + 165 * i, 5, 160, 120);});
  }
}

void drawMainCanvas(String path){
  if(mainset > 10) mainset = 10;
  if(mainset < -1000) mainset = -1000;
  // drawRect(mainCtx, 0, 0, 800, 670);
  for(int i = 0; i < 9; i++){
    ImageElement image = new ImageElement();
    image.src = path + "/${i}.png";;
    image.onLoad.listen((e){mainCtx.drawImageScaled(image, mainset + 600 * i, 10, 600, 450);});
  }
}

void drawImage(String src, int x, int y, int width, int height){
}

void clickCanvas(MouseEvent e){
  int x = e.offset.x, y = e.offset.y;
  print("click canvas ($x, $y)");
  // drawRect(x-4, y-4, 9, 9);
}

void dragCanvas(MouseEvent e){
  print("drag canvas (" + e.offset.x + ", " + e.client.y + ")");
}

void wheelSubCanvas(WheelEvent e){
  double dx = e.deltaX, dy = e.deltaY;
  print("scroll ($dx , $dy)");
  subset += dy.toInt();
  drawSubSlide("compiler_01");
}

void drawRect(CanvasRenderingContext2D context, int x, int y, int width, int height){
  print("drawRect $x $y");
  context..beginPath()
     ..rect(x, y, width, height)
     ..fillStyle = "blue"
     ..strokeStyle = "red"
     ..fill();
}
