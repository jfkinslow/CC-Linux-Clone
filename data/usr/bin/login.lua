os.pullEvent = os.pullEventRaw
local usersFile = fs.open("/etc/passwd", "r")
local usersJSON = usersFile:readAll()
local users = textutils.unserializeJSON(usersJSON)
local hostnameFile = fs.open("/etc/hostname", "r")
local hostname = hostnameFile:readAll()
settings.set("login.hostname", hostname)
term.clear()
term.setCursorPos(1,1)
if term.isColor() then
    term.setTextColor(colors.yellow)
    print("JKOS 1.0")
    term.setTextColor(colors.white)
else
    print("JKOS 1.0")
end
while true do
    term.write("Username: ")
    local user = read()
    term.write("Password: ")
    term.setCursorBlink(false)
    local pass = read("")
    term.setCursorBlink(true)
    local authed = false
    local homedir = ""
    local loginshell = ""
    local reason = nil
    for i,v in ipairs(users) do
        if v.username == user then
            if v.password == pass then
                if v.enabled == true then
                    authed = true
                    homedir = v.home
                    loginshell = v.shell
                    break
                else
                    reason = "This user account is disabled"
                    break
                end
            end
        end
    end
    if authed == true then
        settings.set("login.user", user)
        settings.set("login.home", homedir)
        settings.set("login.shell", loginshell)
        if (fs.exists(homedir)) then
            shell.setDir(homedir)
        else
            fs.makeDir(homedir)
            shell.setDir(homedir)
        end
        if loginshell ~= "default" then
            shell.run(loginshell)
        end
        term.clear()
        term.setCursorPos(1,1)
        if term.isColor() then
            term.setTextColor(colors.yellow)
            print("JKOS 1.0")
            print("ComputerID: "..os.getComputerID())
            print("Logged in as: "..user)
            term.setTextColor(colors.white)
        else
            print("JKOS 1.0")
            print("ComputerID: "..os.getComputerID())
            print("Logged in as: "..user)
        end
        if (settings.get("motd.enable") == true) then
            local motd = shell.resolveProgram("motd")
            shell.run("/"..motd)
        end
        break
    else
        if reason == nil then
            print("Did not recognize those credentials.")
        else
            print(reason)
        end
    end
end