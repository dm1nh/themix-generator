local M = {}

function M.round(x, p)
	local power = 10 ^ (p or 0)
	return (x * power + 0.5 - (x * power + 0.5) % 1) / power
end

function M.clamp(val, min, max)
	return math.min(math.max(val, min), max)
end

function M.contains(obj, value)
	for _, v in pairs(obj) do
		if v == value then
			return true
		end
	end

	return false
end

function M.deepcopy(orig, copies)
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
				copy[M.deepcopy(orig_key, copies)] = M.deepcopy(orig_value, copies)
			end
			setmetatable(copy, M.deepcopy(getmetatable(orig), copies))
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function M.template(tpl, palette)
	return (
		tpl:gsub("($%b{})", function(w)
			return palette[w:sub(3, -2)] or w
		end)
	)
end

function M.remove_hashtag_from_schema(palette)
	local pal = M.deepcopy(palette)
	for k, v in pairs(pal) do
		if type(v) == "string" then
			pal[k] = v:gsub("^#", "")
		end
	end
	return pal
end

function M.cwd(file)
	local chr = os.tmpname():sub(1, 1)
	if chr == "/" then
		-- linux
		chr = "/[^/]*$"
	else
		-- windows
		chr = "\\[^\\]*$"
	end
	return arg[0]:sub(1, arg[0]:find(chr)) .. (file or "")
end

return M
