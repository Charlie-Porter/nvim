return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		require("easy-dotnet").setup({
			lsp = {
				enabled = true,
			},
			background_scanning = false, -- <- stop it auto-picking/starting
		})
	end,
}
