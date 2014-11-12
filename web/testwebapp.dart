import "dart:html";
import "dart:math" as math;

CanvasElement subCanvas, mainCanvas;
CanvasRenderingContext2D subCtx, mainCtx;
int subset, mainset;
List list = new List();
String path;
int w = 800, h = 600, subh = 130, mainh = h - subh;
String segmentStr = "1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 11 0 ";
List<String> segment;
List<int> slidex = new List<int>();

void main() {
  DivElement div = querySelector("#app");
  
  // メインキャンバスの初期化
  mainCanvas = new CanvasElement();
  mainCanvas..width = w
            ..height = mainh;
  div.append(mainCanvas);
  mainCtx = mainCanvas.context2D;
  
  
  // サブキャンバスの初期化
  subCanvas = new CanvasElement();
  subCanvas..width = w
           ..height = subh;
  div.append(subCanvas);
  subCtx = subCanvas.context2D;
  
  // スライドのイメージを全部読み込む
  path = "compiler_01";
  imageLoad(0, 10);
}

void imageLoad(int i, int n){
  if(i > n){
    imageLoaded();
    return;
  }
  ImageElement image = new ImageElement();
  image.src = path + "/${i}.png";
  list.add(image);
  image.onLoad.listen((e){imageLoad(i+1, n);});
}

// スライドイメージ読み込み完了
void imageLoaded(){
  // セグメント情報の取得
  segment = segmentStr.split(" ");
  segment.forEach((String s){
    print(s);
  });
  
  mainset = 10;
  subset = 5;
  
  drawMainCanvas();
  mainCanvas.onMouseWheel.listen(wheelMainCanvas);
  
  drawSubCanvas();
  subCanvas.onClick.listen(clickSubCanvas);
  subCanvas.onMouseWheel.listen(wheelSubCanvas);
}

void drawSubCanvas(){
  // 画面から飛び出してしまわないように 
  if(subset > 0) subset = 0;
  if(subset < -1500) subset = -1500; // FIXME: ここは決め打ち
  
  // 画面クリア
  subCtx.clearRect(0, 0, w, subh);
  
  // 現在の画面位置表示
  // drawRect(subCtx, subset - 5 - mainset * subh ~/ mainh, 0, w * subh ~/ mainh, subh);
  
  // 背景(セグメント)の表示
  // drawSegmentRect(subCtx, subset, 0, 170, subh);
  int segl = 0, segw = 5;
  for(int i = 0; i < segment.length; i++){
    if(segment[i] == "") break;
    int p = int.parse(segment[i]);
    print("segment$p");
    if(p == 0){
      print("$segl $segw");
      drawSegmentRect(subCtx, subset + segl, 0, segw, subh);
      segl = segl + segw + 5;
      segw = 5;
    }else{
      segw += 165;
    }
  }
  
  print("表示");
  int sleft = subset + 5;
  for(int i = 0; i < segment.length; i++){
    if(segment[i] == "") return;
    print("表示");
    int p = int.parse(segment[i]);
    if(p != 0){
      subCtx.drawImageScaled(list[p-1], sleft, 5, 160, 120);
      slidex.add(sleft);
      sleft += 165;
    }else{
      sleft += 10;
    }
  }
}

void drawSegmentRect(CanvasRenderingContext2D ctx, int x, int y, int width, int height){
  print("drawRect $x $y");
  ctx..beginPath()
     ..rect(x, y, width, height)
     ..fillStyle = "#ff0000"
     ..fill();

  ctx..beginPath()
     ..rect(x+2, y+2, width-4, height-4)
     ..fillStyle = "#ffcccc"
     ..fill();
}

void drawMainCanvas(){
  if(mainset > 10) mainset = 10;
  if(mainset < -6000) mainset = -6000;
  mainCtx.clearRect(0, 0, w, mainh);
  for(int i = 0; i < 11; i++){
    mainCtx.drawImageScaled(list[i], mainset + 610 * i, 10, 600, 450);
  }
}

void clickSubCanvas(MouseEvent e){
  int x = e.offset.x, y = e.offset.y;
  print("click canvas ($x, $y)");
  int page;
  for(page = 0; page < 11; page++){
    if(slidex[page] > x - subset) break;
  }
  page--;
  mainset = - 610 * page;
  drawMainCanvas();
}

void dragCanvas(MouseEvent e){
  print("drag canvas (" + e.offset.x + ", " + e.client.y + ")");
}

void wheelSubCanvas(WheelEvent e){
  double dx = e.deltaX, dy = e.deltaY;
  print("scroll ($dx , $dy)");
  subset += dy.toInt();
  drawSubCanvas();
}

void wheelMainCanvas(WheelEvent e){
  double dx = e.deltaX, dy = e.deltaY;
  print("scroll ($dx , $dy)");
  mainset += dy.toInt();
  drawMainCanvas();
}

void drawRect(CanvasRenderingContext2D ctx, int x, int y, int width, int height){
  print("drawRect $x $y");
  ctx..beginPath()
     ..rect(x, y, width, height)
     ..fillStyle = "red"
     ..fill();
}
