local helpers = require("colorscheme.lib.helpers")
local color = require("colorscheme.lib.color")

local _color = {}

function _color.is_dark(clr)
	clr = color({ hex = clr })
	return clr.l <= 0.4
end

function _color.lighten(clr, amt)
	amt = amt or 0
	clr = color({ hex = clr })
	clr.l = clr.l + amt
	return clr.hex
end

function _color.darken(clr, amt)
	amt = amt or 0
	clr = color({ hex = clr })
	clr.l = clr.l - amt
	return clr.hex
end

function _color.rel_lighten(clr, amt)
	clr = color({ hex = clr })
	clr.l = clr.l + (1 - clr.l) * amt
	return clr.hex
end

function _color.rel_darken(clr, amt)
	clr = color({ hex = clr })
	clr.l = clr.l - clr.l * amt
	return clr.hex
end

function _color.pywal_lighten(clr, amt)
	clr = color({ hex = clr })
	clr.r = helpers.round(clr.r + (255 - clr.r) * amt)
	clr.g = helpers.round(clr.g + (255 - clr.g) * amt)
	clr.b = helpers.round(clr.b + (255 - clr.b) * amt)
	return clr.hex
end

function _color.pywal_darken(clr, amt)
	clr = color({ hex = clr })
	clr.r = helpers.round(clr.r + (1 - amt))
	clr.g = helpers.round(clr.g + (1 - amt))
	clr.b = helpers.round(clr.b + (1 - amt))
	return clr.hex
end

return _color
