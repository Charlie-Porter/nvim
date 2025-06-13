local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local smart_splits = require("smart-splits") -- Optimized require
local builtin = require("telescope.builtin") -- Optimized require
local dotnet = require("easy-dotnet") -- Optimized require for easy-dotnet.nvim

-- Exit insert mode with "jk"
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Prevent "x" from yanking into register
keymap.set("n", "x", '"_x', opts)
keymap.set("n", "d", '"_d', opts)

keymap.set("n", "gk", "<C-o>", opts) -- jump back                                            ▐
keymap.set("n", "gj", "<C-i>", opts) -- jump forward

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

-- Save file and quit
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)
keymap.set("n", "<C-q>", ":q<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "<Tab>", ":tabnext<Return>", opts)
keymap.set("n", "<S-Tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Diagnostics (Changed <C-j> to <C-d> to avoid conflict)
keymap.set("n", "<C-d>", vim.diagnostic.goto_next, opts)
keymap.set("n", "<A-r>", builtin.lsp_references, { desc = "Find References (Alt+r)" })
keymap.set("n", "<A-i>", builtin.lsp_implementations, { desc = "Go to Implementation (Alt+l)" })
keymap.set("n", "<A-d>", builtin.lsp_definitions, { desc = "Go to definitions (Alt+d)" })
keymap.set("n", "<A-D>", builtin.lsp_type_definitions, { desc = "Go to definitions (Alt+D)" })

keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
keymap.set("n", "<Leader>B", function()
	require("dap").toggle_breakpoint()
end)

-- Moving between splits
keymap.set("n", "<C-h>", smart_splits.move_cursor_left, opts)
keymap.set("n", "<C-j>", smart_splits.move_cursor_down, opts) -- Kept <C-j> for movement
keymap.set("n", "<C-k>", smart_splits.move_cursor_up, opts)
keymap.set("n", "<C-l>", smart_splits.move_cursor_right, opts)

-- Telescope General Pickers
keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Telescope find files" })
keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Telescope buffers" })
keymap.set("n", "<Leader>fo", builtin.oldfiles, { desc = "Telescope previously opened files" })
keymap.set("n", "<Leader>fC", builtin.commands, { desc = "Telescope available commands" })
keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Telescope LSP Pickers
keymap.set("n", "<Leader>fi", builtin.lsp_implementations, { desc = "Telescope LSP Implementations" })
keymap.set("n", "<Leader>fr", builtin.lsp_references, { desc = "Telescope LSP References" })
keymap.set("n", "<Leader>fd", builtin.diagnostics, { desc = "Telescope Diagnostics" })
keymap.set("n", "<Leader>fs", builtin.lsp_document_symbols, { desc = "Telescope Document Symbols" })

-- Telescope Git Pickers
keymap.set("n", "<Leader>gc", builtin.git_commits, { desc = "Telescope Git Commits" })
keymap.set("n", "<Leader>gs", builtin.git_status, { desc = "Telescope Git Status" })
keymap.set("n", "<Leader>gsh", builtin.git_stash, { desc = "Telescope Git Stash" })

-- **Run .NET Project**
keymap.set("n", "<C-p>", function()
	-- Kill any running dotnet process first (Windows-specific)
	vim.fn.jobstart({ "cmd", "/C", "taskkill /f /im dotnet.exe" }, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			if data then
				print(table.concat(data, "\n"))
			end
		end,
		on_stderr = function(_, data)
			if data then
				print("Error: " .. table.concat(data, "\n"))
			end
		end,
		on_exit = function()
			-- After killing, run the .NET project
			dotnet.run()
		end,
	})
end, { desc = "Kill dotnet and Run .NET Project" })

-- **Secrets Command**
vim.api.nvim_create_user_command("Secrets", function()
	dotnet.secrets()
end, {})
