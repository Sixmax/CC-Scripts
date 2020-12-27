io.write("Loading Module Library...\n")
 
if fs.exists("/modules.lua") == true then 
    fs.delete("/modules.lua") 
    io.write("Deleted old modules.lua file.\n")
end
 
local response = http.get("http://www.pastebin.com/raw.php?i=ccKjkV4z")
 
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
 
load("/localPos", "YFf0kAkm")
 
io.write("Turtle Initialized.\n")