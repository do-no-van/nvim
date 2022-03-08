local M = {}

local api = vim.api
local diagnostic = vim.diagnostic
local fn = vim.fn

local ns = api.nvim_create_namespace("clippy_lints")

-- Parse the output ov `cargo clippy` into a list of files mapped lists of diagnostics
local function parse_clippy(raw_output, show_errors)
    local file_next = false
    local file = ""
    local in_msg = false
    local message = ""
    local severity

    local diagnostics = {}

    -- Get sets of one or more characters that aren't whitespace
    for word in string.gmatch(raw_output, "[^%s]+") do
        if string.find(word, "^", nil, true) then
            local diagnostic_len = string.len(word)

            if message ~= "" then
                -- The file name, line number, and column are seperated by colons
                local file_info = string.gmatch(file, "[^:]+")

                local file_name = file_info()
                local lnum = tonumber(file_info()) - 1
                local col = tonumber(file_info()) - 1

                if not diagnostics[file_name] then
                    diagnostics[file_name] = {}
                end

                table.insert(
                    diagnostics[file_name],
                    {
                        lnum = lnum,
                        col = col,
                        end_col = col + diagnostic_len,
                        severity = severity,
                        message = message,
                        source = "clippy",
                    }
                )

                message = ""
            end
        elseif file_next then
            file = word
            file_next = false
        elseif in_msg then
            if word == "-->" then
                in_msg = false

                file_next = true
            else
                message = message .. word .. " "
            end
        elseif word == "warning:" then
            in_msg = true
            severity = diagnostic.severity.WARN
        elseif show_errors and string.match(word, "]:$") then
            in_msg = true
            severity = diagnostic.severity.ERROR
        end
    end

    return diagnostics
end

-- Get the buffer of a file or return nil if the file has not been opened
local function get_buf_by_file_name(file_name)
    for _, buf in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_is_loaded(buf) then
            local buf_file = api.nvim_buf_get_name(buf)

            -- Check if the buffer's file ends with `file_name`
            if string.find(buf_file, file_name.."$") then
                return buf
            end
        end
    end
end

-- Clear previous diagnostics
M.clear = function()
    diagnostic.reset(ns)
end

-- Asynchronously set diagnostics based on the output of `cargo clippy`
-- `show_errors` defaults to false
M.clippy = function(show_errors)
    fn.jobstart("cargo clippy", {
        stderr_buffered = true,
        on_stderr = function(_, data, _) -- We don't need the job id or event
            M.clear()

            -- `stderr` is passed to `on_stderr` as a list of strings
            local raw_output = table.concat(data, " ")

            for file_name, file_diagnostics in pairs(parse_clippy(raw_output, show_errors)) do
                local file_buf = get_buf_by_file_name(file_name)

                if file_buf then
                    diagnostic.set(ns, file_buf, file_diagnostics)
                end
            end
        end,
    })
end

-- Editor commands for convenience
api.nvim_add_user_command("Clippy", "lua require('cargo_clippy').clippy()", {})
api.nvim_add_user_command("ClippyErr", "lua require('cargo_clippy').clippy(true)", {})
api.nvim_add_user_command("ClippyClear", "lua require('cargo_clippy').clear()", {})

return M

