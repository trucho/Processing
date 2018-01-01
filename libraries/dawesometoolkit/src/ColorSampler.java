package dawesometoolkit;
import processing.core.*;
import processing.event.*;
import processing.core.PGraphics;
import java.util.*;
import java.util.regex.*;
import java.util.Collections;
import java.util.Random;
import static java.lang.Math.*;
import java.awt.Color;

public class ColorSampler implements PConstants {

	PApplet parent;
	PImage img;

	public ColorSampler(PApplet parent, String file) {

		this.parent = parent;
		this.img = parent.loadImage(file);

	}

	public ColorSampler(PApplet parent, PImage img) {

		this.parent = parent;
		this.img = img;

	}

	public final float map(float value, float istart, float istop, float ostart, float ostop) {
    	
    	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));

  	}

 /**
 Uses a float from 0 to 1.0 to get a color at the index mapped across the width of an image  
 @param index a float from 0 to 1.0 
 @return an int with a color value
 */

	public int getColorAt(float index){

		int i = Math.round((img.width-1)*index);
		int c = img.get(i,0);
		return c;

	}
 /**
 Gets  a defined number of colors mapped across an image
 @param amount amount of colors to get
 @return an ArrayList of int colors
 */
	public ArrayList getColors(int amount){
   
    	ArrayList colors = new ArrayList();

    	float step = img.width/amount;

    	for (int i=0; i < Math.floor(img.width/step); i++){
    		float index = map(i*step,0,img.width,0,(float)1.0);
    		int c = getColorAt(index);
    		colors.add(c);
    	} 

    	return colors;

    }





}