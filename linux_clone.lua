local args = {...}
if #args == 1 then
    local command = args[1]
    if (command == "install") then
        print(fs.delete("/*"))
    elseif (command == "update") then

    else
        print("Usage: linux_clone install|update")
        print("install: Installs a fresh copy of CC-Linux-Clone")
        print("update: updates the already installed copy of CC-Linux-Clone")
    end
end