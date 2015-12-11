# Switch API

大学のプロジェクト課題で作成したAPIサーバーです。
家電製品を動かしたいという欲望で動いてるデザイアドリブン駆動なプロジェクトです。

基本git flowの思想の元ブランチは切っていて、
circleCIでテストを動かして通らない場合はプルリクを受け付けない方針をとっています。

## 下準備

クローンしたプロジェクト内のプログラムをコンパイルする

### 受信コマンドコンパイル

```sh
$ sudo gcc recieve.c -o recieve -lwiringPi
```

### 送信コマンドコンパイル

```sh
$ sudo gcc send.c -lm -o send -lwiringPi
```

## サーバーを立てる

一部権限を求められるshコマンドが含まれているので、`sudo`をつけると間違いないかも

### Rails立ち上げ

```sh
$ sudo rails s
```
### Redis立ち上げ

```sh
$ redis-server
```

### Resque立ち上げ

```sh
$ $ QUEUE=* rake environment resque:work
```

### scheduler立ち上げ

```sh
$ DYNAMIC_SCHEDULE=true rake environment resque:scheduler
```

### ログを監視

```sh
$ tail -f log/outputFileName
```


## スケジューラーに関して

cron形式でデータを渡す時の値の諸々

### cronの設定

```
43 23 * * *               23:43に実行
12 05 * * * 　　          05:12に実行
0 17 * * *                17:00に実行
0 17 * * 1                毎週月曜の 17:00に実行
0,10 17 * * 0,2,3         毎週日,火,水曜の 17:00と 17:10に実行
0-10 17 1 * *             毎月 1日の 17:00から17:10まで 1分毎に実行
0 0 1,15 * 1              毎月 1日と 15日と 月曜日の 0:00に実行
42 4 1 * * 　          　 毎月 1日の 4:42分に実行
0 21 * * 1-6　　          月曜日から土曜まで 21:00に実行
0,10,20,30,40,50 * * * *　10分おきに実行
*/10 * * * * 　　　　　　 10分おきに実行
* 1 * * *　　　　　　　　 1:00から 1:59まで 1分おきに実行
0 1 * * *　　　　　　　　 1:00に実行
0 */1 * * *　　　　　　　 毎時 0分に 1時間おきに実行
0 * * * *　　　　　　　　 毎時 0分に 1時間おきに実行
2 8-20/3 * * *　　　　　　8:02,11:02,14:02,17:02,20:02に実行
30 5 1,15 * *　　　　　　 1日と 15日の 5:30に実行
```



## その他

データの同期に関して

### 本番サーバーからdumpファイルを作成

```sh
$ scp pi@hostname:~/rails_app/switch_api/db/development.sqlite3 ./dump.sqlite3
```

### 赤外線情報ファイルの取得

```sh
$ scp -r pi@hostname:~/rails_app/switch_api/data ./
```

## Vagrantで実行する場合

```sh
$ vagrant up

$ vagrant ssh

$ cd /vagrant/

$ rails s -b 0.0.0.0
```
