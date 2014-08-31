/**
 * CardCreator.pde
 *
 * This script aids in playing card design by using a customizable card 
 * template, building each card file with information provided in two
 * spreadsheets.
 *
 * @author  Andrew Albers
 * @version 1.0
 * @since 2014-08-30
 */
 
PGraphics cardMain;
PGraphics fontPlacer;
PImage cardPic;
PFont font;
Table content;
Table template;
ArrayList<String> elements;

/**
 * Reads csv files, defines cards as 675x1050 px (bridge card at 300 dpi)
 * TODO: Let user choose other card sizes to generate
 * TODO: Add bleed area to card sizes for printing.
 */
void setup(){
  getCardValues();
  cardMain = createGraphics(675,1050);
  noLoop();
}

/**
 * Kicks off card creation safter setup.
 */
void draw(){
  createAllCards();
}

/**
 * Passes each row in the content.csv file to createCard()
 */
void createAllCards() {
  println("Creating All Cards");
  for (TableRow conRow : content.rows()) {
    createCard(conRow);
  }
  println("Done. Check the CardCreator directory for updated cards.");
}

/**
 * Builds a single card, placing each element in the order it appears in
 * template.csv. Saves the finished image with the filename given under 
 * "Name" in the content.csv file.
 * 
 * @param conRow a row in the user-created content.csv file
 */
void createCard(TableRow conRow) {
  cardMain.clear();
  for(int i = 0; i < elements.size(); i++){
    //calls drawImg() if "Img" is in element name
    if(elements.get(i).indexOf("Img") != -1){
      drawImg(conRow.getString(elements.get(i)), template.getRow(i));
    }
    //calls drawText() if "Text" is in element name
    else if(elements.get(i).indexOf("Text") != -1){
      drawText(conRow.getString(elements.get(i)), template.getRow(i));
    }
  }
  saveCard(conRow.getString("saveFile"));
}

/**
 * 
 */
void saveCard(String filename){
  println("   Saving ", filename);
  cardMain.save(filename);
}

/**
 * Draws text given a text string, an x and y position,
 * a width, height, and font. Optionally it will also squish
 * the text given an hSquish (horizontal squish percentage).
 * 
 * @param t text to print
 * @param row template.csv attributes for this text element
 */
void drawText(String t, TableRow row) {
  int x = int(row.getString("x"));
  int y = int(row.getString("y"));
  int w = int(row.getString("w"));
  int h = int(row.getString("h"));
  float hSquish = float(row.getString("hSquish"));
  if(Float.isNaN(hSquish) || hSquish <= 0) {
    hSquish = 1; //set hSquish to 1 if undefined or <= 0
  }
  String text = t;
  font = loadFont(row.getString("font"));
  fontPlacer = createGraphics(int(w/hSquish),h);
  fontPlacer.beginDraw();
  fontPlacer.textFont(font);
  fontPlacer.textSize(int(row.getString("size")));
  fontPlacer.textAlign(LEFT,TOP);
  fontPlacer.fill(255,255,255);
  //provide extra horizontal space for text if 0 < hSquish < 1...
  fontPlacer.text(text,0,0,int(w/hSquish),h);
  fontPlacer.endDraw();
  //... and then compresses to the stated width
  cardMain.image(fontPlacer.get(),x,y,w,h);
}

/**
 * Draws an image given a filename, an x and y position,
 * a width, and height.
 *
 * @param filename the image file to draw
 * @param row template.csv attributes for this image element
 */
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

/**
 * Reads template.csv and content.csv, stores their values in
 * two tables: template and content.
 *
 * TODO: Allow multiple template.csv/content.csv files to be
 *       read. ie generate landscape and portrait-formatted 
 *       cards at the same time
 */
void getCardValues(){
  elements = new ArrayList<String>();
  template = loadTable("template.csv", "header");
  for (TableRow row : template.rows()) {
    elements.add(row.getString("element"));
  }
  content = loadTable("content.csv", "header");
}

