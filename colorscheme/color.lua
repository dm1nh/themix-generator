local util = require("colorscheme.util")
local _color = {}

--- Convert hex to rgb
-- @param color string HEX
-- @return table
_color.to_rgb = function(clr)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	clr = string.lower(clr)

	assert(string.find(clr, pat) ~= nil, "hex_to_rgb: invalid color: " .. tostring(clr))

	local r, g, b = string.match(clr, pat)
	r = util.clamp(tonumber(r, 16), 0, 255)
	g = util.clamp(tonumber(g, 16), 0, 255)
	b = util.clamp(tonumber(b, 16), 0, 255)
	return { r = r, g = g, b = b }
end

--- Convert hex to hsl
-- @param color string HEX
-- @return table
_color.to_hsl = function(clr)
	local rgb = _color.to_rgb(clr)
	local r = rgb.r / 255
	local g = rgb.g / 255
	local b = rgb.b / 255
	local cmin = math.min(r, g, b)
	local cmax = math.max(r, g, b)
	local delta = cmax - cmin
	local h, s, l

	if delta == 0 then
		h = 0
	elseif cmax == r then
		h = ((g - b) / delta) % 6
	elseif cmax == g then
		h = ((b - r) / delta) + 2
	else
		h = ((r - g) / delta) + 4
	end

	h = util.round(h * 60)

	if h < 0 then
		h = h + 360
	end

	l = (cmax + cmin) / 2
	s = delta == 0 and 0 or delta / (1 - math.abs(2 * l - 1))
	l = util.round(l * 99)
	s = util.round(s * 100)

	return {
		h = h,
		s = s,
		l = l,
	}
end

_color.from_hsl = function(clr)
	local h = clr.h
	local s = clr.s
	local l = clr.l

	s = s / 100
	l = l / 100
	local c = (1 - math.abs(2 * l - 1)) * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = l - c / 2
	local r, g, b

	if 0 <= h and h < 60 then
		r = c
		g = x
		b = 0
	elseif 60 <= h and h < 120 then
		r = x
		g = c
		b = 0
	elseif 120 <= h and h < 180 then
		r = 0
		g = c
		b = x
	elseif 180 <= h and h < 240 then
		r = 0
		g = x
		b = c
	elseif 240 <= h and h < 300 then
		r = x
		g = 0
		b = c
	elseif 300 <= h and h < 360 then
		r = c
		g = 0
		b = x
	end

	r = util.round((r + m) * 255)
	g = util.round((g + m) * 255)
	b = util.round((b + m) * 255)

	return string.format("#%02X%02X%02X", r, g, b)
end

--- Blend 2 colors
-- @param color1 string HEX
-- @param color2 string HEX
-- @param factor number Float
-- @return string HEX
_color.blend = function(clr1, clr2, factor)
	clr1 = _color.to_rgb(clr1)
	clr2 = _color.to_rgb(clr2)

	-- Get value of each channel
	local bc = function(c)
		local ret = (1 - factor) * clr1[c] + factor * clr2[c]
		return util.clamp(ret, 0, 255)
	end

	return string.format("#%02X%02X%02X", bc("r"), bc("g"), bc("b"))
end

--- Darken a color
-- @param color string HEX
-- @return string HEX
_color.darken = function(clr, lpt)
	local hsl = _color.to_hsl(clr)
	local l = util.clamp(hsl.l - util.round((hsl.l / 100) * lpt), 0, 100)
	return _color.from_hsl({ h = hsl.h, s = hsl.s, l = l })
end

--- Lighten a color
-- @param color string HEX
-- @return string HEX
_color.lighten = function(clr, lpt)
	local hsl = _color.to_hsl(clr)
	local l = util.clamp(hsl.l + util.round(((100 - hsl.l) / 100) * lpt), 0, 100)
	return _color.from_hsl({ h = hsl.h, s = hsl.s, l = l })
end

return _color
