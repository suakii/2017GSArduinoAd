
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

XML res;
String sunrise, sunset;
//영통동
String source="http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=%EC%98%81%ED%86%B5%EB%8F%99&dataTerm=month&pageNo=1&numOfRows=10&ServiceKey=";
String apiKey="8n%2Bl3gJJn6o2pN%2BwlFHj6i9anqdFAjpD97TWoC%2FeV4zynQPsgQ3TCxhgua6DYylpMGG%2Fn1%2BH7rX%2Fya6uDkcItA%3D%3D";

int servoValue;
void setup() {
  size(500,500);
  background(255);
  fill(0);
  
  res = loadXML(source+apiKey);
  //println(res);
  //println(res.getName());
  //println(res.listChildren());
  
  XML[] children = res.getChildren("body");
  XML res2 = children[0];
  
  XML[] answer = res.getChildren("body")[0].getChildren("items")[0].getChildren("item");
  println(answer.length);
  
  int value = -10; 
  boolean done = false;
  for (int i = 0; i < answer.length; i++) {
    XML time = answer[i].getChild("dataTime");
    XML pm10Value = answer[i].getChild("pm10Value");
    text("time : " + time.getContent(), 10, i*20+30);
    text(" pm10Value : " + pm10Value.getContent(), 250, i*20+30);
    
    print("time : " + time.getContent());
    println(" pm10Value : " + pm10Value.getContent());
   
    
    int temp = int(pm10Value.getContent());
    if (temp > 0 && done == false) {
      servoValue = temp;
      done = true;
    }
       
  }
  println("Value = " + servoValue);
  println(Arduino.list());
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(7, Arduino.SERVO);
  
  text(" Servo Value : " + servoValue, 20, 300);

  
}
  
void draw() {

  arduino.servoWrite(7, servoValue);
  
  
}