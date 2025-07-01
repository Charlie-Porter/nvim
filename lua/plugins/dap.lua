local dap = require("dap")

dap.configurations = dap.configurations or {}

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
		name = "Attach - NetCoreDbg",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
