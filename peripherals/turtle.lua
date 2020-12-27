io.write("Loading Module Library...\n")
 
if fs.exists("/modules.lua") == true then 
    fs.delete("/modules.lua") 
    io.write("Deleted old modules.lua file.\n")
end
 
local response = http.get("https://raw.githubusercontent.com/Sixmax/CC-Scripts/main/modules.lua")
 
if not response then 
    io.write("Failed to retrieve module lib code! (Check Pastebin)\n")
    return 
end
 
io.write("Received Response.\n")
 
local handle = fs.open("/modules.lua", "w")
 
handle.write(response.readAll())
 
io.write("'modules.lua' created.\n")
 
handle.close()
response.close()
 
io.write("\nInitializing Turtle Libraries...\n")
 
os.loadAPI("/modules.lua")
 
local function load(file, id)
    modules.loadPaste(file, id)
    io.write("Loaded '" .. file .. "' (" .. id .. ")\n")
end
 
load("localPos", "libraries/localpos.lua")
 
io.write("Turtle Initialized.\n")