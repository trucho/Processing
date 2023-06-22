int sensorPin = 0;    // The potentiometer is connected to analog pin 0
int ledPin = 9;      // The LED is connected to digital pin 9



char START_BYTE = '*'; //three characters used for Serial communication
char DELIMITER = ',';
char END_BYTE = '#';

char signal = '0'; //used to store Serial RX data

// read the input on analog pin 0:
//  int sensorValue = analogRead(A0);

void setup() // this function runs once when the sketch starts up
{
  // Set up the LED pin to be an output:
  pinMode(ledPin, OUTPUT);   

  Serial.begin(9600);//begin Serial communication
  establishContact();
}

void loop(){
  //code below added to listen for Serial comm
  if (Serial.available() > 0) {
    signal = Serial.read();
    
//    switch(signal) {
//    
//      case '0': //bars are off
//      digitalWrite(ledPin, 255);
//      break;
//      
//      case '1': //bars are on
//      digitalWrite(ledPin, 0);
//      break;
//    }
    digitalWrite(ledPin, signal);
  }
  
  int sensorValue = analogRead(sensorPin); //assign sensor value to a variable

  

  Serial.print(sensorValue);//communicate sensor variable
  
  Serial.println();//send a carriage return
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("hShk"); //handShake
    delay(300);
  }
}
