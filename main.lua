---TODO: center text [x]
---TODO: load mono space font [x]
---TODO: render cursor [ ]
---TODO: visual feedback if keypressed doesn't match char [ ]
---TODO: end screen when end of TextToBeTyped is reached [ ]
---TODO: get set of random words as TextToBeTyped [ ]

local utf8 = require("utf8")

--Global variables
local stringIndex = 1
local cursorOffset = 0

function love.load()
	love.window.setMode(1600, 900)
	WinWidth, WinHeight = love.graphics.getDimensions()

	TextToBeTyped = "hi my name is paolo and im from turin italy"
	InputText = ""

	Font = love.graphics.newFont("fonts/JetBrainsMono-Regular.ttf", 30) -- Set font size
	love.graphics.setFont(Font)
	FontHeight = Font:getLineHeight()
	FontWidth = Font:getWidth(TextToBeTyped) / #TextToBeTyped
end

---Func: get input text
---@param t love.textinput
function love.textinput(t)
	if t == string.sub(TextToBeTyped, stringIndex, stringIndex) then
		InputText = InputText .. t
		stringIndex = stringIndex + 1
		cursorOffset = cursorOffset + FontWidth
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
			cursorOffset = cursorOffset - FontWidth
		end
	end
end

function love.draw()
	--Log win size
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(
		"winWidth:"
			.. WinWidth
			.. " - winHeight:"
			.. WinHeight
			.. " - FontHeight:"
			.. FontHeight
			.. " - FontWidth:"
			.. FontWidth
	)

	--Render cursor
	love.graphics.line(
		((WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2)) + cursorOffset,
		(WinHeight / 2) - (Font:getHeight(TextToBeTyped)),
		((WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2)) + cursorOffset,
		(WinHeight / 2) + (Font:getHeight(TextToBeTyped))
	)

	--Render TextToBeTyped
	love.graphics.setColor(1, 0, 0)
	love.graphics.print(
		TextToBeTyped,
		(WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2),
		(WinHeight / 2) - (Font:getHeight(TextToBeTyped) / 2)
	)

	--Render InputText
	love.graphics.setColor(0, 1, 0)
	love.graphics.print(
		InputText,
		(WinWidth / 2) - (Font:getWidth(TextToBeTyped) / 2),
		(WinHeight / 2) - (Font:getHeight(TextToBeTyped) / 2)
	)
end
