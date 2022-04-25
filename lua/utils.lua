local api = vim.api
local keymap = vim.keymap
local diagnostic = vim.diagnostic
local cmd = vim.cmd
local lsp = vim.lsp

local M = {}

local modes_short = {
    ["normal_visual"] = "",
    ["normal"] = "n",
    ["insert"] = "i",
    ["visual"] = "v",
    ["terminal"] = "t",
}

M.map = function(all_bindings)
    for mode, bindings in pairs(all_bindings) do
        for key, binding in pairs(bindings) do
            local options = { noremap = true }

            if type(binding) == "table" then
                vim.tbl_extend("force", options, binding[2])
                binding = binding[1]
            end

            keymap.set(modes_short[mode], key, binding, options)
        end
    end
end


M.diagnostic_or_hover = function()
    local buf, _ = diagnostic.open_float(nil, { focus = false })
    if not buf then
        lsp.buf.hover()
    end
end


local function open_term_win()
    local height = api.nvim_get_option("lines")
    cmd(math.floor(height * 2 / 5) .. "split")
end

local terminal_buf = -1
local terminal_win = -1
M.toggle_term = function()
    if terminal_buf == -1 then
        open_term_win()
        cmd("terminal!")
        cmd("startinsert")

        terminal_buf = api.nvim_get_current_buf()
        terminal_win = api.nvim_get_current_win()
    elseif api.nvim_get_current_win() == terminal_win then
        api.nvim_win_close(terminal_win, false)
        terminal_win = -1
    else
        if terminal_win == -1 or not api.nvim_win_is_valid(terminal_win) then
            open_term_win()
            terminal_win = api.nvim_get_current_win()

            if api.nvim_buf_is_valid(terminal_buf) then
                api.nvim_set_current_buf(terminal_buf)
            else
                cmd("terminal!")
                cmd("startinsert")
            end
        end

        api.nvim_set_current_win(terminal_win)
        cmd("startinsert")
    end
end

local function silent_write()
    cmd("silent write")
end

M.autosave = function()
    silent_write()

    api.nvim_create_autocmd("TextChanged,TextChangedI", {
        pattern = "<buffer>",
        callback = silent_write,
    })
end

api.nvim_create_user_command("Autosave", "lua require('utils').autosave()", {})

return M

