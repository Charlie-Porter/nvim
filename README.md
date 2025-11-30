# Neovim Configuration for .NET Development

This repository contains a Neovim configuration tailored for modern .NET (C#) development. It's focused on providing a productive, minimal, and maintainable setup using the Neovim built-in LSP, Mason for package management, nvim-dap for debugging, and a curated set of plugins for completion and UI enhancements.

## Goals

- Provide a focused, configurable Neovim setup optimized for .NET/C# development.
- Make it easy to bootstrap language servers and debuggers via Mason.
- Keep configuration readable and easy to extend.

## Key Features

- C# language support via a Roslyn-based LSP (csharp-ls / Omnisharp depending on your choice).
- Mason and mason-lspconfig for installing and managing LSP servers and tools.
- Autocompletion configured through nvim-cmp.
- Debugging support for .NET Core applications using nvim-dap and netcoredbg.
- Helpful defaults and example keymaps to get started quickly.

## Prerequisites

- Neovim 0.8+ (or newer) with Lua support.
- Git.
- A plugin manager (this configuration assumes a Lua-based plugin manager; adjust if using a different one).
- netcoredbg (for debugging .NET Core apps).
- .NET SDK/runtime for building and running your apps.

## Installation

1. Clone this repository into your Neovim configuration directory, or copy the relevant files into your existing setup.

   git clone https://github.com/Charlie-Porter/nvim ~/.config/nvim

2. Install plugins using your plugin manager (follow the plugin manager's instructions). Mason will be used to install language servers and debuggers.

3. Open Neovim and run the plugin install command for your plugin manager (for example, :PackerSync for packer.nvim).

4. Open Mason (:Mason) and install the recommended tools: csharp language server (or omnisharp), netcoredbg, and any other tools you need.

## Quick Start

- Open a C# project (a folder with a .sln or .csproj) in Neovim.
- Mason should ensure the language server and debugger are available.
- LSP features (definition, references, hover, code actions) will be available via configured keymaps.
- Autocompletion will be provided by nvim-cmp.

## Debugging .NET Core Applications with nvim-dap

This configuration includes an example setup to attach to or launch .NET Core applications using nvim-dap and netcoredbg.

Prerequisites

- netcoredbg installed (see https://github.com/Samsung/netcoredbg)
- nvim-dap configured in your Neovim configuration
- A .NET application running locally (for attach) or a project to launch (for launch)

Attach to a running process (example workflow)

1. Open Neovim to a .cs file inside the project you want to debug.
2. Open your DAP UI or the telescope picker if configured for dap processes.
3. Trigger the DAP continue/attach command. Example Lua command (map this to a key if desired):

   :lua require'dap'.continue()

4. When prompted, choose the "Attach - NetCoreDbg" configuration.
5. Select the PID of the running .NET process to attach to.

Launch a debug session (example)

- Configure a launch configuration in your dap setup (see your config/dap.lua or equivalent). A typical launch configuration will point the adapter to netcoredbg and the program to your project's built DLL.

Example attach snippet (for your dap configurations)

```lua
-- Example adapter/launch configuration snippet
local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'Attach - NetCoreDbg',
    request = 'attach',
  },
}
```

## Configuration

- See the config/ directory for the Lua configuration files used by this setup.
- Customize keymaps, LSP settings, and plugin options by editing the corresponding Lua modules.

## Troubleshooting

- If LSP features are not available, ensure the language server is installed in Mason and that Neovim can find it.
- For debugging issues, verify netcoredbg is installed and in your PATH. Test running netcoredbg --version from your shell.

## Contributing

Contributions are welcome. Please open issues or pull requests for bug fixes, improvements, or documentation updates.

## License

This repository is provided under the MIT License unless otherwise specified in the repository. See the LICENSE file for details.
