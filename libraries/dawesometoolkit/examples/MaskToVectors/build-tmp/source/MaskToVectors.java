import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Collections; 
import java.util.Random; 
import dawesometoolkit.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MaskToVectors extends PApplet {

// =====================================
// Dawesome Toolkit ====================
// =====================================

// =====================================
// Example using a black & white image 
// to create a list of PVectors
// =====================================





ArrayList<PVector> vectors;
DawesomeToolkit dawesome;
ArrayList<Integer> colors;


public void setup() {
	
	dawesome = new DawesomeToolkit(this);
	dawesome.enableLazySave('s', ".png");
	colors = dawesome.colorSpectrum(16, 100, 50);
	vectors = dawesome.maskToVectors("hello.png");
	vectors = dawesome.centerPVectors(vectors);
	long seed = System.nanoTime();
	Collections.shuffle(vectors, new Random(seed));
	
}

public void draw() {
	background(20);
	translate(width/2, 200);
	int count = 0;
	for (PVector p: vectors){
		if (count%13==0){
			fill(colors.get(count%colors.size()));
			float dotSize = count%15;
			if (count%2==0){
				rect(p.x, p.y, dotSize, dotSize);
			} else {
				ellipse(p.x, p.y, dotSize, dotSize);
			}
		}
		count++;
	}

}

  public void settings() { 	size(600, 600); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "MaskToVectors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
