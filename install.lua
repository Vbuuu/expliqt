local w, h = term.getSize()

term.setCursorPos(h/2,w/2)
print("Expliqt Installer v0.1")
print("Press Enter to continue...")
read("")

term.clear()
term.setCursorPos(1,1)

local versions = http.get("https://raw.githubusercontent.com/Vbuuu/Expliqt/misc/versions.lua").readAll()
local choices = loadstring(versions)()
local max = #choices
local selection = 1
local selecting = true
local url = getURL(selection)

local function draw()
    term.clear()
    for i,v in ipairs(choices) do
        if i == selection then
            term.setCursorPos(math.floor((w-#v.name)/2 - 1), (i - selection) + math.floor(h/2))
            term.write("["..v.name.."]")
            term.setTextColor(colors.green)
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

while selecting do
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

print("Final Warning: are you sure, you wanna install Expliqt os? y/n")
local r = read()

if r == "y" then
    local func = loadstring(http.get(url).readAll())
    setfenv(func,_G)
    func("Expliqt")
    print("Installation complete!")
else
    print("Installation aborted! Stupid Idiot")
end