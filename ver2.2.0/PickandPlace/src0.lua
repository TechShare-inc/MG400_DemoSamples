-- Version: Lua 5.3.5
-- This thread is the main thread and can call any commands.
--[[
ピック＆プレース　サンプルプログラム


]]

local offset_Z={0,0,30,0}
local pos_pick = {{point=P3,pattern = CLOSE},
 				  {point=P5,pattern = CLOSE}}
  
local pos_place = {{point=P2,pattern = OPEN},
				   {point=P4,pattern = OPEN}}


--Main proccess
AccJ(100)
AccL(100)
SpeedJ(100)
SpeedL(100)
CP(100)

while true do
	MovJ(P1)
	for i=1,#pos_pick do
		pick_and_place(pos_pick[i],pos_place[i],offset_Z)
		Sync()	
	end

	for i=#pos_place,1,-1 do
		pick_and_place(pos_place[i],pos_pick[i],offset_Z)	
		Sync()
	end
	MovJ(P1)
end
