library MyCanvas;

import "dart:html";
import "dart:math" as math;

class MyCanvas{
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int w, h, offset = 0, innerW = 5000;
  int page;
  String path, segStr;
  List<ImageElement> slideImageList = new List<ImageElement>();
  List<int> segList = new List<int>();
  List<int> sx = new List<int>();
  

  void draw(){}
  
  void wheel(WheelEvent e){
    double dx = e.deltaX, dy = e.deltaY;
    offset += dy.toInt(); 
    draw();
  }
}

class SubCanvas extends MyCanvas{
  MainCanvas mainCanvas;
  SubCanvas(){
    w = 1000;
    h = 130;
    canvas = new CanvasElement();
    canvas..width = w
          ..height = h
          ..onMouseWheel.listen(wheel)
          ..onClick.listen(click);
    context = canvas.context2D;
  }
  
  // イメージをすべて読み込む
  void loadImage(int i){
    if(i >= page){
      parseSegment();
      return;
    }
    ImageElement image = new ImageElement();
    image.src = path + "/${i}.png";
    slideImageList.add(image);
    image.onLoad.listen((e){loadImage(i+1);});
  }
  
  // イメージが読み込まれたら呼ばれる
  void parseSegment(){
    List<String> list = segStr.split(" ");
    for(int i = 0; i < list.length; i++){
      if(list[i] == "") break;
      int s = int.parse(list[i]);
      segList.add(s);
    }
    draw();
  }
  
  // 描画
  void draw(){
    if(offset > 0) offset = 0;
    innerW = 180 * page - 1000;
    if(offset < -innerW) offset = -innerW; 
    // TODO min offset
    
    // 画面のクリア
    context.clearRect(0, 0, w, h);
    
    // セグメントの描画
    int segl = 0, segw = 5;
    for(int i = 0; i < segList.length; i++){
      int p = segList[i];
      if(p == 0){
        drawSegmentRect(offset + segl, 0, segw, h);
        segl = segl + segw + 5;
        segw = 5;
      }else{
        segw += 165;
      }
    }
    
    // スライド画像の描画
    int sleft = offset + 5;
    for(int i = 0; i < segList.length; i++){
      int p = segList[i];
      if(p != 0){
        context.drawImageScaled(slideImageList[p-1], sleft, 5, 160, 120);
        sx.add(sleft);
        sleft += 165;
      }else{
        sleft += 10;
      }
    }
  }
  
  void click(MouseEvent e){
   int x = e.offset.x, y = e.offset.y;
   int page;
   for(page = 0; page < 11; page++){
     if(sx[page] > x - offset) break;
   }
   page--;
   mainCanvas.viewSlidePage(page);
  }
  
  void drawSegmentRect(x, y, width, height){
    context..beginPath()
       ..rect(x, y, width, height)
       ..fillStyle = "#ff0000"
       ..fill();

    context..beginPath()
       ..rect(x+2, y+2, width-4, height-4)
       ..fillStyle = "#ffcccc"
       ..fill();
  }
}

class MainCanvas extends MyCanvas{
  MainCanvas(){
    w = 1000;
    h = 470;
    canvas = new CanvasElement();
    canvas..width = w
          ..height = h
          ..onMouseWheel.listen(wheel);
    context = canvas.context2D;
  }
  
  void loadImage(int i){
    if(i >= page){
      draw();
      return;
    }
    ImageElement image = new ImageElement();
    image.src = path + "/${i}.png";
    slideImageList.add(image);
    image.onLoad.listen((e){loadImage(i+1);});
  }
  
  void draw(){
    if(offset > 0) offset = 0;
    innerW = 10000;
    if(offset < -innerW) offset = -innerW;
    context.clearRect(0, 0, w, h);
    for(int i = 0; i < page; i++){
      context.drawImageScaled(slideImageList[i], offset + 10 + 610 * i, 10, 600, 450);
    }
  }
  
  void viewSlidePage(int p){
    offset = - 610 * p;
    draw();
  }
}