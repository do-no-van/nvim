local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

local M = {}

cmd("highlight AsciiBorder    guifg=#280068")
cmd("highlight Ascii          guifg=#280068 guibg=#3f007f")

local NVIM_VERSION = "NVIM " .. fn.system('nvim --version | head -n 1 | awk \'{print $2}\''):gsub("\n", "")

local function pad_str(padding, string)
    for _ = 1, padding do
        string = " " .. string
    end

    return string
end

-- one block character is not one coordinate to the right, so these work
-- even though they look completely random

-- end of left border, start of right border
-- borders are non-full blocks on the edge
-- they are done seperatly since they shouldn't change their background color
-- i.e. { <c1>, <c2> } = ▂▂▄▄<c1>████<c2>▄▄▂▂
local ascii_coords = {
    { 25, 28 },
    { 38, 50 },
    { 22, 67 },
    { 14, 77 },
    { 14, 57 },
    { 11, 48 },
    { 18, 56 },
    {  8, 87 },
    {  8, 79 },
    { 18, 62 },
    { 11, 59 },
    { 14, 51 },
    { 16, 81 },
    { 18, 69 },
    { 37, 50 },
    { 25, 28 },
}

local function color_buf(buf, padding)
    local start_y = 1 -- newlines before drawing text
    local ns = api.nvim_create_namespace("ascii_ns")

    for line, coord in ipairs(ascii_coords) do
        api.nvim_buf_add_highlight(
            buf,
            ns,
            "AsciiBorder",
            line + start_y - 1,
            0,
            coord[1] + padding
        )

        api.nvim_buf_add_highlight(
            buf,
            ns,
            "Ascii",
            line + start_y - 1,
            coord[1] + padding,
            coord[2] + padding - 1
        )

        api.nvim_buf_add_highlight(
            buf,
            ns,
            "AsciiBorder",
            line + start_y - 1,
            coord[2] + padding - 1,
            1000 -- this can be any large number, it just means continue highlighting until this col
        )
    end

    -- darken instances of the word <Enter>
    for _, coord in ipairs({ { 23, 17, 23 }, { 24, 19, 25 }, { 25, 9, 15 }, { 26, 12, 18 } }) do
        api.nvim_buf_add_highlight(
            buf,
            ns,
            "Comment",
            coord[1] - 1,
            coord[2] + padding - 1,
            coord[3] + padding
        )
    end
end

local ascii = {
    "                                              ", -- this line needs to be the same length as the
    "                   ▁▁▁▁▁▁▁",                     -- longest line for padding to work correctly
    "             ▁▁▄▄▟█████████▙▄▄▁▁",
    "            ▟███████████████████▙",
    "          ▄████▛▀▀▀▀▀▀▀▀▀▀▀▀▀▜████▄",
    "         ▟████▛               ▜████▙",
    "        ▟████▛                 ▜████▙",
    "       ▐████▛                   ▜████▌",
    "       ████▛                     ▜████",
    "       ████▙                     ▟████",
    "       ▐████▙                   ▟████▌",
    "        ▜████▙                 ▟████▛",
    "         ▜████▙               ▟████▛",
    "          ▀████▙▄▄▄▄▄▄▄▄▄▄▄▄▄▟████▀",
    "            ▜███████████████████▛",
    "             ▔▔▀▀▜█████████▛▀▀▔▔",
    "                   ▔▔▔▔▔▔▔",
    "__NVIM_VERSION__",
    "",
    " Nvim is open source and freely distributable",
    "            https://neovim.io/#chat",
    "",
    "type  :help nvim<Enter>       if you are new",
    "type  :checkhealth<Enter>     to optimize Nvim",
    "type  :q<Enter>               to exit",
    "type  :help<Enter>            for help",
}

local function reset_start_screen()
    cmd("enew")
    local buf = api.nvim_get_current_buf()
    local win = api.nvim_get_current_win()

    api.nvim_buf_set_option(buf, "modifiable", true)
    api.nvim_buf_set_option(buf, "buflisted", true)
    api.nvim_buf_set_option(buf, "buflisted", true)
    api.nvim_win_set_option(win, "colorcolumn", "80,100")
    api.nvim_win_set_option(win, "relativenumber", true)
    api.nvim_win_set_option(win, "number", true)
    api.nvim_win_set_option(win, "list", true)
end

M["set_ascii_bg"] = function()
    local height = api.nvim_get_option("lines")
    local width = api.nvim_get_option("columns")
    local ascii_rows = #ascii
    local ascii_cols = #ascii[1]
    local pad_cols = math.floor((width - ascii_cols) / 2)
    local win = api.nvim_get_current_win()
    local buf = api.nvim_create_buf(true, true)

    -- only display if there is enough space
    if height >= ascii_rows and width >= ascii_cols then
        for i, _ in ipairs(ascii) do
            if ascii[i] == "__NVIM_VERSION__" then
                -- center version number before padding it
                ascii[i] = pad_str(pad_cols, pad_str(math.ceil((ascii_cols - #NVIM_VERSION) / 2), NVIM_VERSION))
            elseif ascii[i] ~= "" then
                ascii[i] = pad_str(pad_cols, ascii[i])
            end
        end

        api.nvim_buf_set_lines(buf, 0, -1, false, ascii)
        color_buf(buf, pad_cols)

        api.nvim_buf_set_option(buf, "modified", false)
        api.nvim_buf_set_option(buf, "buflisted", false)
        api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        api.nvim_buf_set_option(buf, "buftype", "nofile")
        api.nvim_buf_set_option(buf, "swapfile", false)
        api.nvim_win_set_option(win, "colorcolumn", "")
        api.nvim_win_set_option(win, "relativenumber", false)
        api.nvim_win_set_option(win, "number", false)
        api.nvim_win_set_option(win, "list", false)
        api.nvim_set_current_buf(buf)

        api.nvim_create_autocmd("InsertEnter,WinEnter", {
            pattern = "<buffer>",
            callback = reset_start_screen,
        })
    end
end

return M
