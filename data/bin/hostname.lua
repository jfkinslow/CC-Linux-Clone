local args = {...}
local hostnameFile = fs.open("/etc/hostname", "r")
local hostname = hostnameFile:readAll()
local short = false
for i, v in ipairs(args) do
    if (v == "-s" or v == "--short") then
        short = true
    end
end
if (short == true) then
    local i, j = string.find(hostname, "[.]")
    local hostnameShort = string.sub(hostname, 1, i-1)
--    print("i="..i..", j="..j)
    print(hostnameShort)
else
    print(hostname)
    shell.run("/bin/version")
end
