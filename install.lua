term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.white)

print("Welcome to the installer!")
print("Press Enter to continue...")
read("")


term.clear()
term.setCursorPos(1,1)

print("Fetching versions...")

local handle = http.get("http://raw.githubusercontent.com/Vbuuu/Expliqt/misc/versions.lua")
local data = handle.readAll()

print("Loading versions...")

local choices = loadstring(data)()
local max = #choices

local selection = 1

local w, h = term.getSize()

local function draw()
    term.clear()
    for i,v in pairs(choices) do
        if i == selection then
            term.setTextColor(colors.cyan)
            term.setCursorPos(math.floor((w-#v.name)/2 - 1), (i - selection) + math.floor(h/2))
            term.write("["..v.name.."]")
            term.setTextColor(colors.white)
        else
            term.setCursorPos(math.floor((w-#v.name)/2), (i - selection) + math.floor(h/2))
            term.write(v.name)
        end
    end
end

local function getURL(id)
    local url = choices[id].source
    if type(url) == "number" then
        return getURL(url)
    else
        return url
    end
end

local go = true

while go do
    draw()
    local e, id = os.pullEvent("key")
    if id == keys.up then
        selection = selection - 1
        if selection < 1 then
            selection = 1
        end
    elseif id == keys.down then
        selection = selection + 1
        if selection > max then
            selection = max
        end
    elseif id == keys.enter then
        break
    end
end

term.clear()
term.setCursorPos(1,1)

local url = getURL(selection)
print("Are you sure you want to proceed? y/n")

local r = read()

if r == "y" then
    local func = loadstring(http.get(url).readAll())
    setfenv(func,_G)
    func("Expliqt")
    print("Installing Expliqt.")
else
    print("Bro ur stupid.")
    return
end

print("Press ENTER to reboot")
read()
os.reboot()