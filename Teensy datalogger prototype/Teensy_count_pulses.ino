//Author: Flavie Le Bars
//Teensy 4.1
//reading 2 pulses from the Geiger counters
//sums up the count for each counter every minute


int count1 = 0; //counter pulse1
int count2 = 0; //counter pulse2
float value1 = 0; //high or low pulse1, high(1)=no pulse, low(0)=pulse
float value2 = 0;  
float prevstate1;
float prevstate2;
int minutes = 1;
float range;
unsigned long timer, startime;
unsigned long prevtimer = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("Pulse1 and 2 digital");
  startime = millis();
  Serial.print("Start time: ");
  Serial.print("\t");
  Serial.println(startime);  
  Serial.println("Minutes Count1 Count2");
}

void loop() {
    value1 = digitalRead(24);
    value2 = digitalRead(26);
    timer = millis();
    range = 60000*minutes; //60000ms = 60 sec
    if(value1 == LOW && prevstate1 != value1){
       count1++;
       }
    if(value2 == LOW && prevstate2 != value2){
       count2++;
       }
     if (timer>range){
       Serial.print(minutes);
       Serial.print("\t");
       Serial.print(count1);
       Serial.print("\t");
       Serial.println(count2);
       minutes++;
       count1 = 0; //initialise counter again for next minute
       count2 = 0;
     }
       prevstate1 = value1;
       prevstate2 = value2;
       
    }
