local clr = require("color.color")


local variants = {
  Midnight = {
    none = "NONE",
    bg = "#1c1d28",
    fg = "#b3bde4",
    red = "#e66c6e",
    orange = "#e69875",
    yellow = "#d9c574",
    green = "#b3d57d",
    teal = "#7cd398",
    blue = "#6d80ed",
    cyan = "#7adbce",
    magenta = "#cd84a7",
    purple = "#9e6cd0",
  },
  Twilight = {
    none = "NONE",
    bg = "#232432",
    fg = "#c0c8e9",
    red = "#e66c6e",
    orange = "#e69875",
    yellow = "#d9c574",
    green = "#b3d57d",
    teal = "#7cd398",
    blue = "#6d80ed",
    cyan = "#7adbce",
    magenta = "#cd84a7",
    purple = "#9e6cd0",
  },
}

return function(variant)
  variant = variant or "Midnight"
  local p = variants[variant]

  return {
		-- Accent color
		accent = p.blue,
		fg = p.fg,
		bg = p.bg,
		red = p.red,
		green = p.green,
		yellow = p.yellow,
		blue = p.blue,
		magenta = p.magenta,
		cyan = p.cyan,
		teal = p.teal,
		orange = p.orange,
		purple = p.purple,
		-- Backgrounds & Foregrounds
		bgd = clr.darken(p.bg, 0.75),
		bg0 = clr.darken(p.bg, 0.85),
		bg2 = clr.lighten(p.bg, 0.9625),
		bg3 = clr.lighten(p.bg, 0.9),
		fg2 = clr.darken(p.fg, 0.85),
		fg3 = clr.darken(p.fg, 0.7),
		red0 = clr.darken(p.red, 0.9),
		red2 = clr.lighten(p.red, 0.8),
		orange0 = clr.darken(p.orange, 0.95),
		orange2 = clr.lighten(p.orange, 0.8),
		yellow0 = clr.darken(p.yellow, 0.95),
		yellow2 = clr.lighten(p.yellow, 0.8),
		green0 = clr.darken(p.green, 0.95),
		green2 = clr.lighten(p.green, 0.8),
		teal0 = clr.darken(p.teal, 0.95),
		teal2 = clr.lighten(p.teal, 0.8),
		blue0 = clr.darken(p.blue, 0.95),
		blue2 = clr.lighten(p.blue, 0.8),
		cyan0 = clr.darken(p.cyan, 0.95),
		cyan2 = clr.lighten(p.cyan, 0.8),
		magenta0 = clr.darken(p.magenta, 0.95),
		magenta2 = clr.lighten(p.magenta, 0.8),
		purple0 = clr.darken(p.purple, 0.95),
		purple2 = clr.lighten(p.purple, 0.8),
		comment = clr.lighten(p.bg, 0.75),
		black = clr.lighten(p.bg, 0.7),
		white = p.fg,
}
end
