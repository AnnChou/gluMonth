/*
Ann Chou
*/
public class Cell {
  int i; //row  -> y
  int j;  //col -> x
  color cellColor;
  
  Cell (int i, int j, color cellColor) {
    this.i = i;
    this.j = j;
    this.cellColor = cellColor;
  }
  
 // cell & table object?
  
  void draw() {
      pushStyle();
      fill(cellColor);
      //rect(j * CELL_SIZE, i * CELL_SIZE, CELL_SIZE-1, CELL_SIZE-1);
      ARect tempRect = new ARect(j * CELL_SIZE, i * CELL_SIZE, CELL_SIZE-1, CELL_SIZE-1);
      tempRect.draw();
      popStyle();
  }
  

}