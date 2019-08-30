local args = { ... }
local cobalt = args[1]

-- Shorthand!
local surface = cobalt.lib.surface
local class = cobalt.lib.class

local mouse = {
	buttonsDown = {},
}

function mouse.isDown(button)
	-- Return the truthy version of this
	return not not mouse.buttonsDown[button]
end

function mouse._setButton(button, val)
	mouse.buttonsDown[button] = val
end


return mouse