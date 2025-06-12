This Neovim configuration is optimized for .NET development, leveraging Roslyn LSP (csharp-ls) for C# language support, along with Mason, Mason-LSPConfig, and Blink.CMP for enhanced completion and LSP features.

🐞 Debugging .NET Core Applications with nvim-dap
This guide explains how to attach to a running .NET Core process using nvim-dap and netcoredbg.

✅ Prerequisites
netcoredbg installed (see netcoredbg GitHub)
nvim-dap configured
.NET app running on your local machine

✅Trigger the attach config in Neovim
Open Neovim to a .cs file.
Open the DAP UI.
Run this (via a keymap or :lua require'dap'.continue()):
:lua require'dap'.continue()
Pick Attach - NetCoreDbg when prompted.
A process list will appear — select the PID of your running .NET process.
