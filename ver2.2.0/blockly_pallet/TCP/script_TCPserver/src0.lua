-- Version: Lua 5.4.1
-- Copyright © 2021 TechShare Inc. All Rights Reserved.
local ip="192.168.2.6"
local port=6001
local err=0
local socket=0
local Recbaf
local status_client = 0
local status_server = 0

--電子部品を運ぶ動作を定義
function MovePart()
    SpeedJ(100)
    DO(1,ON)
    MoveJ(Initial)
    MoveJ(P1)
    MoveJ(P2)
    DO(1,OFF)
    Wait(1000)
    MoveJ(P1)
    MoveJ(P3)
    SpeedJ(10)
    MoveJ(P4)
    DO(1,ON)
    Wait(1000)
    MoveJ(P3)
    SpeedJ(100)
    MoveJ(Initial)
end
   
--電子部品を元の位置に戻す動作を定義
function MovebackPart()
    SpeedJ(100)
    DO(1,ON)
    MoveJ(P3)
    MoveJ(P4)
    DO(1,OFF)
    Wait(1000)
    MoveJ(P3)
    MoveJ(P1)
    SpeedJ(10)
    MoveJ(P2)
    DO(1,ON)
    Wait(1000)
    MoveJ(P1)
    SpeedJ(100)
    MoveJ(Initial)
end         


--ソケットを生成する
err, socket = TCPCreate(true, ip, port)
--ソケットの作成に成功した場合
if err == 0 then
    --クライアント側のMG400とTCP通信を開始する
    err = TCPStart(socket, 0)
    --通信に成功した場合
    if err == 0 then
        while true do
            --クライアント側のMG400からデータの受信を行う
            err, RecBuf = TCPRead(socket, 0, 'string')
            --データの受信に成功した場合
            if err == 0 then
                status_client = string.format("%s",RecBuf.buf)
                print("status_client:", status_client)
                local tmp_status_client = tonumber(status_client)
                --受け取ったデータが1の場合
                if tmp_status_client == 1 then
                    --電子部品を運ぶ
                    MovePart()
                    --MG400の動作が完了するまでプログラムを一時停止する
                    Sync()
                    status_server = 1
                    --電子部品を運ぶ動作が完了したら、クライアント側のMG400に1を送る                  
                    TCPWrite(socket, status_server, 0)
                --受け取ったデータが2の場合  
                elseif tmp_status_client == 2 then
                    --電子部品を元の位置に戻す
                    MovebackPart()
                    --MG400の動作が完了するまでプログラムを一時停止する
                    Sync()
                    status_server = 2
                    --電子部品を運ぶ動作が完了したら、クライアント側のMG400に2を送る 
                    TCPWrite(socket, status_server, 0)
                    status_server = 0
                end
            end
        end 
    else
        print("Create failed ".. err)
    end
    TCPDestroy(socket)
else
    print("Create failed ".. err)
end
