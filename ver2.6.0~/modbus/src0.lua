resultCreate,id = ModbusCreate('192.168.1.6', 502, 1)
  if resultCreate == 0 then
      print("Create modbus master success!")
  else
      print("Create modbus master failed, code:", resultCreate)
  end
  SetCoils(id,1001,1,{1})
SetCoils(id,1002,1,{0})
SetCoils(id,1003,1,{1})
Sync()
while 1 do
  Sync()
  print(('1001port : '..(GetCoils(id,1001,1)[1])))
  Sync()
  print(('1002port : '..(GetCoils(id,1002,1)[1])))
  Sync()
  print(('1003port : '..(GetCoils(id,1003,1)[1])))
  Sleep(1000)
end
