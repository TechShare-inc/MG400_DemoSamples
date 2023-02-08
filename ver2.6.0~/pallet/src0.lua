DELTA_Z = 50
pick_count = 1
place_count = 1
MovJ((P9))
  local points_pick_pallet = {}
  PalletCreate({P1,P2,P3,P4},{3,3},points_pick_pallet)
  local points_place_pallet = {}
  PalletCreate({P5,P6,P7,P8},{3,3},points_place_pallet)
Sync()
while not ((pick_count==#points_pick_pallet) or (place_count==#points_place_pallet)) do
  MovJ(RelPoint(points_pick_pallet[pick_count],{0,0,DELTA_Z,0}))
  MovL(points_pick_pallet[pick_count])
  MovL(RelPoint(points_pick_pallet[pick_count],{0,0,DELTA_Z,0}))
  MovJ(RelPoint(points_place_pallet[place_count],{0,0,DELTA_Z,0}))
  MovL(points_place_pallet[place_count])
  MovL(RelPoint(points_place_pallet[place_count],{0,0,DELTA_Z,0}))
  pick_count = pick_count + 1
  place_count = place_count + 1
  Sync()
end
