local h,w = term.getSize()

term.setCursorPos(h/2,w/2)
print("Expliqt Installer v0.1")
print("Press Enter to continue...")
read("")

term.clear()
term.setCursorPos(1,1)

versions = http.get("https://raw.githubusercontent.com/Vbuuu/Expliqt/misc/versions.lua")