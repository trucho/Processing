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

public class Colorsampling2 extends PApplet {

/*
Example of using the ColorSampler class to get an ArrayList with a defined number of colors from a color strip image.
*/


DawesomeToolkit dawesome;
ColorSampler colorSampler;
ArrayList<PVector> grid;
ArrayList<Integer> colors;


public void setup(){
	
	
	dawesome = new DawesomeToolkit(this);
	colorSampler = new ColorSampler(this,"colorstrip.png");
  int amountOfColors = 10;
  colors = colorSampler.getColors(amountOfColors);
	grid = dawesome.gridLayout(10,20,20,10);
  grid = dawesome.centerPVectors(grid);
  

}

public void draw() {

	background(20);
  noStroke();
  translate(width/2,height/2);
  for (int i=0; i < grid.size(); i++){
    PVector p = grid.get(i);
    int c = colors.get(i%colors.size());
    fill(c);
    ellipse(p.x,p.y,15,15);
  }

}

  public void settings() { 	size(600,600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Colorsampling2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
