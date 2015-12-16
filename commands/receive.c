#include <wiringPi.h>
#include <stdio.h>
#include <signal.h>
#include <sys/time.h>
#include <stdlib.h>


int readable = 1;       // 非同期でイベントが発生した場合、コールバックにより0に設定される
int pin = 7;       // 入力ピン番号(wiringpiの番号)
int good_pin = 25; // ok led
int bad_pin  = 24; // bad led
int span = 10;      // 継続時間判定の間隔(us)
int max_wait = 40000;   // 最大継続時間(us)

int main(int argc, char *argv[]){
    int result;
    // スキャンデータを書きだすファイルのポインタを取得
    FILE *fp;
    char *fileName = "irdata.txt";
    if(argc >= 2){ fileName = argv[1]; }
    if((fp = fopen(fileName, "w")) == NULL){
        exit(1);
    }
    printf("write file: %s\n", fileName);

    if(signal(SIGINT, signalErrorCallBack) == SIG_ERR){
        exit(1);
    }

    // wiringpiのセットアップ
    if(wiringPiSetup() == -1){
        exit(1);
    }

    pinMode(pin, INPUT);
    pinMode(good_pin, OUTPUT);
    pinMode(bad_pin, OUTPUT);

    // スキャン開始
    result = scan(fp);

    close(fp);

    if(result || !readable){
      int i = 0;
      while(i<4){
        digitalWrite(bad_pin, 1);
        delay(500);
        digitalWrite(bad_pin, 0);
        delay(500);
        i++;
      }
        exit(1);
    } else {
      int i = 0;
      while(i<4){
        digitalWrite(good_pin, 1);
        delay(500);
        digitalWrite(good_pin, 0);
        delay(500);
        i++;
      }
        return(0);
    }
    return 0;
}

void signalErrorCallBack(int sig){
    readable = 0;
}

double getTime(){ //tv_sec ： 指定する時間の1秒以上の部分,tv_usec ： 指定する時間の1秒未満の部分
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return ((double)(tv.tv_sec) * 1000000 + (double)(tv.tv_usec));
}

int scan(FILE *fp){
    digitalWrite(good_pin, 1);
    digitalWrite(bad_pin, 1);

    if(!digitalRead(pin)){ return 1; }

    int on, off, limit;
    limit = 0;

    while( readable && digitalRead(pin) && limit <= 50000000 ){
      limit++;
    }

    if(limit >= 50000000){
      readable = 1;
      digitalWrite(good_pin, 0);
      digitalWrite(bad_pin, 0);
      return 1;
    }

    while( readable ){
        on = getActivateTime(0);
        off = getActivateTime(1);
        fprintf(fp, "%6d %6d\n", on, off);
        if(off > max_wait){ break; }
    }

    digitalWrite(good_pin, 0);
    digitalWrite(bad_pin, 0);
    return 0;
}

int getActivateTime(int status){
    int count = 0;
    int max = max_wait / span;
    double start, end;

    start = getTime();
    while( digitalRead(pin) == status )
    {
      delayMicroseconds(span);
      count++;
      if(count > max){ break; }
    }
    end = getTime();

    return getSpan(start, end);
}

int getSpan(double t1, double t2){
    return (int)(t2-t1);
}
