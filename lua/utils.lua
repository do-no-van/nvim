local api = vim.api
local keymap = vim.keymap
local diagnostic = vim.diagnostic
local cmd = vim.cmd

local M = {}

-- access mode by name instead of a single character
local modes_short = {
	["normal_visual"] = "",
	["normal"] = "n",
	["insert"] = "i",
	["visual"] = "v",
	["terminal"] = "t",
}

M.map = function(all_bindings, buffer)
	for mode, bindings in pairs(all_bindings) do
		for key, binding in pairs(bindings) do
			local options = { noremap = true }

			if buffer then
				options.buffer = true
			end

			if type(binding) == "table" then
				vim.tbl_extend("force", options, binding[2])
				binding = binding[1]
			end

			keymap.set(modes_short[mode], key, binding, options)
		end
	end
end


M.diagnostic_or = function(callback) -- used for hover, callback because rust-tools provides an alternative to the lsp hover
	local buf, _ = diagnostic.open_float(nil, { focus = false })
	if not buf then
		callback()
	end
end


local function open_term_win()
	local height = api.nvim_get_option("lines")
	cmd(math.floor(height * 2 / 5) .. "split") -- the terminal window takes up 2 / 5 of the vectical space
end

local terminal_buf = -1
local terminal_win = -1
M.toggle_term = function()
	if terminal_buf == -1 then -- create terminal if it doesn't already exist
		open_term_win()
		cmd("terminal!")
		cmd("startinsert")

		terminal_buf = api.nvim_get_current_buf()
		terminal_win = api.nvim_get_current_win()
	elseif api.nvim_get_current_win() == terminal_win then -- close window if in the terminal
		api.nvim_win_close(terminal_win, false)
		terminal_win = -1
	else -- open a preexisting terminal buffer
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

return M
