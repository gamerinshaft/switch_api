#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <math.h>
#define BUF_LEN   256

int send_pin = 0;

int khz = 38 * 1000;            // 周波数(KHz)
int d_num = 1;       // duty比(分子)
int d_denomi = 3;    // duty比(分母)
int unit = 26;          // ユニット長us
int d_high;      // HIGH時間
int d_low;      // LOW時間

void high(int on_time)
{
  // パルス信号に変換して送信
  int i;
  int count = on_time/unit;
  for(i=0; i<count; i++)
  {
    digitalWrite(send_pin, 1); //high
    delayMicroseconds(d_high);

    digitalWrite(send_pin, 0); //low
    delayMicroseconds(d_low);
  }
}

void output(int on_time, int off_time)
{
  // 赤外線点灯
  high(on_time);

  // 赤外線消灯
  digitalWrite(send_pin, 0);
  delayMicroseconds(off_time);
}

void readAndSend(FILE *fp)
{
  char buf[BUF_LEN];
  int i, j, length = 0;
  int *on, *off;

  while( fgets(buf, BUF_LEN, fp) != NULL){ length++; }
  on = (int *)calloc(length, sizeof(int));
  off = (int *)calloc(length, sizeof(int));

  rewind(fp);
  for(i=0; i<length; i++)
  {
    fscanf(fp,"%d %d", &on[i], &off[i]);
  }

  for(i=0; i<length; i++)
  {
    output(on[i], off[i]);
  }

  // アロケートしたメモリを解放
  free(on);
  free(off);
}

int main(int argc, char *argv[])
{
  // 送信データファイル
  FILE *fp;
  char *fileName = "irdata.txt";
  if(argc >= 2){ fileName = argv[1]; } //読み込むフィル名
  if((fp = fopen(fileName, "r")) == NULL){
      exit(1);
  }

  // wiringpiのセットアップ
  if(wiringPiSetup() == -1){
      exit(1);
  }

  pinMode(send_pin, OUTPUT);

  // unit長 1sec = 1 * 10^6 us
  unit = (1.0f / khz) * 1000000;
  d_high = roundf(((float)unit / d_denomi) * d_num);
  unit = (int)unit;     //us
  d_low = unit - d_high;

  // 準備完了

  // データ読み込みと赤外線の送信
  readAndSend(fp);

  fclose(fp);

  return 0;
}
