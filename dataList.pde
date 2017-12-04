/*
Ann Chou
*/
public class DataList extends ArrayList{
    //ArrayList of tableRows from a three-columns table
   //  A TableRow object represents a single row of data values, stored in columns, from a table.
  // reference: http://processing.github.io/processing-javadocs/core/
  // fields:
  //String testName;
  //column - ID number of the target column
  //value - value to assign
  String monthName;
  float upperNorm;
  float lowerNorm;
  //float maxVal;
  //float minVal;
  
  //DataList() {
  //}
  
  DataList (float lowerNorm, float upperNorm) {  
     this.lowerNorm = lowerNorm;
     this.upperNorm = upperNorm;
  }
  
  color getColor(float data) {
    //println(this.lowerNorm, "U:", this.upperNorm);
    if (data > this.lowerNorm  && data < this.upperNorm) {  // normal
      return color(0, 0, 255); //blue
    }
    else if (data < this.lowerNorm) {
      return color (225, 225, 90);
    }
    else {  // above upperNorm
      return color(255, 0, 0);//red
    }
  }
   
  void setMonthName(int monthInt){ //accept 1 to 12 only
    this.monthName = textMonth (monthInt);
  }
  
  void setMonthName(String monthText){ //accept 1 to 12 only
    this.monthName = monthText;
  }
}