import "dart:html";
import "dart:math" as math;

CanvasElement canvas;
CanvasRenderingContext2D context;

void main() {
  querySelector("#status").innerHtml = "Hello Dart!";
  
  DivElement div = querySelector("#app");
  
  canvas = new CanvasElement();
  canvas..width = 600
        ..height = 400;
  
  div.append(canvas);
  
  drawRect(10, 10, 120, 80);
  drawRect(200, 200, 120, 80);
  
  for(int i = 0; i < 5; i++){
    String imageString = "compiler_01/${i}.png";
    print(imageString);
    drawImage(imageString, 5 + 125 * i, 20, 120, 80);
  }
  /*
  var button = new ButtonElement();
  button.text = "Click Me";
  button.onClick.listen( (e){
    var div = new Element.html("<div> I am a Div Element </div>");
    document.body.children.add(div);
  });
  document.body.children.add(button);
  */
}

void drawImage(String src, int x, int y, int width, int height){
  print(src);
  CanvasRenderingContext2D ctx = canvas.context2D;
  ImageElement image = new ImageElement();
  image.src = src;
  image.onLoad.listen((e){ctx.drawImageScaled(image, x, y, width, height);});
}


void drawRect(int x, int y, int width, int height){
  CanvasRenderingContext2D ctx = canvas.context2D;
  ctx..beginPath()
     ..rect(x, x, width, height)
     ..fillStyle = "blue"
     ..strokeStyle = "red"
     ..fill();
  // div.innerHtml = "";
  // div.append(canvas);
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
