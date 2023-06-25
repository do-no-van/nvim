local luasnip = require("luasnip")

local snippet = luasnip.s
local fmt = require("luasnip.extras.fmt").fmt

-- nodes
local i = luasnip.insert_node
local c = luasnip.choice_node
local f = luasnip.function_node
local d = luasnip.dynamic_node
local sn = luasnip.snippet_node
local rep = require("luasnip.extras").rep

luasnip.add_snippets("rust", {
	snippet("testmod", fmt([[
		#[cfg(test)]
		mod tests {{
			use super::*;

			#[test]
			fn {}() {{
				{}
			}}
		}}
		]],
		{
			i(1),
			i(0),
		})
	),
})
