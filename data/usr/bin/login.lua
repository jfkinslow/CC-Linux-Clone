os.pullEvent = os.pullEventRaw
local usersFile = fs.open("/etc/passwd", "r")
local usersJSON = usersFile:readAll()
local users = textutils.unserializeJSON(usersJSON)
local hostnameFile = fs.open("/etc/hostname", "r")
local hostname = hostnameFile:readAll()
settings.set("login.hostname", hostname)
term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.yellow)
print("JKOS 1.0")
term.setTextColor(colors.white)
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
    for i,v in ipairs(users) do
        if v.username == user then
            if v.password == pass then
                authed = true
                homedir = v.home
                loginshell = v.shell
                break
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
        if loginshell ~= "" then
            shell.run(loginshell)
        end
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.yellow)
        print("JKOS 1.0")
        print("ComputerID: "..os.getComputerID())
        print("Logged in as: "..user)
        term.setTextColor(colors.white)
        if (settings.get("motd.enable") == true) then
            local motd = shell.resolveProgram("motd")
            shell.run("/"..motd)
        end
        break
    else
        print("Did not recognize those credentials.")
    end
end
