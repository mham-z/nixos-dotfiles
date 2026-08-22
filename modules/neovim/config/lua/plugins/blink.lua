require("blink.cmp").setup({
	keymap = {
		preset = "super-tab";
	};

	sources = {
		default = {
			"lsp";
			"path";
			"snippets";
			"buffer";
		};
	};
})
