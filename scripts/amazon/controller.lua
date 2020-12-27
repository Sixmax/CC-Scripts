local function pt(t)
    for k, v in pairs(t) do 
        if type(v) == "function" then v = "<func>" end 
        io.write(k .. " || " .. v .. "\n")
    end
end

function findPeripheral(type)
    if not type then return end

    local function attempt(dir)
        local temp = peripheral.wrap(dir) 
        if not temp then return end 
        pt(temp)
        if peripheral.getType(temp) == type then return temp end
    end

    local result = attempt("bottom")
    result = attempt("left")
    result = attempt("right")
    result = attempt("front")
    result = attempt("back")

    return result 
end

local screen = findPeripheral("screen")