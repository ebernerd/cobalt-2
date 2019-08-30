local args = { ... }
local cobalt = args[1]

-- Shorthand!
local surface = cobalt.lib.surface
local class = cobalt.lib.class

local keyboard = {
	keysDown = {},
}

function keyboard.isDown(key)
	-- Return the truthy version of this
	return not not keyboard.keysDown[key]
end

function keyboard._setKey(key, val)
	keyboard.keysDown[key] = val
end


return keyboard