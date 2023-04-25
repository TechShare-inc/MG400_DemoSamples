function string_toArray(string,separator)
 local tab = {}
 string.gsub(string, separator, function(w) table.insert(tab, w) end )
 return tab
end
AccJ(100)
SpeedJ(100)
resultCreate1,socket1 = TCPCreate(true, '192.168.1.6', 7920)
  if resultCreate1 == 0 then
      print("Create TCP Server Success!")
  else
      print("Create TCP Server failed, code:", resultCreate1)
  end
  resultCreate1 = TCPStart(socket1, 0)
  if resultCreate1 == 0 then
      print("Listen TCP Client Success!")
  else
      print("Listen TCP Client failed, code:", resultCreate1)
  end
  Sync()
while 1 do
  Sync()
  if (resultCreate1)==0 then
    resultWrite1 = TCPWrite(socket1, 'TRIGGER')
    resultRead1,temp = TCPRead(socket1, 0, 'string')
    temp = temp.buf
    X = string_toArray(temp,'[^'..','..']+')[1]
    Y = string_toArray(temp,'[^'..','..']+')[2]
    R = string_toArray(temp,'[^'..','..']+')[3]
    Sync()
    print(('X:'..X))
    Sync()
    print(('Y:'..Y))
    Sync()
    print(('R:'..R))
    Sync()
    MovJ(({coordinate = {X,Y,(P1.coordinate[3]
    ),R}, tool = 0, user = 0}))
    MovJ((P2))
  end
  Sync()
  Sleep(200)
end
