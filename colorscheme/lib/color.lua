local helpers = require("colorscheme.lib.helpers")

--constants for clarity
local ANY = { "r", "g", "b", "h", "s", "l", "hex" }
local RGB = { "r", "g", "b" }
local HSL = { "h", "s", "l" }
local HEX = { "hex" }

local function color(args)
	local obj = { _props = {} }

	-- Default properties
	obj._props.r = args.r or 0
	obj._props.g = args.g or 0
	obj._props.b = args.b or 0
	obj._props.h = args.h or 0
	obj._props.s = args.s or 0
	obj._props.l = args.l or 0
	obj._props.hex = args.hex or "#000000"

	-- Set access to any
	obj._access = ANY

	function obj:hex_to_rgb()
		obj._props.r, obj._props.g, obj._props.b = helpers.hex_to_rgb(obj._props.hex)
	end

	function obj:rgb_to_hex()
		obj._props.hex = helpers.rgb_to_hex(obj._props)
	end

	function obj:rgb_to_hsl()
		obj._props.h, obj._props.s, obj._props.l = helpers.rgb_to_hsl(obj._props)
	end

	function obj:hsl_to_rgb()
		obj._props.r, obj._props.g, obj._props.b = helpers.hsl_to_rgb(obj._props)
	end

	-- Initially set values
	if obj._props.r ~= 0 or obj._props.g ~= 0 or obj._props.b ~= 0 then
		obj:rgb_to_hex()
		obj:rgb_to_hsl()
	elseif obj._props.hex ~= "#000000" then
		obj:hex_to_rgb()
		obj:rgb_to_hsl()
	elseif obj._props.h ~= 0 or obj._props.s ~= 0 or obj._props.l ~= 0 then
		obj:hsl_to_rgb()
		obj:rgb_to_hex()
	end

	-- Set up metatable
	local mt = getmetatable(obj) or {}

	mt.__index = function(self, key)
		if self._props[key] ~= nil then
			if not helpers.contains(obj._access, key) and helpers.contains(ANY, key) then
				if obj._access == RGB then
					self:rgb_to_hex()
					obj:rgb_to_hsl()
				elseif obj._access == HEX then
					self:rgb_to_hex()
					obj:rgb_to_hsl()
				elseif obj._access == HSL then
					self:hsl_to_rgb()
					self:rgb_to_hex()
				end

				-- Reset accessibleness
				obj._access = ANY
			end

			return self._props[key]
		else
			return rawget(self, key)
		end
	end

	mt.__newindex = function(self, key, value)
		if self._props[key] ~= nil then
			if helpers.contains(RGB, key) then
				obj._access = RGB
			elseif helpers.contains(HSL, key) then
				obj._access = HSL
			elseif key == "hex" then
				obj._access = HEX
			end

			-- set the new value
			self._props[key] = value
		else
			-- if it's not part of _props just normally set it
			rawset(self, key, value)
		end
	end

	-- performs an operation on the color and returns the new color
	local function operate(new, operator)
		local new_color = color({ r = obj.r, g = obj.g, b = obj.b })
		local key = new:match("%a+")
		if operator == "+" then
			new_color[key] = new_color[key] + new:match("[%d\\.]+")
		elseif operator == "-" then
			new_color[key] = new_color[key] - new:match("[%d\\.]+")
		end
		return new_color
	end

	mt.__add = function(_, new)
		return operate(new, "+")
	end

	mt.__sub = function(_, new)
		return operate(new, "-")
	end

	setmetatable(obj, mt)
	return obj
end

return color
