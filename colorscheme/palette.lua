local color = require("colorscheme.color")
local helpers = require("colorscheme.lib.helpers")

local builtin = {
	alpha = {
		fg = "#c5d5df",
		bg = "#0d1418",
		red = "#e46769",
		green = "#a4c76f",
		yellow = "#eace60",
		blue = "#619af5",
		magenta = "#9d78d1",
		cyan = "#42b8e6",
		teal = "#5fd7aa",
		orange = "#e39d5f",
		pink = "#d983d7",
	},
	gamma = {
		fg = "#cfcabe",
		bg = "#141617",
		red = "#e67e80",
		green = "#a4c76f",
		yellow = "#d1cc66",
		blue = "#678dc9",
		magenta = "#a183cc",
		cyan = "#76bfc4",
		teal = "#6fc7a4",
		orange = "#d69760",
		pink = "#c975b9",
	},
}

return function(style, accent)
	style = string.lower(style)
	accent = string.lower(accent)
	local p = builtin[style or "alpha"]

	p = helpers.tbl_extend(p, {
		name = "Crux",
		dark = color.rel_darken(p.bg, 0.32),
		bg0 = color.rel_darken(p.bg, 0.16),
		bg2 = color.rel_lighten(p.bg, 0.02),
		bg3 = color.rel_lighten(p.bg, 0.06),
		bg4 = color.rel_lighten(p.bg, 0.1),
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
