import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import dawesometoolkit.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class iwanthue extends PApplet {

/*
Creates a color palette of 12 colors using iWantHue colors
*/



DawesomeToolkit dawesome;
ArrayList<PVector> grid;
int dotSize = 10;
float gridWidth;
float gridHeight;
ArrayList<Integer> colors;

public void setup(){
  
  
  rectMode(CENTER);
  dawesome = new DawesomeToolkit(this);
  grid = dawesome.gridLayout(12,20,20,20);
  PVector p = dawesome.getMaxValueFromListOfPVectors(grid);
  gridWidth = p.x-dotSize;
  gridHeight = p.y-dotSize;
  colors = dawesome.iWantHue();
}

public void draw(){
  
  background(20);
  fill(0);
  noStroke();
  translate(width/2-gridWidth/2,height/2-gridHeight/2);
  for (int i=0; i < grid.size(); i++) {
    PVector p = grid.get(i);
    int c = colors.get(i);
    fill(c);
    rect(p.x,p.y,dotSize,dotSize*5);
  }
  
}
  public void settings() {  size(600,600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "iwanthue" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
