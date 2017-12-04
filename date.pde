/*
Ann Chou
*/
int [] parseDateStamp(String dt) {
     String [] parts = split(dt, ' ');
     String [] dateParts = split(parts[0], '-');
     String [] timeParts = split(parts[1], ':');
     int [] parsed = new int [2];
     int i = int(timeParts[0]); //i is row
     int j = int(dateParts[0]);  // j is col
     parsed[0] = i;
     parsed[1] = j;
     return parsed;     
}

int parseHourToI(String dt) {
     String [] parts = split(dt, ' ');
     //String [] dateParts = split(parts[0], '-');
     String [] timeParts = split(parts[1], ':');
     int i = int(timeParts[0]); //i is row
     //int j = int(dateParts[0]);  // j is col
     return i;     
}

int parseDateToJ(String dt) {
     String [] parts = split(dt, ' ');
     String [] dateParts = split(parts[0], '-');
     //String [] timeParts = split(parts[1], ':');
     //int i = int(timeParts[0]); //i is row
     int j = int(dateParts[0]);  // j is col
     return j;     
}

String parseDateToMonth(String dt) {
     String [] parts = split(dt, ' ');
     String [] dateParts = split(parts[0], '-');
     int monthInt = int(dateParts[1]);  
     return textMonth(monthInt);     
}

int parseDateToMonthInt(String dt) {
     String [] parts = split(dt, ' ');
     String [] dateParts = split(parts[0], '-');
     int monthInt = int(dateParts[1]); 
     return monthInt;
}


String textMonth (int monthInt) {
  switch (monthInt) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "Apr";      
    case 5:
      return "May";
    case 6:
      return "Jun";      
    case 7:
      return "Jun";
    case 8:
      return "Jul";               
    case 9:
      return "Sep";
    case 10:
      return "Oct";      
    case 11:
      return "November";
    case 12:
      return "December"; 
     default:
      return "XXX";  
    }
}

int numDayforMonth (int monthInt) {
  switch (monthInt) {
    case 1:
      return 31;
    case 2:
      return 29;
    case 3:
      return 31;
    case 4:
      return 30;      
    case 5:
      return 31;
    case 6:
      return 30;      
    case 7:
      return 31;
    case 8:
      return 31;               
    case 9:
      return 30;
    case 10:
      return 31;      
    case 11:
      return 30;
    case 12:
      return 31; 
     default:
      return 31;  
    }
}






void currentDate() {
  println(new SimpleDateFormat("MM-dd-yyyy HH:mm").format(new Date())); //--> 12-03-2017 16:35
  String date = "01-01-2017 09:06";
  println(new SimpleDateFormat("MMMM").format(new Date()));  //--> December
  String dayName = new SimpleDateFormat("EEEE").format(new Date());
  text(dayName, 20, 20); //->Sun Dec 03 16:27:07 PST 2017
  println(new Date());
}