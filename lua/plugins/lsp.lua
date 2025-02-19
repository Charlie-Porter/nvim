return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "csharp-language-server" }, -- Auto-install the LSP
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp", -- Completion support
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				csharp_ls = {},
			}

			for server, config in pairs(servers) do
				config.capabilities = cmp_capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}
