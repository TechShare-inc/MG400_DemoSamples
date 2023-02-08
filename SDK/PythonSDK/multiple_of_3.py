#Copyright © 2021 TechShare Inc. All Rights Reserved.
#coding: utf-8
from dobot_api import dobot_api_dashboard, dobot_api_feedback, MyType
from multiprocessing import Process
import numpy as np
import time

#3の倍数の時の動作(正面から見て右に移動)を定義
def multiple_3(client_dashboard, client_feedback):
    client_feedback.MovJ(250,150,100,0,0,0)
    #ワークのピック位置に移動後、サクションカップON
    client_feedback.MovJIO(250,150,-55,0,0,0, (0,100,1,1))
    time.sleep(3)
    client_feedback.MovJ(250,150,100,0,0,0)
    client_feedback.MovJ(250,0,100,0,0,0)
    #ワークのプレース位置に移動後、サクションカップOFF
    client_feedback.MovJIO(250,0,-55,0,0,0, (0,100,1,0))
    time.sleep(3)
    client_feedback.MovJ(250,0,100,0,0,0)
    time.sleep(1)

#3の倍数以外の時の動作(正面から見て左に移動)を定義
def other(client_dashboard, client_feedback):
    client_feedback.MovJ(250,-150,100,0,0,0)
    #ワークのピック位置に移動後、サクションカップON
    client_feedback.MovJIO(250,-150,-55,0,0,0, (0,100,1,1))
    time.sleep(3)
    client_feedback.MovJ(250,-150,100,0,0,0)
    client_feedback.MovJ(250,-0,100,0,0,0)
    #ワークのプレース位置に移動後、サクションカップOFF
    client_feedback.MovJIO(250,0,-55,0,0,0, (0,100,1,0))
    time.sleep(3)
    client_feedback.MovJ(250,0,100,0,0,0)
    time.sleep(1)

#MG400のipとポートを指定して通信を開始する
client_dashboard = dobot_api_dashboard('192.168.1.6', 29999)
client_feedback = dobot_api_feedback('192.168.1.6', 30003)

#エラーを解除する
client_dashboard.ClearError()
time.sleep(0.5)
#モーターに給電を行う
client_dashboard.EnableRobot()
time.sleep(0.5)
#ユーザー座標系を指定する
client_dashboard.User(0)
#ツールの座標系を指定する
client_dashboard.Tool(0)

#初期位置に移動する
client_feedback.MovJ(250,0,100,0,0,0)


i = 0
#iが10より小さければ繰り返す
while i < 10:
    i += 1
    print (str(i) + "回目")
    #3の倍数の時
    if i % 3 == 0:
        print(str(i) + "は3の倍数です")
        multiple_3(client_dashboard, client_feedback)
    #3の倍数以外の時
    else:
        print(str(i) + "は3の倍数ではありません")
        other(client_dashboard, client_feedback)

print("finished!")
client_dashboard.close()
client_feedback.close()
