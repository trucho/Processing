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

public class Colorsampling extends PApplet {

/*
Example of using the ColorSampler class to map an index to image strip. Useful
for generating color palettes.
*/


DawesomeToolkit dawesome;
ColorSampler colorSampler;
ArrayList<PVector> grid;



public void setup(){
	
	
	dawesome = new DawesomeToolkit(this);
	colorSampler = new ColorSampler(this,"colorstrip.png");
	grid = dawesome.gridLayout(100,20,20,10);
  grid = dawesome.centerPVectors(grid);


}

public void draw() {

	background(20);
  noStroke();
  translate(width/2,height/2);
  for (int i=0; i < grid.size(); i++){
    PVector p = grid.get(i);
    float index = map(i, 0, grid.size()-1, 0, 1.0f);
    int c = colorSampler.getColorAt(index);
    fill(c);
    ellipse(p.x,p.y,15,15);
  }

}

  public void settings() { 	size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Colorsampling" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
