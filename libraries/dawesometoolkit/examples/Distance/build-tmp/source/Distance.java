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

public class Distance extends PApplet {

/*
Demonstrates getting the distance between two lat lon coordinates
*/

DawesomeToolkit dawesome;



public void setup(){
	
	
	dawesome = new DawesomeToolkit(this);
	float distanceMiles = dawesome.getDistanceBetweenLatLonInMiles(51.507351f,-0.127758f,40.712784f,-74.005941f);
	float distanceKM = dawesome.getDistanceBetweenLatLonInKilometres(51.507351f,-0.127758f,40.712784f,-74.005941f);

	println("distance from London to New York: "+distanceMiles+" miles");
	println("distance from London to New York: "+distanceKM+" kilometres");

}

public void draw() {

}
  public void settings() { 	size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Distance" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
