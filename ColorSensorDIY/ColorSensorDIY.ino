int ledArray[] = {2,3,4};
int red = 0;
int green = 0;
int blue = 0;
float colorArray[] = {0,0,0};
float whiteArray[] = {823,810,908};
float blackArray[] = {425,485,543};
int avgReading;
int n = 5;
String vbCom = "";

void setup() {
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  Serial.begin(9600);
  //setBalance();
}

void loop() {
  checkColor();
  printColor();
}

void setBalance(){
  delay(5000);
  for(int i = 0;i<=2;i++){
    digitalWrite(ledArray[i],HIGH);
    delay(100);
    getReading(n);
    whiteArray[i] = avgReading;
    digitalWrite(ledArray[i],LOW);
    delay(100);
  }
  
  delay(5000);
  for(int i = 0;i<=2;i++){
     digitalWrite(ledArray[i],HIGH);
     delay(100);
     getReading(n);
     blackArray[i] = avgReading;
     digitalWrite(ledArray[i],LOW);
     delay(100);
  }

  delay(5000);
}

void checkColor(){
  for(int i = 0; i<=2; i++){
    digitalWrite(ledArray[i], HIGH);
    delay(100);
    getReading(n);
    colorArray[i] = avgReading;
    float greyDiff = whiteArray[i] - blackArray[i];
    colorArray[i] = ((colorArray[i] - blackArray[i])/(greyDiff))*255; 
    digitalWrite(ledArray[i], LOW);
    delay(100);
  }
}

void getReading(int times){
  int reading;
  int tally = 0;
  for(int i = 0; i<times; i++){
    //reading = map(analogRead(0),0,1023,0,255);
    reading = analogRead(0);
    tally = reading + tally;
    delay(10);
  }
  avgReading=(tally)/times;
}

void printColor(){ 
  Serial.print(byte(colorArray[0]));
  Serial.print("#");
  Serial.print(byte(colorArray[1]));
  Serial.print("#");
  Serial.print(byte(colorArray[2]));
  Serial.print("#");

  analogWrite(9, int(colorArray[0]));
  analogWrite(10, int(colorArray[1]));
  analogWrite(11, int(colorArray[2]));
  
  delay(1000);
}
