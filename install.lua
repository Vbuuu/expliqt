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

local bSelection = 1

local w, h = term.getSize()

local function drawInstallerMode()
    term.clear()
    term.setTextColor(colors.cyan)
    term.setCursorPos(math.floor((2-#)))

local function drawBranchSelect()
    term.clear()
    for i,v in pairs(choices) do
        if i == bSelection then
            term.setTextColor(colors.cyan)
            term.setCursorPos(math.floor((w-#v.name)/2 - 1), (i - bSelection) + math.floor(h/2))
            term.write("["..v.name.."]")
            term.setTextColor(colors.white)
        else
            term.setCursorPos(math.floor((w-#v.name)/2), (i - bSelection) + math.floor(h/2))
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

local branchSelecting = true

while branchSelecting do
    drawBranchSelect()
    local e, id = os.pullEvent("key")
    if id == keys.up then
        bSelection = bSelection - 1
        if bSelection < 1 then
            bSelection = 1
        end
    elseif id == keys.down then
        bSelection = bSelection + 1
        if bSelection > max then
            bSelection = max
        end
    elseif id == keys.enter then
        break
    end
end

term.clear()
term.setCursorPos(1,1)

local url = getURL(bSelection)
print("Are you sure you want to proceed? y/n")

local r = read()

if r == "y" then
    local func = loadstring(http.get(url.."install.lua").readAll())
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