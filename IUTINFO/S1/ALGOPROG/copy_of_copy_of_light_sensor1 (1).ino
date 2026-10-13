const int greenLEDPin = 9;/*TO DO*/
const int blueLEDPin = 10;/*TO DO*/
const int redLEDPin = 11;/*TO DO*/

const int redSensorPin =A0;
const int greenSensorPin =A1;
const int blueSensorPin =A2;

int redValue=0;
int greenValue=0;
int blueValue=0;

int redSensorValue=0;
int greenSensorValue=0;
int blueSensorValue=0;


void setup()
{
  Serial.begin(9600);
  
  pinMode(greenLEDPin,OUTPUT);/*TO DO*/
  pinMode(redLEDPin,OUTPUT);/*TO DO*/
  pinMode(blueLEDPin,OUTPUT);/*TO DO*/
}

void loop()
{
  redSensorValue = analogRead(redSensorPin);
  delay(5);
  greenSensorValue = analogRead(greenSensorPin);
  delay(5);
  blueSensorValue = analogRead(blueSensorPin);
  
  Serial.println(redSensorValue);
  Serial.println(greenSensorValue);
  Serial.println(blueSensorValue);
  
  redValue=redSensorValue/4;
  greenValue=greenSensorValue/4;
  blueValue=blueSensorValue/4;
  
  analogWrite(redLEDPin, redValue);
  analogWrite(greenLEDPin, greenValue);
  analogWrite(blueLEDPin, blueValue);
}