local dap = require("dap")

-- Safe fallback
dap.configurations = dap.configurations or {}

-- Explicitly initialize config table if not already present
dap.configurations.cs = dap.configurations.cs or {}

-- Your .NET config
dap.adapters.coreclr = {
	type = "executable",
	command = "C:\\Users\\charles.porter\\netcoredbg\\build\\src\\Debug\\netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch - NetCoreDbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net6.0/", "file")
		end,
	},
	{
		type = "coreclr",
		name = "Attach - NetCoreDbg",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
