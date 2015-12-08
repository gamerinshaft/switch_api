# Switch API

大学のプロジェクト課題で作成したAPIサーバーです。
家電製品を動かしたいという欲望で動いてるデザイアドリブン駆動なプロジェクトです。

基本git flowの思想の元ブランチは切っていて、
circleCIでテストを動かして通らない場合はプルリクを受け付けない方針をとっています。

### 受信コマンドコンパイル

```
sudo gcc recieve.c -o recieve -lwiringPi
```

### 送信コマンドコンパイル

```
sudo gcc send.c -lm -o send -lwiringPi
```