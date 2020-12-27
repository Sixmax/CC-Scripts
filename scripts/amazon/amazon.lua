do -- Location shit 
    x = 0
    y = 0
    z = 0
    yaw = 0
    function GetPos() return x, y, z end
    function GetYaw() return yaw end 
    function ToString() return "{" .. x .. ", " .. y .. ", " .. z .. "} || yaw: " .. yaw end
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
    function U()
        z = z + 1
        _OnMoved()
    end
    function D()
        z = z - 1
        _OnMoved()
    end
    function getFacing()
        if yaw == 0 then return "forward" end
        if yaw == 2 then return "backward" end
        if yaw == 1 then return "right" end
        if yaw == 3 then return "left" end 
        return ""
    end
end 
do -- Movement lib 
    local history = {}
    function ValidateFuel(do_backtrack)
        if do_backtrack == nil then do_backtrack = true end 
        local fuel = turtle.getFuelLevel()
        if not fuel then return false end 
        if fuel == #history / 2 then 
            if do_backtrack == true then home() end
            return false 
        end
        return true 
    end
    function forward(len, to_history)
        if to_history == nil then to_history = true end 
        len = math.max(len or 1, 1)
        for i = 1, len, 1 do 
            turtle.forward() 
            F()
            if to_history == true then 
                table.insert(history, "forward")
            end
            if ValidateFuel() == false then return end   
        end
    end
    function backward(len, to_history)
        if to_history == nil then to_history = true end 
        len = math.max(len or 1, 1)
        for i = 1, len, 1 do 
            turtle.back() 
            B()
            if to_history == true then 
                table.insert(history, "back")
            end 
            if ValidateFuel() == false then return end   
        end
    end
    function rotateLeft(times, to_history)
        if ValidateFuel() == false then return end  
        if to_history == nil then to_history = true end 
        times = math.max(times or 1, 1)
        for i = 1, times, 1 do 
            turtle.turnLeft() 
            L()
            if to_history == true then 
                table.insert(history, "left")
            end 
            if ValidateFuel() == false then return end   
        end
    end
    function down(times, to_history)
        if ValidateFuel() == false then return end  
        if to_history == nil then to_history = true end 
        times = math.max(times or 1, 1)
        for i = 1, times, 1 do 
            turtle.down() 
            D()
            if to_history == true then 
                table.insert(history, "down")
            end 
            if ValidateFuel() == false then return end   
        end
    end
    function up(times, to_history)
        if ValidateFuel() == false then return end  
        if to_history == nil then to_history = true end 
        times = math.max(times or 1, 1)
        for i = 1, times, 1 do 
            turtle.up() 
            U()
            if to_history == true then 
                table.insert(history, "up")
            end 
            if ValidateFuel() == false then return end   
        end
    end
    function rotateRight(times, to_history)
        if ValidateFuel() == false then return end  
        if to_history == nil then to_history = true end
        times = math.max(times or 1, 1)
        for i = 1, times, 1 do 
            turtle.turnRight() 
            R()
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
                backward(1, false)
            elseif entry == "back" then 
                forward(1, false)
            elseif entry == "right" then 
                rotateLeft(1, false)
            elseif entry == "left" then 
                rotateRight(1, false)
            elseif entry == "up" then 
                down(1, false)
            elseif enry == "down" then 
                up(1, false)
            end
            table.remove(history)
            if amount then 
                c = c + 1
                if c > amount then break end 
            end 
        end
    end
    function home()
        while true do 
            if z > 0 then 
                down(1, false)
            elseif z < 0 then 
                up(1, false)
            else break end 
        end
        if y > 0 then 
            while true do 
                rotateLeft(1, false) 
                if getFacing() == "left" then break end  
            end
        elseif y < 0 then 
            while true do 
                rotateRight(1, false)
                if getFacing() == "right" then break end  
            end
        end
        while y ~= 0 do forward(1, false) end
        while getFacing() ~= "forward" do rotateLeft(1, false) end 
        while x ~= 0 do backward(1, false) end
    end
end 
