local api = vim.api

local none = "none"
local black = "#191a1c"
local cursor_pos_bg = "#252525"
local bg0 = "#2c2d30"
local bg1 = "#35373b"
local bg2 = "#3e4045"
local bg3 = "#404247"
local bg_d = "#242628"
local bg_blue = "#79b7eb"
local bg_yellow = "#e6cfa1"
local fg = "#b1b4b9"
local purple = "#c27fd7"
local green = "#99bc80"
local orange = "#c99a6e"
local blue = "#68aee8"
local yellow = "#dfbe81"
local cyan = "#5fafb9"
local red = "#e16d77"
local grey = "#646568"
local light_grey = "#8b8d91"
local dark_cyan = "#316a71"
local dark_red = "#914141"
local dark_yellow = "#8c6724"
local dark_purple = "#854897"
local diff_add = "#32352f"
local diff_delete = "#342f2f"
local diff_change = "#203444"
local diff_text = "#32526c"

local hl = {}

hl.common = {
	Normal = { fg = fg, bg = bg0 },
	Terminal = { fg = fg, bg = bg0 },
	EndOfBuffer = { fg = bg0, bg = bg0 },
	FoldColumn = { fg = fg, bg = bg1 },
	Folded = { fg = fg, bg = bg1 },
	SignColumn = { fg = fg, bg = bg0 },
	Cursor = { reverse = true },
	vCursor = { reverse = true },
	iCursor = { reverse = true },
	lCursor = { reverse = true },
	CursorIM = { reverse = true },
	CursorColumn = { bg = cursor_pos_bg },
	CursorLine = { bg = cursor_pos_bg },
	ColorColumn = { bg = bg1 },
	CursorLineNr = { fg = "#eeeeee" },
	LineNr = grey,
	Conceal = { fg = grey, bg = bg1 },
	DiffAdd = { fg = none, bg = diff_add },
	DiffChange = { fg = none, bg = diff_change },
	DiffDelete = { fg = none, bg = diff_delete },
	DiffText = { fg = none, bg = diff_text },
	DiffAdded = green,
	DiffRemoved = red,
	DiffFile = cyan,
	DiffIndexLine = grey,
	Directory = blue,
	ErrorMsg = { fg = red, bold = true },
	WarningMsg = { fg = yellow, bold = true },
	MoreMsg = { fg = blue, bold = true },
	CurSearch = { fg = bg0, bg = orange },
	IncSearch = { fg = bg0, bg = orange },
	Search = { fg = bg0, bg = bg_yellow },
	Substitute = { fg = bg0, bg = green },
	MatchParen = { fg = none, bg = grey },
	NonText = grey,
	Whitespace = grey,
	SpecialKey = grey,
	Pmenu = { fg = fg, bg = bg1 },
	PmenuSbar = { fg = none, bg = bg1 },
	PmenuSel = { fg = bg0, bg = bg_blue },
	WildMenu = { fg = bg0, bg = blue },
	PmenuThumb = { fg = none, bg = grey },
	Question = yellow,
	SpellBad = { fg = red, underline = true, sp = red },
	SpellCap = { fg = yellow, underline = true, sp = yellow },
	SpellLocal = { fg = blue, underline = true, sp = blue },
	SpellRare = { fg = purple, underline = true, sp = purple },
	StatusLine = { fg = fg, bg = bg2 },
	StatusLineTerm = { fg = fg, bg = bg2 },
	StatusLineNC = { fg = grey, bg = bg1 },
	StatusLineTermNC = { fg = grey, bg = bg1 },
	TabLine = { fg = fg, bg = bg1 },
	TabLineFill = { fg = grey, bg = bg1 },
	TabLineSel = { fg = bg0, bg = fg },
	VertSplit = bg3,
	Visual = { bg = bg3 },
	VisualNOS = { fg = none, bg = bg2, underline = true },
	QuickFixLine = { fg = blue, underline = true },
	Debug = yellow,
	debugPC = { fg = bg0, bg = green },
	debugBreakpoint = { fg = bg0, bg = red },
	ToolbarButton = { fg = bg0, bg = bg_blue },
	FloatBorder = { fg = grey, bg = bg1 },
	NormalFloat = { fg = fg, bg = bg0 },
}

hl.syntax = {
	String = green,
	Character = orange,
	Number = orange,
	Float = orange,
	Boolean = orange,
	Type = yellow,
	Structure = yellow,
	StorageClass = yellow,
	Identifier = red,
	Constant = cyan,
	PreProc = purple,
	PreCondit = purple,
	Include = purple,
	Keyword = purple,
	Define = purple,
	Typedef = purple,
	Exception = purple,
	Conditional = purple,
	Repeat = purple,
	Statement = purple,
	Macro = red,
	Error = purple,
	Label = purple,
	Special = red,
	SpecialChar = red,
	Function = blue,
	Operator = purple,
	Title = cyan,
	Tag = green,
	Delimiter = light_grey,
	Comment = { fg = grey, italic = true },
	SpecialComment = { fg = grey, italic = true },
	Todo = { fg = red, italic = true },
}

