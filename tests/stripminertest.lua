if not turtle then 
    print("This is a Script for a Turtle!")
    return 
end
 
pos = {x = 0, y = 0, z = 0, yaw = 0}
 
function pos:GetPos() return self.x, self.y, self.z end
function pos:GetYaw() return self.yaw end 
function pos:ToString() return "{" .. self.x .. ", " .. self.y .. ", " .. self.z .. "} || yaw: " .. self.yaw end
function pos:OnMoved() print(self:ToString()) end
 
function pos:F(n)
    n = n or 1
    if self.yaw == 0 or self.yaw == 2 then 
        self.x = self.x + (self.yaw == 0 and n or -n) 
    else 
        self.y = self.y + (self.yaw == 1 and n or -n) 
    end
    self:OnMoved()
end
 
function pos:B() 
    self:F(-1) 
    self:OnMoved()
end
 
function pos:RotL()
    self.yaw = self.yaw - 1
    if self.yaw < 0 then self.yaw = 3 end
    self:OnMoved()
end
 
function pos:RotR()
    self.yaw = self.yaw + 1
    if self.yaw > 3 then self.yaw = 0 end
    self:OnMoved()
end
 
self = {}
self.history = {}
 
function self:ValidateFuel(do_backtrack)
    if do_backtrack == nil then do_backtrack = true end 
 
    local fuel = turtle.getFuelLevel()
    
    if not fuel then return false end 
    
    if fuel == #self.history then 
        if do_backtrack == true then self:BackTrack() end
        return false 
    end
 
    return true 
end
 
function self:w(len, to_history)
    if to_history == nil then to_history = true end 
 
    len = math.max(len or 1, 1)
 
    for i = 1, len, 1 do 
        turtle.forward() 
        pos:F()
 
        if to_history == true then 
            table.insert(self.history, "forward")
        end
 
        if self:ValidateFuel() == false then return end   
    end
end
 
function self:s(len, to_history)
    if to_history == nil then to_history = true end 
 
    len = math.max(len or 1, 1)
 
    for i = 1, len, 1 do 
        turtle.back() 
        pos:B()
 
        if to_history == true then 
            table.insert(self.history, "back")
        end 
 
        if self:ValidateFuel() == false then return end   
    end
end
 
function self:a(times, to_history)
    if self:ValidateFuel() == false then return end  
 
    if to_history == nil then to_history = true end 
 
    times = math.max(times or 1, 1)
 
    for i = 1, times, 1 do 
        turtle.turnLeft() 
        pos:RotL()
 
        if to_history == true then 
            table.insert(self.history, "left")
        end 
 
        if self:ValidateFuel() == false then return end   
    end
end
 
function self:d(times, to_history)
    if self:ValidateFuel() == false then return end  
 
    if to_history == nil then to_history = true end
 
    times = math.max(times or 1, 1)
 
    for i = 1, times, 1 do 
        turtle.turnRight() 
        pos:RotR()
 
        if to_history == true then 
            table.insert(self.history, "right")
        end 
 
        if self:ValidateFuel() == false then return end   
    end
end
 
function self:BackTrack(amount)
    local c = 0
    while #self.history > 0 do  
        local entry = self.history[#self.history]
 
        if entry == "forward" then 
            self:s(1, false)
        elseif entry == "back" then 
            self:w(1, false)
        elseif entry == "right" then 
            self:a(1, false)
        elseif entry == "left" then 
            self:d(1, false)
        end
 
        table.remove(self.history)
 
        if amount then 
            c = c + 1
            if c > amount then break end 
        end 
    end
end
 
self:s()
self:w()
self:a()
self:d()
self:BackTrack()