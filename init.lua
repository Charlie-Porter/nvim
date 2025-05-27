-- Load Lazy.nvim plugin manager configuration
require("config.lazy") -- This file likely contains the Lazy.nvim setup and plugin configuration

-- Create an LSP (Language Server Protocol) client capabilities object
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable inlay hints support (but this is later overridden)
capabilities.textDocument.inlayHint = {
	dynamicRegistration = false, -- Disables dynamic registration for inlay hints
}

-- Explicitly disable Inlay Hints support by setting it to nil
capabilities.textDocument.inlayHint = nil -- Ensures that inlay hints are fully disabled

-- Define the path to the Razor Language Server (RZLS) executable
local rzls_path = "C:/repos/razor/artifacts/bin/rzls/Release/net8.0/win-x64/"
local rzls_executable = rzls_path .. "rzls.exe" -- Constructs the full path to the RZLS executable

-- Require the document store module for handling Razor document buffers
local document_store = require("rzls.documentstore")

-- Setup the Razor Language Server (RZLS) with the defined configuration
require("rzls").setup({
	-- Callback function that runs when the LSP attaches to a buffer
	on_attach = function(client, bufnr)
		-- Create virtual buffers for the source buffer
		require("rzls.documentstore").create_vbufs(bufnr)

		-- Define key mappings for LSP functionality
		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		-- Go to definition: Press `gd` to jump to the definition of a symbol
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

		-- Go to implementation: Press `gi` to jump to the implementation of a symbol
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

		-- Show hover documentation: Press `K` to view documentation for a symbol
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	end,

	-- Pass the modified LSP client capabilities (disabling inlay hints)
	capabilities = capabilities,

	-- Path to the RZLS binary
	path = rzls_path,

	-- Server-specific settings
	settings = {
		razor = {
			trace = {
				level = "Error", -- Enables verbose logging for troubleshooting
			},
			format = {
				enable = true, -- Enables automatic Razor file formatting
			},
			inlayHints = {
				enable = false, -- Explicitly disable inlay hints in Razor files
			},
		},
	},
})
-- Enable debugging for LSP logs
vim.lsp.set_log_level("error") -- Useful for troubleshooting LSP-related issues
