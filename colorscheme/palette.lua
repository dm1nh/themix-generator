local color = require("colorscheme.color")
local helpers = require("colorscheme.lib.helpers")

local builtin = {
	forest = {
		fg = "#cfc7c2",
		bg = "#242b2f",
		red = "#e67e80",
		green = "#a7c080",
		yellow = "#dbbc7f",
		blue = "#6c86db",
		magenta = "#b495d3",
		cyan = "#76b4cc",
		teal = "#76cca1",
		orange = "#e69875",
		pink = "#d699b6",
	},
	midnight = {
		fg = "#c4bab4",
		bg = "#21272b",
		red = "#e67e80",
		green = "#a7c080",
		yellow = "#dbbc7f",
		blue = "#6c86db",
		magenta = "#b495d3",
		cyan = "#76b4cc",
		teal = "#76cca1",
		orange = "#e69875",
		pink = "#d699b6",
	},
}

return function(style, accent)
	style = string.lower(style)
	accent = string.lower(accent)
	local p = builtin[style or "forest"]
	print(p)

	p = helpers.tbl_extend(p, {
		name = "Crux",
		dark = color.rel_darken(p.bg, 0.32),
		bg0 = color.rel_darken(p.bg, 0.16),
		bg2 = color.rel_lighten(p.bg, 0.04),
		bg3 = color.rel_lighten(p.bg, 0.08),
		bg4 = color.rel_lighten(p.bg, 0.12),
		fg0 = color.rel_lighten(p.fg, 0.64),
		fg2 = color.rel_darken(p.fg, 0.16),
		fg3 = color.rel_darken(p.fg, 0.32),
		fg4 = color.rel_darken(p.fg, 0.48),
		gray = color.rel_lighten(p.bg, 0.32),
		black = color.rel_lighten(p.bg, 0.2),
		white = color.rel_lighten(p.fg, 0.64),
	})
	p.accent = p[accent]

	return p
end
