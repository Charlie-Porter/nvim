return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	cmd = "CopilotChat",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	-- Set highlight groups
	init = function()
		local function apply_hl()
			vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = "#7C3AED", bold = true })
			vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = "#374151" })
		end

		apply_hl()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = apply_hl,
		})
	end,

	opts = function()
		local base = require("CopilotChat.config.providers")

		local endpoint = os.getenv("OPENAI_API_BASE")
		local api_version = os.getenv("OPENAI_API_AZURE_VERSION") -- e.g. 2024-08-01-preview
		local api_key = os.getenv("OPENAI_API_KEY")
		local deployment = "gpt-5"

		if not (endpoint and api_version and api_key) then
			vim.schedule(function()
				vim.notify(
					"[CopilotChat][azure_openai] Missing env vars: OPENAI_API_BASE / OPENAI_API_AZURE_VERSION / OPENAI_API_KEY",
					vim.log.levels.WARN
				)
			end)
		end

		local providers = {
			copilot = {
				disabled = true,
			},

			github_models = {
				disabled = true,
			},

			azure_openai = {
				prepare_input = base.copilot.prepare_input,
				prepare_output = base.copilot.prepare_output,

				-- Azure Chat Completions URL
				get_url = function(_)
					return string.format(
						"%s/openai/deployments/%s/chat/completions?api-version=%s",
						endpoint,
						deployment,
						api_version
					)
				end,

				get_headers = function()
					assert(api_key, "OPENAI_API_KEY env var not set")
					return {
						["api-key"] = api_key,
						["Content-Type"] = "application/json",
					}
				end,

				get_models = function(_headers)
					return {
						{
							id = deployment,
							name = "Azure " .. deployment,
						},
					}
				end,
			},
		}

		return {
			model = "gpt-5",
			temperature = 1,
			providers = providers,
		}
	end,
}
