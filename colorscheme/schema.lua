local color = require("colorscheme.color")

local bg = "#1f2830"

return {
	theme = "Proxima",
	palette = {
		-- Accent color
		accent = "#8fd780",
		-- Backgrounds & Foregrounds
		bg0 = color.darken(bg, 32),
		bg1 = bg,
		bg2 = color.lighten(bg, 6),
		bg3 = color.lighten(bg, 12),
		bg4 = color.lighten(bg, 18),
		fg0 = color.lighten(bg, 96),
		fg1 = color.lighten(bg, 88),
		fg2 = color.lighten(bg, 72),
		fg3 = color.lighten(bg, 64),
		-- Palette
		red = "#f36a6f",
		orange = "#efaa6f",
		yellow = "#e6dd90",
		green = "#8fd780",
		teal = "#4fd5b5",
		cyan = "#5ddae2",
		blue = "#62b1ff",
		magenta = "#b28ff5",
		pink = "#e67aca",
		black = color.lighten(bg, 24),
		gray = color.lighten(bg, 40),
		white = color.lighten(bg, 96),
	},
}
