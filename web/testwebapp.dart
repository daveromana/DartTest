import 'dart:html';

void main() {
  querySelector("#status").innerHtml = "Hello Dart!";
  
  var button = new ButtonElement();
  button.text = "Click Me";
  button.onClick.listen( (e){
    var div = new Element.html("<div> I am a Div Element </div>");
    document.body.children.add(div);
  });
  document.body.children.add(button);
  
  querySelector("#sample_text_id")
      ..text = "Click me!"
      ..onClick.listen(reverseText);
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
