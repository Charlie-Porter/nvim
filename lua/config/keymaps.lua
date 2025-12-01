local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local smart_splits = require("smart-splits") -- Optimized require
local builtin = require("telescope.builtin") -- Optimized require
local dotnet = require("easy-dotnet") -- Optimized require for easy-dotnet.nvim

-- Exit insert mode with "jk"
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Prevent "x" from yanking into register
keymap.set("n", "x", '"_x', opts)

keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")

-- EasyAlign
keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign (visual)" })

-- Quit
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

keymap.set("n", "<leader>fp", function()
	require("telescope.builtin").live_grep({
		default_text = vim.fn.getreg('"'), -- or '"', '*', etc.
	})
end, { desc = "Live Grep from clipboard" })

keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files({
		default_text = vim.fn.getreg('"'),
		search_dirs = { vim.fn.getcwd() }, -- Root dir
	})
end, { desc = "Find File from clipboard in Root Dir" })

-- -- **Run .NET Project**
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

-- ChatGPT
keymap.set(
	{ "n", "v" },
	"<Leader>cg",
	":ChatGPT<CR>",
	{ noremap = true, silent = true, desc = "ChatGPT (optional input)" }
)
keymap.set({ "n", "v" }, "<Leader>cgc", ":ChatGPT<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cge", ":ChatGPTEditWithInstruction<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgg", ":ChatGPTRun grammar_correction<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgt", ":ChatGPTRun translate<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgk", ":ChatGPTRun keywords<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgd", ":ChatGPTRun docstring<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cga", ":ChatGPTRun add_tests<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgs", ":ChatGPTRun summarize<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgf", ":ChatGPTRun fix_bugs<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgx", ":ChatGPTRun explain_code<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgr", ":ChatGPTRun roxygen_edit<CR>", opts)
keymap.set({ "n", "v" }, "<Leader>cgl", ":ChatGPTRun code_readability_analysis<CR>", opts)

-- Copilot Chat Keybindings
keymap.set(
	"n",
	"<Leader>cc",
	":CopilotChat<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat (optional input)" }
)
keymap.set("n", "<Leader>ccc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "CopilotChat" })
keymap.set(
	"n",
	"<Leader>cco",
	":CopilotChatOpen<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat Open window" }
)
keymap.set(
	"n",
	"<Leader>ccq",
	":CopilotChatClose<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat Close window" }
)
keymap.set(
	"n",
	"<Leader>cct",
	":CopilotChatToggle<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat Toggle window" }
)
keymap.set(
	"n",
	"<Leader>ccs",
	":CopilotChatStop<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat Stop output" }
)
keymap.set(
	"n",
	"<Leader>ccr",
	":CopilotChatReset<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat Reset window" }
)
keymap.set(
	"n",
	"<Leader>ccS",
	":CopilotChatSave ",
	{ noremap = true, silent = true, desc = "CopilotChat Save chat history" }
)
keymap.set(
	"n",
	"<Leader>ccl",
	":CopilotChatLoad ",
	{ noremap = true, silent = true, desc = "CopilotChat Load chat history" }
)
keymap.set(
	"n",
	"<Leader>ccp",
	":CopilotChatPrompts<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat View/select prompts" }
)
keymap.set(
	"n",
	"<Leader>ccm",
	":CopilotChatModels<CR>",
	{ noremap = true, silent = true, desc = "CopilotChat View/select models" }
)
keymap.set("n", "<Leader>ccn", function()
	local name = vim.fn.input("Prompt name: ")
	if name ~= nil and name ~= "" then
		vim.cmd("CopilotChat" .. name)
	end
end, { noremap = true, silent = true, desc = "CopilotChat use specific prompt template" })
