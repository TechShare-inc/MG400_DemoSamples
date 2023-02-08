-- This file is only used to define variables and sub functions.

OPEN = 1
CLOSE = 0

IO_gripper_pwr = 1
IO_gripper_width = 2


local option_up = {SpeedL = 100, AccL = 100, CP = 100}
local option_down = {SpeedL = 100, AccL = 100, CP = 100}
local option_path = {SpeedL = 100, AccL = 100, CP = 100}

function Gripper(pattern)
	if pattern==1 then
		print("Open Gripper")
		--DO(IO_gripper_width,OFF)
		DO(IO_gripper_pwr,ON)
	else
		print("Close Gripper")
		--DO(IO_gripper_width,ON)
		DO(IO_gripper_pwr,OFF)
	end	
end


function pick_and_place(pick,place,offset)	
	MovL(RelPoint(pick.point, offset),option_path)
	MovL(pick.point,option_down)
	Gripper(pick.pattern)

	MovL(RelPoint(pick.point, offset),option_up)
	
	MovL(RelPoint(place.point, offset),option_path)
	MovL(place.point,option_down)
	Gripper(place.pattern)
	MovL(RelPoint(place.point, offset),option_up)
end
