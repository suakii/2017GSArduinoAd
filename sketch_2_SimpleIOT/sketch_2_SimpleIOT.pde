

import processing.net.*;
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;


String SERVER = "api.thingspeak.com"; // MyRobots or ThingSpeak
String APIKEY = "GFYKT9IUN7C0VFQB"; // your channel's API key

int FREQ = 10; // update every 30s

Client c;

int savedTime;
int totalTime = 5000;


String[] fields = { "field1"};
float[] datum = new float[1];


void setup() {
  size(200, 200);
  frameRate(60);
  println(Serial.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
}

int i = 100;
int time5 = 0;
void draw() {

  if (c != null) {
    if (c.available() > 0) {
      //println(c.readString());
      
    }
  }
  int passedTime = millis() - savedTime;
  if (passedTime > totalTime) {
    time5 += 5;
    sendDatum(fields, datum);
    savedTime = millis();
    datum[0] = arduino.analogRead(0); 
    background(255);
    fill(0);
    text(time5 + " seconds have passed!", 10, 50);
    text("send data  " + datum[0], 10,80);
  }
}

void sendDatum(String fields[], float num[]) {
  
  String url = ("GET /update?api_key="+APIKEY);
  StringBuffer sb = new StringBuffer(url);
  
  for(int i=0; i<fields.length; i++) {
    String s = ("&"+fields[i]+"="+ num[i]);
    sb.append(s);
  }
  
  sb.append(" HTTP/1.1\n");
  
  String finalurl = sb.toString();
  print("sending data: " + finalurl);
  
  c = new Client(this, SERVER, 80);
  
  if (c != null) {
        c.write(finalurl);
        c.write("Host: suakii.com\n\n");
  }
}