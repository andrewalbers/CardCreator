PGraphics cardMain;
PGraphics fontPlacer;
PImage cardPic;
PFont font;
Table content;
Table template;
ArrayList<String> items;

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
  for(int i = 0; i < items.size(); i++){
    if(items.get(i).indexOf("Img") != -1){
      drawImg(conRow.getString(items.get(i)), template.getRow(i));
    }
    else if(items.get(i).indexOf("Text") != -1){
      drawText(conRow.getString(items.get(i)), template.getRow(i));
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
  items = new ArrayList<String>();
  template = loadTable("template.csv", "header");
  for (TableRow row : template.rows()) {
    items.add(row.getString("Item"));
  }
  content = loadTable("content.csv", "header");
  println(items);
}

