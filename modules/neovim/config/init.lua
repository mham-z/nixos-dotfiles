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
	"ccc"
}

require("options")
require("keymaps")

for _, name in ipairs(PLUGINS) do
	require("plugins."..name)
end

require("lsp")
