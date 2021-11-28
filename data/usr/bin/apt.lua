local args={...}
if (args[1] == "update") then
    if (fs.isDir("/etc/apt")) then
        repoList = fs.list("/etc/apt")
        repoFiles = {}
        for i,v in ipairs(repoList) do
            repoFiles[i] = "/etc/apt/"..v
        end
        for i,v in ipairs(repoFiles) do
            print(v)
            local repofile = fs.open(v, "r")
            local repoURL = repofile.readAll()
            repofile.close()
            print(repoURL)
        end
    end
elseif (args[1] == "install") then

else
    print("First argument didn't match any known functions.")
end