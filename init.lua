local cobalt = {
	config = {
		path = "/cobalt",
		pollingRate = 1/20,
	},
	lib = {},
	application = {},
	utils = {},

	loop = true,
	

	version = "2.0",
	raw = false,
}

-- Load librares
cobalt.lib.surface = dofile(cobalt.config.path .. "/lib/surface.lua")
cobalt.lib.class = dofile(cobalt.config.path .. "/lib/clasp.lua")


-- Load modules
local loadModule = function(module)
	cobalt[module] = loadfile(cobalt.config.path .. "/lib/modules/" .. module .. "/init.lua")(cobalt)
end
loadModule("graphics")
loadModule("keyboard")
loadModule("mouse")

-- Add quit event to application table
function cobalt.application.quit()
	cobalt.loop = false
	term.clear()
	term.setCursorPos(1,1)
end

-- Timer to keep track of the update loop
cobalt.timer = os.startTimer(cobalt.config.pollingRate)


-- Internal update function
function cobalt._update()
	if cobalt.update then cobalt.update(cobalt.config.pollingRate) end

	if cobalt.draw then
		cobalt.graphics.setCanvas()
		cobalt.graphics.clear()
		cobalt.graphics.setColor("white")

		-- Draw user content to the surface
		cobalt.draw()

		-- Output the application surface to the screen
		cobalt.application.view.surface:output(nil, 0, 0)
	end
end

-- Internal load function
function cobalt._load()
	if cobalt.load then cobalt.load() end
end

-- Internal keydown function
function cobalt._keypressed(key, keycode)
	cobalt.keyboard._setKey(key, true)
	cobalt.keyboard._setKey(keycode, true)

	if cobalt.keypressed then cobalt.keypressed(key, keycode) end
end

function cobalt._keyreleased(key, keycode)
	cobalt.keyboard._setKey(key, false)
	cobalt.keyboard._setKey(keycode, false)

	if cobalt.keyreleased then cobalt.keyreleased(key, keycode) end
end

function cobalt._mousepressed(x, y, button)
	cobalt.mouse._setButton(button, true)
	if cobalt.mousepressed then cobalt.mousepressed(x, y, button) end
end

function cobalt._mousereleased(x, y, button)
	cobalt.mouse._setButton(button, false)
	if cobalt.mousereleased then cobalt.mousereleased(x, y, button) end
end


-- Main function, begins the loop
function cobalt.init(runOnce)

	cobalt._load()

	term.clear()
	term.setCursorPos(1, 1)
	while cobalt.loop do
		local event, a, b, c, d, e = os.pullEvent()

		-- Here is where I wish lua had switch statements :P
		if event == "timer" then
			if a == cobalt.timer then
				if (runOnce) then
					cobalt.loop = false
					return
				end

				-- Reset the timer
				cobalt.timer = os.startTimer(cobalt.config.pollingRate)
				cobalt._update()
			end
		elseif event == "key" then
			cobalt._keypressed(keys.getName(a), a)
		elseif event == "key_up" then
			cobalt._keyreleased(keys.getName(a), a)
		elseif event == "mouse_click" then
			cobalt._mousepressed(b, c, a)
		elseif event == "mouse_up" then
			cobalt._mousereleased(b, c, a)
		elseif event == "char" then
			if cobalt.textinput then cobalt.textinput(a) end
		end
	end


end

return cobalt