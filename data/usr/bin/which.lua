local args = {...}
local programName = ""
function printUsage()
    print("Usage: which <program>")
end
for i,v in ipairs(args) do
    if i == 1 then
        programName = v
    end
end
term.write(programName..": ")
local programs = shell.programs()
for i,v in ipairs(programs) do
    if v:find(programName) then
        local program = shell.resolveProgram(v)
        print("/"..program)
    end
end