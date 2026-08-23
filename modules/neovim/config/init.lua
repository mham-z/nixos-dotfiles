local PLUGINS = {
	"nord";
	"neo-tree";
	"lualine";
	"gitsigns";
	"neogit";
	"telescope";
	"spectre";
	"cord";
	"blink";
	"ccc";
	"treesitter";
	"textobjects";
	"auto-session";
}

require("options")
require("keymaps")
require("mode-cursorline")

for _, name in ipairs(PLUGINS) do
	require("plugins."..name)
end

require("lsp")