hl.treesitter = {
	["@annotation"] = fg,
	["@attribute"] = cyan,
	["@boolean"] = orange,
	["@character"] = orange,
	["@comment"] = { fg = grey, italic = true },
	["@conditional"] = purple,
	["@constant"] = orange,
	["@constant.builtin"] = orange,
	["@constant.macro"] = orange,
	["@constructor"] = { fg = yellow, bold = true },
	["@error"] = fg,
	["@exception"] = purple,
	["@field"] = cyan,
	["@float"] = orange,
	["@function"] = blue,
	["@function.builtin"] = cyan,
	["@function.macro"] = cyan,
	["@include"] = purple,
	["@keyword"] = purple,
	["@keyword.function"] = purple,
	["@keyword.operator"] = purple,
	["@label"] = red,
	["@method"] = blue,
	["@namespace"] = yellow,
	["@none"] = fg,
	["@number"] = orange,
	["@operator"] = fg,
	["@parameter"] = red,
	["@parameter.reference"] = fg,
	["@preproc"] = purple,
	["@property"] = cyan,
	["@punctuation.delimiter"] = light_grey,
	["@punctuation.bracket"] = light_grey,
	["@punctuation.special"] = red,
	["@repeat"] = purple,
	["@string"] = green,
	["@string.regex"] = orange,
	["@string.escape"] = red,
	["@symbol"] = cyan,
	["@tag"] = purple,
	["@tag.attribute"] = yellow,
	["@tag.delimiter"] = purple,
	["@text"] = fg,
	["@text.strong"] = { fg = fg, bold = true },
	["@text.emphasis"] = { fg = fg, italic = true },
	["@text.underline"] = { fg = fg, underline = true },
	["@text.strike"] = { fg = fg, strikethrough = true },
	["@text.title"] = { fg = orange, bold = true },
	["@text.literal"] = green,
	["@text.uri"] = { fg = cyan, underline = true },
	["@text.todo"] = { fg = red, italic = true },
	["@text.math"] = fg,
	["@text.reference"] = blue,
	["@text.environment"] = fg,
	["@text.environment.name"] = fg,
	["@text.diff.add"] = green,
	["@text.diff.delete"] = red,
	["@note"] = fg,
	["@warning"] = fg,
	["@danger"] = fg,
	["@type"] = yellow,
	["@type.builtin"] = orange,
	["@variable"] = fg,
	["@variable.builtin"] = red,
}

hl.lsp = {
	["@lsp.type.comment"] = hl.treesitter["@comment"],
	["@lsp.type.enum"] = hl.treesitter["@type"],
	["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"],
	["@lsp.type.interface"] = hl.treesitter["@type"],
	["@lsp.type.typeParameter"] = hl.treesitter["@type"],
	["@lsp.type.keyword"] = hl.treesitter["@keyword"],
	["@lsp.type.namespace"] = hl.treesitter["@namespace"],
	["@lsp.type.parameter"] = hl.treesitter["@parameter"],
	["@lsp.type.property"] = hl.treesitter["@property"],
	["@lsp.type.variable"] = hl.treesitter["@variable"],
	["@lsp.type.macro"] = hl.treesitter["@function.macro"],
	["@lsp.type.method"] = hl.treesitter["@method"],
	["@lsp.type.number"] = hl.treesitter["@number"],
	["@lsp.type.generic"] = hl.treesitter["@text"],
	["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"],
	["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"],
	["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"],
	["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"],
	["@lsp.typemod.string.injected"] = hl.treesitter["@string"],
	["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"],
	["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"],
	["@lsp.typemod.variable.static"] = hl.treesitter["@constant"],
}

hl.cmp = {
	CmpItemAbbr = fg,
	CmpItemAbbrDeprecated = { fg = light_grey, strikethrough = true },
	CmpItemAbbrMatch = cyan,
	CmpItemAbbrMatchFuzzy = { fg = cyan, underline = true },
	CmpItemMenu = light_grey,
	CmpItemKind = purple,
}

hl.gitsigns = {
	GitSignsAdd = "#33ff55",
	GitSignsChange = "#44bbff",
	GitSignsDelete = "#ff5566",
}

hl.indent_blankline = {
	IndentBlanklineIndent1 = "#444444",
}

hl.telescope = {
	TelescopeBorder = red,
	TelescopePromptBorder = cyan,
	TelescopeResultsBorder = cyan,
	TelescopePreviewBorder = cyan,
	TelescopeMatching = { fg = red, bold = true },
	TelescopePromptPrefix = green,
	TelescopeSelection =  { bg = bg2 },
	TelescopeSelectionCaret = yellow
}

for _, highlights in pairs(hl) do
	for hl_group, highlight in pairs(highlights) do
		if type(highlight) ~= "table" then
			highlight = { fg = highlight }
		end

		api.nvim_set_hl(0, hl_group, highlight)
	end
end
