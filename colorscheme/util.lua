local _util = {}

---Round float to nearest int
-- @param x number Float
-- @return number
_util.round = function(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

---Clamp value between the min and max values.
-- @param value number
-- @param min number
-- @param max number
_util.clamp = function(value, min, max)
	return math.min(math.max(value, min), max)
end

_util.deepcopy = function(orig, copies)
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
				copy[_util.deepcopy(orig_key, copies)] = _util.deepcopy(orig_value, copies)
			end
			setmetatable(copy, _util.deepcopy(getmetatable(orig), copies))
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

_util.template = function(tpl, sch)
	return (
		tpl:gsub("($%b{})", function(w)
			local k = w:sub(3, -2)
			if k == "theme" then
				return sch.theme or w
			end

			return sch.palette[w:sub(3, -2)] or w
		end)
	)
end

_util.remove_hashtag_from_schema = function(sch)
	local _sch = _util.deepcopy(sch)
	local pal = _sch.palette
	for k, v in pairs(pal) do
		if type(v) == "string" then
			pal[k] = v:gsub("^#", "")
		end
	end
	return _sch
end

return _util
