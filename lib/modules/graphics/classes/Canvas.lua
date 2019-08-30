local args = {...}
local cobalt = args[1]

local class = cobalt.lib.class

local Drawable = loadfile(cobalt.config.path .. "/lib/modules/graphics/classes/Drawable.lua")(cobalt)

return Drawable:extend {
	init = function(self, width, height)
		self.surface = cobalt.lib.surface.create(width, height)
	end,
	typeOf = function(self, type)
		return type == "Canvas" or type == "Drawable"
	end,
	renderTo = function(self, fn)
		local oldCanvas = cobalt.graphics.getCanvas()
		cobalt.graphics.setCanvas(self)
		cobalt.graphics.clear()
		fn()
		cobalt.graphics.setCanvas(oldCanvas)
	end
}