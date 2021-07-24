local completion = require "cc.shell.completion"
local complete = completion.build(
    { completion.file, many = false }
)
shell.setCompletionFunction("bin/edit.lua", shell.complete)
local args = {...}
if #args == 1 then
    local usersFile = fs.open("/etc/passwd", "r")
    local users = textutils.unserializeJSON(usersFile:readAll())
    usersFile.close()
    local admin = false
    for i, v in ipairs(users) do
        if v.username == settings.get("login.user") then
            if v.admin == true then
                admin = true
            end
        end
    end
    if fs.isDir(args[1]) then
        print("Error: Unable to edit a directory.")
    else
        if args[1]:find("/etc") then
            if admin == true then
                shell.run("/rom/programs/edit", args[1])
            else
                print("Unable to edit the specified file")
            end
        elseif args[1]:find("/var") then
            if admin == true then
                shell.run("/rom/programs/edit", args[1])
            else
                print("Unable to edit the specified file")
            end
        elseif args[1]:find("/bin") then
            if admin == true then
                shell.run("/rom/programs/edit", args[1])
            else
                print("Unable to edit the specified file")
            end
        elseif args[1]:find("/usr/bin") then
            if admin == true then
                shell.run("/rom/programs/edit", args[1])
            else
                print("Unable to edit the specified file")
            end
        elseif args[1]:find("/usr/sbin") then
            if admin == true then
                shell.run("/rom/programs/edit", args[1])
            else
                print("Unable to edit the specified file")
            end
        else
            shell.run("/rom/programs/edit", args[1])
        end
    end
else
    print("Usage: edit <path>")
end
