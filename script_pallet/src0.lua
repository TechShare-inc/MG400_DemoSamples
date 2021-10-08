
-- Copyright © 2021 TechShare Inc. All Rights Reserved.
---[[ --"--[["に変更すると"--]]"でくくられた行がすべてコメントアウトされます
--[[
  2つのパレットを使用し、一方のパレットにあるワークをもう一方の空のパレットへ移動するプログラム
  パレットについてお客様のほうで2つ作成していただくか、
  本サンプルのpallet.jsonを\\192.168.1.6\project\process\へ追加していただく必要があります。
--]]

--[[
  MatrixPallet(index,ID, Option)
  index   MG400で登録したパレットのNO.
  ID      プログラム内で任意で設定できる固有ID、他のパレットと同じ値にしないこと
  Opiton  パレタイジング時の設定
--]]
local MPpick = MatrixPallet(1,1, "IsUnstack=true Userframe=2")
local MPplace = MatrixPallet(0,2, "IsUnstack=false Userframe=2")

--Resetで一番初めに初期化を行う
Reset(MPpick)
Reset(MPplace)

--パレット移動命令の際に使用するオプションを事前に設定
local Option={SpeedAB=100, SpeedBC=100, AccAB=100, AccBC=100, CP=50}

--メイン処理開始
while true
do
  DO(1,ON)  --ここではMG400オプションである電磁グリッパーを例としてDO1をONにより開いている

  --一つ目のパレットからワークを取り出す
  PalletMoveIn(MPpick, Option)  --一つ目のパレット上のワーク位置へ移動
  DO(1,OFF)  --OFFでグリッパを閉じてつかむ
  PalletMoveOut(MPpick,Option)  --遷移点/Safe pointへ移動

  --二つ目のパレットへワークを移動して置く
  PalletMoveIn(MPplace,Option)  --2つ目のパレットの設置位置へ移動
  DO(1,ON)  --ONでグリッパを開いてワークを置く
  PalletMoveOut(MPplace,Option) --遷移点/Safe Pointへ移動
        
  --終了判定
  result=IsDone(MPpick)
      
  --もし終了していたら、今度は戻す動作を行うようにするための処理
  if (result == true)
  then
      DO(1,OFF)
      Reset(MPpick)
      Reset(MPplace)
      local PP = MPpick
      MPpick = MPplace
      MPplace = PP
      --break
  end
end

Release(MPpick)
Release(MPplace)
--]]一番上の括弧はここまでコメントアウトできます
        
--[[
--一つのパレットを動作確認する際はこちらを参考にしてください
local MPpick = MatrixPallet(2,1, "IsUnstack=true Userframe=2")              // Define the pallet instance 
Reset(MPpick)                                                    // Initial the pallet instance 
while true do 
  MoveIn(MPpick,"velAB=90 velBC=50")                         // Start to assemble 
  MoveOut(MPpick) 
  result=IsDone(MPpick) 
  if (result == true)                                           // Check whether stack assembly is complete 
    then 
    print("EXIT ...") 
    break 
  end 
end 
Release(MPpick) 
--]]
