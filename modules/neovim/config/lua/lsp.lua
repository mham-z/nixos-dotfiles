local LSP = {
	lua_ls = { -- lua
		cmd = {"lua-language-server"};
		filetypes = {"lua"};
		root_markers = {".luarc.json", ".luarc.jsonc", ".git"};
	};
	luau_lsp = { -- luau
		cmd = {"luau-lsp", "lsp"};
		filetypes = {"luau"};
		root_markers = {".luaurc", "rokit.toml", ".git"};
	};
	nil_ls = { -- nix
		cmd = {"nil"};
		filetypes = {"nix"};
		root_markers = {"flake.nix", "shell.nix", ".git"};
	};
	clangd = { -- c/cpp
		cmd = {"clangd"};
		filetypes = {"c", "cpp", "objc", "objcpp"};
		root_markers = {"compile_commands.json", "compile_flags.txt", ".git"};
	};
	basedpyright = { -- python
		cmd = {"basedpyright-langserver", "--stdio"};
		filetypes = {"python"};
		root_markers = {"pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", ".git"};
	};
	cssls = { -- css
		cmd = {"vscode-css-language-server", "--stdio"};
		filetypes = {"css", "scss"};
		root_markers = {"package.json", ".git"};
	};
	texlab = { -- latex
		cmd = {"texlab"};
		filetypes = {"tex", "plaintex"};
		root_markers = {".git"};
	};
	marksman = { -- markdown
		cmd = {"marksman", "server"};
		filetypes = {"markdown"};
		root_markers = {".git"};
	};
}

for server, config in pairs(LSP) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
