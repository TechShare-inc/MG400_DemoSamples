-- Version: Lua 5.4.1
local ip="192.168.2.10"
local port=6001
local err=0
local socket=0
local RecBuf
local status_client = 0
local status_server = 0

--基板を運ぶ動作を定義
function MoveBoard()
    MovJ(InitialPose)
    MoveJ(P1)
    MoveJ(P2)
    DO(1,ON)
    Wait(1000)
    MoveJ(P1)
    MoveJ(P3)
    MoveJ(P4)
    DO(1,OFF)
    DO(2,ON)
    MoveJ(P3)
    DO(2,OFF)
    MoveJ(InitialPose)
end

--基板を元の位置に戻す動作を定義
function MovebackBoard()
    MoveJ(P3)
    MoveJ(P4)
    DO(1,ON)
    Wait(1000)
    MoveJ(P3)
    MoveJ(P1)
    MoveJ(P2)
    DO(1,OFF)
    DO(2,ON)
    MoveJ(P1)
    DO(2,OFF)
    MoveJ(InitialPose)
end     


--ソケットを生成する
err, socket = TCPCreate(false, ip, port)
--ソケットの作成に成功した場合
if err == 0 then
    --サーバー側のMG400とTCP通信を開始する
    err = TCPStart(socket, 0)
    --通信に成功した場合
    if err == 0 then
        　　--基板を運ぶ
            MoveBoard()
            --MG400の動作が完了するまでプログラムを一時停止する
            Sync()
            status_client = 1
            --基板を運ぶ動作が完了したら、サーバー側のMG400に1を送る
            TCPWrite(socket, status_client, 0)
            status_client = 0
            while true do
                --サーバー側のMG400からデータの受信を行う
                err, RecBuf = TCPRead(socket, 0, 'string')
                --データの受信に成功した場合
                if err == 0 then 
                    status_server = string.format("%s", RecBuf.buf)
                    print("status_server:", status_server)
                    local tmp_status_server = tonumber(status_server)
                    --受け取ったデータが2の場合
                    if tmp_status_server == 2 then
                        --基板を元の位置に戻し、再度基板を運ぶ
                        MovebackBoard()
                        MoveBoard()
                        --MG400の動作が完了するまでプログラムを一時停止する
                        Sync()
                        status_client = 1
                        --基板を運ぶ動作が完了したら、サーバー側のMG400に"1"を送る
                        TCPWrite(socket, status_client, 0)
                        status_client = 0
                    --受け取ったデータが1の場合
                    elseif tmp_status_server == 1 then
                        --基板を元の位置に戻し、再度基板を運ぶ
                        MovebackBoard()
                        MoveBoard()
                        --MG400の動作が完了するまでプログラムを一時停止する
                        Sync()
                        status_client = 2
                        --基板を運ぶ動作が完了したら、サーバー側のMG400に"2"を送る
                        TCPWrite(socket, status_client, 0)
                        status_client = 0
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






















