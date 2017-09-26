
//color picker
import javax.swing.JColorChooser;
import java.awt.Color;

import processing.serial.*;

import cc.arduino.*;
import controlP5.*;
Arduino arduino;



color off = color(4, 79, 111);
color on = color(84, 145, 158);

int[] values = { Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW };


ControlP5 cp5;
int myColorBackground = color(0,0,0);
int knobValue = 100;
Knob knobR;
Knob knobG;
Knob knobB;

int r, g, b;
int redPin = 9;
int greenPin = 10;
int bluePin = 11;

//color picker
Color selectColor;

boolean isFirst = true;
void setup() {
  size(700, 600);
  
  println(Arduino.list());
  
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  
  arduino.pinMode(9, Arduino.OUTPUT);
  smooth();
  noStroke();
  cp5 = new ControlP5(this);
  knobR = cp5.addKnob("knobR")
               .setRange(0,255)
               .setValue(0)
               .setPosition(100,50)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(255, 0, 0))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
  
  knobG = cp5.addKnob("knobG")
               .setRange(0,255)
               .setValue(0)
               .setPosition(100,200)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 255, 0))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
               
   knobB = cp5.addKnob("knobB")
               .setRange(0,255)
               .setValue(0)
               .setPosition(100,350)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 0, 255))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
   cp5.addButton("select")
      .setValue(0)
      .setPosition(100, 500)
      .setSize(100, 50);
    
   
}

void draw() {
  
  fill(0);
  rect(80, 40, 140, 450);
  
  fill(0);
  rect( 400, 200 , 200, 200);
  
  fill(r, g, b);
  rect( 450, 250 , 100, 100);
  
  setColor();
  
}
void knobR(int theValue) {
  r = theValue;
}
void knobG(int theValue) {
  g = theValue;
}
void knobB(int theValue) {
  b = theValue;
}

public void select(int theValue) {
  if (isFirst == false) {
    selectColor  = JColorChooser.showDialog(null,"Java Color Chooser",Color.white);
    if(selectColor!=null) {
      r = selectColor.getRed();
      g = selectColor.getGreen();
      b = selectColor.getBlue();
      knobR.setValue(r);
      knobG.setValue(g);
      knobB.setValue(b);
      
    }
  }
  isFirst = false;
}


void setColor() {
  arduino.analogWrite(redPin, r);
  arduino.analogWrite(greenPin, g);
  arduino.analogWrite(bluePin, b);   
}