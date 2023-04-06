Copyright © 2023 TechShare Inc. All Rights Reserved.

# 概要
こちらはDobotStudioPro ver2.6.0以降をご利用の方向けのサンプルプログラムとなります。<br>
一部サンプルプログラムは弊社FAQサイトにて紹介しているものもございます。<br>
プログラムは全てBlocklyで作成しておりますがImport時にはBlocklyとScriptいずれでも可能です。<br>


# 各プログラム説明

- Camera_TCP TCP通信を用いて2Dカメラと座標データのやり取りを行うプログラム(DobotVisionStudioと連携可能)
- Circle 　MoveカテゴリCircle関数の動作確認プログラム
- movecommand   　MOveカテゴリの
- pallet  　パレタイジング動作のサンプルプログラム(詳しくは https://techshare.co.jp/faq/dobot/mg400/palletizing.html にて紹介しています)
- elecric-gripper 小型電動グリッパーの動作確認プログラム
- electromagnetic-gripper 小型電磁グリッパーの動作確認プログラム
- soft-gripper(beak) ソフトグリッパー/ビークの動作確認プログラム
- modbus Modbus通信のサンプルプログラム
- suctioncup&airpump 小型エアポンプを用いたサクションカップの動作確認プログラム

## 各エンドエフェクタ接続方法の紹介、注意点
エンドエフェクタを動作させるプログラムに関しては予め、それぞれに対応するFAQ記事を参考に接続をお済ませください。<br>
- elecric-gripper : https://techshare.co.jp/faq/dobot/end-effector-mg400/electric-gripper.html
- electromagnetic-gripper : https://techshare.co.jp/faq/dobot/end-effector-mg400/electric-gripper.html
- soft-gripper(beak) : https://techshare.co.jp/faq/dobot/end-effector-mg400/soft-gripper.html
- suctioncup&airpump : https://techshare.co.jp/faq/dobot/airpump.html

また、各プログラムではRの値を0°にして動作させるようプログラムを組んでいます。<br>
エンドエフェクタ取り付け時にRの角度を0°付近にして調整していただくか(またはJ4軸のみのキャリブレーションを行い、原点を変更する)、<br>
プログラム内のポイントリストに登録されていR座標の値を変更するなどして、プログラム動作時にケーブルを巻き込まないようお気を付けください。<br>
また、キャリブレーション方法につきましては https://techshare.co.jp/faq/dobot/mg400/home-calibration.html <br>
ポイントリストの使用方法につきましては https://techshare.co.jp/faq/dobot/mg400/point-list.html をご参照ください。<br>


https://techshare.co.jp/faq/dobot/mg400/backup-program.html<br>

Copyright © 2023 TechShare Inc. All Rights Reserved.
