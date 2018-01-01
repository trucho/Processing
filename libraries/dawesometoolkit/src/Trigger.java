package dawesometoolkit;
import processing.core.*;
import processing.event.*;
import processing.core.PGraphics;
import java.lang.reflect.InvocationTargetException; 
import java.lang.reflect.Method;

public class Trigger implements PConstants {
  PApplet parent;
  int start;
  int interval;
  String methodToCall;
  boolean shouldLoop = false;

  public Trigger(PApplet parent){
    this.parent = parent;
  }

/**
Set the trigger
@param interval number of milliseconds to wait before the method is triggered
@param methodToCall a string defining the method name to call
@param shouldLoop a boolean indicating whether the trigger should loop
 */

  public void setTrigger(int interval, String methodToCall,boolean shouldLoop){
    this.interval = interval;
    this.methodToCall = methodToCall;
    this.shouldLoop = shouldLoop;
    this.start = parent.millis();
  }

  public void update(){
    int m = parent.millis();
    if (m >= start+interval && methodToCall!=""){
      try {
        Method method = parent.getClass().getMethod(methodToCall);
        method.invoke(parent);  
      } catch (Exception e) {
        parent.println("e: "+e);
      }
      if (shouldLoop){
        start = parent.millis();
      }else{
        methodToCall = "";
      }

    }
  }

}
