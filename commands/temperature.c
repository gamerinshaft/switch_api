#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>

int read_pin = 1;
int temperature;
int main(void){
  FILE *fp;
  char *fileName = "temperature.txt";
  if(argc >= 2){ fileName = argv[1]; } //読み込むフィル名
  if((fp = fopen(fileName, "w")) == NULL){
    exit(1);
  }
  // wiringpiのセットアップ
  if(wiringPiSetup() == -1){
      exit(1);
  }
  pinMode(send_pin, INPUT);
  temperature = digitalRead(read_pin)
  fprintf(fp, "%6d\n", temperature);
  return 0;
}