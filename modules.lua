local autoConfirm = true -- Uncomment this to avoid annoying confirm shit
 
-- Incase a File already exists, make the user confirm it manually
function confirm(question)
    if autoConfirm == true then return true end 
    if not question then return false end 
    
    io.write(question)
    io.write("y/n? (yes/no)")
 
    return string.lower(io.read()) == "y"
end
 
local dir = "/sixmax/"

-- Create a File and return a Handle to set file.
function createFile(title)
    if not title then return end 
 
    if fs.exists(dir) == false then fs.makeDir(dir)end 

    if fs.exists(dir .. title) == true then 
        if confirm("The File " .. title .. " already exists, do you want to override it?") == true then 
            fs.delete(dir .. title)
        else return end
    end
 
    return fs.open(dir .. title, "w") 
end
 
function loadPaste(title, id)
    io.write("Creating " .. title .. "...\n")
 
    local handle = createFile(title)
    
    if not handle then return end 

    if string.sub(id, 1, 1) ~= "/" then id = "/" .. id end
    
    local response = http.get("https://raw.githubusercontent.com/Sixmax/CC-Scripts/main" .. id)
 
    if not response then 
        io.write("Failed to receive response for " .. id .. "\n")
        handle.close()
        response.close()
        return 
    end
 
    handle.write(response.readAll())
 
    io.write(title .. " created.\n")
 
    handle.close()
    response.close()
end 