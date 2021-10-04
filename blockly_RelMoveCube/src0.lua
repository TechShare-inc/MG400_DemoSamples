while 1 do
  -- 各点を指定して四角形
  MovJ((P1))
  MovJ((P2))
  MovJ((P3))
  MovJ((P4))
  MovJ((P1))
  -- 現在位置からの指定した距離だけ移動
  RelMovJ({0,-150,0,0})
  RelMovJ({0,0,100,0})
  RelMovJ({0,150,0,0})
  MovJ((P1))
  -- P1から指定した距離で移動
  MovJ((RelPoint((P1),{0,-150,0,0})))
  MovJ((RelPoint((P1),{0,-150,100,0})))
  MovJ((RelPoint((P1),{0,0,100,0})))
end
