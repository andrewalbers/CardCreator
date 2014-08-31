PGraphics cardMain;
PGraphics fontPlacer;
PImage cardPic;
PFont font;
Table content;
Table template;
ArrayList<String> elements;

void setup(){
  getCardValues();
  cardMain = createGraphics(675,1050);
  noLoop();
}

void draw(){
  createAllCards();
}

void createCard(TableRow conRow) {
  cardMain.clear();
  for(int i = 0; i < elements.size(); i++){
    if(elements.get(i).indexOf("Img") != -1){
      drawImg(conRow.getString(elements.get(i)), template.getRow(i));
    }
    else if(elements.get(i).indexOf("Text") != -1){
      drawText(conRow.getString(elements.get(i)), template.getRow(i));
    }
  }
  saveCard(conRow.getString("Name"));
}

void createAllCards() {
  println("Creating All Cards");
  for (TableRow conRow : content.rows()) {
    createCard(conRow);
  }
}

void saveCard(String name) {
  String saveString = "card_" + name + ".tif";
  cardMain.save(saveString);
}

void drawText(String t, TableRow row) {
  int x = int(row.getString("x"));
  int y = int(row.getString("y"));
  int w = int(row.getString("w"));
  int h = int(row.getString("h"));
  float hSquish = float(row.getString("hSquish"));
  if(Float.isNaN(hSquish)) {
    hSquish = 1;
  }
  String text = t;
  font = loadFont(row.getString("font"));
  fontPlacer = createGraphics(int(w/hSquish),h);
  fontPlacer.beginDraw();
  fontPlacer.textFont(font);
  fontPlacer.textSize(int(row.getString("size")));
  fontPlacer.textAlign(LEFT,TOP);
  fontPlacer.fill(255,255,255);
  fontPlacer.text(text,0,0,int(w/hSquish),h);
  fontPlacer.endDraw();
  cardMain.image(fontPlacer.get(),x,y,w,h);
}

void drawImg(String filename, TableRow row) {
  if(filename.length() != 0){
    cardPic = loadImage(filename);
    int x = int(row.getString("x"));
    int y = int(row.getString("y"));
    int w = int(row.getString("w"));
    int h = int(row.getString("h"));
    cardMain.image(cardPic,x,y,w,h);
  }
}

void getCardValues(){
  elements = new ArrayList<String>();
  template = loadTable("template.csv", "header");
  for (TableRow row : template.rows()) {
    elements.add(row.getString("element"));
  }
  content = loadTable("content.csv", "header");
  println(elements);
}

