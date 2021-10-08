-- Copyright © 2021 TechShare Inc. All Rights Reserved.
-- DI_16に接続したスイッチからの入力時、DO_16に接続したLEDに出力・+y方向への移動。DO_14に接続したスイッチからの入力時、DO_15に接続したLEDに出力・-y方向への移動。DI_15に接続したスイッチから入力時、DO_01に接続したエアポンプのON・OFF切り替え。
-- DO_01に接続したエアポンプの状態を変数とする(ON時=1,OFF時=0)
airpomp = 0
while 1 do
  -- DO_15, DO_16に接続したLEDをOFFにする
  DO(15,0)
  DO(16,0)
  -- いずれかの入力があるまで、待機する
  while not (((((DI(16))==1) or ((DI(14))==1)) or ((DI(15))==1))) do
    Wait(1)
  end
  -- DO_16に入力があった時の動作
  if (DI(16))==1 then
    DO(16,1)
    RelMovJ({0,30,0,0})
    Sync()
  end
  -- DO_14に入力があった時の動作
  if (DI(14))==1 then
    DO(15,1)
    RelMovJ({0,-30,0,0})
    Sync()
  end
  -- DO_15に入力があった時かつエアポンプ(DO_01)がOFFの時の動作
  if ((DI(15))==1) and (airpomp==0) then
    DO(1,1)
    Sync()
    Wait(1000)
    airpomp = 1
  end
  -- DO_15に入力時があった時かつエアポンプ(DO_01)がONの時の動作
  if ((DI(15))==1) and (airpomp==1) then
    DO(1,0)
    Sync()
    Wait(1000)
    airpomp = 0
  end
end
