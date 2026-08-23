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
}

require("options")
require("keymaps")

for _, name in ipairs(PLUGINS) do
	require("plugins."..name)
end

require("lsp")
