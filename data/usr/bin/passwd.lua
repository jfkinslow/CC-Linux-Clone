local usersFile = fs.open("/etc/passwd", "r")
local usersJSON = usersFile:readAll()
usersFile:close()
local users = textutils.unserializeJSON(usersJSON)
term.write("New Password: ")
local newPass = read(" ")
term.write("Confirm Password: ")
local confirmPass = read(" ")
for i, v in ipairs(users) do
    if v.username == settings.get("login.user") then
        if (newPass == confirmPass) then
            v.password = newPass
            usersFile = fs.open("/etc/passwd", "w")
            usersJSON = textutils.serializeJSON(users)
            usersFile.write(usersJSON)
            usersFile.close()
            print("Password has been changed.")
        else
            print("Error: Passwords do not match.")
        end
    end
end