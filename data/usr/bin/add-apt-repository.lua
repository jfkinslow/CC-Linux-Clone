local args = {...}
local repoName = args[1]
local repoFileNamePartOne = string.sub(repoName, 1, string.find(repoName, "/"))
print(repoFileNamePartOne)