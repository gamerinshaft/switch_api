# Switch API

大学のプロジェクト課題で作成したAPIサーバーです。
家電製品を動かしたいという欲望で動いてるデザイアドリブン駆動なプロジェクトです。

基本git flowの思想の元ブランチは切っていて、
circleCIでテストを動かして通らない場合はプルリクを受け付けない方針をとっています。

### 受信コマンドコンパイル

```sh
$ sudo gcc recieve.c -o recieve -lwiringPi
```

### 送信コマンドコンパイル

```sh
$ sudo gcc send.c -lm -o send -lwiringPi
```

### 本番サーバーからdumpファイルを作成

```sh
$ scp pi@hostname:~/rails_app/switch_api/db/development.sqlite3 ./dump.sqlite3
```

### 赤外線情報ファイルの取得

```sh
$ scp -r pi@hostname:~/rails_app/switch_api/data ./
```

### Vagrantで実行

```sh
$ vagrant up

$ vagrant ssh

$ cd /vagrant/

$ rails s -b 0.0.0.0
```
