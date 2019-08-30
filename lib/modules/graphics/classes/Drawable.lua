local args = {...}
local cobalt = args[1]

local class = cobalt.lib.class

return class {
	typeOf = function(self, type)
		return type == "Drawable"
	end,	
	getWidth = function(self)
		return self.surface.width
	end,
	getHeight = function(self)
		return self.surface.height
	end,
}