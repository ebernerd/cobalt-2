local args = {...}
local cobalt = args[1]

local class = cobalt.lib.class

local Drawable = loadfile(cobalt.config.path .. "/lib/modules/graphics/classes/Drawable.lua")(cobalt)

return Drawable:extend {
	init = function(self, path)
		self.src = path
		self.surface = cobalt.lib.surface.load(path)

		return self
	end,
	typeOf = function(self, type)
		return type == "Image" or type == "Drawable"
	end,
}