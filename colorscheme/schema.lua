local color = require("colorscheme.color")

local bg = "#262a31"
local fg = "#b2b8c3"

return {
	theme = "Proxima",
	palette = {
		-- Accent color
		accent = "#a4c76f",
		-- Backgrounds & Foregrounds
		dark = color.darken(bg, 40),
		bg0 = color.darken(bg, 16),
		bg = bg,
		bg2 = color.lighten(bg, 4),
		bg3 = color.lighten(bg, 8),
		bg4 = color.lighten(bg, 12),
		fg0 = color.lighten(fg, 56),
		fg = fg,
		fg2 = color.darken(fg, 16),
		fg3 = color.darken(fg, 32),
		fg4 = color.darken(fg, 48),
		-- Palette
		red = "#e36f71",
		green = "#a4c76f",
		yellow = "#d1cc66",
		blue = "#5d91e3",
		magenta = "#9c7acc",
		cyan = "#82beed",
		teal = "#77c7a7",
		orange = "#e39d5f",
		pink = "#cc89bf",
		black = color.lighten(bg, 18),
		gray = color.lighten(bg, 32),
		white = color.lighten(fg, 64),
	},
}
