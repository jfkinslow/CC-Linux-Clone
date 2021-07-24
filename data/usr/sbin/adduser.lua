local args = {...}
local assocArgs = {}
function tobool(value)
    if type(value) == "string" then
        if value == "true" then
            return true
        elseif value == "false" then
            return false
        else
            error("Unable to convert from "..value.." to boolean.")
        end
    elseif type(value) == "number" then
        if value == 1 then
            return true
        elseif value == 0 then
            return false
        else
            error("Unable to convert from "..value.." to boolean")
        end
    end
end
for i,v in ipairs(args) do
    if v == "--home" then
        assocArgs["home"] = args[i+1]
    elseif v == "--shell" then
        assocArgs["shell"] = args[i+1]
    elseif v == "--enabled" then
        assocArgs["enabled"] = tobool(args[i+1])
    elseif v == "--password" then
        assocArgs["password"] = args[i+1]
    elseif v == "--admin" then
        assocArgs["admin"] = tobool(args[i+1])
    else
        assocArgs["username"] = args[i]
    end
end
local usersFile = fs.open("/etc/passwd", "r")
local usersJSON = usersFile:readAll()
usersFile.close()
local users = textutils.unserializeJSON(usersJSON)
local admin = false
for i,v in ipairs(users) do
    if (v.username == settings.get("login.user")) then
        if (v.admin == true) then
            admin = true
        end
    end
end
if (admin == true) then
    local newUser = {}
    for i, v in pairs(assocArgs) do
        print("i="..tostring(i)..", v="..tostring(v))
        newUser[i] = v
    end
    table.insert(users, #users + 1, newUser)
    usersJSON = textutils.serializeJSON(users)
    usersFile = fs.open("/etc/passwd", "w")
    usersFile.write(usersJSON)
    usersFile.close()
    if (assocArgs["home"]) then
        if not fs.exists(assocArgs["home"]) then
            fs.makeDir(assocArgs["home"])
        end
    else
        if not fs.exists("/home/"..assocArgs["user"]) then
            fs.makeDir("/home/"..assocArgs["user"])
        end
    end
else
    print("Error: This command requires admin to use")
end