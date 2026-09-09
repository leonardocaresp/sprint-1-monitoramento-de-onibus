#include "Ultrasonic.h"

int pinoEcho = 12;
int pinoTrigger = 13;

HC_SR04 sensor(pinoTrigger, pinoEcho);

void setup() {
  Serial.begin(9600);
}

void loop() {
  float distancia = sensor.distance();

  Serial.print("DistMin:");
  Serial.print(10);
  Serial.print(" ");
  Serial.print("Distancia:");
  Serial.print(distancia);
  Serial.print(" ");
  Serial.print("DistMax:");
  Serial.println(100);

  delay(1000);
}