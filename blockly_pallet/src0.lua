DO(1,0)
pallet1 = MatrixPallet(0, "IsUnstack=false Userframe=0")
pallet2 = MatrixPallet(1, "IsUnstack=false Userframe=0")
Reset(pallet1)
Reset(pallet2)
while 1 do
  MoveIn(pallet1,"velAB=50 velBC=50 accAB=50 accBC=50 CP=0 SYNC=1")
  DO(1,1)
  Wait(1000)
  MoveOut(pallet1,"velAB=50 velBC=50 accAB=50 accBC=50 CP=0 SYNC=1")
  MoveIn(pallet2,"velAB=50 velBC=50 accAB=50 accBC=50 CP=0 SYNC=1")
  DO(1,0)
  Wait(1000)
  MoveOut(pallet2,"velAB=50 velBC=50 accAB=50 accBC=50 CP=0 SYNC=1")
  if (IsDone(pallet1)
  )==1 then
    local tmp = pallet1
    pallet1=pallet2
    pallet1 = tmp
    Reset(pallet1)
    Reset(pallet2)
  end
end
