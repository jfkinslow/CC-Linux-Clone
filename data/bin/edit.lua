local completion = require "cc.shell.completion"
local complete = completion.build(
    {completion.file, many=false}
)
shell.setCompletionFunction("bin/edit.lua", complete)
local usersFile = fs.open("/etc/passwd", "r")
local users = textutils.unserializeJSON(usersFile:readAll())
local currentUser = {}
usersFile.close()
for i, v in ipairs(users) do
    if (v.username == settings.get("login.user")) then
        currentUser = v
    end
end
local args = {...}
if (#args > 0) then
    if (args[1]:find("/bin") or args[1]:find("/etc") or args[1]:find("/usr/bin") or args[1]:find("/usr/sbin")) then
        if (currentUser.admin == true) then
            shell.run("/rom/programs/edit", args[1])
        else
            print("Error: Admin required to access the specified file")
        end
    else
        shell.run("/rom/programs/edit", args[1])
    end
else
    shell.run("/rom/programs/edit")
end
