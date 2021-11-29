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
            local repo = http.get(repoURL .. "/packages.json")
            if (fs.exists("/var/cache/apt/00_linux_clone")) then
                if (fs.isDir("/var/cache/apt/00_linux_clone")) then
                    local repofile = fs.open("/var/cache/apt/00_linux_clone/packages.json", "w")
                    repofile.write(repo.readAll())
                    repofile.close()
                    repo.close()
                end
            else
                fs.makeDir("/var/cache/apt/00_linux_clone")
                local repofile = fs.open("/var/cache/apt/00_linux_clone/packages.json", "w")
                repofile.write(repo.readAll())
                repofile.close()
                repo.close()
            end
            print("Done")
            print("********")
        end
    end
elseif (args[1] == "install") then

else
    print("First argument didn't match any known functions.")
end