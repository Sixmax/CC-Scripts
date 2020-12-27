os.loadAPI("/sixmax/localpos.lua")

if not localpos then 
    io.write("Failed to load localpos.lua")
    return 
end

history = {}
 
function ValidateFuel(do_backtrack)
    if do_backtrack == nil then do_backtrack = true end 
 
    local fuel = turtle.getFuelLevel()
    
    if not fuel then return false end 
    
    if fuel == #history then 
        if do_backtrack == true then BackTrack() end
        return false 
    end
 
    return true 
end
 
function w(len, to_history)
    if to_history == nil then to_history = true end 
 
    len = math.max(len or 1, 1)
 
    for i = 1, len, 1 do 
        turtle.forward() 
        localpos:F()
 
        if to_history == true then 
            table.insert(history, "forward")
        end
 
        if ValidateFuel() == false then return end   
    end
end
 
function s(len, to_history)
    if to_history == nil then to_history = true end 
 
    len = math.max(len or 1, 1)
 
    for i = 1, len, 1 do 
        turtle.back() 
        localpos:B()
 
        if to_history == true then 
            table.insert(history, "back")
        end 
 
        if ValidateFuel() == false then return end   
    end
end
 
function a(times, to_history)
    if ValidateFuel() == false then return end  
 
    if to_history == nil then to_history = true end 
 
    times = math.max(times or 1, 1)
 
    for i = 1, times, 1 do 
        turtle.turnLeft() 
        localpos:RotL()
 
        if to_history == true then 
            table.insert(history, "left")
        end 
 
        if ValidateFuel() == false then return end   
    end
end
 
function self:d(times, to_history)
    if self:ValidateFuel() == false then return end  
 
    if to_history == nil then to_history = true end
 
    times = math.max(times or 1, 1)
 
    for i = 1, times, 1 do 
        turtle.turnRight() 
        localpos:RotR()
 
        if to_history == true then 
            table.insert(history, "right")
        end 
 
        if ValidateFuel() == false then return end   
    end
end
 
function BackTrack(amount)
    local c = 0
    while #history > 0 do  
        local entry = history[#history]
 
        if entry == "forward" then 
            s(1, false)
        elseif entry == "back" then 
            w(1, false)
        elseif entry == "right" then 
            a(1, false)
        elseif entry == "left" then 
            d(1, false)
        end
 
        table.remove(history)
 
        if amount then 
            c = c + 1
            if c > amount then break end 
        end 
    end
end