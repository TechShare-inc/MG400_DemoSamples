DELTA_Z = 50
place_count = 1
MovJ((P5))
  local points_place = {}
  PalletCreate({P1,P2,P3,P4},{3,3},points_place)
Sync()
while not (place_count==#points_place) do
  MovJ(RelPoint(P6,{0,0,DELTA_Z,0}))
  MovL((P6))
  MovL(RelPoint(P6,{0,0,DELTA_Z,0}))
  MovJ(RelPoint(points_place[place_count],{0,0,DELTA_Z,0}))
  MovL(points_place[place_count])
  MovL(RelPoint(points_place[place_count],{0,0,DELTA_Z,0}))
  place_count = place_count + 1
  Sync()
end
