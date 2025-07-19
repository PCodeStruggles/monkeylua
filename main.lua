---TODO: center text
---TODO: render cursor
---TODO: visual feedback if keypressed doesn't match char
---TODO: end screen when end of TextToBeTyped is reached

local utf8 = require("utf8")

function love.load()
	love.window.setMode(1600, 900)
	WinWidth, WinHeight = love.graphics.getDimensions()
	TextToBeTyped = "hi my name is paolo and im from turin italy"
	InputText = ""
	Font = love.graphics.newFont(40)
	love.graphics.setFont(Font)
end

local stringIndex = 1

---Func: get input text
---@param t love.textinput
function love.textinput(t)
	if t == string.sub(TextToBeTyped, stringIndex, stringIndex) then
		InputText = InputText .. t
		stringIndex = stringIndex + 1
	end
end

---Func: Delete on key pressed
---@param key love.keypressed
function love.keypressed(key)
	if key == "backspace" then
		local byteoffset = utf8.offset(InputText, -1)
		if byteoffset then
			InputText = string.sub(InputText, 1, byteoffset - 1)
			stringIndex = stringIndex - 1
		end
	end
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("winWidth: " .. WinWidth .. " - winHeight: " .. WinHeight)
	love.graphics.setColor(1, 0, 0)
	love.graphics.print(
		TextToBeTyped,
		(WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2),
		(WinHeight / 2) - (Font:getHeight(TextToBeTyped) / 2)
	)
	love.graphics.setColor(0, 1, 0)
	love.graphics.print(
		InputText,
		(WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2),
		(WinHeight / 2) - (Font:getHeight(TextToBeTyped) / 2)
	)
end
