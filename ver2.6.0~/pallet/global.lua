DELTA_Z = 0
pick_count = 0
place_count = 0 
--  Pallet

  --直线位置线性插值
  function lineInter(position1,position2,n,result)
    local pallet_dx = (position2[1] - position1[1])/(n-1)
    local pallet_dy = (position2[2] - position1[2])/(n-1)
    local pallet_dz = (position2[3] - position1[3])/(n-1)
    for i = 1,n do
      result[i] = {}
      result[i][1] = position1[1] + pallet_dx*(i-1)
      result[i][2] = position1[2] + pallet_dy*(i-1)
      result[i][3] = position1[3] + pallet_dz*(i-1)
    end
  end

  --球面姿态线性插值(Slerp法)
  function slerp(p,q,n,result)
    local pallet_t=0
    local pallet_cosa = p[1]*q[1]+p[2]*q[2]+p[3]*q[3]+p[4]*q[4]
    local pallet_k0
    local pallet_k1
    --反向判断
    if(pallet_cosa < 0.0) then
      q[1] = -q[1]
      q[2] = -q[2]
      q[3] = -q[3]
      q[4] = -q[4]
      pallet_cosa = -pallet_cosa
    end
    --夹角过小判断
    for i=1,n do
      if(n>1) then
        pallet_t=1/(n-1)
      end
      pallet_t=(i-1)*pallet_t
      if(pallet_cosa > 0.9995) then
        pallet_k0 = 1.0 - pallet_t
        pallet_k1 = pallet_t
      else
        local pallet_sina = math.sqrt(1.0 - pallet_cosa*pallet_cosa)
        local pallet_a = math.atan(pallet_sina,pallet_cosa)
        pallet_k0 = math.sin((1.0 - pallet_t)*pallet_a) / pallet_sina
        pallet_k1 = math.sin(pallet_t*pallet_a) / pallet_sina
      end
      result[i]={}
      result[i][1] = p[1]*pallet_k0 + q[1]*pallet_k1
      result[i][2] = p[2]*pallet_k0 + q[2]*pallet_k1
      result[i][3] = p[3]*pallet_k0 + q[3]*pallet_k1
      result[i][4] = p[4]*pallet_k0 + q[4]*pallet_k1
    end
  end

  --欧拉角转四元数
  function xyzEulerToQuaternion(rpy,quat)
    local pallet_cos1 = math.cos(math.rad(rpy[1]/2))
    local pallet_cos2 = math.cos(math.rad(rpy[2]/2))
    local pallet_cos3 = math.cos(math.rad(rpy[3]/2))

    local pallet_sin1 = math.sin(math.rad(rpy[1]/2))
    local pallet_sin2 = math.sin(math.rad(rpy[2]/2))
    local pallet_sin3 = math.sin(math.rad(rpy[3]/2))

    quat[1] = pallet_sin1 * pallet_sin2 * pallet_sin3 + pallet_cos1 * pallet_cos2 * pallet_cos3
    quat[2] = -pallet_cos1 * pallet_sin2 * pallet_sin3 + pallet_sin1 * pallet_cos2 * pallet_cos3
    quat[3] = pallet_sin1 * pallet_cos2 * pallet_sin3 + pallet_cos1 * pallet_sin2 * pallet_cos3
    quat[4] = pallet_cos1 * pallet_cos2 * pallet_sin3 - pallet_sin1 * pallet_sin2 * pallet_cos3
  end

  function QuaternionToxyzEuler(quat,rpy)
	  rpy[2] = math.asin(2 * (quat[3] * quat[1] - quat[2] * quat[4]))                                            
	  if  rpy[2] == math.pi/2  then                                                                    
      rpy[1] = 0
      rpy[3] = math.atan(quat[2] , quat[1]) * 2
	  elseif rpy[2] == -math.pi/2 then
      rpy[1] = 0
      rpy[3] = -math.atan(quat[2] , quat[1]) * 2
	  else
      rpy[1] = math.atan(2 * (quat[2] * quat[1] + quat[4] * quat[3]),(quat[1] * quat[1] - quat[2] * quat[2] - quat[3] * quat[3] + quat[4] * quat[4]))  
      rpy[3] = math.atan(2 * (quat[2] * quat[3] + quat[4] * quat[1]),(quat[1] * quat[1] + quat[2] * quat[2] - quat[3] * quat[3] - quat[4] * quat[4]))  
	  end

    rpy[1] = rpy[1]*180/math.pi
    rpy[2] = rpy[2]*180/math.pi
    rpy[3] = rpy[3]*180/math.pi
  end

  --生成直线路径点
  function buildLine(startPoint,endPoint,counts,pointArray)
    local pallet_p1 = {}
    pallet_p1[1] = startPoint["coordinate"][1]
    pallet_p1[2] = startPoint["coordinate"][2]
    pallet_p1[3] = startPoint["coordinate"][3]
    local pallet_r1 = {}
    pallet_r1[1] = startPoint["coordinate"][6]
    pallet_r1[2] = startPoint["coordinate"][5]
    pallet_r1[3] = startPoint["coordinate"][4]
    local pallet_p2 = {}
    pallet_p2[1] = endPoint["coordinate"][1]
    pallet_p2[2] = endPoint["coordinate"][2]
    pallet_p2[3] = endPoint["coordinate"][3]
    local pallet_r2 = {}
    pallet_r2[1] = endPoint["coordinate"][6]
    pallet_r2[2] = endPoint["coordinate"][5]
    pallet_r2[3] = endPoint["coordinate"][4]
    --位置线性插补
    posArray = {}   --位置插值序列
    lineInter(pallet_p1,pallet_p2,counts[1],posArray)
    --姿态插补
    local pallet_quat1 = {}
    local pallet_quat2 = {}
    local quatArray = {}
    local eulerArray = {} --姿态插值序列
    xyzEulerToQuaternion(pallet_r1,pallet_quat1)
    xyzEulerToQuaternion(pallet_r2,pallet_quat2)
    slerp(pallet_quat1,pallet_quat2,counts[1],quatArray)
    for i=1,#quatArray do
        eulerArray[i] = {}
        QuaternionToxyzEuler(quatArray[i],eulerArray[i])
    end
    --形成标准点位
    for i=1,#posArray do
        if type(startPoint["armOrientation"]) == "string" then
            pointArray[i] = {armOrientation="right",coordinate={},joint={},user=0,tool=0}
            pointArray[i]["armOrientation"] = startPoint["armOrientation"]
        else
            pointArray[i] = {armOrientation={},coordinate={},joint={},user=0,tool=0}
            pointArray[i]["armOrientation"][1] = startPoint["armOrientation"][1]
            pointArray[i]["armOrientation"][2] = startPoint["armOrientation"][2]
            pointArray[i]["armOrientation"][3] = startPoint["armOrientation"][3]
            pointArray[i]["armOrientation"][4] = startPoint["armOrientation"][4]
        end
        
        pointArray[i]["user"] = startPoint["user"]
        pointArray[i]["tool"] = startPoint["tool"]
        pointArray[i]["joint"][1] = startPoint["joint"][1]
        pointArray[i]["joint"][2] = startPoint["joint"][2]
        pointArray[i]["joint"][3] = startPoint["joint"][3]
        pointArray[i]["joint"][4] = startPoint["joint"][4]
        pointArray[i]["joint"][5] = startPoint["joint"][5]
        pointArray[i]["joint"][6] = startPoint["joint"][6]
        pointArray[i]["coordinate"][1] = posArray[i][1]
        pointArray[i]["coordinate"][2] = posArray[i][2]
        pointArray[i]["coordinate"][3] = posArray[i][3]
        pointArray[i]["coordinate"][4] = eulerArray[i][3]
        pointArray[i]["coordinate"][5] = eulerArray[i][2]
        pointArray[i]["coordinate"][6] = eulerArray[i][1]
    end
  end

  --生成平面路径点
  function buildPlane(teachArray,counts,pointArray)
    --生成两个纵列点位pallet_L14 pallet_L23
    local pallet_count1={}
    local pallet_count2={}
    pallet_count1[1]=counts[1]  --横长
    pallet_count2[1]=counts[2]  --竖长
    local pallet_L14 = {}
    buildLine(teachArray[1],teachArray[4],pallet_count2,pallet_L14)
    local pallet_L23 = {}
    buildLine(teachArray[2],teachArray[3],pallet_count2,pallet_L23)
    local pallet_L = {}
    for i=1,counts[2] do	     
        buildLine(pallet_L14[i],pallet_L23[i],pallet_count1,pallet_L)
        for j=1,counts[1] do
          pointArray[(i-1)*counts[1]+j] = pallet_L[j]
        end
    end
  end

  --生成立体路径点
  function buildVolume(teachArray,counts,VolumeArray)
    --生成高度点位
    local count_height={}
    count_height[1]=counts[3]
    local pallet_L15 = {}
    buildLine(teachArray[1],teachArray[5],count_height,pallet_L15)
    local pallet_L26 = {}
    buildLine(teachArray[2],teachArray[6],count_height,pallet_L26)
    local pallet_L37 = {}
    buildLine(teachArray[3],teachArray[7],count_height,pallet_L37)
    local pallet_L48 = {}
    buildLine(teachArray[4],teachArray[8],count_height,pallet_L48)
    counts_plane ={counts[1],counts[2]}
    local planeArray={}
    for i = 1, counts[3] do
        plane={pallet_L15[i],pallet_L26[i],pallet_L37[i],pallet_L48[i]}
        buildPlane(plane,counts_plane,planeArray)
        for j=1,counts[1]*counts[2] do
          VolumeArray[(i-1)*counts[1]*counts[2]+j] = planeArray[j]
        end
    
    end

  end

  --托盘点位自动生成
  function PalletCreate(teachPoints, counts, resultArray)
    --一维托盘
    if (#counts == 1) then
        buildLine(teachPoints[1],teachPoints[2],counts,resultArray)
    --二维托盘
    elseif(#counts == 2) then
          buildPlane(teachPoints,counts,resultArray)
    --三维托盘
    elseif(#counts == 3) then
          buildVolume(teachPoints,counts,resultArray)
    else
    print("Counts Error")
    end
  end

  --table逆序
  function dobotReverseTable(tab)
    local tmp = {}
    for i = 1, #tab do
      local key = #tab
      tmp[i] = table.remove(tab)
    end

    return tmp
  end
  