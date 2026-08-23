local lualine = require("lualine")

local mode_groups = {
	n = "lualine_a_normal";
	i = "lualine_a_insert";
	v = "lualine_a_visual";
	V = "lualine_a_visual";
	["\22"] = "lualine_a_visual";
	R = "lualine_a_replace";
}

local function rgb(color)
	return {
		r = bit.rshift(color, 16);
		g = bit.band(bit.rshift(color, 8), 0xff);
		b = bit.band(color, 0xff);
	}
end

local function mix(a, b, amount)
	a = rgb(a)
	b = rgb(b)

	return string.format(
		"#%02X%02X%02X",
		a.r + (b.r - a.r) * amount,
		a.g + (b.g - a.g) * amount,
		a.b + (b.b - a.b) * amount
	)
end

local function update_cursorline()
	local mode = vim.fn.mode()
	local group = mode_groups[mode]

	if not group then
		return
	end

	local normal = vim.api.nvim_get_hl(0, {
		name = "Normal";
		link = false;
	})

	local mode_hl = vim.api.nvim_get_hl(0, {
		name = group;
		link = false;
	})

	if not normal.bg or not mode_hl.fg then
		return
	end

	vim.api.nvim_set_hl(0, "CursorLine", {
		bg = mix(normal.bg, mode_hl.bg, 0.3);
	})
end

lualine.setup {
	options = {
		theme = "nord";
		globalstatus = false;
	},
}

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = update_cursorline;
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = update_cursorline;
})

vim.schedule(update_cursorline)
