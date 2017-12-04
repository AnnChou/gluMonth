import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import controlP5.*;

ControlP5 gui;
float LOWER_NORM, UPPER_NORM;
float userLower, userUpper;
Slider sliderUpper, sliderLower;

int ROWS, COLS, CELL_SIZE;
int numCol;
DataList cellList;  // elements will need to be casted to Cell class type
ArrayList monthList;

Table dataTable;
String dataMonth;
int monthInt;

int pressedDay;
float [][] dayList;

int startMonthInt;
PFont myFont;
ARect [] dayRect;



void setup(){
  size (1530, 870);
  LOWER_NORM = 4;
  UPPER_NORM = 6;
  ROWS = 24;
  COLS = 31; // note numCol which is set for the month.
  CELL_SIZE = 30;
  //println("Canvas Width ", (COLS+1+9+10)* CELL_SIZE, "Height ", (ROWS+1+2+2) * CELL_SIZE);
  //println("part1 Width", (COLS+1)* CELL_SIZE); // part2 width -> 960, 1530
  
  pressedDay = 0;
  //startMonthInt = 11;
  monthList = new ArrayList();
   
  cellList = new DataList (LOWER_NORM, UPPER_NORM); //TODO: to change lower and upper norm
  monthList.add(cellList);
  
  /* load data from csv file */
  dataTable = loadTable("MOCK_DATA11.csv", "header");  
  print("row count", dataTable.getRowCount());
  TableRow firstRow = dataTable.getRow(0);
  
  /* need the month from the first row -- I will show only one month data on a view */
  
   monthInt = parseDateToMonthInt(firstRow.getString("timestamp"));
   numCol = numDayforMonth(monthInt);
   
   dataMonth = parseDateToMonth(firstRow.getString("timestamp"));
   cellList.setMonthName(dataMonth);
   dayList = new float[numCol+1][ROWS]; // 0 is not used for day (numCol)
   
   for (TableRow row: dataTable.rows()) {
     int [] cellPos = new int [2];
     cellPos = parseDateStamp(row.getString("timestamp"));
     int i = cellPos[0]; //i is row
     int j = cellPos[1];  // j is col   

     float data = float(row.getString("glucose"));
     cellList.add( new Cell(i, j, cellList.getColor(data)));
     dayList [j][i] = data;
   }
   
  /* set up Slider for user's custom upper/lower norm */
  gui = new ControlP5(this);
  sliderUpper = new Slider(gui,"Upper");
  sliderUpper.setPosition(1150, height-150).setSize(200, 20).setRange(3.50, 12.00).setValue(UPPER_NORM);
  sliderUpper.setFont(createFont("Verdana",12));
  sliderUpper.setNumberOfTickMarks(11).setSliderMode(Slider.FLEXIBLE);
  sliderUpper.getValueLabel().align(ControlP5.RIGHT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
  sliderUpper.setCaptionLabel("Custom UpperNorm");
  sliderUpper.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
  
  sliderLower = new Slider(gui,"Lower");
  sliderLower.setPosition(1150, height-100).setSize(200, 20).setRange(3.50, 12.00).setValue(LOWER_NORM);
  sliderLower.setFont(createFont("Verdana",12));
  sliderLower.setNumberOfTickMarks(11).setSliderMode(Slider.FLEXIBLE);
  sliderLower.getValueLabel().align(ControlP5.RIGHT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
  sliderLower.setCaptionLabel("Custom LowerNorm");
  sliderLower.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
}

void draw(){
  background(30);
  /* get user-updated lower and upper norm */
  userLower = sliderLower.getValue();
  userUpper = sliderUpper.getValue();
  println(sliderUpper.getValue()," ", sliderLower.getValue());
  
  /* drawing Part 1 - month view on the right */ 
  PFont anon;
  anon = createFont("Anonymous-25.vlw", 25);
  textFont(anon);
  pushStyle();
  fill(0, 102, 153); // for text
  textSize(25);
  textAlign(CENTER);
  String p1Heading = "Blood Glucose for "+ dataMonth;
  text(p1Heading, COLS * CELL_SIZE/2, CELL_SIZE); //current spreadsheet is nov
  
  translate(0 ,CELL_SIZE*2);
  pushMatrix(); // before the heading row
  
  pushStyle();
  fill(0, 102, 153); // for text
  textSize(20);
  textAlign(CENTER);
  
  stroke(0, 102, 153); // for grid line

  // write day on heading row
  text("D ->", CELL_SIZE/2+4, CELL_SIZE); 

  dayRect = new ARect[numCol+1];
    for (int j = 1; j <= numCol; j++) {  // for day
     text(j, (j + 1) * CELL_SIZE + CELL_SIZE/2, CELL_SIZE);
     dayRect[j] = new ARect((j + 1) * CELL_SIZE + CELL_SIZE/2, CELL_SIZE, CELL_SIZE, CELL_SIZE);
     //println (j, (j + 1) * CELL_SIZE + CELL_SIZE/2, CELL_SIZE);
     //vertical grid line
     line((j + 1) * CELL_SIZE, CELL_SIZE, (j + 1) * CELL_SIZE, (ROWS+1) * CELL_SIZE); 
  }
  //line((COLS + 2) * CELL_SIZE, CELL_SIZE, (COLS + 2) * CELL_SIZE, (ROWS+1) * CELL_SIZE);
  line((numCol  + 2) * CELL_SIZE, CELL_SIZE, (numCol + 2) * CELL_SIZE, (ROWS+1) * CELL_SIZE);
    
  // write hour on heading column  
  text("Hr", CELL_SIZE/2-2, (1 + 1) * CELL_SIZE);
  text("|", CELL_SIZE/4, 3 * CELL_SIZE);
  text("v", CELL_SIZE/5, 3.5 * CELL_SIZE);
  for (int i = 0; i <= 23; i++) {
     text(i, CELL_SIZE + CELL_SIZE/2,(i + 2) * CELL_SIZE ); 
     //horizontal grid line
     //line(CELL_SIZE*2, (i + 1) * CELL_SIZE, (COLS+2) * CELL_SIZE, (i + 1) * CELL_SIZE); 
     line(CELL_SIZE*2, (i + 1) * CELL_SIZE, (numCol+2) * CELL_SIZE, (i + 1) * CELL_SIZE); 
  }
  line(CELL_SIZE*2, (ROWS + 1) * CELL_SIZE, (numCol+2) * CELL_SIZE, (ROWS + 1) * CELL_SIZE); 
  popStyle();

  // draw table
  pushMatrix();
  translate(CELL_SIZE,CELL_SIZE);
  for (int i = 0; i < cellList.size(); i++){
      Cell temp = (Cell) cellList.get(i);
      temp.draw();
  }
  popMatrix(); // done draw table
  popMatrix(); // pop for the heading row/col
}