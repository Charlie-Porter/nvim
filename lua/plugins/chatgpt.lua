return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			api_key_cmd = "echo %OPENAI_API_KEY%",
			api_host_cmd = "echo -n ''",
			api_type_cmd = "echo azure",
			openai_params = {
				model = "gpt-5",
				-- top_p = 0.1, not supported in gpt-5
				n = 1,
				temperature = 1,
			},
		},
		config = function(_, opts)
			require("chatgpt").setup(opts)

			local cfg = require("chatgpt.config").options
			cfg.openai_params.max_tokens = nil
			cfg.azure_api_base_cmd = "echo https://ais-sharedai-dev-eus2-743.cognitiveservices.azure.com"
			cfg.azure_api_engine_cmd = "echo gpt-5"
			cfg.azure_api_version_cmd = "echo 2024-12-01-preview"
			cfg.openai_params.temperature = nil
		end,
	},
}
