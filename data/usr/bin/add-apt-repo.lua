local args = {...}
local repoName = args[1]
local repoFileNamePartOne = string.sub(repoName, 1, string.find(repoName, "/")-1)
print(repoFileNamePartOne)
local repoFileNamePartTwo = string.sub(repoName, string.find(repoName, "/")+1, string.len(repoName))
print(repoFileNamePartTwo)
local repoFileName = repoFileNamePartOne .. "_" .. repoFileNamePartTwo .. ".repo"
print(repoFileName)
local versionFile = fs.open("/etc/version", "r")
local version = versionFile.readAll()
versionFile.close()
local repoLocation = "https://raw.githubusercontent.com/" .. repoName .. "/" .. version
print(repoLocation)
local repo = http.get(repoLocation.."/packages.json")
if (repo) then
    local repoFile = fs.open("/etc/apt/" .. repoFileName, "w")
    repoFile.write(repoLocation)
    repoFile.close()
    print("Done..")
else
    print("Cannot add repo "..repoName.." as it does not exist as a repository on github or does not meet the required structure for the apt repository.")

