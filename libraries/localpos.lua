x = 0
y = 0
z = 0
yaw = 0


function GetPos() 
    return x, y, z
end
 
function GetYaw() 
    return yaw
end 
 
function ToString() 
    return "{" .. x .. ", " .. y .. ", " .. z .. "} || yaw: " .. yaw
end
 
function OnMoved() end 
local function _OnMoved() 
    print(ToString()) 
    OnMoved()
end
 
function F(n)
    n = n or 1
 
    if yaw == 0 or yaw == 2 then 
        x = x + (yaw == 0 and n or -n) 
    else 
        y = y + (yaw == 1 and n or -n) 
    end
 
    _OnMoved()
end
 
function B() 
    F(-1) 
    _OnMoved()
end
 
function L()
    yaw = yaw - 1
    if yaw < 0 then yaw = 3 end
    _OnMoved()
end
 
function R()
    yaw = yaw + 1
    if yaw > 3 then yaw = 0 end
    _OnMoved()
end