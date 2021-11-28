local currentDir = shell.dir()
if (currentDir == "") then
    print("/")
else
    print("/"..currentDir)
end