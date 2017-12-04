/*
Ann Chou
*/
class ARect {
  //field
  float rectX; 
  float rectY;  
  float rectH;  //height
  float rectW;  //width
  boolean active;
  
  ARect (float rect1X, float rect1Y, float rectH, float rectW) { //constructor for a rect
    this.rectX = rect1X;
    this.rectY = rect1Y;
    this.rectH = rectH;
    this.rectW = rectW;
    this.active = false;
  }
  
  void draw(){
    //stroke(255);
   // print("aRect draw");
    rect(this.rectX, this.rectY, this.rectW, this.rectH);
  }
  
  boolean isOver (float x, float y)  {
  //boolean isOver (){  //is callled per mouse pressed
                      //note rectMode(CENTER);
  if (mouseX >= this.rectX && mouseX <= this.rectX +this.rectW  && 
      mouseY >= this.rectY && mouseY <= this.rectY + this.rectH ) {
        //this.active = true;
      return true;
    } else {
      //this.active = true;
      return false;
    }
  }
  
}


//void drawRect(float rect1X, float rect1Y, float rectSize){
//  rect(rect1X, rect1Y, rectSize, rectSize);
//}