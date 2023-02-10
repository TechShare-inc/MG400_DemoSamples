Copyright © 2021 TechShare Inc. All Rights Reserved.

# MG400_DemoSamples
オンラインデモでご紹介したプログラムや、初めてMG400をご利用いただく方向けのサンプルプログラムはこちらからダウンロードできます。<br>
お使いのDobotStudioProのバージョンに応じて使用できるサンプルプログラムが異なりますのでご注意ください。<br>
2/10時点での最新バージョンは2.6.0となっており、これ以前のバージョンとはプログラムの仕様が大きく変更されております。<br>
バージョン2.5.0以前をご使用の方は「ver2.2.0」フォルダにありますサンプルプログラムをまずはご利用ください。<br>


# 使い方
1. 画面右上CodeよりDownload ZIPからプログラムをダウンロードしてください。
2. PCとMG400をLANケーブルを用いて接続してください。ポートはLAN1でお願いいたします。
3. Windows Explorer上部のファイルパスへ`\\192.168.1.6`を入力してMG400内のフォルダへアクセスします。
4. `project/project/`がプログラムを保存するフォルダとなります。こちらにMG400_DemoSamplesからダウンロードしたファイルを入れてください。
各ファイル名は"開発方法_プログラム名"となっています。
5. DobotStudio2020より TeachandPlayback/Blockly/Script のそれぞれで追加したプログラムを実行してください。

# プログラム説明
- PickandPlace  scriptプログラム、グリッパで単純なピック＆プレースを繰り返す
- PythonSDK　 　  PythonSDKを使用し、PCに保存したプログラムでMG400を制御する
  - multiple_of_3.py   
- TCP   　　MG400を2台連携させたデモ
  - script_TCPclient　　   クライアントプログラム
  - script_TCPserver  　　 サーバープログラム
- blockly_IO  　　 デジタルI/Oに接続したスイッチからアームやパトランプ、エアポンプの制御を行う
- blockly_RelMoveCube 　　  RelMoveJ、MoveJブロックを使用し、四角形を描く移動を行う
- blockly_pointlist  　　 ポイントリストを使用し、指定した点へ移動を行う
- playback_lineSquare  　　 MoveL命令を使用し、四角形を描く移動を行う
- playback_pointlist 　　  ポイントリストを使用し、指定した点へ移動を行う
- plyaback_simple3point 　　  MoveL命令を使用し、3点間の移動を行う
- script_pallet 　　  パレット機能を使用して、一方のパレットから他方のパレットへワークの積み替えを行う

Copyright © 2021 TechShare Inc. All Rights Reserved.
