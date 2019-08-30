local args = { ... }
local cobalt = args[1]

-- Shorthand!
local surface = cobalt.lib.surface
local class = cobalt.lib.class

local graphics = {
	currentCanvas = "",

	color = colors.white,
	background = colors.black,
	classes = {},
}

-- Load classes
graphics.classes.Image = loadfile(cobalt.config.path .. "/lib/modules/graphics/classes/Image.lua")(cobalt)
graphics.classes.Canvas = loadfile(cobalt.config.path .. "/lib/modules/graphics/classes/Canvas.lua")(cobalt)


function graphics.setCanvas(canvas)
	canvas = canvas or cobalt.application.view
	graphics.currentCanvas = canvas or graphics.currentCanvas
end
function graphics.getCanvas()
	return graphics.currentCanvas
end

function graphics.setColor(color)
	if (colors[color]) then
		graphics.color = colors[color]
	else
		graphics.color = color
	end
end
function graphics.getColor()
	return graphics.color
end

function graphics.setBackgroundColor(color)
	if (colors[color]) then
		graphics.background = colors[color]
	else
		graphics.background = color
	end
end
function graphics.getBackgroundColor()
	return graphics.background
end


function graphics.print(text, x, y)
	x = math.floor(x or 0)
	y = math.floor(y or 0)

	text = tostring(text or "Some text")
	graphics.currentCanvas.surface:drawString(text, x, y, graphics.getBackgroundColor(), graphics.getColor())
end

function graphics.rect(mode, x, y, width, height)
	x = math.floor(x or 0)
	y = math.floor(y or 0)
	width = math.floor(width or 4)
	height = math.floor(height or 2)

	if mode == "fill" then
		graphics.currentCanvas.surface:fillRect(x, y, width+x, height+y, graphics.getColor())
	elseif mode == "line" then
		graphics.currentCanvas.surface:drawRect(x, y, width+x, height+y, graphics.getColor())
	else
		error("Must supply valid shape mode: 'fill' or 'line'")
	end
end
graphics.rectangle = graphics.rect

function graphics.ellipse(mode, x, y, width, height)
	x = math.floor(x or 0)
	y = math.floor(y or 0)
	width = math.floor(width or 4)
	height = math.floor(height or 4)

	if mode == "fill" then
		graphics.currentCanvas.surface:fillEllipse(x, y, width, height, graphics.getColor())
	elseif mode == "line" then
		graphics.currentCanvas.surface:drawEllipse(x, y, width, height, graphics.getColor())
	else
		error("Must supply valid shape mode: 'fill' or 'line'")
	end
end

function graphics.pixel(x, y)
	x = math.floor(x or 0)
	y = math.floor(y or 0)
	graphics.currentCanvas.surface:drawPixel(x, y, graphics.getColor())
end

function graphics.line(x1, y1, x2, y2)
	x1 = math.floor(x1 or 0)
	y1 = math.floor(y1 or 0)
	x2 = math.floor(x2 or 10)
	y2 = math.floor(y2 or 10)

	graphics.currentCanvas.surface:drawLine(x1, y1, x2, y2, graphics.getColor())
end

function graphics.draw(drawable, x, y)
	x = math.floor(x or 0)
	y = math.floor(y or 0)

	if drawable.typeOf and drawable:typeOf("Drawable") then
		if (graphics.currentCanvas.surface == drawable.surface) then
			error("Cannot draw canvas to self")
		end
		graphics.currentCanvas.surface:drawSurface(drawable.surface, x, y)
	end
end

function graphics.clear()
	graphics.currentCanvas.surface:clear(graphics.getBackgroundColor())
end



-- Constructors
function graphics.newImage(path)
	return graphics.classes.Image(path)
end

function graphics.newCanvas(width, height)
	return graphics.classes.Canvas(width, height)
end




-- Create a default canvas if it doesn't exist
local dx, dy = term.getSize()
cobalt.application.view = cobalt.application.view or graphics.newCanvas(dx, dy)
graphics.currentCanvas = cobalt.application.view
return graphics