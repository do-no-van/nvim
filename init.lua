local fn = vim.fn
local opt = vim.opt

require("utils")
require("options")
require("mappings")
require("plugins")
require("plugin_configs")

-- Check if there were args (i.e. opened file), non-empty buffer, or started in insert mode
if fn.argc() == 0 or fn.line2byte("$") ~= -1 and not opt.insertmode then
    require("ascii_bg").set_ascii_bg()
end
