return {
	"L3MON4D3/LuaSnip",
	lazy = true,
	build = (not LazyVim.is_win())
			and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
		or nil,
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				local ls = require("luasnip")
				-- Load VSCode-style snippets
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { vim.fn.stdpath("config") .. "/snippets" },
				})

				ls.filetype_extend("cs", { "csharp" })
				ls.filetype_extend("jsx", { "react", "javascript" })
				ls.filetype_extend("javascriptreact", { "javascript", "react" })
				ls.filetype_extend("typescriptreact", { "javascript", "react" })
			end,
		},
	},
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
}
