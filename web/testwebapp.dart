import "dart:html";
import "dart:math" as math;

CanvasElement canvas;
CanvasRenderingContext2D ctx;

void main() {
  querySelector("#status").innerHtml = "Hello Dart!";
  
  DivElement div = querySelector("#app");
  
  canvas = new CanvasElement();
  canvas..width = 800
        ..height = 600;
  ctx = canvas.context2D;
  
  div.append(canvas);
  
  for(int i = 0; i < 5; i++){
    String imageString = "compiler_01/${i}.png";
    print(imageString);
    drawImage(imageString, 5 + 125 * i, 20, 120, 80);
  }
  
  drawRect(10, 10, 120, 80);
  drawRect(200, 200, 120, 80);
  
  canvas.addEventListener(canvas.onClick, clickCanvas);
}

void drawImage(String src, int x, int y, int width, int height){
  print(src);
  ImageElement image = new ImageElement();
  image.src = src;
  // イメージが読み込めてから描画する
  image.onLoad.listen((e){ctx.drawImageScaled(image, x, y, width, height);});
}

void clickCanvas(MouseEvent e){
  System.out.ptintln("clicl canvas");
}

void drawRect(int x, int y, int width, int height){
  ctx..beginPath()
     ..rect(x, x, width, height)
     ..fillStyle = "blue"
     ..strokeStyle = "red"
     ..fill();
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
