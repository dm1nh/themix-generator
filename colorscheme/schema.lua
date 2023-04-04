local color = require("colorscheme.color")

local bg = "#293235"
local fg = "#d4cbb8"

return {
	theme = "Proxima",
	palette = {
		-- Accent color
		accent = "#a4c76f",
		-- Backgrounds & Foregrounds
		dark = color.darken(bg, 32),
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
		red = "#e67e80",
		green = "#a4c76f",
		yellow = "#d1cc66",
		blue = "#5fbde8",
		magenta = "#a382d1",
		cyan = "#73c9c5",
		teal = "#58d699",
		orange = "#de995d",
		pink = "#d971c4",
		black = color.lighten(bg, 18),
		gray = color.lighten(bg, 24),
		white = color.lighten(fg, 64),
	},
}
