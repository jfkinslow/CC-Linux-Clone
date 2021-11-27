local args={...}
if (args[2] == "update") then
    if (fs.isDir("/etc/apt")) then
        repoList = fs.list("/etc/apt")
        for i,v in ipairs(repoList) do
            print(v)
        end
    end
elseif (args[2] == "install") then

else
    print("First argument didn't match any known functions.")
end