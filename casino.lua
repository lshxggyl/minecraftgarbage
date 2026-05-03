local mon = peripheral.find("monitor")
if not mon then
    error("Where the fuck is the monitor? Connect it to the computer first.")
end

-- Crank the scale up. 2 is massive and fits perfect on a 7x4 monitor.
mon.setTextScale(2)
local w, h = mon.getSize()

-- The obnoxious neon color palette
local neon_colors = {
    colors.red, 
    colors.orange, 
    colors.yellow, 
    colors.lime, 
    colors.lightBlue, 
    colors.magenta
}
local c_len = #neon_colors

local function centerText(text, y)
    local x = math.floor((w - string.len(text)) / 2) + 1
    mon.setCursorPos(x, y)
    mon.write(text)
end

local step = 0
while true do
    mon.setBackgroundColor(colors.black)
    mon.clear()

    -- Flashy alternating title
    mon.setTextColor(neon_colors[(step % c_len) + 1])
    centerText("SYSTEM 32", math.floor(h/2) - 3)

    mon.setTextColor(neon_colors[((step + 2) % c_len) + 1])
    centerText("CASINO", math.floor(h/2) - 1)

    -- Static info so the drunks can actually read it
    mon.setTextColor(colors.white)
    centerText("UPPER FLOOR", math.floor(h/2) + 2)

    -- Animated Arrow sliding right
    mon.setTextColor(colors.lime)
    local arrow_offset = step % 4
    local arrow = string.rep(" ", arrow_offset) .. "===>" .. string.rep(" ", 3 - arrow_offset)
    
    local rightText = "STAIRS " .. arrow
    -- Pin it to the bottom right
    mon.setCursorPos(w - string.len(rightText) - 1, math.floor(h/2) + 4)
    mon.write(rightText)

    step = step + 1
    os.sleep(0.15) -- Fast, obnoxious, perfect.
end
