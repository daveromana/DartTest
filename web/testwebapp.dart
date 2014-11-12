import "dart:html";
import "MyCanvas.dart";
import "dart:math" as math;

CanvasElement subCanvas, mainCanvas;
CanvasRenderingContext2D subCtx, mainCtx;
int subset, mainset;
List list = new List();
String path;
int w = 800, h = 600, subh = 130, mainh = h - subh;
List<String> segment;
List<int> slidex = new List<int>();

void main() {
  DivElement div = querySelector("#app");
  DivElement meta = querySelector("#dir");
  
  // メインキャンバス
  MainCanvas mc = new MainCanvas();
  mc..path = "compiler_02"
    ..page = 36;
  mc.loadImage(0);
  div.append(mc.canvas);
  
  // サブキャンバス
  SubCanvas sc = new SubCanvas();
  sc..segStr = meta.className
    ..path = "compiler_02"
    ..page = 36
    ..mainCanvas = mc;
  
  sc.loadImage(0);
  div.append(sc.canvas);
}