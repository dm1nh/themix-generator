local _helpers = {}

function _helpers.round(x, p)
	local power = 10 ^ (p or 0)
	return (x * power + 0.5 - (x * power + 0.5) % 1) / power
end

function _helpers.clamp(val, min, max)
	return math.min(math.max(val, min), max)
end

function _helpers.hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function _helpers.rgb_to_hex(obj)
	local r = obj.r or obj[1]
	local g = obj.g or obj[2]
	local b = obj.b or obj[3]

	return "#" .. string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

function _helpers.rgb_to_hsl(obj)
	local r = obj.r or obj[1]
	local g = obj.g or obj[2]
	local b = obj.b or obj[3]
	local R, G, B = r / 255, g / 255, b / 255
	local max, min = math.max(R, G, B), math.min(R, G, B)
	local h, s, l
	-- Get luminance
	l = (max + min) / 2

	-- Short circuit saturation and hue if it's grey to prevent divide by 0
	if max == min then
		return 0, 0, l
	end

	-- Get saturation
	if l <= 0.5 then
		s = (max - min) / (max + min)
	else
		s = (max - min) / (2 - max - min)
	end

	-- Get hue
	if max == R then
		h = (G - B) / (max - min) * 60
	elseif max == G then
		h = (2.0 + (B - R) / (max - min)) * 60
	else
		h = (4.0 + (R - G) / (max - min)) * 60
	end

	-- Make sure it goes around if it's negative (hue is a circle)
	if h ~= 360 then
		h = h % 360
	end

	return h, s, l
end

function _helpers.hsl_to_rgb(obj)
	local h = obj.h or obj[1]
	local s = obj.s or obj[2]
	local l = obj.l or obj[3]

	local temp1, temp2, temp_r, temp_g, temp_b, temp_h

	-- Set the temp variables
	if l <= 0.5 then
		temp1 = l * (s + 1)
	else
		temp1 = l + s - l * s
	end

	temp2 = l * 2 - temp1
	temp_h = h / 360
	temp_r = temp_h + 1 / 3
	temp_g = temp_h
	temp_b = temp_h - 1 / 3

	-- Make sure it's between 0 and 1
	if temp_r ~= 1 then
		temp_r = temp_r % 1
	end
	if temp_g ~= 1 then
		temp_g = temp_g % 1
	end
	if temp_b ~= 1 then
		temp_b = temp_b % 1
	end

	local rgb = {}

	for _, v in pairs({ { temp_r, "r" }, { temp_g, "g" }, { temp_b, "b" } }) do
		if v[1] * 6 < 1 then
			rgb[v[2]] = temp2 + (temp1 - temp2) * v[1] * 6
		elseif v[1] * 2 < 1 then
			rgb[v[2]] = temp1
		elseif v[1] * 3 < 2 then
			rgb[v[2]] = temp2 + (temp1 - temp2) * (2 / 3 - v[1]) * 6
		else
			rgb[v[2]] = temp2
		end
	end

	return _helpers.round(rgb.r * 255), _helpers.round(rgb.g * 255), _helpers.round(rgb.b * 255)
end

function _helpers.tbl_extend(t1, t2)
	local t = {}
	for i, _ in pairs(t1) do
		t[i] = t1[i]
	end
	for i, _ in pairs(t2) do
		t[i] = t2[i]
	end
	return t
end

function _helpers.contains(obj, value)
	for _, v in pairs(obj) do
		if v == value then
			return true
		end
	end

	return false
end

function _helpers.deepcopy(orig, copies)
	copies = copies or {}
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		if copies[orig] then
			copy = copies[orig]
		else
			copy = {}
			copies[orig] = copy
			for orig_key, orig_value in next, orig, nil do
				copy[_helpers.deepcopy(orig_key, copies)] = _helpers.deepcopy(orig_value, copies)
			end
			setmetatable(copy, _helpers.deepcopy(getmetatable(orig), copies))
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function _helpers.template(tpl, pal)
	return (
		tpl:gsub("($%b{})", function(w)
			local k = w:sub(3, -2)
			if k == "name" then
				return pal.name or w
			end

			return pal[w:sub(3, -2)] or w
		end)
	)
end

function _helpers.palette_without_sharp(pal)
	local _pal = _helpers.deepcopy(pal)
	for k, v in pairs(pal) do
		if type(v) == "string" then
			_pal[k] = v:gsub("^#", "")
		end
	end
	return _pal
end

return _helpers
