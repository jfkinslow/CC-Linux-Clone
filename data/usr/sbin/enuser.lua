local args = {...}
local usersFile = fs.open("/etc/passwd", "r")
local usersJSON = usersFile:readAll()
usersFile.close()
if #args == 1 then
    if (args[1] ~= "root") then
        print(textutils.unserializeJSON(usersJSON))
        local users = textutils.unserializeJSON(usersJSON) or print("Error reading json")
        local admin = false
        local userIndex = nil
        for i, v in ipairs(users) do
            if (v.username == settings.get("login.user")) then
                if (v.admin == true) then
                    admin = true
                end
            elseif (v.username == args[1]) then
                userIndex = i
            end
        end
        if (admin == true) then
            if (userIndex ~= nil) then
                users[userIndex].enabled = true
                usersFile = fs.open("/etc/passwd", "w")
                usersFile.write(textutils.serializeJSON(users))
                usersFile.close()
            else
                print("Error: No user found with specified username.")
            end
        else
            print("Error: must be admin to run this command.")
        end
    else
        print("Error: Cannot be used on user root.")
    end
else
    print("Usage: enuser <username>")
end