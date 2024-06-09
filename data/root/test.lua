local completion = require "cc.shell.completion"
local completeFunc = completion.build(
{ completion.file, many = false}
)
shell.setCompletionFunction("root/test.lua", completeFunc)
