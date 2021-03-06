os.pullEvent = os.pullEventRaw
shell.run("/startup/00_path")
term.clear()
term.setCursorPos(1,1)
if term.isColor() then
    term.setTextColor(colors.yellow)
    shell.run("/bin/version")
    term.setTextColor(colors.white)
else
    shell.run("/bin/version")
end
if (settings.get("motd.enable") == true) then
    local motd = shell.resolveProgram("motd")
    shell.run("/"..motd)
end
if settings.get("login.currentShellDepth") ~= nil then
    settings.set("login.currentShellDepth", tonumber(settings.get("login.currentShellDepth")) + 1)
else
    settings.set("login.currentShellDepth", 0)
end
local homedir = settings.get("login.home")
local profile = homedir.."/.bash_profile.lua"
local PS1 = ""
if (fs.exists(profile)) then
    shell.run(profile)
end
if (settings.get("PS1") ~= nil) then
    PS1 = settings.get("PS1")
else
    if pocket then
        PS1 = settings.get("login.user").." "..curDirShown.." # "
    else
        PS1 = settings.get("login.user").."@"..settings.get("login.hostname").." "..curDirShown.." # "
    end
end
local ctrl = false
local running = true
local history = {}
function exitBash()
    term.clear()
    term.setCursorPos(1,1)
    if (settings.get("login.shell") == "/bin/bash") then
       if (tonumber(settings.get("login.currentShellDepth")) == 0) then
           shell.run("/bin/logout")
       else
           settings.set("login.currentShellDepth", tonumber(settings.get("login.currentShellDepth")) - 1)
           running = false
       end
    else
        settings.set("login.currentShellDepth", tonumber(settings.get("login.currentShellDepth")) - 1)
        running = false
    end
end
function keyboard_shortcuts()
    while running do
        local event, key = os.pullEvent()
        if (event == "key") then
            if (key == keys.leftCtrl) then
                ctrl = true
            elseif (key == keys.d) then
                if (ctrl == true) then
                    exitBash()
                    break
                end
            end
        elseif (event == "key_up") then
            if (key == keys.leftCtrl) then
                ctrl = false
            end
        end
    end
end
function mainLoop()
    while running do
        local currentDir = "/"..shell.dir()
        local curDirShown = currentDir
        if (currentDir == settings.get("login.home")) then
            curDirShown = "~"
        end
        local programName = ""
        if term.isColor() then
            term.setTextColor(colors.yellow)
            programName = read(nil, history, shell.complete, PS1)
            term.setTextColor(colors.white)
        else
            programName = read(nil, history, shell.complete, PS1)
        end
        
        local args = ""
        if string.find(programName, " ") then
            local start = string.find(programName, " ")
            args = string.sub(programName, start+1)
            programName = string.sub(programName, 1, start-1)
            print("Program: "..programName)
            print("Args: "..args)
        end
        if programName == "exit" then
            exitBash()
            break
        end
        local program = shell.resolveProgram(programName)
        if program == nil then
            term.setTextColor(colors.red)
            print("No Program Found")
            term.setTextColor(colors.white)
        else
            shell.run("/"..program.." "..args)
        end
    end
end

parallel.waitForAny(mainLoop, keyboard_shortcuts)
exitBash()
--mainLoop()
