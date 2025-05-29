return {
	"sbdchd/neoformat",
	config = function()
		vim.api.nvim_create_augroup("NeoformatOnSave", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = "NeoformatOnSave",
			pattern = "*",
			callback = function()
				vim.cmd("undojoin | Neoformat")
			end,
		})
	end,
}
