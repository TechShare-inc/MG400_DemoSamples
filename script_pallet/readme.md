Copyright © 2021 TechShare Inc. All Rights Reserved.
# PythonSDK/multiple_of_3.py
パレット機能を用いて、一方のパレットから他方のパレットへの積み替えを行う 
 <br>
 <br>
 
## デモ内容
1. 3の倍数の時はアームが右側に、それ以外の時は左側に移動する。
2. ピックアップ時はDO_01に接続したエアポンプを使用する。
 
 <br>
  
## 動作環境
- Windows10
  
 <br>
  
## 動作時の注意点
1. パレットについてお客様のほうで2つ作成していただくか、本サンプルのpallet.jsonを\\192.168.1.6\project\process\へ追加していただく必要があります。
 
 <br>
 
## 使用した関数の注意点
### MatrixPallet(index,ID, Option)
  index   MG400で登録したパレットのNO.
  ID      プログラム内で任意で設定できる固有ID、他のパレットと同じ値にしないこと
  Opiton  パレタイジング時の設定

Copyright © 2021 TechShare Inc. All Rights Reserved.
