
pos = {x = 0, y = 0, z = 0, yaw = 0}
 
function pos:GetPos() 
    return self.x, self.y, self.z 
end
 
function pos:GetYaw() 
    return self.yaw 
end 
 
function pos:ToString() 
    return "{" .. self.x .. ", " .. self.y .. ", " .. self.z .. "} || yaw: " .. self.yaw
end
 
function pos:OnMoved() end 
function pos:_OnMoved() 
    print(self:ToString()) 
    self:OnMoved()
end
 
function pos:F(n)
    n = n or 1
 
    if self.yaw == 0 or self.yaw == 2 then 
        self.x = self.x + (self.yaw == 0 and n or -n) 
    else 
        self.y = self.y + (self.yaw == 1 and n or -n) 
    end
 
    self:_OnMoved()
end
 
function pos:B() 
    self:F(-1) 
    self:_OnMoved()
end
 
function pos:L()
    self.yaw = self.yaw - 1
    if self.yaw < 0 then self.yaw = 3 end
    self:_OnMoved()
end
 
function pos:R()
    self.yaw = self.yaw + 1
    if self.yaw > 3 then self.yaw = 0 end
    self:_OnMoved()
end
 
return pos 